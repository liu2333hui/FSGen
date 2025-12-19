package exponent

import chisel3._
import chisel3.util._

import memories.LUT
import java.lang.Math



class ExponentComp( HardwareConfig: Map[String, String]) extends Module{
  val prec_in:Int = HardwareConfig("prec_in").toInt
  val prec_out:Int = HardwareConfig("prec_out").toInt
  val io = IO(new Bundle {
    // 输入索引，因为有 256 行，所以索引需要 8 位
    val in = Input(UInt(prec_in.W))
    // 输出数据，这里假设数据位宽为 32 位，可按需修改
    val out = Output(UInt(prec_out.W))
  })		
}

// class BinaryShiftExponentLUT( HardwareConfig:Map[String, String]) extends 
//     LUT(HardwareConfig) {

// }

//AI half generated
//Should support signed numbers
class ExponentLUT( HardwareConfig:Map[String, String]) extends 
    ExponentComp(HardwareConfig) {
	
  // 这里可以根据需要初始化 LUT 的内容
  // 示例：将 LUT 初始化为索引值乘以 2
  //Max value
  
  val lut = Mem(1<<prec_in, UInt(prec_out.W))
  
  io.out := lut(io.in)
  
   val prec_frac:Int = HardwareConfig("prec_frac").toInt
  
  
  for (i <- 0 until (1 << prec_in) ) {
    // var expValue = 1.0
    val sign = (i > (1<<(prec_in-1)))
    // var x = (i % (1<<(prec_in-1))).toDouble / (1<<(prec_in-1))
	
	var a = (i >> prec_frac).U
	var b = i & (1 << (prec_frac-1)-1)
	
	var x = i & ((1 << (prec_in-1)) -1)
	
	var expValue = Math.exp(x /(1<< prec_frac))
	
	
	if(sign){
        expValue =  Math.exp(-x /(1<< prec_frac).toDouble)
    }else{
        expValue =  Math.exp(x /(1<< prec_frac).toDouble)
    }
	// println()
	
	// println(i + "," + expValue)
	// val max_value = 
	if((expValue *(1<< prec_frac)).toInt 
		> ((1<<prec_out)-1)){
		lut(i) := ((1<<prec_out) - 1).U
	}else{
		lut(i) := (expValue *(1<< prec_frac)).toInt.U//x.U//(expValue * (1 << (prec_frac-1))).toInt.U
	}
    // (expValue * (1 << prec_out))
    // lut(i) := (i * 2).U
  }

}
