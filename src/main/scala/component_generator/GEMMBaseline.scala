package components

import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory}
import networks.{Multicast, PipelineChainValid}
import maxmin.{MaxN}

import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer

//class GEMMBaselinePipeline

//class GEMMBaselineL1 

//class GEMMBaselineGroup Sparsity



// Baselines
// 1. Systolic Arrays (Gemmini + TensorLib/Rubick)
// 2. Limited Sparsity (Stellar)
// 3. Ours

class BaselineSystolicPE(HardwareConfig: Map[String, String]) extends Module{
	
	//Primary Tilings
	val N = HardwareConfig.get("N").getOrElse("").toInt
	val I = HardwareConfig.get("I").getOrElse("").toInt
	val B = HardwareConfig.get("B").getOrElse("").toInt
	//Precisions
	val PW = HardwareConfig.get("PW").getOrElse("").toInt
	val PX = HardwareConfig.get("PX").getOrElse("").toInt
	val PY = HardwareConfig.get("PY").getOrElse("").toInt
	
	val PI = HardwareConfig.get("PI").getOrElse("").toInt //Intermediate

	//Network
	val WNet = HardwareConfig.get("WNet").getOrElse("") // MC, SYS
	val XNet = HardwareConfig.get("XNet").getOrElse("") // MC, SYS
	val YNet = HardwareConfig.get("YNet").getOrElse("") // MC, SYS
	
	val PE = N*I*B
	val io = IO(new Bundle {
		val W = Input (Vec( N*I   , UInt (PW.W ) ) )
		val X = Input (Vec( I*B   , UInt (PX.W)  ) )

		val PE_OUT = Output (Vec( PE   , UInt (PI.toInt.W)  )) 	
		
		val Y = Output (Vec( B*N   , UInt (PY.toInt.W) ) )
		// val entry = new EntryIO()
		// val exit = new ExitIO()
		
		// val out_allow = Input(  Bool()  )
		val Y_valid = Output(Vec( B*N , Bool()))
		
		val valid = Input (Bool())
		
		val DEBUG_VALID = Output(Vec(B*N*I, Bool()))

	})

	
	// 1. 
	val pe_cfg = Map[String, String](
		"prec1" -> PW.toString,
		"prec2" -> PX.toString,
		"prec_out" -> PI.toString, 

		"prec1_type" -> "INT",
		"prec2_type" -> "INT",
		"prec_out_type" -> "INT", 

		"auto_prec_out" -> false.toString,
		"radix" -> 256.toString,
		"multiplierType" -> "SimpleMultiplier2",
		"adderType" -> "SimpleAdder2",
		"signed" -> false.toString,
		"buffered" -> false.toString,
		"side" -> "A" 
	  )
	val PEA = ArrayBuffer.fill(PE)( Module(Multiplier2Factory.create( pe_cfg   ))	)  
	for (p <- 0 until PE){
		io.PE_OUT(p) := PEA(p).io.Out
	}
	
	val VALID_PE = Wire(Vec(B*N*I, Bool()))
	//io.DEBUG_VALID := VALID_PE
	//Regs
	val REG_A = Reg(Vec(B*N*I, UInt(PX.W)))
	val REG_B = Reg(Vec(B*N*I, UInt(PW.W)))
	for(i <- 0 until I){
		for( n <- 0 until N){
			for( b <- 0 until B ){
				val idx = i + I*(n + N*(b))
				PEA(idx).io.A := REG_A(idx)
				PEA(idx).io.B := REG_B(idx)
				PEA(idx).io.entry.valid := 1.B
				PEA(idx).io.exit.ready := 1.B //Assume 1 for now
			}
		}
	}
		
	// 2. W queue (B)
	var WQueue = new ArrayBuffer[Queue[UInt]] 
	if(XNet == "SYS"){
		for ( n <- 0 until N){
			for (i <- 0 until I ){
				val b = 0
				val dataQueue = Module(new Queue[UInt](entries = N+2, gen = UInt(PW.W)))
				WQueue += dataQueue
			}
		}
	}else{
		for ( n <- 0 until N){
			for (i <- 0 until I ){
				val b = 0
				val dataQueue = Module(new Queue[UInt](entries = 3, gen = UInt(PW.W)))
				WQueue += dataQueue
			}
		}
	}
	
	// 2.1 W network
	var WPipe = new ArrayBuffer[PipelineChainValid]
	if(WNet == "SYS"){
		for(n <- 0 until N){
			val pipe = Module(new PipelineChainValid(  Map("depth"-> (B).toString)) )
			WPipe += pipe
		}
	}else {
		for(n <- 0 until N){
			val pipe = Module(new PipelineChainValid(  Map("depth"->1.toString)))
			WPipe += pipe
		}		
	}
	
	// 3. X queue
	var XQueue = new ArrayBuffer[Queue[UInt]] 
	if(WNet == "SYS"){
		for ( b <- 0 until B){
			for (i <- 0 until I ){
				val b = 0
				val dataQueue = Module(new Queue(gen = UInt(PX.W), entries = B+2))
				XQueue += dataQueue
			}
		}
	}else{
		for ( b <- 0 until B){
			for (i <- 0 until I ){
				val b = 0
				val dataQueue = Module(new Queue(gen = UInt(PX.W), entries = 3))
				XQueue += dataQueue
			}
		}
	}		

	// 3.1 X network
	var XPipe = new ArrayBuffer[PipelineChainValid]
	var XPipe_depth = 
	if(XNet == "SYS"){
		for(b <- 0 until B){
			val pipe = Module(new PipelineChainValid(  Map("depth"-> (N).toString)) )
			XPipe += pipe
		}
	}else {
		for(b <- 0 until B){
			val pipe = Module(new PipelineChainValid(  Map("depth"->1.toString)))
			XPipe += pipe
		}		
	}



	//4 Connect pipeline variables
	// WPipe(n)...(0) --> (1) --> (2) --> (3)
	//           QUEUE   PE1      PE2     PE3
	
	//4.1 WQueue head
	for ( n <- 0 until N){
		for (i <- 0 until I ){
			val b = 0
			val idx = i + I*(n)
			val dataQueue = WQueue(idx)
			
			dataQueue.io.enq.bits := io.W(idx)
			dataQueue.io.enq.valid := io.valid
			
			REG_B(idx) := dataQueue.io.deq.bits
			dataQueue.io.deq.ready := 	XPipe(0).io.data_update(n % XPipe(0).depth )	
			
			WPipe(n).io.out_allow := 1.B//io.out_allow
			WPipe(n).io.validin := dataQueue.io.deq.valid //& XPipe(0).io.data_update(n % XPipe(0).depth )	
			WPipe(n).io.pipe_ready_go(b) := 1.B// XPipe(0).io.data_update(n % XPipe(0).depth ) //XPipe(0).io.data_update(n % XPipe(0).depth )
			
			WPipe(n).io.validin := dataQueue.io.deq.valid 
			
			
		}
	}
	
	
	//4.2 WPipe, REG_B Body
	for( n <- 0 until N){
	for (i <- 0 until I){
		val idx = i + I*(n)
		val dataQueue = WQueue(idx)
	for (b <- 1 until B){
		if(WNet == "SYS"){
			val fidx = i + I*(n + N*(b))
			val fidx_prev = i + I*(n + N*(b-1))
			when(WPipe(n).io.data_update(b)	){
				REG_B(fidx) := REG_B(fidx_prev)
			}
			
			WPipe(n).io.pipe_ready_go(b) := 1.B//XPipe(b-1).io.validout_internal(n % XPipe(b).depth)//data_update(n % XPipe(b).depth )	
		}else{
			val fidx = i + I*(n + N*(b))
			REG_B(fidx) := dataQueue.io.deq.bits
		}
				
	}}}	


	//4.3 XQueue head
	for ( b <- 0 until B){
		for (i <- 0 until I ){
			val n = 0
			val idx = i + I*(n + N*(b))
			val dataQueue = XQueue(i + I*b)
			
			dataQueue.io.enq.bits := io.X(i + I*b)
			dataQueue.io.enq.valid := io.valid
			
			REG_A(idx) := dataQueue.io.deq.bits
			dataQueue.io.deq.ready := 	WPipe(0).io.data_update(b % WPipe(0).depth )	
			
			XPipe(b).io.out_allow := 1.B//io.out_allow
			XPipe(b).io.validin := dataQueue.io.deq.valid //& WPipe(0).io.data_update(b % WPipe(0).depth )	
			XPipe(b).io.pipe_ready_go(n) := 	1.B//WPipe(0).io.data_update(b % WPipe(0).depth )
			
		}
	}
	
	//4.4 XPipe, REG_A Body	
	for( b <- 0 until B){
	for (i <- 0 until I){
		val dataQueue = XQueue(i + I*b)
	for (n <- 1 until N){
		if(XNet == "SYS"){
			val fidx = i + I*(n + N*(b))
			val fidx_prev = i + I*(n-1 + N*(b))
			when(XPipe(b).io.data_update(n)	){ //XPipe(b).io.data_update(n)
				REG_A(fidx) := REG_A(fidx_prev)
			}
			
			XPipe(b).io.pipe_ready_go(n) := 1.B//WPipe(n-1).io.validout_internal(b % WPipe(n).depth )	//data_update
		}else{
			val fidx = i + I*(n + N*(b))
			REG_A(fidx) := dataQueue.io.deq.bits
		}
				
	}}}	

	//debugging
	for(b <- 0 until B){
		for (n <- 0 until N){
			for (i <- 0 until I){
				val fidx = i + I*(n + N*(b))
				VALID_PE(fidx) :=  (XPipe(b).io.validout_internal(n % XPipe(b).depth) &
						WPipe(n).io.validout_internal(b  % WPipe(n).depth) )

				if(WNet == "SYS" && XNet == "SYS"){
					if(n>0 && b > 0){
						io.DEBUG_VALID (fidx) :=  (XPipe(b).io.validout_internal(n % XPipe(b).depth) &
								WPipe(n).io.validout_internal(b  % WPipe(n).depth) &
								~XPipe(b-1).io.validout_internal(n % XPipe(b).depth) &
								~WPipe(n-1).io.validout_internal(b  % WPipe(n).depth) );
										
					}else if(n > 0){
						io.DEBUG_VALID (fidx) :=  (XPipe(b).io.validout_internal(n % XPipe(b).depth) &
								WPipe(n).io.validout_internal(b  % WPipe(n).depth) &
								~WPipe(n-1).io.validout_internal(b  % WPipe(n).depth) );
							
					}else if(b >0 ){
						io.DEBUG_VALID (fidx) :=  (XPipe(b).io.validout_internal(n % XPipe(b).depth) &
								WPipe(n).io.validout_internal(b  % WPipe(n).depth) &
								~ XPipe(b-1).io.validout_internal(n % XPipe(b).depth) );
							
					}else{
								io.DEBUG_VALID (fidx) :=  (XPipe(b).io.validout_internal(n % XPipe(b).depth) &
										WPipe(n).io.validout_internal(b  % WPipe(n).depth) );
										
					}
				} else{
					io.DEBUG_VALID (fidx) :=  (XPipe(b).io.validout_internal(n % XPipe(b).depth) &
								WPipe(n).io.validout_internal(b  % WPipe(n).depth) );
				}
				
				
				
			}}}
	
	
	//5. output reducer
	//To be summed will always be generated in parallel --> only two cases
	//If is multicast, directly sum the results (which will be generated in parallel).
	
	// //5.1 Output Queue
	var YQueue = new ArrayBuffer[Queue[UInt]] 
	if(YNet == "SYS"){
	
	// 	for(n <- 0 until N){
	// 	for(b <- 0 until B){
	// 	for(i <- 0 until I){
	// 		var entries = 1
	// 		if(XNet == "SYS"){
	// 			entries *= B
	// 		}
			
	// 		if(WNet == "SYS"){
	// 			entries *= N
	// 		}
	// 		val dataQueue = Module(new Queue[UInt](entries = entries, gen = UInt(PI.W)))
	// 		YQueue += dataQueue
	// 	}}}
		
	}else{
		
		for(n <- 0 until N){
		for(b <- 0 until B){
		for(i <- 0 until I){
			val dataQueue = Module(new Queue[UInt](entries = 3, gen = UInt(PI.W)))
			YQueue += dataQueue
		}}}
		
	}

	// //5.2 Adder
	var YAdder = new ArrayBuffer[GenericAdderN] 
	var YPipe = new ArrayBuffer[PipelineChainValid]
	if(YNet != "SYS"){
		
		val terms = I
		val group = N*B
		
		val reduce_cfg = Map[String, String]( 
				"prec_in" -> PI.toString, 
				"prec_sum" -> PI.toString, 
				"adderNType" -> "SimpleAdderN", 
				"adderType" -> "SimpleAdder2", 
				"terms" -> ( terms ).toString, 
				"signed" -> false.toString, 
				"same_prec" -> true.toString, 
				"pipelined" -> false.toString, 
				"buffered" -> false.toString, 
				"auto_prec_sum" -> false.toString 
		)
		
		YAdder = ArrayBuffer.fill(group)( Module( AdderNFactory.create(  reduce_cfg   ))	)  		
			
	}else{

		val terms = 1
		val group = N*B*I //What about finer systolic movements? terms = 2, ..., sys_group = 
		
		val reduce_cfg = Map[String, String]( 
				"prec_in" -> PI.toString, 
				"prec_sum" -> PI.toString, 
				"adderNType" -> "SimpleAdderN", 
				"adderType" -> "SimpleAdder2", 
				"terms" -> ( 2 ).toString, 
				"signed" -> false.toString, 
				"same_prec" -> true.toString, 
				"pipelined" -> false.toString, 
				"buffered" -> false.toString, 
				"auto_prec_sum" -> false.toString 
		)
		YAdder = ArrayBuffer.fill(group)( Module( AdderNFactory.create(  reduce_cfg   ))	)  		
		
		YPipe = ArrayBuffer.fill(N*B)( Module(new PipelineChainValid(  Map("depth"->I.toString)))	)  		
		
		
	}
	
	var yregs = 1
	if(YNet == "SYS"){
		yregs = N*B*I
	}else{
		yregs = N*B
	}
	val Y_REG = Reg(Vec(yregs, UInt(PI.W)))
	
	if(YNet == "SYS"){
	//6.3 connect pipeline if any
		for ( b <- 0 until B){
			for ( n <- 0 until N){
				// for (i <- 0 until I ){
					val gidx = (n + N*b)
					val idx =I-1 + (n + N*b)
					
					io.Y(gidx) := Y_REG( idx )
		}}
		
	}else{
		for ( b <- 0 until B){
			for ( n <- 0 until N){
				// for (i <- 0 until I ){
					val gidx = (n + N*b)
					val idx =I-1 + (n + N*b)
					
					io.Y(gidx) := Y_REG( gidx ) >> (PI - PY).U
			//io.Y := (Y_REG >> (PI - PY).U)
	
		}}
		
		
	}
	//6 Connection of Adder to Output of PEA and to Output Port
	//simple y_valid
	for ( b <- 0 until B){
		for ( n <- 0 until N){
				val idx = 0 + I*(n + N*b)		
				io.Y_valid(n + N*b) := io.DEBUG_VALID(idx)
	}}
	
	//6.1 Connect queupipelinee
	//6.2 connect adder tree
	//6.3 connect  if any
	for ( b <- 0 until B){
		for ( n <- 0 until N){
			for (i <- 0 until I ){
				val idx = i + I*(n + N*b)

				val dataQueue = YQueue(idx)

				dataQueue.io.enq.bits := PEA(idx).io.Out
				dataQueue.io.enq.valid := io.DEBUG_VALID(idx)

			}

			val gidx = (n + N*b)
			if(YNet == "SYS"){
				
				// val i = 0 
				// val idx = i + I*(n + N*b) 
				
				// dataQueue.io.enq.bits  := PEA(idx).io.Out
				// dataQueue.io.enq.valid := io.DEBUG_VALID(idx)
				
				// YPipe(gidx).io.out_allow := 1.B
				
				// //head 
				// val headQueue = YQueue(gidx) 

				// YPipe(gidx).io.out_allow := 1.B //io.out_allow
				// YPipe(gidx).io.validin := headQueue.io.deq.valid //& XPipe(0).io.data_update(n % XPipe(0).depth )	
				// YPipe(gidx).io.pipe_ready_go(0) := 1.B // XPipe(0).io.data_update(n % XPipe(0).depth ) //XPipe(0).io.data_update(n % XPipe(0).depth )

				// Y_REG(idx) := headQueue.io.deq.bits 
				// headQueue.io.deq.ready := 1.B

				// for(i <- 0 until I){

				// 	//body
				// 	for(i <- 1 until I){
				// 		val fidx = i + I*(n + N*b)
				// 		val fidx_prev = i-1 + I*(n + N*b)
				// 		when( YPipe(gidx).io.data_update(i)	){ //XPipe(b).io.data_update(n)
				// 			Y_REG(fidx) := Y_REG(fidx_prev)
				// 		}
				// 		YPipe(gidx).io.pipe_ready_go(i) := 1.B//WPipe(n-1).io.validout_internal(b % WPipe(n).depth )	//data_update
				// 	}

				// }

			}else{
				for(i <- 0 until I){
					val idx = i + I*(n + N*b)
					val dataQueue = YQueue(idx)
					
					dataQueue.io.deq.ready := 1.B	//XPipe(0).io.data_update(n % XPipe(0).depth )
					YAdder(gidx).io.A(i) := dataQueue.io.deq.bits
					YAdder(gidx).io.exit.ready := 1.B
					YAdder(gidx).io.entry.valid := 1.B
					
					
					Y_REG(gidx) := YAdder(gidx).io.Sum
				}
			
			}
				

				
			}
		}
	
	
	
	
}


// //Value Sparsity + Systolic Movement
class BaselineSystolicSparsePE(HardwareConfig: Map[String, String]) extends Module{
	def printmap(s:String, m: Map[String, String]) = {
		println(s)
		for(i <- m.keys){
			println("\t"+i + "->" + m(i))
		}
	}
	
	
	//Primary Tilings
	val N = HardwareConfig.get("N").getOrElse("").toInt
	val I = HardwareConfig.get("I").getOrElse("").toInt
	val B = HardwareConfig.get("B").getOrElse("").toInt
	//Second Tile
	val NN = HardwareConfig.get("NN").getOrElse("").toInt
	val II = HardwareConfig.get("II").getOrElse("").toInt
	val BB = HardwareConfig.get("BB").getOrElse("").toInt
	//Sparse
	val SN = HardwareConfig.get("SN").getOrElse("").toInt
	val SI = HardwareConfig.get("SI").getOrElse("").toInt
	val SB = HardwareConfig.get("SB").getOrElse("").toInt
	//Precisions
	val PW = HardwareConfig.get("PW").getOrElse("").toInt
	val PX = HardwareConfig.get("PX").getOrElse("").toInt
	val PY = HardwareConfig.get("PY").getOrElse("").toInt

	val PI = HardwareConfig.get("PI").getOrElse("").toInt //Intermediate
	
	//Network
	val WNet = HardwareConfig.get("WNet").getOrElse("") // MC, SYS
	val XNet = HardwareConfig.get("XNet").getOrElse("") // MC, SYS
	val YNet = HardwareConfig.get("YNet").getOrElse("") // MC, SYS
	
	val PE = NN*II*BB
	val io = IO(new Bundle {
		val W = Input (Vec( SN*SI   , UInt (PW.W ) ) )
		val X = Input (Vec( SI*SB   , UInt (PX.W)  ) )
		
		val W_zeromap = Input (Vec( SN*SI   , Bool() ) )
		val X_zeromap = Input (Vec( SI*SB   , Bool()  ) ) 

		val PE_OUT = Output (Vec( PE   , UInt (PI.toInt.W)  )) 	
		//val Y = Output (Vec( SB*SN   , UInt (PY.toInt).W)  ))) 
		// val entry = new EntryIO()
		// val exit = new ExitIO()
		
		val ready = Input(Bool())
		val valid = Output(Bool())
		// val DONE = Output( Bool())
	})

    //PHI(i,b,n) == (X(i,b) == 0)
	//PHI(i,b,n) == (W(i,n) == 0)

	val SKIP_X = HardwareConfig.get("SKIP_X").getOrElse("").toInt
	val SKIP_W = HardwareConfig.get("SKIP_W").getOrElse("").toInt
	
	
	//Y == 0
	//W == 0
	
	////////////////////////////////////////////////////
	//1. Gen pe array
	/////////////////////////////////////
	val pe_cfg = Map[String, String](
		"prec1" -> PW.toString,
		"prec2" -> PX.toString,
		"prec_out" -> PI.toString, 

		"prec1_type" -> "INT",
		"prec2_type" -> "INT",
		"prec_out_type" -> "INT", 

		"auto_prec_out" -> false.toString,
		"radix" -> 256.toString,
		"multiplierType" -> "SimpleMultiplier2",
		"adderType" -> "SimpleAdder2",
		"signed" -> false.toString,
		"buffered" -> false.toString,
		"side" -> "A" 
	  )
	val PEA = ArrayBuffer.fill(PE)( Module(Multiplier2Factory.create( pe_cfg   ))	)  
	
	////////////////////////////////////////////////////
	//2. Gen crossbars for each variable
	///////////////////////////////////
	var w_copy = 1
	var w_group = NN/N
	var w_bcast = 1
	var w_cfg = Map[String, String](
		"prec" -> PW.toString,
		"in_terms" -> ( SN * SI / w_group ).toString,
		"out_terms" -> (  NN*I /w_group ).toString,
	)
	// var CB_W = new ArrayBuffer[PipelinedZeroMapCrossbar]()
	var CB_W = new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()
	
	var x_copy = 1
	var x_bcast = 1
	var x_group = BB/B
	var x_cfg = Map[String, String](
		"prec" -> PX.toString,
		"in_terms" -> ( SB * SI / x_group ).toString,
		"out_terms" -> (  BB*I  / x_group ).toString,
	)
	// var CB_X = new ArrayBuffer[PipelinedZeroMapCrossbar]()//new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()
	var CB_X = new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()
	

	if(SKIP_X == 1 && SKIP_W == 1){
		
		w_copy = 1 
		w_group = BB/B * NN/N
		w_bcast = 1
		w_cfg = Map[String, String](
			"prec" -> PW.toString,
			"in_terms" -> ( SB* SN * SI / w_group ).toString,
			"out_terms" -> (  BB* NN*I /w_group ).toString,
		)
		CB_W = ArrayBuffer.fill(w_copy)(  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))   )
		
		x_copy = 1
		x_group = BB/B * NN/N
		x_bcast = 1
		x_cfg = Map[String, String](
			"prec" -> PX.toString,
			"in_terms" -> ( SB * SN * SI / x_group ).toString,
			"out_terms" -> (  BB*NN*I  / x_group ).toString,
		)
		CB_X = ArrayBuffer.fill(x_copy)(   ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))    )
	
		val X_valids = Wire(Vec(x_copy*x_group, Bool()))
		// println("X_valids", x_copy*x_group)
		val W_valids = Wire(Vec(w_copy*w_group, Bool()))//VecInit(Seq.fill(w_copy * w_group)(Wire(Bool())))
		val combinedX = X_valids.reduce(_ & _)
		val combinedW = W_valids.reduce(_ & _)
		io.valid := combinedX & combinedW
	
		for (bb <- 0 until BB/B){
			for (nn <- 0 until NN/N){
				for(b <- 0 until B){
				for(n <- 0 until N){
					for(i <- 0 until I){
						val X_idx = i + I*(b)
						val W_idx = i + I*(n)
						val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)
						
						// println("Connect PEA " + pe_idx + ".A to CB_X("+0+")("+bb+").io.out."+X_idx)
						// println("Connect PEA " + pe_idx + ".B to CB_W("+bb+")("+nn+").io.out."+W_idx)
						PEA(pe_idx).io.A := CB_X(0)( bb ).io.out(X_idx)
						PEA(pe_idx).io.B := CB_W(0)( nn ).io.out(W_idx)
						PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
						PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
                                                                                                                                                         io.PE_OUT(pe_idx) := PEA(pe_idx).io.Out
						
						// println( "connected" )
						
						//connect CB_X
						for(sn <- 0 until SN/NN){
							for(sb <- 0 until SB/BB){
								for(si <- 0 until (SI/I)){
									val ioX_idx = (si*I + i)  + SI*( sb*B + b )
									val X_in_idx   = (si*I + i) + SI*(sb*B + b) + SI*SB/(BB/B)*( sn*N + n )
									
									val ioW_idx = (si*I + i) + SI*(sn*N + n)
									val W_in_idx   = (si*I + i) + SI*(sn*N + n) + SI*SN/(NN/N)*( sb*B + b )  
									
									// println("sn,sb,si="+sn+","+sb+","+si)
									// println("nn,bb,i="+nn+","+bb+","+i)
									// println("n,b="+n+","+b)
									// println(X_in_idx, ioX_idx)
									CB_X(0)( bb + BB/B*nn ).io.pipeline_ready := io.ready
									X_valids( bb + BB/B*nn ) := CB_X(0)( bb + BB/B*nn ).io.pipeline_valid
									// println(bb+ BB/B*nn)
									CB_X(0)( bb + BB/B*nn ).io.in( X_in_idx ) := io.X( ioX_idx )	
																									
									// println("CB_X connected")
									CB_X(0)( bb + BB/B*nn ).io.zeromap( X_in_idx ) := ~(io.X( ioX_idx ) === 0.U) & ~(io.W( ioW_idx ) === 0.U)
									
									// println("CB_X connected")
									//TODOS here, nn + NN/N*bb
									CB_W(0)( nn + NN/N*bb ).io.pipeline_ready := io.ready
									W_valids(  nn + NN/N*bb ) := CB_W(0)( nn + NN/N*bb ).io.pipeline_valid
									CB_W(0)( nn + NN/N*bb ).io.in( W_in_idx ) := io.W( ioW_idx )
									CB_W(0)( nn + NN/N*bb ).io.zeromap( W_in_idx ) := ~(io.X( ioX_idx ) === 0.U) & ~(io.W( ioW_idx ) === 0.U)
									
									// println("CB_W connected")
						}}}
							
						
					}	//I
				}} // B, N
			}} // BB, NN
	
	}else if(SKIP_X == 1){
		// No SN
		
		w_copy = SB
		w_group = NN/N
		w_bcast = 1
		w_cfg = Map[String, String](
			"prec" -> PW.toString,
			"in_terms" -> ( NN * SI / w_group ).toString,
			"out_terms" -> (  NN*I /w_group ).toString,
		)
		CB_W = ArrayBuffer.fill(w_copy)(  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))   )
		
		x_copy = 1
		x_group = BB/B
		x_bcast = NN
		x_cfg = Map[String, String](
			"prec" -> PX.toString,
			"in_terms" -> ( SB * SI / x_group ).toString,
			"out_terms" -> (  BB*I  / x_group ).toString,
		)
		CB_X = ArrayBuffer.fill(x_copy)(   ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))    )

		val X_valids = Wire(Vec(x_copy*x_group, Bool()))
		// println("X_valids", x_copy*x_group)
		val W_valids = Wire(Vec(w_copy*w_group, Bool()))//VecInit(Seq.fill(w_copy * w_group)(Wire(Bool())))
		val combinedX = X_valids.reduce(_ & _)
		val combinedW = W_valids.reduce(_ & _)
		io.valid := combinedX & combinedW
			
		for (bb <- 0 until BB/B){
			for (nn <- 0 until NN/N){
				for(b <- 0 until B){
				for(n <- 0 until N){
					for(i <- 0 until I){
						val X_idx = i + I*(b)
						val W_idx = i + I*(n)
						val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)

						// println("Connect PEA " + pe_idx + ".A to CB_X("+0+")("+bb+").io.out."+X_idx)
						// println("Connect PEA " + pe_idx + ".B to CB_W("+bb+")("+nn+").io.out."+W_idx)
						PEA(pe_idx).io.A := CB_X(0)(bb ).io.out(X_idx)
						PEA(pe_idx).io.B := CB_W(bb)(nn ).io.out(W_idx)
						PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
						PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
						// println("connected")
                                                                                                                                                         io.PE_OUT(pe_idx) := PEA(pe_idx).io.Out
	
						
						
						//connect CB_X
						for(sb <- 0 until SB/BB){
							for(si <- 0 until (SI/I)){
								// println("sb, bb, b = " + sb + "," + bb + "," + b)
								val X_in_idx = (si*I + i) + SI*(sb*B + b)
								val ioX_idx = (si*I + i) + SI*(sb*B + b)
								// println(si, i, si*I+i)
								// println("Connect CB_X " + bb + ".in("+X_in_idx+ ")to io.X( "+ ioX_idx +")" )
								CB_X(0)( bb ).io.pipeline_ready := io.ready
								
								
								X_valids( bb ) := CB_X(0)( bb ).io.pipeline_valid
								
								
								CB_X(0)( bb ).io.in( X_in_idx ) := io.X( ioX_idx )								
								CB_X(0)( bb ).io.zeromap( X_in_idx ) := ~(io.X( ioX_idx ) === 0.U)
							}
						}
						
						//connect CB_W
						for(bbb <- 0 until SB){
							for(si <- 0 until (SI/I)){
									// println("sb,sn,si = " +sb+","+ sn+ "," + si)
									// println("bb,nn = " +bb+","+ nn)
									// println("b, n, i = " + b + "," + n + "," + i)
									val W_in_idx = (si*I + i) + SI*(n)
									val ioW_idx = (si*I + i) + SI*(n)
									
									val ioX_idx = (si*I + i) + SI*(bbb)
									// println("Connect CB_W " + nn + ".in("+W_in_idx+ ")to io.W( "+ ioW_idx +")"  )
									// println("Connect CB_W " + b + "_" + nn + ".in("+W_in_idx+ ")to io.W( "+ ioW_idx +")"  )
									
									CB_W(bbb)( nn ).io.pipeline_ready := io.ready
									W_valids(  nn + NN/N*bbb ) := CB_W(bbb)( nn ).io.pipeline_valid
									
									CB_W(bbb)( nn ).io.in( W_in_idx ) := io.W( ioW_idx )
									CB_W(bbb)( nn ).io.zeromap( W_in_idx ) := ~(io.X( ioX_idx ) === 0.U)
									
									// println("connected")
							
							}}
							
						
					}	//I
				}} // B, N
			}} // BB, NN
			
			
		// for (nn <- 0 until NN/N){
		// 	for(n <- 0 until N){
		// 		for(i <- 0 until I){
					
					
		// 		}	//I
		// 	} // N
		// } // NN
					
						
						
	}else if(SKIP_W == 1){
		// No SB
		w_copy = 1
		w_group = NN/N
		w_bcast = BB
		w_cfg = Map[String, String](
			"prec" -> PW.toString,
			"in_terms" -> ( SN * SI / w_group ).toString,
			"out_terms" -> (  NN*I /w_group ).toString,
		)
		CB_W = ArrayBuffer.fill(w_copy)(  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))   )
		
		x_copy = SN
		x_group = BB/B
		x_bcast = 1
		x_cfg = Map[String, String](
			"prec" -> PX.toString,
			"in_terms" -> ( BB * SI / x_group ).toString,
			"out_terms" -> (  BB*I  / x_group ).toString,
		)
		CB_X = ArrayBuffer.fill(x_copy)(   ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))    )
		val X_valids = Wire(Vec(x_copy*x_group, Bool()))
		// println("X_valids", x_copy*x_group)
		val W_valids = Wire(Vec(w_copy*w_group, Bool()))//VecInit(Seq.fill(w_copy * w_group)(Wire(Bool())))
		val combinedX = X_valids.reduce(_ & _)
		val combinedW = W_valids.reduce(_ & _)
		io.valid := combinedX & combinedW
	
		for (bb <- 0 until BB/B){
			for (nn <- 0 until NN/N){
				for(b <- 0 until B){
				for(n <- 0 until N){
					for(i <- 0 until I){
						val X_idx = i + I*(b)
						val W_idx = i + I*(n)
						val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)

						PEA(pe_idx).io.A := CB_X(nn)(bb ).io.out(X_idx)
						PEA(pe_idx).io.B := CB_W(0)(nn ).io.out(W_idx)
						PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
						PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
						
                                                                                                                                                         io.PE_OUT(pe_idx) := PEA(pe_idx).io.Out
	
						
						//connect CB_X
						for(nnn <- 0 until SN){
							for(si <- 0 until (SI/I)){
								val X_in_idx = (si*I + i) + SI*(b)
								val ioX_idx = (si*I + i) + SI*(b)
								val ioW_idx = (si*I + i) + SI*(nnn)
								CB_X(nnn)( bb ).io.pipeline_ready := io.ready
								X_valids( bb + BB/B*nnn ) := CB_X(nnn)( bb ).io.pipeline_valid
								
								CB_X(nnn)( bb ).io.in( X_in_idx ) := io.X( ioX_idx )								
								CB_X(nnn)( bb ).io.zeromap( X_in_idx ) := (io.W( ioW_idx ) === 0.U)
						}}
						
						//connect CB_W
						for(sn <- 0 until SN/NN){
							for(si <- 0 until (SI/I)){
								val W_in_idx = (si*I + i) + SI*(sn*N + n)
								val ioW_idx = (si*I + i) + SI*(sn*N + n)
								CB_W(0)( nn ).io.pipeline_ready := io.ready
								W_valids(  nn ) := CB_W(0)( nn ).io.pipeline_valid
								
								CB_W(0)( nn ).io.in( W_in_idx ) := io.W( ioW_idx )
								CB_W(0)( nn ).io.zeromap( W_in_idx ) := (io.W( ioW_idx ) === 0.U)
						}}
							
						
					}	//I
				}} // B, N
			}} // BB, NN
			
					
		
	}
	

	println("N:"+SN+":"+NN+":"+N)
	println("B:"+SB+":"+BB+":"+B)
	println("I:"+SI+":"+I)
	println("SKIP_X:"+SKIP_X)
	println("SKIP_W:"+SKIP_W)
	
	println()
	println("W_Tensor")
	println("w_copy:" +  w_copy)
	println("w_group:" +  w_group)
	println("w_bcast:" + w_bcast)
	printmap("w_cfg", w_cfg)
	
	println("X_Tensor")
	println("x_copy:" +  x_copy)
	println("x_group:" +  x_group)
	println("x_bcast:" + x_bcast)
	printmap("x_cfg", x_cfg)
	// w_copy = 1
	// w_group = NN/N
	// w_cfg = Map[String, String](
	// 	"prec" -> PW.toString,
	// 	"in_terms" -> ( SN * SI / w_group ).toString,
	// 	"out_terms" -> (  NN*I /w_group ).toString,
	// )
	// CB_W =  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))  
	
	// val x_copy = 1
	// val x_group = BB/B
	// val x_cfg = Map[String, String](
	// 	"prec" -> PX.toString,
	// 	"in_terms" -> ( SB * SI / x_group ).toString,
	// 	"out_terms" -> (  BB*I/x_group  ).toString,
	// )
	// CB_X = ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))
	
	
	//Output 
	//Add reduce z
	val y_terms = BB*I*NN / (w_group*x_group) 
	val y_group = SN*SB  
    val reduce_cfg = Map[String, String]( 
			"prec_in" -> PI.toString, 
			"prec_sum" -> PY.toString, 
			"adderNType" -> "SimpleAdderN", 
			"adderType" -> "SimpleAdder2", 
			"terms" -> ( y_terms ).toString, 
			"signed" -> false.toString, 
			"same_prec" -> true.toString, 
			"pipelined" -> false.toString, 
			"buffered" -> false.toString, 
			"auto_prec_sum" -> false.toString 
	)
	
    // val CB_Y = ArrayBuffer.fill(y_group)( Module( AdderNFactory.create(  reduce_cfg   ))	)  
	
	//output indice crossbars + register array
	// val index_prec = 8
	// val REGA_X = Reg(Vec( PE , index_prec.U  ))
	// val REGA_W = Reg(Vec( PE , index_prec.U  ))
	// val INDEX_X = ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))
	// val INDEX_W = ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))

	// //Filter for output
	// CB_Y(y).io.A := Mux(( INDEX_X === x_idx  ) && ( INDEX_Y === y_idx ), )
	// val filter_cfg = Map[String, String](
	// 	"prec" -> PI.toString,
	// 	"terms" -> y_terms
	// )
	// val FILTER_Y_W = ArrayBuffer.fill(y_group)(  Module ( new MultiFilter2(filter_cfg)))
	// val FILTER_Y_X = ArrayBuffer.fill(y_group)(  Module ( new MultiFilter2(filter_cfg)))
	// for(y <- 0 until y_group){
	// 	// FILTER_Y(y).io.in0 := 
	// 	FILTER_Y(y).io.in1 := y.U
	// 	CB_Y(y).io.A := FILTER_Y(y).io.out
	// }
	
	////////////////////////////////////////////////////
	//3. Generate Pipeline hardware
	//INPUT CROSSBARS --> MULTIPLY PE --> REDUCTION
	////////////////////////////////////////////////////
	// val pl_cfg = Map[String, String](
	// 	"prec" -> 1.toString,
	// 	"depth" -> 3.toString
	// )
	// val PIPELINE = Module( new PipelineChain(pl_cfg)  )

	////////////////////////////////////////////////////
	//4. Connect crossbar to pe array
	//5. Connect crossbar to input/output ports
	////////////////////////////////////////////////////
	// 		val zeromap = Input( Vec(in_terms, UInt(1.W)  ) )
	// 		val out  = Output( Vec(out_terms, UInt(prec.W)))  
	// 		val in     = Input(  Vec(in_terms, UInt(prec.W))) 
	// 		val valid = Output(Vec(out_terms, Bool() ))
	// 		val top_valid = Output ( UInt(prec.W) ) 
	// 		val pipeline_ready = Input( Bool())
	// 		val pipeline_valid = Output( Bool())
	
	// for (bb <- 0 until BB/B){
	// for (nn <- 0 until NN/N){
	// 	for(b <- 0 until B){
	// 	for(n <- 0 until N){
	// 		for(i <- 0 until I){
	// 			val X_idx = i + I*(bb*B+b)
	// 			val W_idx = i + I*(nn*N+n)
	// 			val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)
				
	// 			// println("Connect PEA " + pe_idx + ".A to CB_X("+bb+").io.out."+X_idx)
	// 			// println("Connect PEA " + pe_idx + ".B to CB_W("+nn+").io.out."+W_idx)
				
	// 			PEA(pe_idx).io.A := CB_X(bb ).io.out(X_idx)
	// 			PEA(pe_idx).io.B := CB_W(nn ).io.out(W_idx)
	// 			PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
	// 			PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
	// 			// exit_validWire(pidx)  := pp.io.exit.valid
	// 			// entry_readyWire(pidx) := pp.io.entry.ready   
				
	// 			CB_X( bb ).io.pipeline_ready := 1.B
	// 			CB_W( bb ).io.pipeline_ready := 1.B
				
	// 			for(sb <- 0 until SB/(BB/B)){
	// 				for(si <- 0 until (SI/I)){
	// 					val X_in_idx = (si*I + i) + SI*(sb)
	// 					val ioX_idx = (si*I + i) + SI*(sb*BB + bb*B + b)
	// 					// println(si, i, si*I+i)
	// 					// println("Connect CB_X " + bb + ".in("+X_in_idx+ ")to io.X( "+ ioX_idx +")" )
						
	// 					CB_X( bb ).io.in( X_in_idx ) := io.X( ioX_idx )
						
	// 					CB_X( bb ).io.zeromap( X_in_idx ) := (io.X( ioX_idx ) === 0.U)
	// 				}
	// 			}

	// 			for(sn <- 0 until SN/NN){
	// 				for(si <- 0 until (SI/I)){
	// 						println("sn,si = " + sn+ "," + si)
	// 						val W_in_idx = (si*I + i) + SI*(sn*N + n)
	// 						val ioW_idx = (si*I + i) + SI*(sn*NN + nn*N + n)
	// 						println("Connect CB_W " + nn + ".in("+W_in_idx+ ")to io.W( "+ ioW_idx +")"  )
				
	// 						CB_W( nn ).io.in( W_in_idx ) := io.W( ioW_idx )
	// 						CB_W( nn ).io.zeromap( W_in_idx ) := (io.W( ioW_idx ) === 0.U)
	// 						// CB_W( nn ).io.
	// 					}
	// 				}
				
	// 			// INDEX_X(bb / B).io.in(X_idx) := ().U
	// 			// INDEX_W(nn / N).io.in(W_idx) := ().U
				
	// 			// REGA_X(pe_idx) := CB_X(bb / B).io.out(X_idx)   
	// 			// REGA_W(pe_idx) := CB_W(nn / N).io.out(W_idx)
	// 		}	
	// 	}}
	// }}
	
	// CB_X.io.zeromap 
	// CB_X.io.out
	// CB_X.io.valid
	// XB_X.io.valid
	// CB_X.io.top_valid
	// CB_X.pipeline_ready
	// CB_X.pipeline_valid

	////////////////////////////////////////////////////
	//6. Connect PE Array to Reduction
	// Connect reduction to output
	////////////////////////////////////////////////////	

	// for (bb <- 0 until BB/B){
	// 	for (nn <- 0 until NN/N){

	// 		for (sb <- 0 until SN/(NN/N)){
	// 			for (sn <- 0 until SB/(BB/B)){

	// 				for (b <- 0 until B){
	// 					for (n <- 0 until N){
	// 						for (i <- 0 until I){
	// 							val b_idx = sb*BB + bb*B + b
	// 							val n_idx = sn*NN + nn*N + n
	// 							val pe_idx = i + I*((nn*N + n) + (bb*B+b)*NN)
	// 							val inner_idx = i + n*I + b*I*N
	// 							CB_Y( n_idx + SN*b_idx).io.in( inner_idx ) := PEA(pe_idx).io.Out

	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }


	////////////////////////////////////////////////////
	//7. Connect crossbar zero-map to specified value sparsity
	////////////////////////////////////////////////////

	////////////////////////////////////////////////////
	//8. connect pipelining registers and ports
	////////////////////////////////////////////////////
	
	
}




//Contains dataflow + Value Sparsity
class GEMMBaselinePE(HardwareConfig: Map[String, String]) extends Module{
	def printmap(s:String, m: Map[String, String]) = {
		println(s)
		for(i <- m.keys){
			println("\t"+i + "->" + m(i))
		}
	}
	
	
	//Primary Tilings
	val N = HardwareConfig.get("N").getOrElse("").toInt
	val I = HardwareConfig.get("I").getOrElse("").toInt
	val B = HardwareConfig.get("B").getOrElse("").toInt
	//Second Tile
	val NN = HardwareConfig.get("NN").getOrElse("").toInt
	val II = HardwareConfig.get("II").getOrElse("").toInt
	val BB = HardwareConfig.get("BB").getOrElse("").toInt
	//Sparse
	val SN = HardwareConfig.get("SN").getOrElse("").toInt
	val SI = HardwareConfig.get("SI").getOrElse("").toInt
	val SB = HardwareConfig.get("SB").getOrElse("").toInt
	//Precisions
	val PW = HardwareConfig.get("PW").getOrElse("").toInt
	val PX = HardwareConfig.get("PX").getOrElse("").toInt
	val PY = HardwareConfig.get("PY").getOrElse("").toInt

	val PI = HardwareConfig.get("PI").getOrElse("").toInt //Intermediate

	val PE = NN*II*BB
	val io = IO(new Bundle {
		val W = Input (Vec( SN*SI   , UInt (PW.W ) ) )
		val X = Input (Vec( SI*SB   , UInt (PX.W)  ) )
		
		val W_zeromap = Input (Vec( SN*SI   , Bool() ) )
		val X_zeromap = Input (Vec( SI*SB   , Bool()  ) ) 

		val PE_OUT = Output (Vec( PE   , UInt (PI.toInt.W)  )) 	
		//val Y = Output (Vec( SB*SN   , UInt (PY.toInt).W)  ))) 
		// val entry = new EntryIO()
		// val exit = new ExitIO()
		
		val ready = Input(Bool())
		val valid = Output(Bool())
		// val DONE = Output( Bool())
	})

    //PHI(i,b,n) == (X(i,b) == 0)
	//PHI(i,b,n) == (W(i,n) == 0)

	val SKIP_X = HardwareConfig.get("SKIP_X").getOrElse("").toInt
	val SKIP_W = HardwareConfig.get("SKIP_W").getOrElse("").toInt
	
	
	//Y == 0
	//W == 0
	
	////////////////////////////////////////////////////
	//1. Gen pe array
	/////////////////////////////////////
	val pe_cfg = Map[String, String](
		"prec1" -> PW.toString,
		"prec2" -> PX.toString,
		"prec_out" -> PI.toString, 

		"prec1_type" -> "INT",
		"prec2_type" -> "INT",
		"prec_out_type" -> "INT", 

		"auto_prec_out" -> false.toString,
		"radix" -> 256.toString,
		"multiplierType" -> "SimpleMultiplier2",
		"adderType" -> "SimpleAdder2",
		"signed" -> false.toString,
		"buffered" -> false.toString,
		"side" -> "A" 
	  )
	val PEA = ArrayBuffer.fill(PE)( Module(Multiplier2Factory.create( pe_cfg   ))	)  
	
	////////////////////////////////////////////////////
	//2. Gen crossbars for each variable
	///////////////////////////////////
	var w_copy = 1
	var w_group = NN/N
	var w_bcast = 1
	var w_cfg = Map[String, String](
		"prec" -> PW.toString,
		"in_terms" -> ( SN * SI / w_group ).toString,
		"out_terms" -> (  NN*I /w_group ).toString,
	)
	// var CB_W = new ArrayBuffer[PipelinedZeroMapCrossbar]()
	var CB_W = new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()
	
	var x_copy = 1
	var x_bcast = 1
	var x_group = BB/B
	var x_cfg = Map[String, String](
		"prec" -> PX.toString,
		"in_terms" -> ( SB * SI / x_group ).toString,
		"out_terms" -> (  BB*I  / x_group ).toString,
	)
	// var CB_X = new ArrayBuffer[PipelinedZeroMapCrossbar]()//new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()
	var CB_X = new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()
	

	if(SKIP_X == 1 && SKIP_W == 1){
		
		w_copy = 1 
		w_group = BB/B * NN/N
		w_bcast = 1
		w_cfg = Map[String, String](
			"prec" -> PW.toString,
			"in_terms" -> ( SB* SN * SI / w_group ).toString,
			"out_terms" -> (  BB* NN*I /w_group ).toString,
		)
		CB_W = ArrayBuffer.fill(w_copy)(  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))   )
		
		x_copy = 1
		x_group = BB/B * NN/N
		x_bcast = 1
		x_cfg = Map[String, String](
			"prec" -> PX.toString,
			"in_terms" -> ( SB * SN * SI / x_group ).toString,
			"out_terms" -> (  BB*NN*I  / x_group ).toString,
		)
		CB_X = ArrayBuffer.fill(x_copy)(   ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))    )
	
		val X_valids = Wire(Vec(x_copy*x_group, Bool()))
		// println("X_valids", x_copy*x_group)
		val W_valids = Wire(Vec(w_copy*w_group, Bool()))//VecInit(Seq.fill(w_copy * w_group)(Wire(Bool())))
		val combinedX = X_valids.reduce(_ & _)
		val combinedW = W_valids.reduce(_ & _)
		io.valid := combinedX & combinedW
	
		for (bb <- 0 until BB/B){
			for (nn <- 0 until NN/N){
				for(b <- 0 until B){
				for(n <- 0 until N){
					for(i <- 0 until I){
						val X_idx = i + I*(b)
						val W_idx = i + I*(n)
						val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)
						
						// println("Connect PEA " + pe_idx + ".A to CB_X("+0+")("+bb+").io.out."+X_idx)
						// println("Connect PEA " + pe_idx + ".B to CB_W("+bb+")("+nn+").io.out."+W_idx)
						PEA(pe_idx).io.A := CB_X(0)( bb ).io.out(X_idx)
						PEA(pe_idx).io.B := CB_W(0)( nn ).io.out(W_idx)
						PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
						PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
                         io.PE_OUT(pe_idx) := PEA(pe_idx).io.Out
						
						// println( "connected" )
						
						//connect CB_X
						for(sn <- 0 until SN/NN){
							for(sb <- 0 until SB/BB){
								for(si <- 0 until (SI/I)){
									val ioX_idx = (si*I + i)  + SI*( sb*B + b )
									val X_in_idx   = (si*I + i) + SI*(sb*B + b) + SI*SB/(BB/B)*( sn*N + n )
									
									val ioW_idx = (si*I + i) + SI*(sn*N + n)
									val W_in_idx   = (si*I + i) + SI*(sn*N + n) + SI*SN/(NN/N)*( sb*B + b )  
									
									// println("sn,sb,si="+sn+","+sb+","+si)
									// println("nn,bb,i="+nn+","+bb+","+i)
									// println("n,b="+n+","+b)
									// println(X_in_idx, ioX_idx)
									CB_X(0)( bb + BB/B*nn ).io.pipeline_ready := io.ready
									X_valids( bb + BB/B*nn ) := CB_X(0)( bb + BB/B*nn ).io.pipeline_valid
									// println(bb+ BB/B*nn)
									CB_X(0)( bb + BB/B*nn ).io.in( X_in_idx ) := io.X( ioX_idx )	
																									
									// println("CB_X connected")
									CB_X(0)( bb + BB/B*nn ).io.zeromap( X_in_idx ) := ~(io.X( ioX_idx ) === 0.U) & ~(io.W( ioW_idx ) === 0.U)
									
									// println("CB_X connected")
									//TODOS here, nn + NN/N*bb
									CB_W(0)( nn + NN/N*bb ).io.pipeline_ready := io.ready
									W_valids(  nn + NN/N*bb ) := CB_W(0)( nn + NN/N*bb ).io.pipeline_valid
									CB_W(0)( nn + NN/N*bb ).io.in( W_in_idx ) := io.W( ioW_idx )
									CB_W(0)( nn + NN/N*bb ).io.zeromap( W_in_idx ) := ~(io.X( ioX_idx ) === 0.U) & ~(io.W( ioW_idx ) === 0.U)
									
									// println("CB_W connected")
						}}}
							
						
					}	//I
				}} // B, N
			}} // BB, NN
	
	}else if(SKIP_X == 1){
		// No SN
		
		w_copy = SB
		w_group = NN/N
		w_bcast = 1
		w_cfg = Map[String, String](
			"prec" -> PW.toString,
			"in_terms" -> ( NN * SI / w_group ).toString,
			"out_terms" -> (  NN*I /w_group ).toString,
		)
		CB_W = ArrayBuffer.fill(w_copy)(  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))   )
		
		x_copy = 1
		x_group = BB/B
		x_bcast = NN
		x_cfg = Map[String, String](
			"prec" -> PX.toString,
			"in_terms" -> ( SB * SI / x_group ).toString,
			"out_terms" -> (  BB*I  / x_group ).toString,
		)
		CB_X = ArrayBuffer.fill(x_copy)(   ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))    )

		val X_valids = Wire(Vec(x_copy*x_group, Bool()))
		// println("X_valids", x_copy*x_group)
		val W_valids = Wire(Vec(w_copy*w_group, Bool()))//VecInit(Seq.fill(w_copy * w_group)(Wire(Bool())))
		val combinedX = X_valids.reduce(_ & _)
		val combinedW = W_valids.reduce(_ & _)
		io.valid := combinedX & combinedW
			
		for (bb <- 0 until BB/B){
			for (nn <- 0 until NN/N){
				for(b <- 0 until B){
				for(n <- 0 until N){
					for(i <- 0 until I){
						val X_idx = i + I*(b)
						val W_idx = i + I*(n)
						val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)

						// println("Connect PEA " + pe_idx + ".A to CB_X("+0+")("+bb+").io.out."+X_idx)
						// println("Connect PEA " + pe_idx + ".B to CB_W("+bb+")("+nn+").io.out."+W_idx)
						PEA(pe_idx).io.A := CB_X(0)(bb ).io.out(X_idx)
						PEA(pe_idx).io.B := CB_W(bb)(nn ).io.out(W_idx)
						PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
						PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
						// println("connected")
                                                                                                                                                         io.PE_OUT(pe_idx) := PEA(pe_idx).io.Out
	
						
						
						//connect CB_X
						for(sb <- 0 until SB/BB){
							for(si <- 0 until (SI/I)){
								// println("sb, bb, b = " + sb + "," + bb + "," + b)
								val X_in_idx = (si*I + i) + SI*(sb*B + b)
								val ioX_idx = (si*I + i) + SI*(sb*B + b)
								// println(si, i, si*I+i)
								// println("Connect CB_X " + bb + ".in("+X_in_idx+ ")to io.X( "+ ioX_idx +")" )
								CB_X(0)( bb ).io.pipeline_ready := io.ready
								
								
								X_valids( bb ) := CB_X(0)( bb ).io.pipeline_valid
								
								
								CB_X(0)( bb ).io.in( X_in_idx ) := io.X( ioX_idx )								
								CB_X(0)( bb ).io.zeromap( X_in_idx ) := ~(io.X( ioX_idx ) === 0.U)
							}
						}
						
						//connect CB_W
						for(bbb <- 0 until SB){
							for(si <- 0 until (SI/I)){
									// println("sb,sn,si = " +sb+","+ sn+ "," + si)
									// println("bb,nn = " +bb+","+ nn)
									// println("b, n, i = " + b + "," + n + "," + i)
									val W_in_idx = (si*I + i) + SI*(n)
									val ioW_idx = (si*I + i) + SI*(n)
									
									val ioX_idx = (si*I + i) + SI*(bbb)
									// println("Connect CB_W " + nn + ".in("+W_in_idx+ ")to io.W( "+ ioW_idx +")"  )
									// println("Connect CB_W " + b + "_" + nn + ".in("+W_in_idx+ ")to io.W( "+ ioW_idx +")"  )
									
									CB_W(bbb)( nn ).io.pipeline_ready := io.ready
									W_valids(  nn + NN/N*bbb ) := CB_W(bbb)( nn ).io.pipeline_valid
									
									CB_W(bbb)( nn ).io.in( W_in_idx ) := io.W( ioW_idx )
									CB_W(bbb)( nn ).io.zeromap( W_in_idx ) := ~(io.X( ioX_idx ) === 0.U)
									
									// println("connected")
							
							}}
							
						
					}	//I
				}} // B, N
			}} // BB, NN
			
			
		// for (nn <- 0 until NN/N){
		// 	for(n <- 0 until N){
		// 		for(i <- 0 until I){
					
					
		// 		}	//I
		// 	} // N
		// } // NN
					
						
						
	}else if(SKIP_W == 1){
		// No SB
		w_copy = 1
		w_group = NN/N
		w_bcast = BB
		w_cfg = Map[String, String](
			"prec" -> PW.toString,
			"in_terms" -> ( SN * SI / w_group ).toString,
			"out_terms" -> (  NN*I /w_group ).toString,
		)
		CB_W = ArrayBuffer.fill(w_copy)(  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))   )
		
		x_copy = SN
		x_group = BB/B
		x_bcast = 1
		x_cfg = Map[String, String](
			"prec" -> PX.toString,
			"in_terms" -> ( BB * SI / x_group ).toString,
			"out_terms" -> (  BB*I  / x_group ).toString,
		)
		CB_X = ArrayBuffer.fill(x_copy)(   ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))    )
		val X_valids = Wire(Vec(x_copy*x_group, Bool()))
		// println("X_valids", x_copy*x_group)
		val W_valids = Wire(Vec(w_copy*w_group, Bool()))//VecInit(Seq.fill(w_copy * w_group)(Wire(Bool())))
		val combinedX = X_valids.reduce(_ & _)
		val combinedW = W_valids.reduce(_ & _)
		io.valid := combinedX & combinedW
	
		for (bb <- 0 until BB/B){
			for (nn <- 0 until NN/N){
				for(b <- 0 until B){
				for(n <- 0 until N){
					for(i <- 0 until I){
						val X_idx = i + I*(b)
						val W_idx = i + I*(n)
						val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)

						PEA(pe_idx).io.A := CB_X(nn)(bb ).io.out(X_idx)
						PEA(pe_idx).io.B := CB_W(0)(nn ).io.out(W_idx)
						PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
						PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
						
                                                                                                                                                         io.PE_OUT(pe_idx) := PEA(pe_idx).io.Out
	
						
						//connect CB_X
						for(nnn <- 0 until SN){
							for(si <- 0 until (SI/I)){
								val X_in_idx = (si*I + i) + SI*(b)
								val ioX_idx = (si*I + i) + SI*(b)
								val ioW_idx = (si*I + i) + SI*(nnn)
								CB_X(nnn)( bb ).io.pipeline_ready := io.ready
								X_valids( bb + BB/B*nnn ) := CB_X(nnn)( bb ).io.pipeline_valid
								
								CB_X(nnn)( bb ).io.in( X_in_idx ) := io.X( ioX_idx )								
								CB_X(nnn)( bb ).io.zeromap( X_in_idx ) := (io.W( ioW_idx ) === 0.U)
						}}
						
						//connect CB_W
						for(sn <- 0 until SN/NN){
							for(si <- 0 until (SI/I)){
								val W_in_idx = (si*I + i) + SI*(sn*N + n)
								val ioW_idx = (si*I + i) + SI*(sn*N + n)
								CB_W(0)( nn ).io.pipeline_ready := io.ready
								W_valids(  nn ) := CB_W(0)( nn ).io.pipeline_valid
								
								CB_W(0)( nn ).io.in( W_in_idx ) := io.W( ioW_idx )
								CB_W(0)( nn ).io.zeromap( W_in_idx ) := (io.W( ioW_idx ) === 0.U)
						}}
							
						
					}	//I
				}} // B, N
			}} // BB, NN
			
					
		
	}
	

	println("N:"+SN+":"+NN+":"+N)
	println("B:"+SB+":"+BB+":"+B)
	println("I:"+SI+":"+I)
	println("SKIP_X:"+SKIP_X)
	println("SKIP_W:"+SKIP_W)
	
	println()
	println("W_Tensor")
	println("w_copy:" +  w_copy)
	println("w_group:" +  w_group)
	println("w_bcast:" + w_bcast)
	printmap("w_cfg", w_cfg)
	
	println("X_Tensor")
	println("x_copy:" +  x_copy)
	println("x_group:" +  x_group)
	println("x_bcast:" + x_bcast)
	printmap("x_cfg", x_cfg)
	// w_copy = 1
	// w_group = NN/N
	// w_cfg = Map[String, String](
	// 	"prec" -> PW.toString,
	// 	"in_terms" -> ( SN * SI / w_group ).toString,
	// 	"out_terms" -> (  NN*I /w_group ).toString,
	// )
	// CB_W =  ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))  
	
	// val x_copy = 1
	// val x_group = BB/B
	// val x_cfg = Map[String, String](
	// 	"prec" -> PX.toString,
	// 	"in_terms" -> ( SB * SI / x_group ).toString,
	// 	"out_terms" -> (  BB*I/x_group  ).toString,
	// )
	// CB_X = ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( x_cfg )  ))
	
	
	//Output 
	//Add reduce z
	val y_terms = BB*I*NN / (w_group*x_group) 
	val y_group = SN*SB  
    val reduce_cfg = Map[String, String]( 
			"prec_in" -> PI.toString, 
			"prec_sum" -> PY.toString, 
			"adderNType" -> "SimpleAdderN", 
			"adderType" -> "SimpleAdder2", 
			"terms" -> ( y_terms ).toString, 
			"signed" -> false.toString, 
			"same_prec" -> true.toString, 
			"pipelined" -> false.toString, 
			"buffered" -> false.toString, 
			"auto_prec_sum" -> false.toString 
	)
	
    // val CB_Y = ArrayBuffer.fill(y_group)( Module( AdderNFactory.create(  reduce_cfg   ))	)  
	
	//output indice crossbars + register array
	// val index_prec = 8
	// val REGA_X = Reg(Vec( PE , index_prec.U  ))
	// val REGA_W = Reg(Vec( PE , index_prec.U  ))
	// val INDEX_X = ArrayBuffer.fill(x_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))
	// val INDEX_W = ArrayBuffer.fill(w_group)( Module(new PipelinedZeroMapCrossbar( w_cfg )  ))

	// //Filter for output
	// CB_Y(y).io.A := Mux(( INDEX_X === x_idx  ) && ( INDEX_Y === y_idx ), )
	// val filter_cfg = Map[String, String](
	// 	"prec" -> PI.toString,
	// 	"terms" -> y_terms
	// )
	// val FILTER_Y_W = ArrayBuffer.fill(y_group)(  Module ( new MultiFilter2(filter_cfg)))
	// val FILTER_Y_X = ArrayBuffer.fill(y_group)(  Module ( new MultiFilter2(filter_cfg)))
	// for(y <- 0 until y_group){
	// 	// FILTER_Y(y).io.in0 := 
	// 	FILTER_Y(y).io.in1 := y.U
	// 	CB_Y(y).io.A := FILTER_Y(y).io.out
	// }
	
	////////////////////////////////////////////////////
	//3. Generate Pipeline hardware
	//INPUT CROSSBARS --> MULTIPLY PE --> REDUCTION
	////////////////////////////////////////////////////
	// val pl_cfg = Map[String, String](
	// 	"prec" -> 1.toString,
	// 	"depth" -> 3.toString
	// )
	// val PIPELINE = Module( new PipelineChain(pl_cfg)  )

	////////////////////////////////////////////////////
	//4. Connect crossbar to pe array
	//5. Connect crossbar to input/output ports
	////////////////////////////////////////////////////
	// 		val zeromap = Input( Vec(in_terms, UInt(1.W)  ) )
	// 		val out  = Output( Vec(out_terms, UInt(prec.W)))  
	// 		val in     = Input(  Vec(in_terms, UInt(prec.W))) 
	// 		val valid = Output(Vec(out_terms, Bool() ))
	// 		val top_valid = Output ( UInt(prec.W) ) 
	// 		val pipeline_ready = Input( Bool())
	// 		val pipeline_valid = Output( Bool())
	
	// for (bb <- 0 until BB/B){
	// for (nn <- 0 until NN/N){
	// 	for(b <- 0 until B){
	// 	for(n <- 0 until N){
	// 		for(i <- 0 until I){
	// 			val X_idx = i + I*(bb*B+b)
	// 			val W_idx = i + I*(nn*N+n)
	// 			val pe_idx = i + I*((n+nn*N) + (bb*B+b)*NN)
				
	// 			// println("Connect PEA " + pe_idx + ".A to CB_X("+bb+").io.out."+X_idx)
	// 			// println("Connect PEA " + pe_idx + ".B to CB_W("+nn+").io.out."+W_idx)
				
	// 			PEA(pe_idx).io.A := CB_X(bb ).io.out(X_idx)
	// 			PEA(pe_idx).io.B := CB_W(nn ).io.out(W_idx)
	// 			PEA(pe_idx).io.exit.ready := 1.B//io.io.exit.ready
	// 			PEA(pe_idx).io.entry.valid :=  1.B// CB_X(bb % B).io.valid(X_idx) & CB_W(nn % N).io.valid(X_idx)
	// 			// exit_validWire(pidx)  := pp.io.exit.valid
	// 			// entry_readyWire(pidx) := pp.io.entry.ready   
				
	// 			CB_X( bb ).io.pipeline_ready := 1.B
	// 			CB_W( bb ).io.pipeline_ready := 1.B
				
	// 			for(sb <- 0 until SB/(BB/B)){
	// 				for(si <- 0 until (SI/I)){
	// 					val X_in_idx = (si*I + i) + SI*(sb)
	// 					val ioX_idx = (si*I + i) + SI*(sb*BB + bb*B + b)
	// 					// println(si, i, si*I+i)
	// 					// println("Connect CB_X " + bb + ".in("+X_in_idx+ ")to io.X( "+ ioX_idx +")" )
						
	// 					CB_X( bb ).io.in( X_in_idx ) := io.X( ioX_idx )
						
	// 					CB_X( bb ).io.zeromap( X_in_idx ) := (io.X( ioX_idx ) === 0.U)
	// 				}
	// 			}

	// 			for(sn <- 0 until SN/NN){
	// 				for(si <- 0 until (SI/I)){
	// 						println("sn,si = " + sn+ "," + si)
	// 						val W_in_idx = (si*I + i) + SI*(sn*N + n)
	// 						val ioW_idx = (si*I + i) + SI*(sn*NN + nn*N + n)
	// 						println("Connect CB_W " + nn + ".in("+W_in_idx+ ")to io.W( "+ ioW_idx +")"  )
				
	// 						CB_W( nn ).io.in( W_in_idx ) := io.W( ioW_idx )
	// 						CB_W( nn ).io.zeromap( W_in_idx ) := (io.W( ioW_idx ) === 0.U)
	// 						// CB_W( nn ).io.
	// 					}
	// 				}
				
	// 			// INDEX_X(bb / B).io.in(X_idx) := ().U
	// 			// INDEX_W(nn / N).io.in(W_idx) := ().U
				
	// 			// REGA_X(pe_idx) := CB_X(bb / B).io.out(X_idx)   
	// 			// REGA_W(pe_idx) := CB_W(nn / N).io.out(W_idx)
	// 		}	
	// 	}}
	// }}
	
	// CB_X.io.zeromap 
	// CB_X.io.out
	// CB_X.io.valid
	// XB_X.io.valid
	// CB_X.io.top_valid
	// CB_X.pipeline_ready
	// CB_X.pipeline_valid

	////////////////////////////////////////////////////
	//6. Connect PE Array to Reduction
	// Connect reduction to output
	////////////////////////////////////////////////////	

	// for (bb <- 0 until BB/B){
	// 	for (nn <- 0 until NN/N){

	// 		for (sb <- 0 until SN/(NN/N)){
	// 			for (sn <- 0 until SB/(BB/B)){

	// 				for (b <- 0 until B){
	// 					for (n <- 0 until N){
	// 						for (i <- 0 until I){
	// 							val b_idx = sb*BB + bb*B + b
	// 							val n_idx = sn*NN + nn*N + n
	// 							val pe_idx = i + I*((nn*N + n) + (bb*B+b)*NN)
	// 							val inner_idx = i + n*I + b*I*N
	// 							CB_Y( n_idx + SN*b_idx).io.in( inner_idx ) := PEA(pe_idx).io.Out

	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	}
	// }


	////////////////////////////////////////////////////
	//7. Connect crossbar zero-map to specified value sparsity
	////////////////////////////////////////////////////

	////////////////////////////////////////////////////
	//8. connect pipelining registers and ports
	////////////////////////////////////////////////////


}


// class SoftmaxBaselinePE(HardwareConfig: Map[String, String]) extends Module{

// }
