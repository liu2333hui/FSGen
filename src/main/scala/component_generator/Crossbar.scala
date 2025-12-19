package components

import networks.{Crossbar,MuxN}

import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory}



//Crossbar
//Full Mux-based

//Partial Mux

//Anything else ? Multi-stage? Butterfly if have time

class GenericZeroMapNetwork( HardwareConfig:Map[String, String]) extends Module {

 val prec:Int  = HardwareConfig("prec").toInt
 val in_terms:Int = HardwareConfig("in_terms").toInt
 val out_terms:Int = HardwareConfig("out_terms").toInt

	val io = IO(new Bundle {
		val zeromap = Input( Vec(in_terms, UInt(1.W)  ) ) 
		val out  = Output( Vec(out_terms, UInt(prec.W)))  
		
			val in     = Input(  Vec(in_terms, UInt(prec.W))) 

		val valid = Output(Vec(out_terms, Bool() ))
		val top_valid = Output ( UInt(prec.W) ) 
  })  

}


class ZeroMapCrossbar2( HardwareConfig:Map[String, String]) extends GenericZeroMapNetwork(HardwareConfig) {

    val sel_prec:Int  = 8 //max 256 input crossbar, HardwareConfig("in_prec").toInt
	

	val m = Module(new Crossbar(
		HardwareConfig
	))
	
	m.io.in := io.in
	io.out  := m.io.out
	


	//val sel   = Input( Vec(out_terms, UInt(log2Ceil(in_terms).W) ) )
	
	// val zeroadd = Wire(Vec( in_terms, UInt(sel_prec.W)  ) )
	// val zeromask = Wire(Vec( in_terms, UInt(sel_prec.W) )  )
	// zeroadd(0) := io.zeromap(0)
	// for (i <- 1 until in_terms){
	// 	zeroadd(i) := zeroadd(i-1) + io.zeromap(i)
	// }
	
	// for (i <- 0 until in_terms){
	// 	zeromask(i) := zeroadd(i) & Cat(Seq.fill(sel_prec)(io.zeromap(i)))
	// }
	
	val onehot = Wire(Vec (out_terms, UInt(sel_prec.W) ))
	val zeromap_wire = Wire(  UInt(in_terms.W) )
	zeromap_wire := io.zeromap.asUInt
	for (j <- 0 until out_terms){
		// for(i <- 0 until in_terms){
			
		// 	onehot(j)(i) := (zeromask(i) === (j+1).U)
			
		// }
		// val mux_cfg = Map[String, String](
		//  "prec" -> prec.toString,
		//  "terms" -> (in_terms - j).toString,
		//  "sel_prec" -> (sel_prec).toString,
		//   )
		// val m = Module(new MuxN(
		// 	mux_cfg
		// ))
		// for (i <- 0 until in_terms - j){
		// 	m.io.in(i) := io.in(i+j)
		// 	io.out(j) := m.io.out
		// }
		
		
		// val onehot = Wire( UInt((  in_terms - j   ).W   ))
		onehot(j) := zeromap_wire & (Fill(in_terms , 1.U(1.W)) << j) //zeromap_wire(in_terms -1, j)
		
		println("J",j)
		m.io.sel(j) := PriorityEncoder((onehot(j))) //+ j.U
		
		io.valid(j) := (onehot.asUInt =/= 0.U)
		
		if(j == out_terms-1){
			io.top_valid := m.io.sel(j)
		}
			
	}
	// zeromap ( 1 0 0 1)
	// zeroadd ( 1 1 1 2)
	
	
	
	
	// m.io.sel(0) = 
	
	
	
}




class ZeroMapCrossbar( HardwareConfig:Map[String, String]) extends GenericZeroMapNetwork(HardwareConfig) {

    val sel_prec:Int  = 8 //max 256 input crossbar, HardwareConfig("in_prec").toInt
	
	val m = Module(new Crossbar(
		HardwareConfig
	))
	
	m.io.in := io.in
	io.out  := m.io.out
	


	//val sel   = Input( Vec(out_terms, UInt(log2Ceil(in_terms).W) ) )
	
	val zeroadd = Wire(Vec( in_terms, UInt(sel_prec.W)  ) )
	val zeromask = Wire(Vec( in_terms, UInt(sel_prec.W) )  )
	zeroadd(0) := io.zeromap(0)
	for (i <- 1 until in_terms){
		zeroadd(i) := zeroadd(i-1) + io.zeromap(i)
	}
	
	for (i <- 0 until in_terms){
		zeromask(i) := zeroadd(i) & Cat(Seq.fill(sel_prec)(io.zeromap(i)))
	}
	


	
	val onehot = Wire(Vec (out_terms, Vec (in_terms, Bool() )))

	for (j <- 0 until out_terms){
		for(i <- 0 until in_terms){
			
			onehot(j)(i) := (zeromask(i) === (j+1).U)
			
		}
			// val conditions = Seq.tabulate(in_terms)(i =>   (zeromask(i) === j.U, io.sel(j) = i.U)  )
			// val finalLogic = conditions.foldLeft(when(false.B) {}) { 
			//   (chain, (cond, block)) => chain.elsewhen(cond) { block }
			// }.otherwise {  }

			// val conditions2 = Seq.tabulate(in_terms)(i =>   (zeromask(i) === j.U, io.valid(j) := 1.U)  )
			// val finalLogic2 = conditions.foldLeft(when(false.B) {}) { 
			//   (chain, (cond, block)) => chain.elsewhen(cond) { block }
			// }.otherwise { io.valid(j) := 0.U }
		m.io.sel(j) := PriorityEncoder(onehot(j).asUInt)
		
		io.valid(j) := (onehot(j).asUInt =/= 0.U)
		
		if(j == out_terms-1){
			io.top_valid := PriorityEncoder(onehot(j).asUInt) 
		}
			
	}
	// zeromap ( 1 0 0 1)
	// zeroadd ( 1 1 1 2)
	
	
	
	
	// m.io.sel(0) = 
	
	
	
}





class PipelinedZeroMapNetwork(HardwareConfig:Map[String, String]) extends Module {
	
	val prec:Int  = HardwareConfig("prec").toInt
	val in_terms:Int = HardwareConfig("in_terms").toInt
	val out_terms:Int = HardwareConfig("out_terms").toInt
	
		val io = IO(new Bundle {
			val zeromap = Input( Vec(in_terms, UInt(1.W)  ) ) 
			val out  = Output( Vec(out_terms, UInt(prec.W)))  
			
			val in     = Input(  Vec(in_terms, UInt(prec.W))) 
	
			val valid = Output(Vec(out_terms, Bool() ))
			val top_valid = Output ( UInt(prec.W) ) 
	
			
			val pipeline_ready = Input( Bool())
			val pipeline_valid = Output( Bool())
	 })  
	
}


class PipelinedZeroMapCrossbar( HardwareConfig:Map[String, String]) extends PipelinedZeroMapNetwork(HardwareConfig) {


val sel_prec:Int  = 8 //max 256 input crossbar, HardwareConfig("in_prec").toInt
	
 // 状态定义
  val idle :: busy :: Nil = Enum(2)
  val stateReg = RegInit(idle)      // 初始状态为红灯
  
  val cur_start_idx =  Reg(UInt(sel_prec.W))
  
  // val valid = RegInit(0.B)
  io.pipeline_valid := (io.top_valid+ 1.U === in_terms.U)
  // io.pipeline_valid  := valid
  cur_start_idx := 0.U
  
  // 状态转换逻辑
  switch(stateReg) {
    is(idle) {
      when(io.pipeline_ready) { 
		  stateReg := busy   
		}
		
    }
    is(busy) {
      when(io.top_valid+ 1.U === in_terms.U){
		when(io.pipeline_ready) {
		  stateReg := busy 
		}.otherwise{
		  stateReg := idle   
		}
		cur_start_idx := 0.U
	  }.otherwise{
		cur_start_idx := io.top_valid+1.U	
	  }
	  
    }
  }





	val m = Module(new Crossbar(
		HardwareConfig
	))
	m.io.in := RegNext(io.in)
	
	val zeromap = Wire( Vec(in_terms, UInt(1.W)  ) ) 
	for(i <- 0 until in_terms){
		zeromap(i) := RegNext(io.zeromap(i))
	}
	
	// val out = 
	io.out  := (m.io.out)
	
	
	
	val zeroadd = Wire(Vec( in_terms, UInt(sel_prec.W)  ) )
	val zeromask = Wire(Vec( in_terms, UInt(sel_prec.W) )  )
	zeroadd(0) := zeromap(0) - cur_start_idx
	for (i <- 1 until in_terms){
		zeroadd(i) := zeroadd(i-1) + zeromap(i)
	}
	for (i <- 0 until in_terms){
		zeromask(i) := zeroadd(i) & Cat(Seq.fill(sel_prec)(zeromap(i)))
	}
	val onehot = Wire(Vec (out_terms, Vec (in_terms, Bool() )))
	for (j <- 0 until out_terms){
		for(i <- 0 until in_terms){
			onehot(j)(i) := (zeromask(i) === (j+1).U)
		}
		m.io.sel(j) := PriorityEncoder(onehot(j).asUInt)
		
		io.valid(j) := (onehot(j).asUInt =/= 0.U)
		
		if(j == out_terms-1){
			io.top_valid := PriorityEncoder(onehot(j).asUInt) 
		}
			
	} 
	
}



