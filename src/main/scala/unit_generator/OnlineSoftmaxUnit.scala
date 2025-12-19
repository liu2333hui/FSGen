package units

// Softmax Unit
import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory,Adder2Factory}
import networks.{Multicast}

import maxmin.{MaxN}
import scala.collection.mutable.Set

import scala.collection.mutable.ArrayBuffer

import exponent.ExponentLUT

import components.{GenericPEArray,PEArrayFactory}

//Basic Softmax
// Loop1
// m max= S

// Loop2
// L += exp(S-m)

// Loop3
// P = exp(S-m)
// O = P/L

//Basic Online Softmax Unit
// Loop1
// m max= S
// P = exp(S - m)
// c = exp(m'-m)
// L *= c
// L += P
// O /= c
// O += P

// Loop2
//O = O/L

//Online Softmax Unit with Output
// Loop1
// m max= S
// P = exp(S - m)
// c = exp(m'-m)
// L *= c
// L += P
// O /= c
// O += P*V

// Loop2
//O = O/L

// m max= S
// class MaxComponent(HardwareConfig: Map[String, String]) extends Module{


//    m.io <> io
// }


//Dense no systolic , no pipeline
class BasicOnlineSoftmax(HardwareConfig: Map[String, String]) 
	extends Module{
	//Primary Tilings
	val N = HardwareConfig.get("N").getOrElse("").toInt
	val M = HardwareConfig.get("M").getOrElse("").toInt
	val H = HardwareConfig.get("H").getOrElse("").toInt
	val B = HardwareConfig.get("B").getOrElse("").toInt
	//Second Tile
	// val NN = HardwareConfig.get("NN").getOrElse("").toInt
	// val MM = HardwareConfig.get("MM").getOrElse("").toInt
	// val HH = HardwareConfig.get("HH").getOrElse("").toInt
	// val BB = HardwareConfig.get("BB").getOrElse("").toInt
	// //Sparse
	// val SN = HardwareConfig.get("SN").getOrElse("").toInt
	// val SI = HardwareConfig.get("SI").getOrElse("").toInt
	// val SB = HardwareConfig.get("SB").getOrElse("").toInt
	//Precisions
	val PS = HardwareConfig.get("PS").getOrElse("").toInt
	val PP = HardwareConfig.get("PP").getOrElse("").toInt
	val PO = HardwareConfig.get("PO").getOrElse("").toInt
	val PFRAC = HardwareConfig.get("PFRAC").getOrElse("").toInt
	
	// val PY = HardwareConfig.get("PY").getOrElse("").toInt
	
	// val PI = HardwareConfig.get("PI").getOrElse("").toInt //Intermediate
	
	val io = IO(new Bundle {
		val S = Input (Vec( B*H*N*M   , UInt (PS.W ) ) )		
		
		val OUT1 = Output (Vec( B*H*N   , UInt (PS.W)  )) 
			
		val OUTR = Output(Vec( B*H*N, UInt(PP.W)  ))
		val OUTP = Output(Vec( B*H*N*M,  UInt(PP.W)))
		
		val OUTO = Output(Vec( B*H*N*M,  UInt((PO+PS).W)))
		
		val OUTL = Output(Vec( B*H*N, UInt((PO+PS).W) ))
		//val Y = Output (Vec( SB*SN   , UInt (PY.toInt).W)  ))) 
		// val entry = new EntryIO()
		// val exit = new ExitIO()
	})


	///////////////////////////////////////
	// 1st stage	
	//0. Regs
	val max_prev = Reg(Vec(B*H*N, UInt(PS.W)))
	val max_cur = Reg(Vec( B*H*N, UInt(PS.W) ))
	io.OUT1 := max_cur

	//1. Max Unit
	val MAX_ROW = ArrayBuffer.fill(B*H*N)( Module(new MaxN(
		Map(
			"prec" -> PS.toString,
			"terms"-> M.toString
		)
	)	) )
	val MAX_PREV = ArrayBuffer.fill(B*H*N)( Module(new MaxN(
		Map(
			"prec" -> PS.toString,
			"terms" -> 2.toString
		)
	)   ))
	val TN = N
	val TH = H
	val TM = M
	for(b <- 0 until B){
		for(h <- 0 until H){
			for(n <- 0 until N){
				val idx = (n  +  TN*(h + TH*(b)))
				for(m <- 0 until M){
					val s_idx = m + TM*idx
					MAX_ROW(idx).io.in(m) := io.S(s_idx)
				}
				MAX_PREV(idx).io.in(0) := MAX_ROW(idx).io.out
				MAX_PREV(idx).io.in(1) := max_prev(idx)
				max_cur(idx) := MAX_PREV(idx).io.out
			}
		}
	}
	
	///////////////////////////////////////
	// 2nd stage
	val P = Reg(Vec(B*H*N*M, UInt(PP.W)))
	val R = Reg(Vec( B*H*N, UInt(PP.W) ))
	io.OUTR := R
	io.OUTP := P
	
	//2. Minus/Exp Unit P 
	val EXPP = ArrayBuffer.fill(B*H*N*M)( Module(new ExponentLUT( Map(
		("prec_in",   PS.toString ),
		("prec_out",  PP.toString ),
		("prec_frac", PFRAC.toString ),		
	))  ) )
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
	for(m <- 0 until M){
		val idx = (n  +  TN*(h + TH*(b)))
		val s_idx = m + TM*idx
		EXPP(s_idx).io.in := io.S(s_idx) - max_cur(idx)
		P(s_idx) := EXPP(s_idx).io.out
	}}}}
	
	//3. Minus/Exp Unit R (m-m)
	val EXPR = ArrayBuffer.fill(B*H*N)( Module(new ExponentLUT( Map(
		("prec_in",   PS.toString ),
		("prec_out",  PP.toString ),
		("prec_frac", PFRAC.toString ),		
	))  ) )
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
		val idx = (n  +  TN*(h + TH*(b)))
		EXPR(idx).io.in := max_cur(idx) - max_prev(idx)
		R(idx) := EXPR(idx).io.out
	}}}
	
	
	///////////////////////////////////////
	// 3rd stage
	val O_prev = Reg(Vec(B*H*N*M, UInt(PO.W)))
	val O_cur = Reg(Vec(B*H*N*M, UInt((PO+PS).W)))
	// val L = Reg(Vec( B*H*N, UInt(PO.W) ))
	// io.OUTL := L
	io.OUTO := O_cur
	
	//4. Output
	val OUT_MULT = ArrayBuffer.fill(B*H*N*M)( Module(Multiplier2Factory.create( 
	   Map[String, String](
	   		"prec1" -> PO.toString,
	   		"prec2" -> PS.toString,
	   		"prec_out" -> (PO+PS).toString, 
	   
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
	   ))	)  
	val OUT_ADD = ArrayBuffer.fill(B*H*N*M)( Module( Adder2Factory.create(
		Map(("prec_sum",(PO+PS).toString),
		  ("prec1",(PO+PS).toString),
		  ("prec2",(PP).toString),
		  ("same_prec",false.toString),
		  ("buffered",false.toString),
		  ("adderType","SimpleAdder2"),
		  ("signed", true.toString))
	)))
	
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
	for(m <- 0 until M){
		val idx = (n  +  TN*(h + TH*(b)))
		val s_idx = m + TM*idx
		OUT_MULT(s_idx).io.A := O_prev(s_idx)
		OUT_MULT(s_idx).io.B := max_cur(idx)
		
		OUT_MULT(s_idx).io.entry.valid := 1.B
		OUT_MULT(s_idx).io.exit.ready := 1.B
		
		OUT_ADD(s_idx).io.A := OUT_MULT(s_idx).io.Out
		OUT_ADD(s_idx).io.B := P(s_idx)
		
		
		OUT_ADD(s_idx).io.entry.valid := 1.B
		OUT_ADD(s_idx).io.exit.ready := 1.B
		OUT_ADD(s_idx).io.Cin := 0.B
		
		O_cur(s_idx) := OUT_ADD(s_idx).io.Sum

	}}}}
	
	//5. Denominator
	val L_prev = Reg(Vec(B*H*N, UInt(PO.W)))
	val L_cur = Reg(Vec(B*H*N, UInt(PP.W)))
	io.OUTL := L_cur
	
	val L_MULT = ArrayBuffer.fill(B*H*N*M)( Module(Multiplier2Factory.create( 
	   Map[String, String](
	   		"prec1" -> PO.toString,
	   		"prec2" -> PS.toString,
	   		"prec_out" -> (PO+PS).toString, 
	   
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
	   ))	)  
	val L_REDUCE = ArrayBuffer.fill(B*H*N)( Module( AdderNFactory.create(
		Map(  ("prec_in",  PP.toString  ),
			  ("prec_sum", PP.toString ),
			  ("adderNType", "SimpleAdderN" ), //AddTreeN
			  ("adderType", "SimpleAdder2" ),
			  ("terms",  M.toString ),
			  ("signed", true.toString ),
			  ("same_prec", true.toString ),
			  ("pipelined", false.toString),
			  ("buffered", false.toString),
			  ("auto_prec_sum", true.toString)
			)
				  
	)))
	
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
	for(m <- 0 until M){
		val idx = (n  +  TN*(h + TH*(b)))
		val s_idx = m + TM*idx
		
		L_MULT(s_idx).io.A := L_prev(idx)
		L_MULT(s_idx).io.B := max_cur(idx)
		L_MULT(s_idx).io.entry.valid := 1.B
		L_MULT(s_idx).io.exit.ready := 1.B
		
		L_REDUCE(idx).io.A(m) := P(s_idx)
		L_REDUCE(idx).io.entry.valid:= 1.B
		L_REDUCE(idx).io.exit.ready := 1.B
		
		L_cur(idx) := OUT_MULT(s_idx).io.Out  + L_REDUCE(idx).io.Sum

	}}}}
		
	
	//6. Final
	
	
}





//Dense no systolic , W/ pipeline
class BasicPipelinedSoftmax(HardwareConfig: Map[String, String]) 
	extends Module{
	//Primary Tilings
	val N = HardwareConfig.get("N").getOrElse("").toInt
	val M = HardwareConfig.get("M").getOrElse("").toInt
	val H = HardwareConfig.get("H").getOrElse("").toInt
	val B = HardwareConfig.get("B").getOrElse("").toInt
	//Second Tile
	// val NN = HardwareConfig.get("NN").getOrElse("").toInt
	// val MM = HardwareConfig.get("MM").getOrElse("").toInt
	// val HH = HardwareConfig.get("HH").getOrElse("").toInt
	// val BB = HardwareConfig.get("BB").getOrElse("").toInt
	// //Sparse
	// val SN = HardwareConfig.get("SN").getOrElse("").toInt
	// val SI = HardwareConfig.get("SI").getOrElse("").toInt
	// val SB = HardwareConfig.get("SB").getOrElse("").toInt
	//Precisions
	val PS = HardwareConfig.get("PS").getOrElse("").toInt
	val PP = HardwareConfig.get("PP").getOrElse("").toInt
	val PO = HardwareConfig.get("PO").getOrElse("").toInt
	val PFRAC = HardwareConfig.get("PFRAC").getOrElse("").toInt
	
	// val PY = HardwareConfig.get("PY").getOrElse("").toInt
	
	// val PI = HardwareConfig.get("PI").getOrElse("").toInt //Intermediate
	
	val io = IO(new Bundle {
		val S = Input (Vec( B*H*N*M   , UInt (PS.W ) ) )		
		
		val OUT1 = Output (Vec( B*H*N   , UInt (PS.W)  )) 
			
		val OUTR = Output(Vec( B*H*N, UInt(PP.W)  ))
		val OUTP = Output(Vec( B*H*N*M,  UInt(PP.W)))
		
		val OUTO = Output(Vec( B*H*N*M,  UInt((PO+PS).W)))
		
		val OUTL = Output(Vec( B*H*N, UInt((PO+PS).W) ))
		//val Y = Output (Vec( SB*SN   , UInt (PY.toInt).W)  ))) 
		// val entry = new EntryIO()
		// val exit = new ExitIO()
	})


	///////////////////////////////////////
	// 1st stage	
	//0. Regs
	val max_prev = Reg(Vec(B*H*N, UInt(PS.W)))
	val max_cur = Reg(Vec( B*H*N, UInt(PS.W) ))
	io.OUT1 := max_cur

	//1. Max Unit
	val MAX_ROW = ArrayBuffer.fill(B*H*N)( Module(new MaxN(
		Map(
			"prec" -> PS.toString,
			"terms"-> M.toString
		)
	)	) )
	val MAX_PREV = ArrayBuffer.fill(B*H*N)( Module(new MaxN(
		Map(
			"prec" -> PS.toString,
			"terms" -> 2.toString
		)
	)   ))
	val TN = N
	val TH = H
	val TM = M
	for(b <- 0 until B){
		for(h <- 0 until H){
			for(n <- 0 until N){
				val idx = (n  +  TN*(h + TH*(b)))
				for(m <- 0 until M){
					val s_idx = m + TM*idx
					MAX_ROW(idx).io.in(m) := io.S(s_idx)
				}
				MAX_PREV(idx).io.in(0) := MAX_ROW(idx).io.out
				MAX_PREV(idx).io.in(1) := max_prev(idx)
				max_cur(idx) := MAX_PREV(idx).io.out
			}
		}
	}
	
	///////////////////////////////////////
	// 2nd stage
	val P = Reg(Vec(B*H*N*M, UInt(PP.W)))
	val R = Reg(Vec( B*H*N, UInt(PP.W) ))
	io.OUTR := R
	io.OUTP := P
	
	//2. Minus/Exp Unit P 
	val EXPP = ArrayBuffer.fill(B*H*N*M)( Module(new ExponentLUT( Map(
		("prec_in",   PS.toString ),
		("prec_out",  PP.toString ),
		("prec_frac", PFRAC.toString ),		
	))  ) )
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
	for(m <- 0 until M){
		val idx = (n  +  TN*(h + TH*(b)))
		val s_idx = m + TM*idx
		EXPP(s_idx).io.in := io.S(s_idx) - max_cur(idx)
		P(s_idx) := EXPP(s_idx).io.out
	}}}}
	
	//3. Minus/Exp Unit R (m-m)
	val EXPR = ArrayBuffer.fill(B*H*N)( Module(new ExponentLUT( Map(
		("prec_in",   PS.toString ),
		("prec_out",  PP.toString ),
		("prec_frac", PFRAC.toString ),		
	))  ) )
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
		val idx = (n  +  TN*(h + TH*(b)))
		EXPR(idx).io.in := max_cur(idx) - max_prev(idx)
		R(idx) := EXPR(idx).io.out
	}}}
	
	
	///////////////////////////////////////
	// 3rd stage
	val O_prev = Reg(Vec(B*H*N*M, UInt(PO.W)))
	val O_cur = Reg(Vec(B*H*N*M, UInt((PO+PS).W)))
	// val L = Reg(Vec( B*H*N, UInt(PO.W) ))
	// io.OUTL := L
	io.OUTO := O_cur
	
	//4. Output
	val OUT_MULT = ArrayBuffer.fill(B*H*N*M)( Module(Multiplier2Factory.create( 
	   Map[String, String](
	   		"prec1" -> PO.toString,
	   		"prec2" -> PS.toString,
	   		"prec_out" -> (PO+PS).toString, 
	   
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
	   ))	)  
	val OUT_ADD = ArrayBuffer.fill(B*H*N*M)( Module( Adder2Factory.create(
		Map(("prec_sum",(PO+PS).toString),
		  ("prec1",(PO+PS).toString),
		  ("prec2",(PP).toString),
		  ("same_prec",false.toString),
		  ("buffered",false.toString),
		  ("adderType","SimpleAdder2"),
		  ("signed", true.toString))
	)))
	
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
	for(m <- 0 until M){
		val idx = (n  +  TN*(h + TH*(b)))
		val s_idx = m + TM*idx
		OUT_MULT(s_idx).io.A := O_prev(s_idx)
		OUT_MULT(s_idx).io.B := max_cur(idx)
		
		OUT_MULT(s_idx).io.entry.valid := 1.B
		OUT_MULT(s_idx).io.exit.ready := 1.B
		
		OUT_ADD(s_idx).io.A := OUT_MULT(s_idx).io.Out
		OUT_ADD(s_idx).io.B := P(s_idx)
		
		
		OUT_ADD(s_idx).io.entry.valid := 1.B
		OUT_ADD(s_idx).io.exit.ready := 1.B
		OUT_ADD(s_idx).io.Cin := 0.B
		
		O_cur(s_idx) := OUT_ADD(s_idx).io.Sum

	}}}}
	
	//5. Denominator
	val L_prev = Reg(Vec(B*H*N, UInt(PO.W)))
	val L_cur = Reg(Vec(B*H*N, UInt(PP.W)))
	io.OUTL := L_cur
	
	val L_MULT = ArrayBuffer.fill(B*H*N*M)( Module(Multiplier2Factory.create( 
	   Map[String, String](
	   		"prec1" -> PO.toString,
	   		"prec2" -> PS.toString,
	   		"prec_out" -> (PO+PS).toString, 
	   
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
	   ))	)  
	val L_REDUCE = ArrayBuffer.fill(B*H*N)( Module( AdderNFactory.create(
		Map(  ("prec_in",  PP.toString  ),
			  ("prec_sum", PP.toString ),
			  ("adderNType", "SimpleAdderN" ), //AddTreeN
			  ("adderType", "SimpleAdder2" ),
			  ("terms",  M.toString ),
			  ("signed", true.toString ),
			  ("same_prec", true.toString ),
			  ("pipelined", false.toString),
			  ("buffered", false.toString),
			  ("auto_prec_sum", true.toString)
			)
				  
	)))
	
	for(b <- 0 until B){
	for(h <- 0 until H){
	for(n <- 0 until N){
	for(m <- 0 until M){
		val idx = (n  +  TN*(h + TH*(b)))
		val s_idx = m + TM*idx
		
		L_MULT(s_idx).io.A := L_prev(idx)
		L_MULT(s_idx).io.B := max_cur(idx)
		L_MULT(s_idx).io.entry.valid := 1.B
		L_MULT(s_idx).io.exit.ready := 1.B
		
		L_REDUCE(idx).io.A(m) := P(s_idx)
		L_REDUCE(idx).io.entry.valid:= 1.B
		L_REDUCE(idx).io.exit.ready := 1.B
		
		L_cur(idx) := OUT_MULT(s_idx).io.Out  + L_REDUCE(idx).io.Sum

	}}}}
		
	
	//6. Final
	
	// (todos)
	
	// Pipelined, once the M == final, done, then output result and output valids
	
	
}






/*
class ExpComponent(HardwareConfig: Map[String, String]) extends Module{

}
class BasicSoftmax(HardwareConfig: Map[String, String]) extends Module{

}


class OnlineSoftmaxWithOutput(HardwareConfig: Map[String, String]) extends Module{


}
*/




