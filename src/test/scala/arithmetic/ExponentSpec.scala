// // See LICENSE.txt for license details.
package exponent

import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

import eda._
import tester.{Helper, TechNode, FullTester}
import chisel3._
import chisel3.util._
import scala.collection.mutable.Queue
import helper._

import play.api.libs.json._
import scala.io.Source

import play.api.libs.json._



class ExponentLUTSpec(c: ExponentLUT, 
    TestVector : Map[String, Array[Int]] ,
    N: Int = 500,
	D: Int = 1 ) extends PeekPokeTester(c) {

    val cc = c
	
	for (k <- 0 until (1<<c.prec_in.toInt )){
		poke(c.io.in , k)
		step(D)
		println("exp("+(k/(1<<c.prec_frac).toDouble) +")=" + 
			(peek(c.io.out).toDouble /(1<< c.prec_frac).toDouble).toString)
	}

	// for (i <- 0 until N) {	
	// 	for (s <- 0 until TestVector("in_0").length ){
		
	// 		//Set Data
	// 		for (k <- 0 until cc.terms){
	// 				val kk = k 
	// 			poke(   c.io.in(k) , TestVector(s"in_$kk"  )(s  ) )
	// 		}

		
	// 		step(D)
                       
	// 		var max_val = 0
 //            for (k <- 0 until cc.terms){
 //                val kk = k
 //                if(TestVector(s"in_$kk")(s) > max_val){
	// 				max_val = TestVector(s"in_$kk")(s)
	// 			}
 //            }
	// 		expect(c.io.out,   max_val )	
			
	// 	}
	// }

}

object ExponentLUTSpec extends App{ 
		// Testing Params
		val N = 500
		val EDAVerification = false//false//false // false //true// false
		val ModuleName = "ExponentLUT"//Match class names
		val SpecName = s"${ModuleName}Spec"//Match class names
		val   TestName = "Train"
		
		val SkipSimulation = false //true// false
		val ForceSynthesis = false
		
		// Hardware Params
	    val HardwareMap = Map(
            ("prec_in", Array(8)),
            ("prec_out", Array(10)),
			("prec_frac", Array(4)),
        	("tech",Array( "tsmc40"))
		)
  
		var TestVectorMap = Map(("in_0",Array(   Array(123, 1, 41, 4 )   )),
		 		         ("in_1",Array(  Array(11, 22, 3,  123)   )) )

		val RuntimeMap = Map(("CLOCK", Array(1 )),
							 ("cap_load", Array(1.000 )),
							 ("fanout_load", Array(0.100 ))
		)
		
		
		class Tester extends FullTester{
			override def driver() = {
					Driver.execute(  Array("--generate-vcd-output" , "on",
					  "--top-name", this.SpecName,
					   "--target-dir", this.TargetDir), 
					   () => {
							val m = new ExponentLUT(this.HardwareConfig)
							//val m = AdderNFactory.create(this.HardwareConfig)
							( m  ) 
					   })( c => {
						    val mspec = new ExponentLUTSpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
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
