
// // See LICENSE.txt for license details.
package units
import breeze.linalg.{DenseMatrix, DenseVector, softmax}
import breeze.numerics.sqrt



import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

import eda._
import tester.{Helper, TechNode, FullTester}
import chisel3._
import chisel3.util._
import scala.collection.mutable.Queue
import scala.collection.immutable.Map

import helper._

import play.api.libs.json._
import scala.io.Source

import breeze.linalg.DenseMatrix
import breeze.stats.distributions.{ThreadLocalRandomGenerator,RandBasis}

import breeze.stats.distributions.{RandBasis, ThreadLocalRandomGenerator}
import org.apache.commons.math3.random.MersenneTwister

// class MHA_Decoding_V1Spec(c: MHA_V1, 
//     TestVector : Map[String, Array[Int]] ,
//     N: Int = 500,
// 	D: Int = 1 ) extends PeekPokeTester(c) {

// 	// 	val dModel = 512
//  //        val numHeads = 8
//  //        val dK = 64

// // 设置固定种子(如42)
// // implicit val rb: RandBasis = new RandBasis(42)

// 	// val dModel = 16
// 	// val numHeads = 2
// 	// val dK:Int =  dModel/numHeads     
// 	// val Batch = 1
// 	// val Seq = 16

// 	val dModel = 4
// 	val numHeads = 2
// 	val dK:Int =  dModel/numHeads     
// 	val Batch = 1
// 	val Seq = 4
	
// 	val Head = numHeads
// 	val OutEmbed = dModel
// 	val InEmbed = dModel
// 	val Hidden = dModel

// 	//val X = DenseMatrix.rand[Double](Batch,Seq, InEmbed) .mapValues(_.toInt)
// 	// scala.util.Random.setSeed(123L)
// 	// val rand = new RandBasis(scala.util.Random.withSeed(123L))
// 	implicit val randBasis: RandBasis = new RandBasis(new ThreadLocalRandomGenerator(new MersenneTwister(42)))

// 	val X_ratio = 256 // X_ratio/256
// 	val W_ratio = 256 // W_ratio/256

// 	val temp = DenseMatrix.rand[Double](Batch*Seq,InEmbed)
// 	val X = temp.mapValues(x => (math.round(x*256).toInt % X_ratio))

// 	var Wq_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt) 
// 	var Wk_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt)
// 	var Wv_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt)
// 	var Wo_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt)
	
// 	val Wq = Wq_temp.mapValues(x => (math.round(x*256).toInt % W_ratio))
// 	val Wk = Wk_temp.mapValues(x => math.round(x*256).toInt)
// 	val Wv = Wv_temp.mapValues(x => math.round(x*256).toInt)
// 	val Wo = Wo_temp.mapValues(x => math.round(x*256).toInt)

// 	var VCache_temp = DenseMatrix.rand[Double](Batch*Seq, Head*dModel)//.mapValues(_.toInt) 
// 	var KCache_temp = DenseMatrix.rand[Double](Batch*Seq, Head*dModel)//.mapValues(_.toInt)
// 	val VCache = VCache_temp.mapValues(x => (math.round(x*256).toInt % W_ratio))
// 	val KCache = KCache_temp.mapValues(x => math.round(x*256).toInt)
					
	
// 	val SH = c.H1
// 	val SN = c.N1
// 	val SB = c.B1
// 	val SM = c.M1
// 	val SE = c.E1
// 	val SD = c.D1
	
// 	val DimB = Batch
// 	val DimN = 1
// 	val DimH = Head
// 	val DimM = Seq
// 	val DimD = dModel
// 	val DimE = dModel

// 	poke( c.io.LLMMode, 1)
	
// 	for(b <- 0 until DimB by SB){
// 	for(n <- 0 until DimN by SN){
// 	for(h <- 0 until DimH by SH){
// 	for(m <- 0 until DimM by SM){
// 	for(d <- 0 until DimD by SD){
			
// 		poke( c.io.N, n)
// 		poke( c.io.M, m)
// 		poke( c.io.H, h)
// 		poke( c.io.B, b)
// 		poke( c.io.O, 0)
// 		poke( c.io.D, d)
// 		poke( c.io.DimN, DimN) 
// 		poke( c.io.DimM, DimM) 
// 		poke( c.io.DimH, DimH) 
// 		poke( c.io.DimB, DimB) 
// 		poke( c.io.DimO, 1) 
// 		poke( c.io.DimD, DimD) 
// 		poke( c.io.valid, 1)
		
// 		//1. KV Cache + Query Calc 
// 		//2. KV Cache + Query Cache
// 		//3. K Calc + Query Calc
// 		//4. K Calc + Query Cache
// 		if( m < DimM - SM && m == 0 ){
			
// 		}else if( m < DimM - SM && m > 0  ){
			
// 		}else if( m >= DimM - SM && m == 0  ){
			
// 		}else{
			
// 		}
		
// 		if(m < DimM - SM){

// 			for(bb <- 0 until SB){
// 			for(nn <- 0 until SN){
// 			for(hh <- 0 until SH){
// 			for(mm <- 0 until SM){
// 			for(dd <- 0 until SD){
// 				val kidx = 
// 				val vidx = 
// 				poke( c.io.VCache(vidx)  ,VCache(n+nn + DimN*(b+bb), (d+dd) + DimD*(hh+h) )  ))
// 				poke( c.io.KCache(kidx)  ,KCache(n+nn + DimN*(b+bb), (d+dd) + DimD*(hh+h) )  ))
// 			}}}}}
// 			step(1)
// 		}else{
// 		for(e <- 0 until DimE by SE){
				
// 			poke( c.io.E, e)
// 			poke( c.io.DimE, DimE) 
					
// 				for(bb <- 0 until SB){
// 				for(nn <- 0 until SN){
// 				for(hh <- 0 until SH){
// 				for(mm <- 0 until SM){
// 				for(dd <- 0 until SD){
// 				for(ee <- 0 until SE){
					
// 					val wq_idx = ee + SE*(dd + SD*hh)
// 					val xq_idx = ee + SE*(nn + SN*bb)
// 					val wk_idx = ee + SE*(dd + SD*hh)
// 					val xk_idx = ee + SE*(nn + SN*bb)
// 					val wv_idx = ee + SE*(dd + SD*hh)
// 					val xv_idx = ee + SE*(nn + SN*bb)
										
// 					poke( c.io.Wq(wq_idx),  Wq(e+ee, (d+dd) + DimD*(hh+h) )   )  
// 					poke( c.io.Xq(xq_idx),   X(n+nn + DimN*(b+bb), e+ee  )   )
// 					poke( c.io.Wk(wk_idx),  Wk(e+ee, d+dd + DimD*(hh+h))   )
// 					poke( c.io.Xk(xk_idx),   X(n+nn + DimM*(b+bb), e+ee  )   )
// 					poke( c.io.Wv(wv_idx),  Wv(e+ee, d+dd + DimD*(hh+h))   )
// 					poke( c.io.Xv(xv_idx),   X(n+nn + DimM*(b+bb), e+ee  )   )
										  
// 				}}}}}}
				
// 				step(1)
// 				// poke(c.io.valid, 0)
// 				// step(20)
// 			}
// 			}
			
// 			}}}}}
// 	step(20)

// }




class MHA_V1Spec(c: MHA_V1, 
    TestVector : Map[String, Array[Int]] ,
    N: Int = 500,
	D: Int = 1 ) extends PeekPokeTester(c) {

	// 	val dModel = 512
 //        val numHeads = 8
 //        val dK = 64

// 设置固定种子(如42)
// implicit val rb: RandBasis = new RandBasis(42)

	// val dModel = 16
	// val numHeads = 2
	// val dK:Int =  dModel/numHeads     
	// val Batch = 1
	// val Seq = 16

	// val dModel = 8
	// val numHeads = 2
	// val dK:Int =  dModel/numHeads     
	// val Batch = 2
	// val Seq = 8

	val dModel = 8
	val numHeads = 2
	val dK:Int =  dModel/numHeads     
	val Batch = 1
	val Seq = 8

	// val dModel = 6
	// val numHeads = 2
	// val dK:Int =  dModel/numHeads     
	// val Batch = 1
	// val Seq = 4
		
	val Head = numHeads
	val OutEmbed = dModel
	val InEmbed = dModel
	val Hidden = dModel

	//val X = DenseMatrix.rand[Double](Batch,Seq, InEmbed) .mapValues(_.toInt)
	// scala.util.Random.setSeed(123L)
	// val rand = new RandBasis(scala.util.Random.withSeed(123L))
	implicit val randBasis: RandBasis = new RandBasis(new ThreadLocalRandomGenerator(new MersenneTwister(42)))

	val X_ratio = 256 // X_ratio/256
	val W_ratio = 256 // W_ratio/256

	val temp = DenseMatrix.rand[Double](Batch*Seq,InEmbed)
	val X = temp.mapValues(x => (math.round(x*256).toInt % X_ratio))

	var Wq_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt) 
	var Wk_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt)
	var Wv_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt)
	var Wo_temp = DenseMatrix.rand[Double](dModel, Head*dModel)//.mapValues(_.toInt)
	
	val Wq = Wq_temp.mapValues(x => (math.round(x*256).toInt % W_ratio))
	val Wk = Wk_temp.mapValues(x => math.round(x*256).toInt)
	val Wv = Wv_temp.mapValues(x => math.round(x*256).toInt)
	val Wo = Wo_temp.mapValues(x => math.round(x*256).toInt)
					
	
	val SH = c.H1
	val SN = c.N1
	val SB = c.B1
	val SM = c.M1
	val SE = c.E1
	val SD = c.D1
	
	val DimB = Batch
	val DimN = Seq
	val DimH = Head
	val DimM = Seq
	val DimD = dModel
	val DimE = dModel

		//Output stationary
		for(b <- 0 until DimB by SB){
		for(n <- 0 until DimN by SN){
		for(h <- 0 until DimH by SH){
		for(m <- 0 until DimM by SM){
		for(d <- 0 until DimD by SD){
		for(e <- 0 until DimE by SE){

	// 	//XS
	// 	for(b <- 0 until DimB by SB){
	// 	for(n <- 0 until DimN by SN){
	// 	for(m <- 0 until DimM by SM){
	// 	for(e <- 0 until DimE by SE){
	// 	for(h <- 0 until DimH by SH){	
	// 	for(d <- 0 until DimD by SD){

	// 	//WS
	// 	for(h <- 0 until DimH by SH){	
	// 	for(d <- 0 until DimD by SD){
	// 	for(e <- 0 until DimE by SE){
	// 	for(b <- 0 until DimB by SB){
	// 	for(n <- 0 until DimN by SN){
	// 	for(m <- 0 until DimM by SM){
					
	// 	//Key stationary 
	// 	for(b <- 0 until DimB by SB){	
	// 	for(d <- 0 until DimD by SD){
	// 	for(h <- 0 until DimH by SH){
	// 	for(m <- 0 until DimM by SM){
	// 	for(n <- 0 until DimN by SN){
	// 	for(e <- 0 until DimE by SE){		

	// 	//Query Stationary
	// 	for(b <- 0 until DimB by SB){	
	// 	for(n <- 0 until DimN by SN){
	// 	for(h <- 0 until DimH by SH){
	// 	for(d <- 0 until DimD by SD){
	// 	for(m <- 0 until DimM by SM){
	// 	for(e <- 0 until DimE by SE){		
	
	// 	//Output Stationary
	// 	for(b <- 0 until DimB by SB){
	// 	for(h <- 0 until DimH by SH){	
	// 	for(n <- 0 until DimN by SN){
	// 	for(m <- 0 until DimM by SM){
	// 	for(d <- 0 until DimD by SD){
	// 	for(e <- 0 until DimE by SE){		
		
				for(bb <- 0 until SB){
				for(nn <- 0 until SN){
				for(hh <- 0 until SH){
				for(mm <- 0 until SM){
				for(dd <- 0 until SD){
				for(ee <- 0 until SE){
					
					val wq_idx = ee + SE*(dd + SD*hh)
					val xq_idx = ee + SE*(nn + SN*bb)
					val wk_idx = ee + SE*(dd + SD*hh)
					val xk_idx = ee + SE*(mm + SM*bb)
					val wv_idx = ee + SE*(dd + SD*hh)
					val xv_idx = ee + SE*(mm + SM*bb)
					
					
					
					poke( c.io.Wq(wq_idx),  Wq(e+ee, (d+dd) + DimD*(hh+h) )   )  
					poke( c.io.Xq(xq_idx),   X(n+nn + DimN*(b+bb), e+ee  )   )
					poke( c.io.Wk(wk_idx),  Wk(e+ee, d+dd + DimD*(hh+h))   )
					poke( c.io.Xk(xk_idx),   X(m+mm + DimM*(b+bb), e+ee  )   )
					poke( c.io.Wv(wv_idx),  Wv(e+ee, d+dd + DimD*(hh+h))   )
					poke( c.io.Xv(xv_idx),   X(m+mm + DimM*(b+bb), e+ee  )   )
					  					  
					// val N = Input( UInt(32.W))
					// val M = Input( UInt(32.W))
					// val H = Input( UInt(32.W))
					// val B = Input( UInt(32.W))
					// val O = Input( UInt(32.W))
					// val E = Input( UInt(32.W))
					// val D = Input( UInt(32.W)) //0,1,2,3, ...,DDim
					  
				}}}}}}
				
				poke( c.io.N, n)
				poke( c.io.M, m)
				poke( c.io.H, h)
				poke( c.io.B, b)
				poke( c.io.O, 0)
				poke( c.io.E, e)
				poke( c.io.D, d)
				
				poke( c.io.DimN, DimN) 
				poke( c.io.DimM, DimM) 
				poke( c.io.DimH, DimH) 
				poke( c.io.DimB, DimB) 
				poke( c.io.DimO, 1) 
				poke( c.io.DimE, DimE) 
				poke( c.io.DimD, DimD) 
				
				
				poke(c.io.valid, 1)
				println("loop " + b + " " + n + " " + m + " " + h + " " + d + " " + e )
				step(1)
				// poke(c.io.valid, 0)
				// step(20)
			}}}}}}
	step(20)

}




object MHAV1Spec extends App{ 
		// Testing Params

		val N = 200
		val EDAVerification = false//false// true

		val ModuleName = "MHAV1"//Match class names
		val SpecName = s"${ModuleName}Spec"//Match class names
		val   TestName = "Train"
		
		val SkipSimulation =false //true// false
		val ForceSynthesis = false

		//KV stationary
		var TN = 1
		var TB = 1
		var TH = 1
		var TD = 2
		var TE = 2
		var TM = 1
	
		// stationary
		// TN = 4
		// TB = 1
		// TH = 1
		// TD = 1
		// TE = 4
		// TM = 4
	
		// Hardware Params
		var HardwareMap = Map(
			// //Primary Tilings
			// // K, Q               KQt, Softmax         PV                
			// "B1" -> Array("1"), "B2" -> Array("1"), "B3" -> Array("1"),  
			// "N1" -> Array("8"), "N2" -> Array("8"), "N3" -> Array("8"),  
			// "H1" -> Array("1"), "H2" -> Array("1"), "H3" -> Array("1"),   
			// "D1" -> Array("1"), "D2" -> Array("1"), 
			// "E1" -> Array("8"),						"E3" -> Array("8"),  
			// "M1" -> Array("8"), "M2" -> Array("8"), "M3" -> Array("8"),
			// 										   //V
			// 										"O3" -> Array("1"),
													
	//Primary Tilings
	// K, Q               KQt, Softmax         PV                 Residual
	"B1" -> Array(TB.toString), "B2" -> Array(TB.toString), "B3" -> Array(TB.toString),   "B4" -> Array(TB.toString),
	"N1" -> Array(TN.toString), "N2" -> Array(TN.toString), "N3" -> Array(TN.toString),   "N4" -> Array(TN.toString),
	"H1" -> Array(TH.toString), "H2" -> Array(TH.toString), "H3" -> Array(TH.toString),
	"D1" -> Array(TD.toString), "D2" -> Array(TD.toString),
	"E1" -> Array(TE.toString),                                             "E3" -> Array(TE.toString),   "E4" -> Array(TE.toString),
	"M1" -> Array(TM.toString), "M2" -> Array(TM.toString), "M3" -> Array(TM.toString),
	   //V
	"O3" -> Array(TD.toString),
								

			//Precisions
			"PX" -> Array("8"),
			"PWq" -> Array("8"),
			"PWk" -> Array("8"),
			
			"PWv" -> Array("8"),
			
			"PQ" -> Array("8"),
			"PK" -> Array("8"),
			"PS" -> Array("8"),
			"PP" -> Array("8"),
			"PO" -> Array("8"),
			"PV" -> Array("8"),
			"PSoftmaxFrac" -> Array("3"),
			
			//Network
			"XqNet" -> Array("SYS"), // MC, SYS
			"XkNet" -> Array("SYS"), // MC, SYS
			"XvNet" -> Array("SYS"), // MC, SYS
			
			"WqNet" -> Array("MC"), // MC, SYS
			"WkNet" -> Array("MC"), // MC, SYS
			"WvNet" -> Array("MC"), // MC, SYS
			
			"QNet" -> Array("MC"),// MC, SYS
			"KNet" -> Array("MC"),// MC, SYS
			"SNet" -> Array("MC"),// MC, SYS
			"VNet" -> Array("MC"),// MC, SYS
			"KNet" -> Array("MC"),// MC, SYS
			"SNet" -> Array("MC"),// MC, SYS
						
			//Cache sizes (based on addr)
			"PQCache" -> Array("6"), //6 (64), 8 (256), 10 (1024), 16 (64KB), 
			"PKCache" -> Array("6"), //6 (64), 8 (256), 10 (1024), 16 (64KB), 
			"PVCache" -> Array("6"), //6 (64), 8 (256), 10 (1024), 16 (64KB), 
			"PPCache" -> Array("6"), //6 (64), 8 (256), 10 (1024), 16 (64KB), 
			"POCache" -> Array("6"),
			"PSCache" -> Array("2"),
						
			//Systolic Set
			// val XNet = HardwareConfig.get("XNet").getOrElse("") // MC, SYS
			// val YNet = HardwareConfig.get("YNet").getOrElse("") // MC, SYS
			
			
			//Sparse Set
			// "SKIP_X" -> Array("1"),
			// "SKIP_W" -> Array("0"),
			
			"tech" -> Array( "tsmc40")  
		)

		var TestVectorMap = Map(("in_0",Array(   Array(123, 1, 41, 4 )   )),
		 		         ("in_1",Array(  Array(11, 22, 3,  123)   )) )

		TestVectorMap = Map(("in_0",Array(   Array(18 ), Array(158)   )),
		 		         ("in_1",Array(  Array(38), Array(27)   )) )

		TestVectorMap = Map(("in_0",Array(       Array(5, 12, 3, 8, 233, 1 )   )),
			 		         ("in_1",Array(  Array(12, 3, 49, 1, 233, 88  )   )) )
	
		//	TestVectorMap = Helper.GenSimpleTrainingVectors(mode="bits_no_zero", p=8, dim=2)
		//TestVectorMap = Helper.GenSimpleTrainingVectors(mode="random", p=8, dim=2)

		val RuntimeMap = Map(("CLOCK", Array(1 )),
							 ("cap_load", Array(1.00 )),//1.0)),//,0.010, 0.10, 1.0) ),
							 ("fanout_load", Array(0.100 ))
		)
		
		
		class Tester extends FullTester{
			override def driver() = {
					Driver.execute(  Array("--generate-vcd-output" , "on",
					  "--top-name", this.SpecName,
					   "--target-dir", this.TargetDir), 
					   () => {
							val m = new MHA_V1(this.HardwareConfig)
							( m  ) 
					   })( c => {
						    val mspec = new MHA_V1Spec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
					   	    ( mspec )    
						} ) 
			}
		}
		
		val m = new Tester()
		m.run(HardwareMap,
				RuntimeMap, 
				TestVectorMap,
				N,
				ModuleName=ModuleName,
				TestName=TestName,
				SpecName=SpecName,
				EDAVerification = EDAVerification,
				SkipSimulation = SkipSimulation,
				ForceSynthesis = ForceSynthesis)
		println("done")

}














