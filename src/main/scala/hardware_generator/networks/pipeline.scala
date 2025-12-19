//Parallel2Serial, Serializer
package networks

import chisel3._
import chisel3.util._
import scala.collection.mutable.Queue
import helper._
  
class PipelineChainValid( HardwareConfig:Map[String, String] ) extends Module{
	
	val depth:Int = HardwareConfig("depth").toInt
	val prec:Int  = 1//HardwareConfig("prec").toInt //Ratio, terms:1
	
	val io = IO(new Bundle{
		val validin = Input( Bool() )
		val out_allow = Input(  Bool()  )
		
		val validout = Output( Bool() )
		
		val data_update = Output(Vec(depth, Bool()))
		
		val validout_internal = Output( Vec(depth,Bool() ))
		
		val pipe_ready_go = Input(Vec(depth, Bool() ))
		val pipe_allowin = Output(Bool())
	})
	
	
	val m = Module(new PipelineChain(
		HardwareConfig + ("prec" -> prec.toString)
	))
	
	m.io.validin := io.validin
	m.io.datain := 0.U
	m.io.out_allow := io.out_allow
	
	io.validout := m.io.validout
	
	m.io.pipe_ready_go := io.pipe_ready_go
	io.pipe_allowin := m.io.pipe_allowin
	
	for(d <- 0 until depth){
		io.data_update(d) :=	m.io.validin_internal(d) & m.io.pipe_allowin_internal(d)
	}
	
	io.validout_internal := m.io.validout_internal
	
}

class PipelineChain( HardwareConfig:Map[String, String]) extends Module{

	val depth:Int = HardwareConfig("depth").toInt
	val prec:Int  = HardwareConfig("prec").toInt //Ratio, terms:1
	

	val io = IO(new Bundle{
		val validin = Input( Bool() )
		val datain  = Input( UInt(prec.W))
		val out_allow = Input(  Bool()  )
		
		val validout = Output( Bool() )
		val dataout = Output( UInt(prec.W) )
		
		
		val validin_internal = Output(Vec(depth, Bool() ))
		val pipe_allowin_internal = Output(Vec(depth, Bool()))
		val validout_internal = Output(Vec(depth, Bool()))
		
		val pipe_ready_go = Input(Vec(depth, Bool() ))
		val pipe_allowin = Output(Bool())
	})
	
	
    val cur_pea =  Array.fill(depth)( Module(new PipelineUnit(HardwareConfig) )	)  
	
	for(d <- 0 until depth){
		val p = cur_pea(d)
		p.io.pipe1_ready_go := io.pipe_ready_go(d)
	}
	
	val f = cur_pea(0)
	f.io.validin := io.validin
	f.io.datain  := io.datain
	
	io.validin_internal(0) := io.validin
	io.pipe_allowin_internal(0) := io.pipe_allowin
	
	io.pipe_allowin := f.io.pipe_allowin
	
	val w = cur_pea(depth-1)
	w.io.out_allow := io.out_allow
	io.validout := w.io.validout
	io.dataout := w.io.dataout
	
	io.validout_internal(0) := f.io.pipe_valid_reg
	
	for (d <- 1 until depth){
		val p = cur_pea(d-1)
		val pp = cur_pea(d)
		
		io.validout_internal(d) := pp.io.pipe_valid_reg
		
		io.validin_internal(d) := pp.io.validin
		
		io.pipe_allowin_internal(d) := pp.io.pipe_allowin
		
		pp.io.validin := p.io.validout
		pp.io.datain := p.io.dataout

		p.io.out_allow := pp.io.pipe_allowin		
	}
	
	
}


class PipelineUnit( HardwareConfig:Map[String, String]) 
	extends Module{

   val prec:Int  = HardwareConfig("prec").toInt //Ratio, terms:1

	val io = IO(new Bundle{

		val validin = Input(Bool())
		val datain = Input( UInt(prec.W)  )
		val out_allow = Input(    Bool()  )
		
		val validout  = Output(   Bool()  )
		val dataout = Output( UInt(prec.W) )
	
		val pipe1_ready_go = Input(Bool())
		val pipe_allowin = Output(Bool())
	
		val pipe_valid_reg = Output(Bool())
	})
	
	//One pipeline stage
	val pipe_valid = RegInit(false.B)
	val pipe_data = Reg(UInt(prec.W))

	io.pipe_valid_reg := pipe_valid
	
	when(io.pipe_allowin){
		pipe_valid := io.validin
	}
	
	when(io.validin && io.pipe_allowin){
		pipe_data := io.datain
	}
	//pipelining logic
	io.pipe_allowin := !pipe_valid || io.pipe1_ready_go && io.out_allow
	
	//Output
	io.validout := pipe_valid && io.pipe1_ready_go
	io.dataout  := pipe_data
	
	

}
