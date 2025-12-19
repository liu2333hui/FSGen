package logic
import chisel3._
import chisel3.util._
import scala.collection.mutable.Queue
// import networks.{Mux2}

class Equals2( HardwareConfig:Map[String, String]) extends Module {
	
  val prec:Int = HardwareConfig("prec").toInt
	
  val io = IO(new Bundle {
    val in0    = Input(UInt(prec.W))
    val in1    = Input(UInt(prec.W))
	val out = Output(Bool())
  })  
  
	io.out := (io.in0 === io.in1)

}

class Filter2( HardwareConfig:Map[String, String]) extends Module {
	
  val prec:Int = HardwareConfig("prec").toInt
	
  val io = IO(new Bundle {
    val in0    = Input(UInt(prec.W))
    val in1    = Input(UInt(prec.W))
	val out = Output(UInt(prec.W))
  })  
  
	io.out := Mux((io.in0 === io.in1), io.in0, 0.U)

}

class MultiFilter2( HardwareConfig:Map[String, String]) extends Module {
	
  val prec:Int = HardwareConfig("prec").toInt
  val terms:Int = HardwareConfig("terms").toInt
		
  val io = IO(new Bundle {
    val in0    = Input(Vec(terms,UInt(prec.W)))
    val in1    = Input(Vec(terms,UInt(prec.W)))
	val out    = Output(Vec(terms,UInt(prec.W)))
  })  
  
	for(t <- 0 until terms){
		val m = Module(new Filter2(HardwareConfig))
		m.io.in0 := io.in0(t)
		m.io.in1 := io.in1(t)
		io.out(t) := m.io.out 
	}
	
}




//Equals

//Greater Than or Equal （can be tree)

//Greater Than (can be tree)