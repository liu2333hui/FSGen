package networks

import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

import sys.process._

import eda._
import tester.{Helper, TechNode, FullTester}

import scala.reflect.runtime.universe._





class PipelineChainTester extends FullTester{
	override def driver() = {
		
		class PipelineChainSpec(cc: PipelineChain,
		    TestVector : Map[String, Array[Int]] ,
		    N: Int = 500,
			D: Int = 1 ) extends PeekPokeTester(cc) {
				
			val c = cc
			
			val depth = c.depth
			
			for (i <- 0 until depth) {
				poke(c.io.pipe_ready_go(i), 1 ) 
			}
			for (i <- 0 until TestVector("in_0").length){
				
				poke(c.io.validin,  1  )
				poke(c.io.out_allow, 1  )
				poke(c.io.datain, TestVector("in_0")(i) )
				
				step(1)	
				
				
			}
				
	}//endclass
		
		
			Driver.execute(  Array("--generate-vcd-output" , "on",
			  "--top-name", this.SpecName,
			   "--target-dir", this.TargetDir), 
			   () => {
					val m = new PipelineChain(this.HardwareConfig)
					( m  ) 
			   })( c => {
				    val mspec = new PipelineChainSpec(c, TestVector=this.TestVector, N=this.N,D=this.CLOCK) 
			   	    ( mspec )  
				} ) 

	}
	
}


object PipelineChainSpec extends App{ 
	// Testing Params
		val N = 100
		val EDAVerification = false
		val ModuleName = "PipelineChain"//Match class names
		
		// Hardware Params
		val HardwareMap = Map(
				("depth",Array(8)),
			    ("prec",Array(32)),
				("tech",Array("tsmc40")),
		)

		val TestVectorMap = Map(
			("in_0",Array( Array(8,88,888)    )),
		)

		val RuntimeMap = Map(("CLOCK", Array(1)),
				     ("cap_load", Array(1.00)),
			    	     ("fanout_load", Array(0.0))
		)
		
		
		val m = new PipelineChainTester()
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
