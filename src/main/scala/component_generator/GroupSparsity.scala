// package components

// import networks.{Crossbar,MuxN}

// import chisel3._
// import chisel3.util._
// import helper._
// import multipliers.{GenericMultiplier2,Multiplier2Factory}
// import adders.{GenericAdderN,AdderNFactory}



// class ComputeGroupSparsity( HardwareConfig:Map[String, String]) extends Module{

// 	val prec:Int  = HardwareConfig("prec").toInt
	
// 	val SSB = HardwareConfig("SSB").toInt
// 	val SB = HardwareConfig("SB").toInt
// 	val SSN = HardwareConfig("SSN").toInt
// 	val SN = HardwareConfig("SN").toInt
// 	val SSI = HardwareConfig("SSI").toInt
// 	val SI = HardwareConfig("SI").toInt

	
	
	
	
	
// 	// val in_terms:Int = HardwareConfig("in_terms").toInt
// 	// val tile:Int = HardwareConfig("out_terms").toInt
	
// 	val PX = HardwareConfig("PX").toInt
	
// 	val PW = HardwareConfig("PW").toInt
	
// 	val io = IO(new Bundle { 	
			
// 		val Xin  = Input(  Vec(SSB*SSI, UInt(PX.W))  ) 
// 		val Xout =  Output( Vec( SB*SI, UInt(PX.W)) )
		
// 		val Win  = Input( (Vec(SSN*SSI , UInt(PW.W)) ))
// 		val Wout = Output( Vec(SN*SI, UInt(PW.W)  ) )
	
// 	// 		val out  = Output( Vec(out_terms, UInt(prec.W)))  
// 	// 		val in     = Input(  Vec(in_terms, UInt(prec.W))) 

// 	// 		val valid = Output(Vec(out_terms, Bool() ))	

// 	// 		val zeromap = Input( Vec(in_terms, UInt(1.W)  ) )
// 	// 		val out  = Output( Vec(out_terms, UInt(prec.W)))  

// 	// 		val in     = Input(  Vec(in_terms, UInt(prec.W))) 
				
// 	// 		val valid = Output(Vec(out_terms, Bool() ))
// 	// 		val top_valid = Output ( UInt(prec.W) ) 
			
// 	// 		val pipeline_ready = Input( Bool())
// 	// 		val pipeline_valid = Output( Bool())
			
// 	 })  
	 
	
// 	val xcb = Array.fill(SI*SB)(Module(new PipelinedZeroMapCrossbar(Map(
// 		"prec" -> PX.toString,
// 		"in_terms" -> ((SSB/SB) * (SSI/SI)).toString,
// 		"out_terms" -> ( 1 ).toString,
// 	))))
	
// 	val wcb = Array.fill(SI*SN)(Module(new PipelinedZeroMapCrossbar(Map(
// 		"prec" -> PW.toString,
// 		"in_terms" -> ((SSN/SN) * (SSI/SI)).toString,
// 		"out_terms" -> ( 1 ).toString,
// 	))))
	
// 	for(si <- 0 until SI){
// 		for(sn <- 0 until SN){
// 			val idx = sn + SN*si
// 			io.Wout(idx) := wcb(idx).io.out(0)
// 		}
// 	}
	
// 	for(si <- 0 until SI){
// 		for(sb <- 0 until SB){
// 			val idx = sb + SB*si
// 			io.Xout(idx) := xcb(idx).io.out(0)
// 		}
// 	}

	
// 	for(si <- 0 until SSI){
// 		for(sn <- 0 until SSN){
// 			val idx = sn + SSN*si
// 			xcb := io.Win(idx).io.in(idx)
// 		}
// 	}
	
// 	for(si <- 0 until SSI){
// 		for(sb <- 0 until SSB){
// 			val idx = sb + SSB*si
// 			io.Xin(idx) := xcb(idx).io.out(0)
// 		}
// 	}
			
	 
// 	var w_copy = 1
// 	var w_group = NN/N
// 	var w_bcast = 1
// 	var w_cfg = Map[String, String](
// 	"prec" -> PW.toString,
// 	"in_terms" -> ( SN * SI / w_group ).toString,
// 	"out_terms" -> (  NN*I /w_group ).toString,
// 	)
// 	// var CB_W = new ArrayBuffer[PipelinedZeroMapCrossbar]()
// 	var CB_W = new ArrayBuffer[ArrayBuffer[PipelinedZeroMapCrossbar]]()

	
	 
// }

// //KQ Pruning
// // class KQPruning( HardwareConfig:Map[String, String]) extends ComputeGroupSparsity {
// // }
// // //Head Pruning
// // class MemorySparsity( HardwareConfig: Map[String, String]) extends Module{
	
	
	
// // }