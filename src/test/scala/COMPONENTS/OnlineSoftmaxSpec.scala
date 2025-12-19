
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

class BasicOnlineSoftmaxSpec(c: BasicOnlineSoftmax, 
    TestVector : Map[String, Array[Int]] ,
    NIters: Int = 500,
	D: Int = 1 ) extends PeekPokeTester(c) {
    
	
	//Prefill
	val dModel = 16
	val numHeads = 2
	val dK:Int =  dModel/numHeads     
	val Batch = 1
	val Seq = 16
	
	var N = Seq
	var M = Seq
	
	//Decode
	// N = 1
	// M = Seq
	
	val Head = numHeads
	val OutEmbed = dModel
	val InEmbed = dModel
	val Hidden = dModel
	
	//Data
	val S_ratio = 256
	val temps = DenseMatrix.rand[Double](Batch, N*M*numHeads)
	val S = temps.mapValues(x => (math.round(x*256).toInt % S_ratio))
				
	
	val TB = c.B
	val TN = c.N
	val TM = c.M
	val TH = c.H
	//OS
	for (b <- 0 until Batch by TB){
	for (n <- 0 until N by TN){
	for (m <- 0 until M by TM){
	for (h <- 0 until numHeads by TH){
				
		for(bb <- 0 until TB){
		for(nn <- 0 until TN){
		for(mm <- 0 until TM){
		for(hh <- 0 until TH){
			val s_raw = (mm+m) + TM*(nn+n  +  TN*(hh+h))
			val s_idx = (mm) + TM*(nn  +  TN*(hh + TH*bb))
			// println(s_idx, s_raw)
			poke( c.io.S(s_idx),  S(bb, s_raw )   )
			print(S(bb,s_raw) + ",")
			// poke( c.io.W_zeromap(w_idx ),  Wq(n+nn, i+ii) != 0  )  
			// poke( c.io.X_zeromap(x_idx),  X(b+bb, i+ii) != 0   )  
		}}}}
		
		step(D)
		for(bb <- 0 until TB){
		for(nn <- 0 until TN){
		for(hh <- 0 until TH){
			val s_idx = (nn  +  TN*(hh)) + (bb)*TN*TM*TH
			
			print("-("+s_idx+")->" + peek(c.io.OUT1(s_idx)))
		
		}}}
		print("\n")
		
	}}}}
	
	
}

object OnlineSoftmaxSpec extends App{ 
		// Testing Params

		val N = 200
		val EDAVerification = false

		val ModuleName = "BasicOnlineSoftmax"//Match class names
		val SpecName = s"${ModuleName}Spec"//Match class names
		val   TestName = "Train"
		
		val SkipSimulation =false //true// false
		val ForceSynthesis = false
		
		// Hardware Params
		var HardwareMap = Map(
		 //   "tensors" ->  Array("MM,S,M" ),
		 //   "tensors_prec" ->  Array("8,8,8")  , 
		 //   "tensors_type" ->  Array("int,int,int") , 
		 //   "iters" -> Array("b,h,m,n") ,
		 //   "iters_tiles" -> Array("1,1,8,8"),

			// "in_ports" -> Array("S,M"),
			// "out_ports" -> Array("MM"), 
			// "app_in" -> Array("none,MM,S,M"), //
			// "app_reduce" -> Array("max"),//, "none", "max"

			// "tensors_access" -> Array("b,h,m b,h,m,n b,h,m") ,
			// "tensors_movement" ->Array( "MC,MC,MC" ) ,
			// "tensors_sparse_ratio" -> Array("1,1,1") ,
			// "app_sparse" -> Array("tensors_X tensors_W" ) ,


			// "template" -> Array("GeneralSpatialArray"),

			"H" -> Array("1"),
			"N" -> Array("2"),
			"M" -> Array("2"),
			"B" -> Array("1"),				
																			
			//Precisions
			"PS" -> Array("8"),
			"PP" -> Array("12"),
			
			"PO" -> Array("8"),
			
			"PFRAC" -> Array("5"),
			
			"tech" ->Array( "tsmc40"  )
		)


		var TestVectorMap = Map(("in_0",Array(   Array(123, 1, 41, 4 )   )),
		 		         ("in_1",Array(  Array(11, 22, 3,  123)   )) )

		TestVectorMap = Map(("in_0",Array(   Array(18 ), Array(158)   )),
		 		         ("in_1",Array(  Array(38), Array(27)   )) )

		TestVectorMap = Map(("in_0",Array(       Array(5, 12, 3, 8, 233, 1 )   )),
			 		         ("in_1",Array(  Array(12, 3, 49, 1, 233, 88  )   )) )
	
	//	TestVectorMap = Helper.GenSimpleTrainingVectors(mode="bits_no_zero", p=8, dim=2)
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
							val m = new BasicOnlineSoftmax(this.HardwareConfig)
							( m  ) 
					   })( c => {
						    val mspec = new BasicOnlineSoftmaxSpec(c, 
							TestVector=this.TestVector, NIters=this.N,D=this.CLOCK) 
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

