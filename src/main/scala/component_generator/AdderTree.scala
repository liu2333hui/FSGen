package components

// A simple Adder Tree

import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory}
import accumulators.RegAccumulatorN
import networks.Parallel2SerialFactory


class AdderTree(HardwareConfig: Map[String, String]) extends Module {
	val hardware_config = HardwareConfig
	val number = HardwareConfig("number").toInt

	val terms = HardwareConfig("terms").toInt	
	val inner = terms
	
	
	val htype = HardwareConfig("type").toString
			
  	val prec_in = HardwareConfig("prec_in").toInt
	val prec_sum = HardwareConfig("prec_sum").toInt	

	val io = IO(new Bundle {	
        	val in = Input (Vec(number*inner , UInt (prec_in.W) ) )
	        val Out  = Output(Vec(number , UInt(prec_sum.W)))	
		val entry = new EntryIO()
		val exit = new ExitIO()
	})	
        io.exit.valid := 1.B
        io.entry.ready := 1.B

        //println(number)
	for (n <- 0 until number){

		if(htype == "AdderTree"){
			//AdderN primitive
			val m = Module(AdderNFactory.create(hardware_config )   )
			for (i <- 0 until inner){
				m.io.A(i) := io.in(i+n*inner)
			}
                        m.io.entry.valid := 1.B
                        m.io.exit.ready := 1.B
                        io.Out(n) := m.io.Sum

		} else if(htype == "Accumulator"){
			//Accumulator primitive + parallel2serial primitive
					
			val p2s = Parallel2SerialFactory.create_general(hardware_config)

			for (i <- 0 until inner){
				p2s.io.in(i) := io.in(i+n*inner)
			}

			val m = Module(new	RegAccumulatorN(hardware_config 
				+ ("terms" -> "1"   )))

			m.io.A(0) := p2s.io.out(0)

			m.io.Sum
				
		} else {
			println("does not exist this type " + htype)
			//	system.exit(0)
		}


	}




	


}



