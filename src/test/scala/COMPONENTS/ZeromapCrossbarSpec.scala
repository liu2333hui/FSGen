package components

import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

import sys.process._

import eda._
import tester.{Helper, TechNode, FullTester}

import scala.reflect.runtime.universe._

import play.api.libs.json._
import scala.io.Source

import play.api.libs.json._





class ZeroMapCrossbarTest extends FullTester{
	override def driver() = {
		
		class ZeroMapCrossbarSpec(cc: ZeroMapCrossbar,
		    TestVector : Map[String, Array[Int]] ,
		    N: Int = 500,
			D: Int = 1 ) extends PeekPokeTester(cc) {
				
			val c = cc
				
			
			
				for (s <- 0 until TestVector("in_0").length ){	

					for(n <- 0 until c.in_terms){
						poke(c.io.in(n) , TestVector(s"in_$n")(s)  )
						//poke(c.io.in(1) == TestVector("in_1")(s) )
					}

					for(n <-0 until c.in_terms){
						poke(c.io.zeromap(n) , TestVector(s"in_$n")(s)!=0 )
					}
				
					step(D)	
				// for (t <- 0 until cc.out_terms){
				// val act_sel = TestVector(s"sel_$t")(s)
				// //println(s + "\t"+ TestVector(s"in_$act_sel")+"\t"+ sel)
				// expect(c.io.out(t), TestVector(s"in_$act_sel")( s ) )
						
			}//end test loop
	
	}//endclass
		
		
			Driver.execute(  Array("--generate-vcd-output" , "on",
			  "--top-name", this.SpecName,
			   "--target-dir", this.TargetDir), 
			   () => {
					val m = new ZeroMapCrossbar(this.HardwareConfig)
					( m  ) 
			   })( c => {
				    val mspec = new ZeroMapCrossbarSpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
			   	    ( mspec )  
				} ) 

	}
	
}

object ZeroMapCrossbarSpec extends App{ 
		// Testing Params
		val N = 500
		val EDAVerification = false
		val ModuleName = "ZeroMapCrossbarSpec"//Match class names
		
		// Hardware Params
		val terms = Array(8)
		val HardwareMap = Map(("in_terms",Array( 4 )   ),
					("out_terms", Array( 2 ) ),//2
			        ("prec",Array(8)),
					 ("tech",Array("tsmc40")),
		)
		

		var TestVectorMap = Map(
					// ("zeromap", Array( 1011,0011,0001  ) ),
					 ("in_0",  Array( Array(88,0,0)    )),
					 ("in_1",  Array( Array(0,0,0) )),
					 ("in_2",  Array( Array(88,1,0) )),
					 ("in_3",  Array( Array(88,32,1)  ))
		)
	

		val RuntimeMap = Map(("CLOCK", Array(1)),
				     ("cap_load", Array(1.00)),
			    	     ("fanout_load", Array(0.0))
		)
		
		
		val m = new ZeroMapCrossbarTest()
		m.run(HardwareMap,
				RuntimeMap, 
				TestVectorMap,
				N,
				ModuleName=ModuleName,
				TestName="TrainSelect",
				SpecName=s"${ModuleName}SelectSpec",
				EDAVerification = EDAVerification,
				SkipSimulation = false,
				ForceSynthesis = false)

}











class PipelinedZeroMapCrossbarTest extends FullTester{
	override def driver() = {
		
		class PipelinedZeroMapCrossbarSpec(cc: PipelinedZeroMapCrossbar,
		    TestVector : Map[String, Array[Int]] ,
		    N: Int = 500,
			D: Int = 1 ) extends PeekPokeTester(cc) {
				
			val c = cc
				
			poke(c.io.pipeline_ready, 1)
			
				// step(0.5)
				for (s <- 0 until TestVector("in_0").length ){	

					for(n <- 0 until c.in_terms){
						poke(c.io.in(n) , TestVector(s"in_$n")(s)  )
						//poke(c.io.in(1) == TestVector("in_1")(s) )
					}

					for(n <-0 until c.in_terms){
						poke(c.io.zeromap(n) , TestVector(s"in_$n")(s)!=0 )
					}
					step(1)
					poke(c.io.pipeline_ready, 0)
					poke(c.io.pipeline_ready, 1)
					println(peek(c.io.pipeline_valid).toString)
					while( peek(c.io.pipeline_valid) == 0){
						step(1)
						println("delay")
					}
					// step(1)
					poke(c.io.pipeline_ready, 1)
				// for (t <- 0 until cc.out_terms){
				// val act_sel = TestVector(s"sel_$t")(s)
				// //println(s + "\t"+ TestVector(s"in_$act_sel")+"\t"+ sel)
				// expect(c.io.out(t), TestVector(s"in_$act_sel")( s ) )
						
			}//end test loop
	
	}//endclass
		
		
			Driver.execute(  Array("--generate-vcd-output" , "on",
			  "--top-name", this.SpecName,
			   "--target-dir", this.TargetDir), 
			   () => {
					val m = new PipelinedZeroMapCrossbar(this.HardwareConfig)
					( m  ) 
			   })( c => {
				    val mspec = new PipelinedZeroMapCrossbarSpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
			   	    ( mspec )  
				} ) 

	}
	
}

object PipelinedZeroMapCrossbarSpec extends App{ 
		// Testing Params
		val N = 500
		val EDAVerification = false
		val ModuleName = "PipelinedZeroMapCrossbarSpec"//Match class names
		
		// Hardware Params
		val terms = Array(8)
		val HardwareMap = Map(("in_terms",Array( 4 )   ),
					("out_terms", Array( 2 ) ),//2
			        ("prec",Array(8)),
					 ("tech",Array("tsmc40")),
		)
		

		var TestVectorMap = Map(
					// ("zeromap", Array( 1011,0011,0001  ) ),
					 ("in_0",  Array( Array(1,1,0,0,1)    )),
					 ("in_1",  Array( Array(2,0,0,0,2) )),
					 ("in_2",  Array( Array(3,2,1,0,3) )),
					 ("in_3",  Array( Array(4,3,2,1,4)  ))
		)
	

		val RuntimeMap = Map(("CLOCK", Array(1)),
				     ("cap_load", Array(1.00)),
			    	     ("fanout_load", Array(0.0))
		)
		
		
		val m = new PipelinedZeroMapCrossbarTest()
		m.run(HardwareMap,
				RuntimeMap, 
				TestVectorMap,
				N,
				ModuleName=ModuleName,
				TestName="TrainSelect",
				SpecName=s"${ModuleName}SelectSpec",
				EDAVerification = EDAVerification,
				SkipSimulation = false,
				ForceSynthesis = false)

}
