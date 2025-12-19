
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







class GeneralSparseArraySpec(c: GeneralSparseArray, 
    TestVector : Map[String, Array[Int]] ,
    N: Int = 500,
	D: Int = 1 ) extends PeekPokeTester(c) {

	// 	//val dModel = 512
 //        //val numHeads = 8
 //        //val dK = 64
 
 //        val dModel = 16
 //        val numHeads = 2
 //        val dK:Int =  dModel/numHeads     
 //        val Batch = 1
 //        val Seq = 16

 //        val Head = numHeads
 //        val OutEmbed = dModel
 //        val InEmbed = dModel
 //        val Hidden = dModel

 //        //val X = DenseMatrix.rand[Double](Batch,Seq, InEmbed) .mapValues(_.toInt)

 //        val temp = DenseMatrix.rand[Double](Batch, Seq *InEmbed)
 //        val X = temp.mapValues(x => math.round(x).toInt)


 //        val Wq = DenseMatrix.rand[Double](dModel, dModel).mapValues(_.toInt) 
 //        val Wk = DenseMatrix.rand[Double](dModel, dModel).mapValues(_.toInt)
 //        val Wv = DenseMatrix.rand[Double](dModel, dModel).mapValues(_.toInt)
 //        val Wo = DenseMatrix.rand[Double](dModel, dModel)	.mapValues(_.toInt)

 //    // primary-level Tilings
 //    // PE tiling (B,N,H)
 //    // --> MHA tilings (BNMHODE)

 //    val MM_B = c.iter2tile("b")
 //    val MM_N = c.iter2tile("n")
 //    val MM_I = c.iter2tile("i") 

 //    println("MM_B"+MM_B)
 //    println("MM_N"+MM_N)
 //    println("MM_I"+MM_I)
 //    val TB = 1
 //    val TN = MM_B
 //    val TM = MM_B
 //    val TH = 1
 //    val TO = MM_N
 //    val TD = MM_N
 //    val TE = MM_I

 //    println("TD"+TD)
 //    println("TE"+TE)
 //    if (true){ 
 //    for (b <- 0 until Batch by TB ){
 //      for(n <- 0 until Seq by TN){
 //        for (h <- 0 until Head by TH){
 //         for (o <- 0 until OutEmbed by TO ){
 //          for (m <- 0 to Seq by TM){
 //            for (d <- 0 until Hidden  by TD ){
 //              for (e <- 0 until InEmbed by TE){
 //                //load x1     // (B, N, E)
 //                //load x2     // (B, M, E) 

 //                for( bb <- 0 until TB){
 //                for( nn <- 0 until TN){
 //                for( ee <- 0 until TE){
 //                  val idx = ee + TE*nn + TE*TN*bb
 //                  val ddx = (e+ee) + InEmbed*(n+nn)
 //                  poke( c.io.In0(idx),  X(b+bb,ddx)   )  
 //                }}}

 //                for( dd <- 0 until TD){
 //                for( ee <- 0 until TE){
 //                  val idx = ee + TE*dd
 //                  poke( c.io.In1.get(idx),  Wq(ee,dd)   )  
 //                }}

 //               //println(bb+"\n"+ nn+"\n" ee+"\n"+ dd)
 //               //println("e"+e)
 //               //println("d"+d)
 //               println(b+"\n"+n+"\n"+e+"\n"+d)
 //                step(D) 


                

 //              } // end E


 //            } //end D
 //         } //end M


 //        } //end H
 //       } //end O
 //      } //end N
 //    } //end B
    

 //   }


}

object GeneralSparseArraySpec extends App{ 
		// Testing Params

		val N = 200
		val EDAVerification = false

		val ModuleName = "GeneralSparseArray"//Match class names
		val SpecName = s"${ModuleName}Spec"//Match class names
		val   TestName = "Train"
		
		val SkipSimulation =false //true// false
		val ForceSynthesis = false
		
		// Hardware Params
		var HardwareMap = Map(

			   "tensors" -> Array( "Y,W,X") ,
			   "tensors_prec" ->  Array( "8,8,8" )  , 
			   "tensors_type" ->  Array( "int,int,int"   ), 
			   
			   "iters" -> Array( "b,n,i" ),
			   "iters_tiles" -> Array( "2,2,1" ),
			   
			   "iters_second_tiles" -> Array( "2,2,1" ), //New 
			   "iters_sparse_tiles" -> Array( "2,2,4" ), //New
			   
			 "tensors_access" -> Array( "b,n n,i b,i" ),
		   "tensors_movement" -> Array( "MC,MC,MC"  ),
		   
		   "tensors_sparse_ratio" -> Array( "1,1,1" ),
		   
		   		   

		   "in_ports" -> Array("X,W"),
		   "out_ports" -> Array("Y"), 
		   "app_in" -> Array( "mult,reduceadd,Y,X,W"      ),
		   "app_reduce" -> Array( "add") ,//, "None", "Max"
		   "app_sparse" -> Array( "tensors_X tensors_W"  )  ,
					  ("tech",Array( "tsmc40"))  
		)
	



		var TestVectorMap = Map(("in_0",Array(   Array(123, 1, 41, 4 )   )),
		 		         ("in_1",Array(  Array(11, 22, 3,  123)   )) )

		TestVectorMap = Map(("in_0",Array(   Array(18 ), Array(158)   )),
		 		         ("in_1",Array(  Array(38), Array(27)   )) )

		TestVectorMap = Map(("in_0",Array(       Array(5, 12, 3, 8, 233, 1 )   )),
			 		         ("in_1",Array(  Array(12, 3, 49, 1, 233, 88  )   )) )
	
	    //TestVectorMap = Helper.GenSimpleTrainingVectors(mode="bits_no_zero", p=8, dim=2)
		//TestVectorMap = Helper.GenSimpleTrainingVectors(mode="random", p=8, dim=2)
	
	
		
		 for (i <-TestVectorMap.keys){
		 	for (k <- TestVectorMap(i)){
		 		// print( i+",")
		 		for(v <- k){
		 		//	print(v+",")
		 		}
		 		//println()
		 	}
		 }
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
						val m = new GeneralSparseArray(this.HardwareConfig)
						( m  ) 
				   })( c => {
						val mspec = new GeneralSparseArraySpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
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

