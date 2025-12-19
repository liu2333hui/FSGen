
// // See LICENSE.txt for license details.
package components
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
class BaselineSystolicPESpec(c: BaselineSystolicPE, 
    TestVector : Map[String, Array[Int]] ,
    N: Int = 500,
	D: Int = 1 ) extends PeekPokeTester(c) {

	// 	val dModel = 512
 //        val numHeads = 8
 //        val dK = 64

// 设置固定种子(如42)
// implicit val rb: RandBasis = new RandBasis(42)

	val dModel = 16
	val numHeads = 2
	val dK:Int =  dModel/numHeads     
	val Batch = 1
	val Seq = 16

	// val dModel = 4
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

	var Wq_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt) 
	var Wk_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt)
	var Wv_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt)
	var Wo_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt)
	
	val Wq = Wq_temp.mapValues(x => (math.round(x*256).toInt % W_ratio))
	val Wk = Wk_temp.mapValues(x => math.round(x*256).toInt)
	val Wv = Wv_temp.mapValues(x => math.round(x*256).toInt)
	val Wo = Wo_temp.mapValues(x => math.round(x*256).toInt)
					
	
	val SI = c.I
	val SN = c.N
	val SB = c.B

	//OS
	for (b <- 0 until Batch*Seq by SB ){
		for (n <- 0 until dModel by SN){
			for (i <- 0 until dModel by SI){
	
	//IS
	// for (b <- 0 until Batch*Seq by SB ){
	// 	for (i <- 0 until dModel by SI){
	// 		for (n <- 0 until dModel by SN){
	
	// WS
	// 	for (n <- 0 until dModel by SN){
	// 	  for (i <- 0 until dModel by SI){
	//		for (b <- 0 until Batch*Seq by SB ){
	
				for(bb <- 0 until SB){
				for(nn <- 0 until SN){
				for(ii <- 0 until SI){
					val w_idx = ii + SI*nn
					val x_idx = ii + SI*bb
					poke( c.io.W(w_idx),  Wq(n+nn, i+ii)   )  
					poke( c.io.X(x_idx),   X(b+bb, i+ii)   )  
				}}}
				
				poke(c.io.valid, 1)
				step(1)
				// poke(c.io.valid, 0)
				// step(20)
			}
		}
	}
	step(20)

}




object BaselineSystolicPESpec extends App{ 
		// Testing Params

		val N = 200
		val EDAVerification = false//false// true

		val ModuleName = "BaselineSystolicPE"//Match class names
		val SpecName = s"${ModuleName}Spec"//Match class names
		val   TestName = "Train"
		
		val SkipSimulation =false //true// false
		val ForceSynthesis = false
		
		// Hardware Params
		var HardwareMap = Map(
			//Tiling
			"N" -> Array("2"),
			"I" -> Array("1"),
			"B" -> Array("4"),		
														
			//Precisions
			"PW" -> Array("8"),
			"PX" -> Array("8"),
			"PY" -> Array("8"),
			"PI" -> Array("16"),
			
			"PY" -> Array("8"),
			
			//Systolic Set
			// val XNet = HardwareConfig.get("XNet").getOrElse("") // MC, SYS
			// val YNet = HardwareConfig.get("YNet").getOrElse("") // MC, SYS
			
			"XNet" -> Array("MC"),
			"WNet" -> Array("MC"),
			"YNet" -> Array("MC"),
			
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
							val m = new BaselineSystolicPE(this.HardwareConfig)
							( m  ) 
					   })( c => {
						    val mspec = new BaselineSystolicPESpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
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






















class GEMMBaselinePESpec(c: GEMMBaselinePE, 
    TestVector : Map[String, Array[Int]] ,
    N: Int = 500,
	D: Int = 1 ) extends PeekPokeTester(c) {

	// 	val dModel = 512
 //        val numHeads = 8
 //        val dK = 64
 
        val dModel = 16
        val numHeads = 2
        val dK:Int =  dModel/numHeads     
        val Batch = 1
        val Seq = 16

        val Head = numHeads
        val OutEmbed = dModel
        val InEmbed = dModel
        val Hidden = dModel

        //val X = DenseMatrix.rand[Double](Batch,Seq, InEmbed) .mapValues(_.toInt)

		val ratio = 4
        val X_ratio = ratio // X_ratio/256
		val X_ratio_b = 256
		val W_ratio = ratio // W_ratio/256

        val temp = DenseMatrix.rand[Double](Batch*Seq,InEmbed)
        val X = temp.mapValues(x => (math.round(x*256).toInt ))


        var Wq_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt) 
        var Wk_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt)
        var Wv_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt)
        var Wo_temp = DenseMatrix.rand[Double](dModel, dModel)//.mapValues(_.toInt)
		
		val Wq = Wq_temp.mapValues(x => (math.round(x*256).toInt ))
		val Wk = Wk_temp.mapValues(x => math.round(x*256).toInt)
		val Wv = Wv_temp.mapValues(x => math.round(x*256).toInt)
		val Wo = Wo_temp.mapValues(x => math.round(x*256).toInt)
			
		for(i <- 0 until dModel){
			for(n <-0 until  dModel){
				if(n % W_ratio == 0){
					Wq(i,n) = 0
				}
			}
		}
		for(i <- 0 until Batch*Seq){
			for(n <- 0 until InEmbed){
				if(n % X_ratio == 0){
					X(i,n) = 0
				}
				if(i % X_ratio_b == 0){
					X(i,n) = 0
				}
			}
		}		

    // primary-level Tilings
    // PE tiling (B,N,H)
    // --> MHA tilings (BNMHODE)

    // val MM_B = c.iter2tile("b")
    // val MM_N = c.iter2tile("n")
    // val MM_I = c.iter2tile("i") 

    // println("MM_B"+MM_B)
    // println("MM_N"+MM_N)
    // println("MM_I"+MM_I)
    // val TB = 1
    // val TN = MM_B
    // val TM = MM_B
    // val TH = 1
    // val TO = MM_N
    // val TD = MM_N
    // val TE = MM_I

    // println("TD"+TD)
    // println("TE"+TE)
	
	val SI = c.SI
	val SN = c.SN
	val SB = c.SB

	//OS
	for (b <- 0 until Batch*Seq by SB ){
		for (n <- 0 until dModel by SN){
			for (i <- 0 until dModel by SI){
	
	//IS
	// for (b <- 0 until Batch*Seq by SB ){
	// 	for (i <- 0 until dModel by SI){
	// 		for (n <- 0 until dModel by SN){
	
	// WS
	// 	for (n <- 0 until dModel by SN){
	// 	  for (i <- 0 until dModel by SI){
	//		for (b <- 0 until Batch*Seq by SB ){
	
				for(bb <- 0 until SB){
				for(nn <- 0 until SN){
				for(ii <- 0 until SI){
					val w_idx = ii + SI*nn
					val x_idx = ii + SI*bb
					poke( c.io.W(w_idx),  Wq(n+nn, i+ii)   )  
					poke( c.io.X(x_idx),   X(b+bb, i+ii)   )  
					
					poke( c.io.W_zeromap(w_idx ),  Wq(n+nn, i+ii) != 0  )  
					poke( c.io.X_zeromap(x_idx),  X(b+bb, i+ii) != 0   )  
				}}}
				poke(c.io.ready, 1)
				// step(1)
				do{
					step(D)
					poke(c.io.ready,0)
					//poke(c.io.entry.valid,0)		
				} while ( peek(c.io.valid) == 0  )
				
				// poke(c.io.ready,0)
				// step(9)
			}
		}
	}
		
		
    // for (b <- 0 until Batch by TB ){
    //   for(n <- 0 until Seq by TN){
    //     for (h <- 0 until Head by TH){
    //      for (o <- 0 until OutEmbed by TO ){
    //       for (m <- 0 to Seq by TM){
    //         for (d <- 0 until Hidden  by TD ){
    //           for (e <- 0 until InEmbed by TE){
    //             //load x1     // (B, N, E)
    //             //load x2     // (B, M, E) 

    //             for( bb <- 0 until TB){
    //             for( nn <- 0 until TN){
    //             for( ee <- 0 until TE){
    //               val idx = ee + TE*nn + TE*TN*bb
    //               val ddx = (e+ee) + InEmbed*(n+nn)
    //               poke( c.io.In0(idx),  X(b+bb,ddx)   )  
    //             }}}

    //             for( dd <- 0 until TD){
    //             for( ee <- 0 until TE){
    //               val idx = ee + TE*dd
    //               poke( c.io.In1.get(idx),  Wq(ee,dd)   )  
    //             }}

    //            //println(bb+"\n"+ nn+"\n" ee+"\n"+ dd)
    //            //println("e"+e)
    //            //println("d"+d)
    //            println(b+"\n"+n+"\n"+e+"\n"+d)
    //             step(D) 


                

    //           } // end E


    //         } //end D
    //      } //end M


    //     } //end H
    //    } //end O
    //   } //end N
    // } //end B


}

object GEMMBaselinePESpec extends App{ 
		// Testing Params

		val N = 200
		val EDAVerification = false//false// true

		val ModuleName = "GEMMBaselinePE"//Match class names
		val SpecName = s"${ModuleName}Spec"//Match class names
		val   TestName = "Train"
		
		val SkipSimulation =false //true// false
		val ForceSynthesis = false
		
		// Hardware Params
		var HardwareMap = Map(

		//	"tensors" -> Array( "Q,W,X") ,
		//	"tensors_prec" ->  Array( "8,8,8" )  , 
		//	"tensors_type" ->  Array( "int,int,int"   ), 
		//	"iters" -> Array( "b,s,e,hd"  ),
		//	"iters_tiles" -> Array( "2,2,1,1" ),
		//	"tensors_access" -> Array( "b,s,hd e,hd b,s,e" ),
		//	"tensors_movement" -> Array( "MC,MC,MC"  ),
		//	"tensors_sparse_ratio" -> Array( "1,1,1" ),

		//	"in_ports" -> Array("X,W"),
		//	"out_ports" -> Array("Q"), 
		//	"app_in" -> Array( "mult,Q,X,W"      ),
		//	"app_reduce" -> Array( "add") ,//, "None", "Max"
		//	"app_sparse" -> Array( "tensors_X tensors_W"  )  ,
			
			"SN" -> Array("2"),"NN" -> Array("2"),"N" -> Array("2"),
			"SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			"SB" -> Array("4"),"BB" -> Array("2"),"B" -> Array("1"),		
		
			// "SN" -> Array("2"),"NN" -> Array("2"),"N" -> Array("2"),
			// "SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			// "SB" -> Array("4"),"BB" -> Array("2"),"B" -> Array("2"),
			
			// "SN" -> Array("2"),"NN" -> Array("2"),"N" -> Array("2"),
			// "SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			// "SB" -> Array("2"),"BB" -> Array("2"),"B" -> Array("2"),			
			
			// "SN" -> Array("2"),"NN" -> Array("2"),"N" -> Array("2"),
			// "SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			// "SB" -> Array("4"),"BB" -> Array("2"),"B" -> Array("1"),
			
			// "SN" -> Array("2"),"NN" -> Array("2"),"N" -> Array("2"),
			// "SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			// "SB" -> Array("4"),"BB" -> Array("2"),"B" -> Array("2"),
		
			// "SN" -> Array("2"),"NN" -> Array("2"),"N" -> Array("1"),
			// "SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			// "SB" -> Array("4"),"BB" -> Array("2"),"B" -> Array("1"),

			// "SN" -> Array("4"),"NN" -> Array("2"),"N" -> Array("1"),
			// "SI" -> Array("4"),"II" -> Array("2"),"I" -> Array("2"),
			// "SB" -> Array("4"),"BB" -> Array("2"),"B" -> Array("1"),
						
			// "SN" -> Array("4"),"NN" -> Array("4"),"N" -> Array("4"),
			// "SI" -> Array("4"),"II" -> Array("4"),"I" -> Array("4"),
			// "SB" -> Array("4"),"BB" -> Array("4"),"B" -> Array("4"),						
						
			// "SN" -> Array("4"),"NN" -> Array("4"),"N" -> Array("1"),
			// "SI" -> Array("4"),"II" -> Array("4"),"I" -> Array("4"),
			// "SB" -> Array("4"),"BB" -> Array("4"),"B" -> Array("1"),
			
			// "SN" -> Array("4"),"NN" -> Array("4"),"N" -> Array("2"),
			// "SI" -> Array("4"),"II" -> Array("4"),"I" -> Array("4"),
			// "SB" -> Array("4"),"BB" -> Array("4"),"B" -> Array("1"),
																			
			//Precisions
			"PW" -> Array("8"),
			"PX" -> Array("8"),
			"PY" -> Array("8"),
			"PI" -> Array("16"),
			
			//Sparse Set
			"SKIP_X" -> Array("1"),
			"SKIP_W" -> Array("1"),
			
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
							val m = new GEMMBaselinePE(this.HardwareConfig)
							( m  ) 
					   })( c => {
						    val mspec = new GEMMBaselinePESpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
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

