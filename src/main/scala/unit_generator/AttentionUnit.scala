package units

import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory}
import networks.{Multicast, PipelineChainValid}
import maxmin.{MaxN}

import memories.{SRAMS}

import components.{BaselineSystolicPE}

import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer




class MHA_V1(HardwareConfig: Map[String, String]) extends Module{
	
	//Primary Tilings
	val B1 = HardwareConfig.get("B1").getOrElse("").toInt
	val N1 = HardwareConfig.get("N1").getOrElse("").toInt
	val H1 = HardwareConfig.get("H1").getOrElse("").toInt
	val D1 = HardwareConfig.get("D1").getOrElse("").toInt
	val E1 = HardwareConfig.get("E1").getOrElse("").toInt
	val M1 = HardwareConfig.get("M1").getOrElse("").toInt

	val B2 = HardwareConfig.get("B2").getOrElse("").toInt
	val N2 = HardwareConfig.get("N2").getOrElse("").toInt
	val H2 = HardwareConfig.get("H2").getOrElse("").toInt
	val D2 = HardwareConfig.get("D2").getOrElse("").toInt
	val M2 = HardwareConfig.get("M2").getOrElse("").toInt

	val B3 = HardwareConfig.get("B3").getOrElse("").toInt
	val N3 = HardwareConfig.get("N3").getOrElse("").toInt
	val H3 = HardwareConfig.get("H3").getOrElse("").toInt
	val M3 = HardwareConfig.get("M3").getOrElse("").toInt
	val O3 = HardwareConfig.get("O3").getOrElse("").toInt
	val E3 = HardwareConfig.get("E3").getOrElse("").toInt
	

	//Precisions
	val PX  = HardwareConfig.get("PX").getOrElse("").toInt
	val PWq = HardwareConfig.get("PWq").getOrElse("").toInt
	val PWk = HardwareConfig.get("PWk").getOrElse("").toInt
	val PWv = HardwareConfig.get("PWv").getOrElse("").toInt
	
	val PQ = HardwareConfig.get("PQ").getOrElse("").toInt
	val PK = HardwareConfig.get("PK").getOrElse("").toInt
	val PS = HardwareConfig.get("PS").getOrElse("").toInt
	val PP = HardwareConfig.get("PP").getOrElse("").toInt
	val PO = HardwareConfig.get("PO").getOrElse("").toInt
	val PSoftmaxFrac = HardwareConfig.get("PSoftmaxFrac").getOrElse("").toInt
	
	val PV = HardwareConfig.get("PV").getOrElse("").toInt
	
	//Network
	val XqNet = HardwareConfig.get("XqNet").getOrElse("") // MC, SYS
	val XkNet = HardwareConfig.get("XkNet").getOrElse("") // MC, SYS
	val XvNet = HardwareConfig.get("XvNet").getOrElse("") // MC, SYS
	
	val WqNet = HardwareConfig.get("WqNet").getOrElse("") // MC, SYS
	val WkNet = HardwareConfig.get("WkNet").getOrElse("") // MC, SYS
	val WvNet = HardwareConfig.get("WvNet").getOrElse("") // MC, SYS
	
	val QNet = HardwareConfig.get("QNet").getOrElse("") // MC, SYS
	val KNet = HardwareConfig.get("KNet").getOrElse("") // MC, SYS
	val SNet = HardwareConfig.get("SNet").getOrElse("") // MC, SYS
	val VNet = HardwareConfig.get("VNet").getOrElse("") // MC, SYS
	val ONet = HardwareConfig.get("ONet").getOrElse("") // MC, SYS
	val PNet = HardwareConfig.get("PNet").getOrElse("") // MC, SYS
		
	//Cache sizes (based on addr)
	val PQCache = HardwareConfig.get("PQCache").getOrElse("").toInt //6 (64), 8 (256), 10 (1024), 16 (64KB), 
	val PKCache = HardwareConfig.get("PKCache").getOrElse("").toInt //6 (64), 8 (256), 10 (1024), 16 (64KB), 
	val PVCache = HardwareConfig.get("PVCache").getOrElse("").toInt //6 (64), 8 (256), 10 (1024), 16 (64KB), 
	val PPCache = HardwareConfig.get("PPCache").getOrElse("").toInt //6 (64), 8 (256), 10 (1024), 16 (64KB), 
	val POCache = HardwareConfig.get("POCache").getOrElse("").toInt //6 (64), 8 (256), 10 (1024), 16 (64KB), 
	
	val PSCache = HardwareConfig.get("PSCache").getOrElse("").toInt //6 (64), 8 (256), 10 (1024), 16 (64KB),
	
	// val PE = N*I*B
	val io = IO(new Bundle {
		// val W = Input (Vec( N*I   , UInt (PW.W ) ) )
		val Xk = Input (Vec( B1*M1*E1   , UInt (PX.W)  ) )
		val Xq = Input (Vec( B1*N1*E1   , UInt (PX.W)  ) )
		val Xv = Input (Vec( B3*M3*E3   , UInt (PX.W)  ) )
		val Wq = Input (Vec( H1*D1*E1   , UInt (PWq.W)  ) )
		val Wk = Input (Vec( H1*D1*E1   , UInt (PWk.W)  ) )
		val Wv = Input (Vec( H3*O3*E3   , UInt (PWv.W)  ) )

		//KV Cache
		val KCache = Input( Vec( B1*M1*H1*D1 , UInt (PK.toInt.W) ))
		val VCache = Input( Vec( B3*M3*H3*O3 , UInt (PV.toInt.W) ))
		val LLMMode = Input(Bool())
		
		
		//More control

		val DEBUG_K = Output (Vec( B1*M1*H1*D1  , UInt (PK.toInt.W)  )) 
		val DEBUG_V = Output (Vec( B3*M3*H3*O3  , UInt (PV.toInt.W)  ))
			
		val DEBUG_Q = Output (Vec( B1*N1*H1*D1  , UInt (PQ.toInt.W)  ))
		val DEBUG_S = Output (Vec( B2*N2*H2*M2  , UInt (PS.toInt.W)  ))
		val DEBUG_O = Output (Vec( B3*N3*H3*O3  , UInt (PS.toInt.W)  ))
		
		val DEBUG_P = Output (Vec( B2*N2*H2*M2  , UInt (PP.toInt.W)  ))
							
		// val Y = Output (Vec( B*N   , UInt (PY.toInt.W) ) )
		// val entry = new EntryIO()
		// val exit = new ExitIO()
		
		// val out_allow = Input(  Bool()  )
		
		val valid = Input (Bool())
		
		// val DEBUG_VALID = Output(Vec(B*N*I, Bool()))

		val N = Input( UInt(32.W))
		val M = Input( UInt(32.W))
		val H = Input( UInt(32.W))
		val B = Input( UInt(32.W))
		val O = Input( UInt(32.W))
		val E = Input( UInt(32.W))
		val D = Input( UInt(32.W)) //0,1,2,3, ...,DDim

		val DimN = Input( UInt(32.W))
		val DimM = Input( UInt(32.W))
		val DimH = Input( UInt(32.W))
		val DimB = Input( UInt(32.W))
		val DimO = Input( UInt(32.W))
		val DimE = Input( UInt(32.W))
		val DimD = Input( UInt(32.W)) //Based on D1 tiles...

	})
	
	//1. Set Main Computing Arrays
	//1. MM - Q
	val MM_Q_cfg = Map[String,String](
		("N" -> (H1*D1).toString),
		("I" -> E1.toString),
		("B" -> (B1*N1).toString),
		("PW" -> (PWq).toString),
		("PX" -> (PX).toString),
		("PY" -> (PQ).toString),
		("PI" -> (PWq + PX).toString),
		("WNet" -> WqNet.toString),
		("XNet" -> XqNet.toString),
		("YNet" -> QNet.toString)
	)
	//not grouped
	val MM_Q = Array.fill( 1 )( Module(new BaselineSystolicPE( MM_Q_cfg  )) )
	
	MM_Q(0).io.X := io.Xq
	MM_Q(0).io.W := io.Wq
	MM_Q(0).io.valid := io.valid
	// val PE_OUT = Output (Vec( PE   , UInt (PI.toInt.W)  )) 	
	// val Y = Output (Vec( B*N   , UInt (PY.toInt.W) ) )
	// val valid = Input (Bool())
	// val DEBUG_VALID = Output(Vec(B*N*I, Bool()))
	
	//1. Output Queue
	
	var MM_Q_queue = new ArrayBuffer[Queue[UInt]] 
	var systolic = 8//random for now, maybe choose based on the systolic nature?
	if(WqNet == "SYS" && XqNet == "SYS"){
		systolic = B1*N1*H1*D1
	}
	else if(WqNet == "SYS"){
		systolic = H1*D1
	}
	else if(XqNet == "SYS"){
		systolic = B1*N1
	}
	
	for(b <- 0 until   B1*N1  ){
		for(n <- 0 until H1*D1 ){
			val dataQueue = Module(new Queue[UInt](entries = systolic, gen = UInt(PQ.W)))
			
			val idx = n + (H1*D1)*b
			dataQueue.io.enq.bits := MM_Q(0).io.Y(idx)
			dataQueue.io.enq.valid := io.valid
			// REG_B(idx) := dataQueue.io.deq.bits
			// dataQueue.io.deq.ready := 	XPipe(0).io.data_update(n % XPipe(0).depth )
			
			//val idx = n + (H1*D1)*b
			
			MM_Q_queue += dataQueue
		}
	}
	
	//1. Accumulator
	val MM_Q_adder_cfg =  Map[String, String]( 
		"prec_in" -> PQ.toString, 
		"prec_sum" -> PQ.toString, 
		"adderNType" -> "SimpleAdderN", 
		"adderType" -> "SimpleAdder2", 
		"terms" -> ( 2 ).toString, 
		"signed" -> true.toString, 
		"same_prec" -> true.toString, 
		"pipelined" -> false.toString, 
		"buffered" -> false.toString, 
		"auto_prec_sum" -> false.toString 
	)
	var MM_Q_adder = Array.fill(B1*N1*H1*D1)( Module( AdderNFactory.create(MM_Q_adder_cfg) ) )
	
	//1. Q Cache
	var MM_Q_cache = Array.fill( B1*N1*H1*D1 )( Module( new SRAMS(Map(
		"prec_addr" -> PQCache.toString,
		"prec_data" -> PQ.toString,
	)) ) )

	//Loop order assume B N H O M D E 
	
	//D E
	//raddr: 0, 0, 0, 0, 0, 1, 1, 1, 1, 1
	//E D
	//raddr: 0, 1, 2, 3, 4 ... D/D1, 0, 1, 2, ...
	for(b <- 0 until   B1*N1  ){
		for(n <- 0 until H1*D1 ){
			val idx = n + (H1*D1)*b
			val dataQueue = MM_Q_queue(idx)
			MM_Q_cache(idx).io.raddr := 0.U//io.D % (1 << PQCache).U //  Somehow a counter here
			MM_Q_cache(idx).io.ren := 1.B //always reading
			// E == 0, M == 0
			MM_Q_cache(idx).io.waddr := 0.U //Somehow a counter here
			MM_Q_cache(idx).io.wen := 1.B// ~( io.M > 0.U | io.O > 0.U ) // writing ... when?
			when( io.E > 0.U ) {//first accum.
				MM_Q_cache(idx).io.wdata := MM_Q_adder(idx).io.Sum
			}.otherwise{
				MM_Q_cache(idx).io.wdata := dataQueue.io.deq.bits
			}

			io.DEBUG_Q(idx) := MM_Q_cache(idx).io.rdata

			MM_Q_adder(idx).io.A(1) := MM_Q_cache(idx).io.rdata
			MM_Q_adder(idx).io.A(0) := dataQueue.io.deq.bits
			
			MM_Q_adder(idx).io.entry.valid := 1.B
			MM_Q_adder(idx).io.exit.ready := 1.B
			
			// REG_B(idx) := dataQueue.io.deq.bits
			dataQueue.io.deq.ready := 1.B//XPipe(0).io.data_update(n % XPipe(0).depth )
		}
	}
	
	val Q_valid = Reg(Bool())
	Q_valid := (io.E + E1.U >= io.DimE)
	
	
	
	//2. MM - K
	val MM_K_cfg = Map[String,String](
		("N" -> (H1*D1).toString),
		("I" -> E1.toString),
		("B" -> (B1*M1).toString),
		("PW" -> (PWk).toString),
		("PX" -> (PX).toString),
		("PY" -> (PK).toString),
		("PI" -> (PWk + PX).toString),
		("WNet" -> WkNet.toString),
		("XNet" -> XkNet.toString),
		("YNet" -> KNet.toString)
	)
	val MM_K = Array.fill( 1 )( Module(new BaselineSystolicPE( MM_K_cfg  )) )

	MM_K(0).io.X := io.Xk
	MM_K(0).io.W := io.Wk
	// MM_K(0).io.valid := io.valid
	when(io.LLMMode === 1.U && io.M < io.DimM - M1.U ){
		MM_K(0).io.valid := 0.U //Skip MM
	}.otherwise{
		MM_K(0).io.valid := io.valid
	}	
	
	//2. Output Queue
	var MM_K_queue = new ArrayBuffer[Queue[UInt]] 
	systolic = 8//random for now, maybe choose based on the systolic nature?
	if(WqNet == "SYS" && XqNet == "SYS"){
		systolic = B1*M1*H1*D1
	}
	else if(WkNet == "SYS"){
		systolic = H1*D1
	}
	else if(XkNet == "SYS"){
		systolic = B1*M1
	}
	
	for(b <- 0 until   B1*M1  ){
		for(n <- 0 until H1*D1 ){
			val dataQueue = Module(new Queue[UInt](entries = systolic, gen = UInt(PK.W)))
			
			val idx = n + (H1*D1)*b
			dataQueue.io.enq.bits := MM_K(0).io.Y(idx)
			dataQueue.io.enq.valid := io.valid
			// REG_B(idx) := dataQueue.io.deq.bits
			// dataQueue.io.deq.ready := 	XPipe(0).io.data_update(n % XPipe(0).depth )
			
			//val idx = n + (H1*D1)*b
			
			MM_K_queue += dataQueue
		}
	}
	
	//2. Accumulator
	val MM_K_adder_cfg =  Map[String, String]( 
		"prec_in" -> PK.toString, 
		"prec_sum" -> PK.toString, 
		"adderNType" -> "SimpleAdderN", 
		"adderType" -> "SimpleAdder2", 
		"terms" -> ( 2 ).toString, 
		"signed" -> true.toString, 
		"same_prec" -> true.toString, 
		"pipelined" -> false.toString, 
		"buffered" -> false.toString, 
		"auto_prec_sum" -> false.toString 
	)
	var MM_K_adder = Array.fill(B1*M1*H1*D1)( Module( AdderNFactory.create(MM_K_adder_cfg) ) )
	
	//2. K Cache
	var MM_K_cache = Array.fill( B1*M1*H1*D1 )( Module( new SRAMS(Map(
		"prec_addr" -> PKCache.toString,
		"prec_data" -> PK.toString,
	)) ) )

	//Loop order assume B N H O M D E 
	
	//D E
	//raddr: 0, 0, 0, 0, 0, 1, 1, 1, 1, 1
	//E D
	//raddr: 0, 1, 2, 3, 4 ... D/D1, 0, 1, 2, ...
	for(b <- 0 until   B1*M1  ){
		for(n <- 0 until H1*D1 ){
			val idx = n + (H1*D1)*b
			val dataQueue = MM_K_queue(idx)
			MM_K_cache(idx).io.raddr := 0.U //io.D % (1 << PKCache).U //  Somehow a counter here
			MM_K_cache(idx).io.ren := 1.B //always reading
			// E == 0, M == 0
			MM_K_cache(idx).io.waddr := 0.U //Somehow a counter here
			MM_K_cache(idx).io.wen := 1.B// ~( io.N > 0.U | io.O > 0.U ) // writing ... when?
			when( io.E > 0.U ) {//first accum.
				MM_K_cache(idx).io.wdata := MM_K_adder(idx).io.Sum
			}.otherwise{
				MM_K_cache(idx).io.wdata := dataQueue.io.deq.bits
			}

			io.DEBUG_K(idx) := MM_K_cache(idx).io.rdata

			MM_K_adder(idx).io.A(1) := MM_K_cache(idx).io.rdata
			MM_K_adder(idx).io.A(0) := dataQueue.io.deq.bits
			
			MM_K_adder(idx).io.entry.valid := 1.B
			MM_K_adder(idx).io.exit.ready := 1.B
			
			// REG_B(idx) := dataQueue.io.deq.bits
			dataQueue.io.deq.ready := 1.B//XPipe(0).io.data_update(n % XPipe(0).depth )
		}
	}
	
	val K_valid = Reg(Bool())
	//K_valid := (io.E + 1.U >= io.DimE)
	when(io.LLMMode === 1.U && io.M < io.DimM - M1.U ){
		K_valid := 1.B //Should be dram ready signal
	}.otherwise{
		K_valid := (io.E + E1.U >= io.DimE)
	}	
	
	
	//2-3 Connecting fabric
	val mux_Q = Reg(Vec(B2*H2*N2*D2, UInt(PQ.W)))
	val mux_K = Reg(Vec(B2*H2*M2*D2, UInt(PK.W)))
	//simplified
	mux_Q := io.DEBUG_Q
	// mux_K := io.DEBUG_K
	//Cascaded Tiling (i.e. )
	
	//From KV Cache	
	//decoding mode (only final M sequence needs to be calculated)
	when(io.LLMMode === 1.U && io.M < io.DimM - M1.U ){
		mux_K := io.KCache
	}.otherwise{
		mux_K := io.DEBUG_K
	}
	
	//3. MM - S
	val MM_S_cfg = Map[String,String](
		("N" -> (M2).toString),
		("I" -> D2.toString),
		("B" -> (N2).toString),
		("PW" -> (PK).toString),
		("PX" -> (PQ).toString),
		("PY" -> (PS).toString),
		("PI" -> (PK + PQ).toString),
		("WNet" -> KNet.toString),
		("XNet" -> QNet.toString),
		("YNet" -> SNet.toString)
	)
	//grouped matrix mulitply
	val MM_S = Array.fill( B2*H2 )( Module(new BaselineSystolicPE( MM_S_cfg  )) )

	for(b <- 0 until B2){
	for(h <- 0 until H2){
		val group = h + H2*b
		MM_S(group).io.valid := K_valid & Q_valid
		
		for(m <- 0 until M2){
			for(d <- 0 until D2){
				MM_S(group).io.W(d + D2*m) := mux_K(d + D2*(m+M2*group))
			}
		}
		
		for(n <- 0 until N2){
			for(d <- 0 until D2){
				MM_S(group).io.X(d + D2*n) := mux_Q(d + D2*(n+N2*group))
			}
		}
		
	}}
	
	//3. Output Queue
	var MM_S_queue = new ArrayBuffer[Queue[UInt]] 
	systolic = 8//random for now, maybe choose based on the systolic nature?
	if(WqNet == "SYS" && XqNet == "SYS"){
		systolic = M2*N2
	}
	else if(KNet == "SYS"){
		systolic = M2
	}
	else if(QNet == "SYS"){
		systolic = N2
	}
	
	val S_valid_next = RegNext(K_valid & Q_valid)
	for(bp <- 0 until B2){
	for(hp <- 0 until H2){
		val group = hp + H2*bp
		for(b <- 0 until N2 ){
			for(n <- 0 until M2 ){
				val dataQueue = Module(new Queue[UInt](entries = systolic, gen = UInt(PS.W)))
				val idx = n + (M2)*b
				dataQueue.io.enq.bits := MM_S(group).io.Y(idx)
				dataQueue.io.enq.valid := S_valid_next
				MM_S_queue += dataQueue
			}
		}
	}}
		
	//3. Accumulator
	val MM_S_adder_cfg =  Map[String, String]( 
		"prec_in" -> PS.toString, 
		"prec_sum" -> PS.toString, 
		"adderNType" -> "SimpleAdderN", 
		"adderType" -> "SimpleAdder2", 
		"terms" -> ( 2 ).toString, 
		"signed" -> true.toString, 
		"same_prec" -> true.toString, 
		"pipelined" -> false.toString, 
		"buffered" -> false.toString, 
		"auto_prec_sum" -> false.toString 
	)
	var MM_S_adder = Array.fill(B2*M2*N2*H2)( Module( AdderNFactory.create(MM_S_adder_cfg) ) )
	
	//3. S Cache
	var MM_S_cache = Array.fill( B2*M2*N2*H2 )( Module( new SRAMS(Map(
		"prec_addr" -> PSCache.toString,
		"prec_data" -> PS.toString,
	)) ) )

	//Loop order assume B N H O M D E 
	//D E
	//raddr: 0, 0, 0, 0, 0, 1, 1, 1, 1, 1
	//E D
	//raddr: 0, 1, 2, 3, 4 ... D/D1, 0, 1, 2, ...
	for(bp <- 0 until B2){
	for(hp <- 0 until H2){
		val group = hp + H2*bp
	
		for(b <- 0 until   N2  ){
			for(n <- 0 until M2 ){
				val idx = n + M2*(b + N2*group)
				val dataQueue = MM_S_queue(idx)
				MM_S_cache(idx).io.raddr := 0.U //  Somehow a counter here
				MM_S_cache(idx).io.ren := 1.B //always reading
				// E == 0, M == 0
				MM_S_cache(idx).io.waddr := 0.U //Somehow a counter here
				MM_S_cache(idx).io.wen :=  S_valid_next //~( io.O > 0.U ) // writing ... when?
				when( io.D > 0.U ) {//first accum.
					MM_S_cache(idx).io.wdata := MM_S_adder(idx).io.Sum
				}.otherwise{
					MM_S_cache(idx).io.wdata := dataQueue.io.deq.bits
				}

				io.DEBUG_S(idx) := MM_S_cache(idx).io.rdata

				MM_S_adder(idx).io.A(1) := MM_S_cache(idx).io.rdata
				MM_S_adder(idx).io.A(0) := dataQueue.io.deq.bits
				MM_S_adder(idx).io.entry.valid := 1.B
				MM_S_adder(idx).io.exit.ready := 1.B
				
				// REG_B(idx) := dataQueue.io.deq.bits
				dataQueue.io.deq.ready :=  S_valid_next//XPipe(0).io.data_update(n % XPipe(0).depth )
				}
			}
	}}
	
	val S_valid = Reg(Bool())
	S_valid := (io.D + D2.U >= io.DimD)
	


	//3-4 KQt to Softmax network

	//4. Softmax
	val softmax_cfg = Map[String,String](
		"N" -> N2.toString,
		"M" -> M2.toString,
		"H" -> H2.toString,
		"B" -> B2.toString,
		//Precisions
		"PS" -> PS.toString,
		"PP" -> PP.toString,
		"PO" -> PO.toString,
		"PFRAC" -> PSoftmaxFrac.toString
	)
	val softmax = Module(new BasicOnlineSoftmax(softmax_cfg))

	softmax.io.S := io.DEBUG_S
	when(S_valid){
		io.DEBUG_P := RegNext(softmax.io.OUTO)
	}.otherwise{
		io.DEBUG_P := RegNext(io.DEBUG_P)
	}
	
	//5. MM - V
	val MM_V_cfg = Map[String,String](
		("N" -> (H3*O3).toString),
		("I" -> E3.toString),
		("B" -> (B3*M3).toString),
		("PW" -> (PWv).toString),
		("PX" -> (PX).toString),
		("PY" -> (PV).toString),
		("PI" -> (PWv + PX).toString),
		("WNet" -> WkNet.toString),
		("XNet" -> XkNet.toString),
		("YNet" -> KNet.toString)
	)
	val MM_V = Array.fill( 1 )( Module(new BaselineSystolicPE( MM_V_cfg  )) )

	MM_V(0).io.X := io.Xk
	MM_V(0).io.W := io.Wv
	// MM_V(0).io.valid := io.valid
	when(io.LLMMode === 1.U && io.M < io.DimM - M3.U ){
		MM_V(0).io.valid := 0.U
	}.otherwise{
		MM_V(0).io.valid := io.valid
	}		
	
	//5. Output Queue
	var MM_V_queue = new ArrayBuffer[Queue[UInt]] 
	systolic = 8//random for now, maybe choose based on the systolic nature?
	if(WvNet == "SYS" && XvNet == "SYS"){
		systolic = B3*M3*H3*O3
	}
	else if(WkNet == "SYS"){
		systolic = H3*O3
	}
	else if(XkNet == "SYS"){
		systolic = B3*M3
	}
	
	for(b <- 0 until   B3*M3  ){
		for(n <- 0 until H3*O3 ){
			val dataQueue = Module(new Queue[UInt](entries = systolic, gen = UInt(PV.W)))
			
			val idx = n + (H3*O3)*b
			dataQueue.io.enq.bits := MM_V(0).io.Y(idx)
			dataQueue.io.enq.valid := io.valid
			// REG_B(idx) := dataQueue.io.deq.bits
			// dataQueue.io.deq.ready := 	XPipe(0).io.data_update(n % XPipe(0).depth )
			
			//val idx = n + (H1*D1)*b
			
			MM_V_queue += dataQueue
		}
	}
	
	//5. Accumulator
	val MM_V_adder_cfg =  Map[String, String]( 
		"prec_in" ->  PV.toString, 
		"prec_sum" -> PV.toString, 
		"adderNType" -> "SimpleAdderN", 
		"adderType" -> "SimpleAdder2", 
		"terms" -> ( 2 ).toString, 
		"signed" -> true.toString, 
		"same_prec" -> true.toString, 
		"pipelined" -> false.toString, 
		"buffered" -> false.toString, 
		"auto_prec_sum" -> false.toString 
	)
	var MM_V_adder = Array.fill(B3*M3*H3*O3)( Module( AdderNFactory.create(MM_V_adder_cfg) ) )
	
	//5. V Cache
	var MM_V_cache = Array.fill( B3*M3*H3*O3 )( Module( new SRAMS(Map(
		"prec_addr" -> PVCache.toString,
		"prec_data" -> PV.toString,
	)) ) )

	//Loop order assume B N H O M D E 
	
	//D E
	//raddr: 0, 0, 0, 0, 0, 1, 1, 1, 1, 1
	//E D
	//raddr: 0, 1, 2, 3, 4 ... D/D1, 0, 1, 2, ...
	for(b <- 0 until   B3*M3  ){
		for(n <- 0 until H3*O3 ){
			val idx = n + (H3*O3)*b
			val dataQueue = MM_V_queue(idx)
			MM_V_cache(idx).io.raddr := 0.U //io.D % (1 << PVCache).U //  Somehow a counter here
			MM_V_cache(idx).io.ren := 1.B //always reading
			// E == 0, M == 0
			MM_V_cache(idx).io.waddr := 0.U //Somehow a counter here
			MM_V_cache(idx).io.wen := 1.B //~( io.N > 0.U | io.O > 0.U ) // writing ... when?
			when( io.E > 0.U ) {//first accum.
				MM_V_cache(idx).io.wdata := MM_V_adder(idx).io.Sum
			}.otherwise{
				MM_V_cache(idx).io.wdata := dataQueue.io.deq.bits
			}

			io.DEBUG_V(idx) := MM_V_cache(idx).io.rdata

			MM_V_adder(idx).io.A(1) := MM_V_cache(idx).io.rdata
			MM_V_adder(idx).io.A(0) := dataQueue.io.deq.bits
			
			MM_V_adder(idx).io.entry.valid := 1.B
			MM_V_adder(idx).io.exit.ready := 1.B
			
			// REG_B(idx) := dataQueue.io.deq.bits
			dataQueue.io.deq.ready := 1.B//XPipe(0).io.data_update(n % XPipe(0).depth )
		}
	}
	
	val V_valid = Reg(Bool())
	// V_valid := (io.E + 1.U >= io.DimE)
	when(io.LLMMode === 1.U && io.M < io.DimM - M3.U ){
		V_valid := 1.U
	}.otherwise{
		V_valid := (io.E + E3.U >= io.DimE)
	}			
	
	
	//4/5-6 Connecting fabric
	val mux_P = Reg(Vec(B3*H3*N3*M3, UInt(PP.W)))
	val mux_V = Reg(Vec(B3*H3*M3*O3, UInt(PV.W)))
	//simplified (todos)
	mux_P := io.DEBUG_P
	// mux_V := io.DEBUG_V
	when(io.LLMMode === 1.U && io.M < io.DimM - M3.U ){
		mux_V := io.VCache
	}.otherwise{
		mux_V := io.DEBUG_V
	}		
		
	//6. O = PV Stage
	val MM_O_cfg = Map[String,String](
		("N" -> (O3).toString),
		("I" -> (M3).toString),
		("B" -> (N3).toString),
		("PW" -> (PV).toString),
		("PX" -> (PP).toString),
		("PY" -> (PO).toString),
		("PI" -> (PP + PO).toString),
		("WNet" -> VNet.toString),
		("XNet" -> PNet.toString),
		("YNet" -> ONet.toString)
	)
	//grouped matrix mulitply
	val MM_O = Array.fill( B3*H3 )( Module(new BaselineSystolicPE( MM_O_cfg  )) )

	for(b <- 0 until B3){
	for(h <- 0 until H3){
		val group = h + H3*b
		MM_O(group).io.valid := S_valid & V_valid
		
		for(m <- 0 until O3){
			for(d <- 0 until M3){
				MM_O(group).io.W(d + M3*m) := mux_V(d + M3*(m+O3*group))
			}
		}
		
		for(n <- 0 until N3){
			for(d <- 0 until M3){
				MM_O(group).io.X(d + M3*n) := mux_P(d + M3*(n+N3*group))
			}
		}
		
	}}
	
	//6. Output Queue
	var MM_O_queue = new ArrayBuffer[Queue[UInt]] 
	systolic = 8//random for now, maybe choose based on the systolic nature?
	if(PNet == "SYS" && VNet == "SYS"){
		systolic = N3*O3
	}
	else if(PNet == "SYS"){
		systolic = N3
	}
	else if(VNet == "SYS"){
		systolic = O3
	}
	
	for(bp <- 0 until B3){
	for(hp <- 0 until H3){
		val group = hp + H3*bp
		for(b <- 0 until N3 ){
			for(n <- 0 until O3 ){
				val dataQueue = Module(new Queue[UInt](entries = systolic, gen = UInt(PO.W)))
				val idx = n + (O3)*b
				dataQueue.io.enq.bits := MM_O(group).io.Y(idx)
				dataQueue.io.enq.valid := io.valid
				MM_O_queue += dataQueue
			}
		}
	}}
		
	//6. Accumulator
	val MM_O_adder_cfg =  Map[String, String]( 
		"prec_in" -> PO.toString, 
		"prec_sum" -> PO.toString, 
		"adderNType" -> "SimpleAdderN", 
		"adderType" -> "SimpleAdder2", 
		"terms" -> ( 2 ).toString, 
		"signed" -> true.toString, 
		"same_prec" -> true.toString, 
		"pipelined" -> false.toString, 
		"buffered" -> false.toString, 
		"auto_prec_sum" -> false.toString 
	)
	var MM_O_adder = Array.fill(B3*N3*H3*O3)( Module( AdderNFactory.create(MM_O_adder_cfg) ) )
	
	//2. S Cache
	var MM_O_cache = Array.fill( B3*N3*H3*O3 )( Module( new SRAMS(Map(
		"prec_addr" -> POCache.toString,
		"prec_data" -> PO.toString,
	)) ) )

	//Loop order assume B N H O M D E 
	
	//D E
	//raddr: 0, 0, 0, 0, 0, 1, 1, 1, 1, 1
	//E D
	//raddr: 0, 1, 2, 3, 4 ... D/D1, 0, 1, 2, ...
	for(bp <- 0 until B3){
	for(hp <- 0 until H3){
		val group = hp + H3*bp
	
		for(b <- 0 until N3 ){
			for(n <- 0 until O3 ){
				val idx = n + O3*(b + N3*group)
				val dataQueue = MM_O_queue(idx)
				MM_O_cache(idx).io.raddr := 0.U //  Somehow a counter here
				MM_O_cache(idx).io.ren := 1.B //always reading
				// E == 0, M == 0
				MM_O_cache(idx).io.waddr := 0.U //Somehow a counter here
				MM_O_cache(idx).io.wen := 1.B//~( io.O > 0.U ) // writing ... when?
				when( io.M > 0.U ) {//first accum.
					MM_O_cache(idx).io.wdata := MM_O_adder(idx).io.Sum
				}.otherwise{
					MM_O_cache(idx).io.wdata := dataQueue.io.deq.bits
				}

				io.DEBUG_O(idx) := MM_O_cache(idx).io.rdata

				MM_O_adder(idx).io.A(1) := MM_O_cache(idx).io.rdata
				MM_O_adder(idx).io.A(0) := dataQueue.io.deq.bits
				MM_O_adder(idx).io.entry.valid := 1.B
				MM_O_adder(idx).io.exit.ready := 1.B
				
				// REG_B(idx) := dataQueue.io.deq.bits
				dataQueue.io.deq.ready := 1.B//XPipe(0).io.data_update(n % XPipe(0).depth )
				}
			}
	}}
	
	val O_valid = Wire(Bool())
	O_valid := (io.M + 1.U >= io.DimM)
	
	
	//7. Residual
	//Todos
	
	
	
	
	
	// val S = Input (Vec( B*H*N*M   , UInt (PS.W ) ) )
	// val OUT1 = Output (Vec( B*H*N   , UInt (PS.W)  )) 
	// val OUTR = Output(Vec( B*H*N, UInt(PP.W)  ))
	// val OUTP = Output(Vec( B*H*N*M,  UInt(PP.W)))
	// val OUTO = Output(Vec( B*H*N*M,  UInt((PO+PS).W)))
	// val OUTL = Output(Vec( B*H*N, UInt((PO+PS).W) ))

	//Pipeline
	// val SoftmaxPipeline = Module(new PipelineChainValid(  Map("depth"-> "2" )) )
	//1. MM_K,MM_Q --> 2. MM_KQ --> 3. Softmax --> 4. MM_O
	//1. MM_V --> 4. MM_O
	// val VPipeline = Module(new PipelineChainValid(  Map("depth"-> "1" )) )
	
	
	
}