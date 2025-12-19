package eda

import scala.io._
import java.io._
import sys.process._
import scala.io.Source

object area{


        def main(args: Array[String]) {

             val Area : Double =  get_area("./generated/AdderN/AdderN_true_false_true_SimpleAdderN_false_16_false_tsmc40_16_8_SimpleAdder2__1_0.1_0.1/SimpleAdderN.area")
		println("area" + Area)
//      println("PWR = "+pwr)

      }



       def get_area(report:String) :Double = {

         println(report)
         val source : BufferedSource = Source.fromFile(report)
           val lines:Iterator[String] = source.getLines()
            val myread :List[String] = lines.toList
             var state = 0

             for(line <- myread){
                   if(state == 0){
                        if(line.contains("Total cell area")){
	                    val elements = line.split("\\s+")
	       	            val result = elements.slice(3,4).map(_.toDouble )
	 
                              println(result(0)) 
                              //sys.exit(0)
       		              return  result(0)
 
			}



                        if(line.contains("--------------------------------  ---------  -------  --------  ---------  ------  ---------")){
                          state = 1
                            }
                         
                   }
                    else {
                   //println("LINE" + line)
                    val elements = line.split("\\s+")
                   val result = elements.slice(1,2).map(_.toDouble )
	//	println(elements)
              //   println("AREA" + result(0))
 
                     return  result(0)
                    state = state + 1

                  }

              }

    
            0.0
}



}
