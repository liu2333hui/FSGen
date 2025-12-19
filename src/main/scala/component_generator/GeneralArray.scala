package components

// A general Array
// PE array can be any computation involving N tensors
// Can have reduction as well
// No systolic yet

import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory}
import networks.{Multicast}
import maxmin.{MaxN}

import scala.collection.mutable.Set

import scala.collection.mutable.ArrayBuffer

// (b, s, hd)
// (8, 8, 8)

// Q[b, s, hd] += W[e, hd] x[b, s, e]
// Q, W, x
// MC, MC, MC - multicast MC, systolic SYS
// if(x[b,s,e] == 0) 
// Y[i,j] +=  X1[j,k]  X2[i]

// W[e, hd] * x[b,s,e]

// tensors = [Q, W, x]
// prec    = [(int,8), (int,8), (int, 8)]
// tiles = [8,8,1,1]
// sparse_ratio = [1,1,1,1]
// iters = [b,s,e,hd]
// Access = [[1,1,0,1], [0,0,1,1], [1,1,1,0]]
// Movement = [MC, MC, MC]
// Out = Q
// In = [["mult", Q, W]] 
// Reduce == "Add"//, "None", "Max"
// sparse = [(X, 'tensors'), (W, 'tensors')  ]
//Sparsity for array only covers value-based sparsities
//For index-based or group-based, see next layer

class GeneralSpatialArray(HardwareConfig: Map[String, String]) extends GenericPEArray(HardwareConfig){

 //  val app_in = HardwareConfig.get("app_in").getOrElse("").split(" ")
 //  val app_reduce = HardwareConfig.get("app_reduce").getOrElse("")

 //  val in_ports = HardwareConfig.get("in_ports").getOrElse("").split(",")
 //  val out_ports = HardwareConfig.get("out_ports").getOrElse("").split(",")
 

 
 //  val tensors = HardwareConfig.get("tensors").getOrElse("").split(",")
 //  val tensors_prec = HardwareConfig.get("tensors_prec").getOrElse("").split(",")
 //  val tensors_type = HardwareConfig.get("tensors_type").getOrElse("").split(",")
 //  val tensors_access = HardwareConfig.get("tensors_access").getOrElse("").split(" ")
 //  val tensors_movement = HardwareConfig.get("tensors_movement").getOrElse("").split(",")

 //  val iters = HardwareConfig.get("iters").getOrElse("").split(",")
 //  val iters_tiles = HardwareConfig.get("iters_tiles").getOrElse("").split(",")

	// 0. Iterate all spatial arrays
	// 1. Identify operation
	// 2. Find index and tilings for the operation based on output, input access indices
	// 3. Calculate PE size
	// 4. Generate PE array
	// 5. Generate Network Unit based on Systolic (skip)
	// 6. Generate Sparsity unit (crossbar) based on Sparsity requirement, order (skip)
	// 7. Based on pairing and ordering, connect the units
	// 8. Connect the component to the top IO
	// 9. Connect operations together

	// Maps
	// var var2prec = Map[String, String ]()
	// var var2type = Map[String, String ]()
	// var var2access = Map[String, String]()
	// var var2movement = Map[String, String]()

	// for (t <- 0 until tensors.length){ 
	//    var2prec += ( tensors(t)  -> tensors_prec(t) )
	//    var2type += ( tensors(t)  -> tensors_type(t))
	//    var2access += ( tensors(t) -> tensors_access(t)   )
	//    var2movement += ( tensors(t) -> tensors_movement(t)  )
	// }

	// //Tile corresponding to the iteration index
	// //i.e. i -> 8
	// var iter2tile = Map[String, Int]()
	// for (t <- 0 until iters.length  ){
	// 	iter2tile += ( iters(t) -> iters_tiles(t).toInt   )  
	// }

	// //Number of a given tensor
	// var var2num = Map[String, Int]()

	// //Input variable to index
	// //i.e. X --> In0, Y --> In1
	// var var2in = Map[String, Int]()
	// var iidx = 0
	// for (i <- in_ports){
	// 	var2in += (i -> iidx) 
	// 	//println("VAR2IN",i,var2in(i))
	// 	iidx = iidx + 1
	// }

	// var ports = out_ports
	// for (tensor <- in_ports){
	// 	   //println("DEBUG: "+op + " " + cfg(idx) )
	// 	   var tensorSet = Set.empty[String] 
	// 	   var access = var2access.get(tensor).getOrElse("").split(",")
	// 	   for (acc <- access){
	// 		  tensorSet += acc
	// 	   } 
	// 	   var tensor_tile = 1
	// 	   var tensor_tile_map = Map[String, Int]()
	// 	   var tensorArray = ArrayBuffer.empty[String]
	// 	   for(m <- access){
	// 			//println("ACCESS", m)
	// 	   }
	// 	   for (m <- access) {
	// 		 //println(m)
	// 		 if( tensorSet.contains(m)) {
	// 			tensor_tile *= iter2tile(m).toInt  
	// 		 }
	// 	   }

	// 	   //Save tensor tile
	// 		   var2num += (tensor-> tensor_tile  ) //tensor_tile_map
	// }

	// for (tensor <- out_ports){
	// 	   var tensorSet = Set.empty[String] 
	// 	   var access = var2access.get(tensor).getOrElse("").split(",")
	// 	   for (acc <- access){
	// 		  tensorSet += acc
	// 	   } 
	// 	   var tensor_tile = 1
	// 	   var tensor_tile_map = Map[String, Int]()
	// 	   var tensorArray = ArrayBuffer.empty[String]
	// 	   for(m <- access){
	// 			//println("ACCESS", m)
	// 	   }
	// 	   for (m <- access) {
	// 		 if( tensorSet.contains(m)) {
	// 			tensor_tile *= iter2tile(m).toInt  
	// 		 }
	// 	   }

	// 	  var2num += (tensor-> tensor_tile  ) //tensor_tile_map
	// }

	// for(i <- var2num){
	//    println("VAR2NUM"+i)
	// }



	// // (todos) hardcoded max 3 tensor inputs ?
	// // Input and output ports
	// val io = IO(new Bundle {		
	// 		val In0 = Input (Vec( var2num(in_ports(0))   , UInt( (var2prec(in_ports(0)).toInt).W ) ))
	// 		val In1 = if (in_ports.length > 1) Some(Input(Vec( var2num(in_ports(1))  , UInt ((var2prec(in_ports(1) ).toInt).W)  ))) else None
	// 		val In2= if (in_ports.length > 2) Some(Input(Vec( var2num(in_ports(2))  , UInt ((var2prec(in_ports(2) ).toInt).W)  ))) else None

	// 		val Out  = Output(Vec( var2num(out_ports(0)) , UInt(  (var2prec(out_ports(0)).toInt).W)))	
	// 		val entry = new EntryIO()
	// 		val exit = new ExitIO()
	// 	})





	// 0. Iterate
	var app_idx = 0
	var PEA = Map[Int, ArrayBuffer[Module]  ]()

	val app = app_in(0)
	// 1. Identify
	val cfg = app.split(",")
	val op = cfg(0)
	val op_reduce = cfg(1) 
	val out = cfg(2)

   // 2. Find index and tilings for the operation based on output, input access indices
   val mutableSet = Set.empty[String]
   var varArray = ArrayBuffer.empty[String]
   for (idx <- 2 until cfg.length){
     //println("DEBUG: "+op + " " + cfg(idx) )
     var tensor = cfg(idx)
     
     // b;s;hd
     var access = var2access.get(tensor).getOrElse("").split(",")
     for (acc <- access){
        mutableSet += acc
     } 

     //mutableSet += cfg(idx)
   }

	// 3. Calculate PE size
	var PEs = 1
	var PEs_tile_map = Map[String, Int]()
	for (m <- mutableSet) {
	  //simple map, idx -> tile
	  PEs_tile_map += (m -> PEs) 
	  PEs *= iter2tile(m).toInt
	  varArray += m
	}
	println( "PEs: "+ PEs )
 
    // 4. Generate PE array
    var cur_pea = ArrayBuffer.empty[Module]
	
	// PE outputs ports
	val outWire = Wire(Vec(PEs, UInt(var2prec(out).toInt.W))) // 4个8位无符号整数的线网
	val exit_validWire  = Wire(Vec(PEs, Bool()))
 	val entry_readyWire = Wire(Vec(PEs, Bool()))   
	// PE inputs ports
	val in0Wire = Wire(Vec(PEs, UInt(var2prec(in_ports(0)).toInt.W)))
	val in1Wire = if (in_ports.length > 1) Some( Wire(Vec(PEs, UInt(var2prec(in_ports(1 % in_ports.length)).toInt.W))) ) else None
	val in2Wire = if (in_ports.length > 2) Some( Wire(Vec(PEs, UInt(var2prec(in_ports(2 % in_ports.length )).toInt.W))) ) else None
	val exit_readyWire  = Wire(Vec(PEs, Bool()))
	val entry_validWire = Wire(Vec(PEs, Bool()))

    if(op == "mult"){ 
 
        val pe_cfg = Map[String, String](
			"prec1" -> var2prec(cfg(2)  ),
			"prec2" -> var2prec(cfg(3)  ),
			"prec_out" -> var2prec(cfg(1)), 

			"prec1_type" -> var2type(cfg(2)  ),
			"prec2_type" -> var2type(cfg(3)  ),
			"prec_out_type" -> var2type(cfg(1)), 

			"auto_prec_out" -> false.toString,
			"radix" -> 256.toString,
			"multiplierType" -> "SimpleMultiplier2",
			"adderType" -> "SimpleAdder2",
			"signed" -> false.toString,
			"buffered" -> false.toString,
			"side" -> "A" 
          )
            
         cur_pea =  ArrayBuffer.fill(PEs)( Module(Multiplier2Factory.create( pe_cfg   ))	)  
         PEA += (app_idx  ->  cur_pea  )
		 for(pidx <- 0 until PEs){
			var pp = cur_pea(pidx).asInstanceOf[GenericMultiplier2]
			pp.io.A := in0Wire(pidx)
			pp.io.B := in1Wire.get(pidx)
			pp.io.exit.ready := exit_readyWire(pidx) 
			pp.io.entry.valid := entry_validWire(pidx)
			 
			outWire(pidx) := pp.io.Out
			exit_validWire(pidx)  := pp.io.exit.valid
			entry_readyWire(pidx) := pp.io.entry.ready   
			
		 }
    }
	else if(op == "none"){
		
		println("NONE")
		
		cur_pea = ArrayBuffer.fill(PEs)(  Module(new EntryExitWire( var2prec(in_ports(0)).toInt,  var2prec(out).toInt   )))
		PEA += (app_idx -> cur_pea)
		for(pidx <- 0 until PEs){
			var pp = cur_pea(pidx).asInstanceOf[EntryExitWire]
			pp.io.in := in0Wire(pidx)
			pp.io.exit.ready := exit_readyWire(pidx) 
			pp.io.entry.valid := entry_validWire(pidx)
			 
			outWire(pidx) := pp.io.out
			exit_validWire(pidx)  := pp.io.exit.valid
			entry_readyWire(pidx) := pp.io.entry.ready   			
		}
		
	}
    else if(op == "add"){
		//PEA += (app_idx -> ArrayBuffer.fill(PEs)( Module(Adder2Factory.create(pe_cfg) ) ) )
    }
    else if(op == "exp"){
		//PEA += (app_idx  -> Array.fill(PEs)( Module(ExponentFactory.create(HardwareConfig))))
    }


    // 5. Generate Network Unit based on Systolic
   //Only multicast for now
   //Inputs
   var in_idx = 0
   for (idx <- 2 until cfg.length){
       //println("DEBUG: "+op + " " + cfg(idx) )
       var tensor = cfg(idx)
       var tensorSet = Set.empty[String] 
       var access = var2access.get(tensor).getOrElse("").split(",")
       for (acc <- access){
          tensorSet += acc
       } 
       var tensor_tile = 1
       var tensor_tile_map = Map[String, Int]()
       var tensorArray = ArrayBuffer.empty[String]
       var bcast_tile = 1
       var bcast_tile_map = Map[String, Int]()
       var bcastArray = ArrayBuffer.empty[String] 
       for (m <- varArray) {
         if( tensorSet.contains(m)) {
            tensor_tile_map += (m -> tensor_tile)
            tensor_tile *= iter2tile(m).toInt 
            tensorArray += m 
         }else {
            bcast_tile_map += (m -> bcast_tile)
            bcast_tile *= iter2tile(m).toInt 
            bcastArray += m  
         }
       }

        /*
       for (m <- varArray) {
          if( tensorSet.contains(m)) {
           println(m, tensor_tile_map(m))
  
         }else {
           println(m, bcast_tile_map(m))
  
         }
          println(m, iter2tile(m))    
       } 
       */ 
       
       //println("tensor " + tensor  + "tile "+ tile ) 
       var broadcast = (PEs/tensor_tile).toInt 
  
       println("STATS",tensor_tile, broadcast)

       //Save tensor tile
       for (t <- tensor_tile_map){
           //var2num += t //tensor_tile_map
       }

       //Skip convolution/diagonal-like systolic arrays for now (todos)
       val network_cfg = Map[String, String](
	     "terms" -> tensor_tile.toString,
             "fanout" ->  broadcast.toString,
             "prec" -> var2prec(tensor).toString, 
	     "buffered" -> false.toString
          )
       //val cur_network =  Array.fill( PEs )( Module(new Multicast(network_cfg)))
       val cur_network =  Module(new Multicast(network_cfg))

       cur_network.io.en := 1.B


       // PEs (v1, v2, v3)
       // TENSOR (v3, v1) -> (v1, v3)
       // TENSOR_TILE(v1: 1, v3: Tv1, v4: Tv1*Tv3, v5:Tv3*Tv4*Tv5)
       // TENSOR_idx (v1, v3) -> ( ( i // 1 % V1), (i //V1 % V3), ... )
       // iidx = v1*1 + v3*V1

       // jidx = ...
       
       // pidx = v1*V1 + v2*V2 + v3*V3 
       for(i <- 0 until tensor_tile){
          var tensor_idx = Map[String, Int]()
          var iidx = 0
          for (m <- tensorArray){
             tensor_idx += m-> ((i / (tensor_tile_map(m))) % iter2tile(m).toInt).toInt
             iidx += tensor_idx(m)*tensor_tile_map(m)
          } 

          if( var2in(tensor) == 0){
              cur_network.io.in(iidx) := io.In0(iidx) 
          }else if( var2in(tensor) == 1){
              cur_network.io.in(iidx) := io.In1.get(iidx) 
          }else if( var2in(tensor) == 2){
              cur_network.io.in(iidx) := io.In2.get(iidx) 
          }
 
 
 
          for(j <- 0 until broadcast){ 
             var jidx = 0
             var bcast_idx = Map[String, Int]()
             for (m <- bcastArray){
                bcast_idx += m-> ((j / bcast_tile_map(m)) % iter2tile(m).toInt).toInt
                jidx += bcast_idx(m)*bcast_tile_map(m)
             }  

             var pidx =0// v1 + v2*V1 + v3*V1*V2
             for (m <- varArray){
                 var v = 0
                 if(bcastArray.contains(m)){
                     v = bcast_idx(m)
                     println(j,"bcast", v, m, PEs_tile_map(m))
 
                 }else {
                     v = tensor_idx(m)
                     println("tensor", v, m, PEs_tile_map(m))
 
                 }
                 pidx += v*PEs_tile_map(m)
            }

            println(tensor, "PIDX",pidx)
 
			// outWire(pidx) := pp.io.Out
			
			if(in_idx == 0){
				in0Wire(pidx) := cur_network.io.out(iidx)(jidx)	
				exit_readyWire(pidx) := io.exit.ready
				entry_validWire(pidx) := io.entry.valid
				
				if(pidx == 0){
				   io.entry.ready := entry_readyWire(pidx)
				   io.exit.valid := exit_validWire(pidx)
					
					
				}
			} else if (in_idx == 1){
				in1Wire.get(pidx) := cur_network.io.out(iidx)(jidx)	
			}else if (in_idx == 2){
				in2Wire.get(pidx) := cur_network.io.out(iidx)(jidx)	
			}
			

        }//end broadcast
		}//end tensor

       in_idx = in_idx + 1 
        
	  }//end input tensor fill


	   //6. Outputs
	   //val op_reduce = cfg(1) 
	   //val out = cfg(2)
	   //cur_pea[ pidx  ].io.exit.valid := 
	   //cur_pea[ pidx  ].io.entry.ready :=  
   
     var    tensor = cfg(1)
     var    tensorSet = Set.empty[String] 
      var   access = var2access.get(tensor).getOrElse("").split(",")
       for (acc <- access){
          tensorSet += acc
       } 
     var    tensor_tile = 1
      var   tensor_tile_map = Map[String, Int]()
      var   tensorArray = ArrayBuffer.empty[String]
      var   bcast_tile = 1
      var   bcast_tile_map = Map[String, Int]()
     var    bcastArray = ArrayBuffer.empty[String] 
       for (m <- varArray) {
         if( tensorSet.contains(m)) {
            tensor_tile_map += (m -> tensor_tile)
            tensor_tile *= iter2tile(m).toInt 
            tensorArray += m 
         }else {
            bcast_tile_map += (m -> bcast_tile)
            bcast_tile *= iter2tile(m).toInt 
            bcastArray += m  
         }
       }
      var   broadcast = (PEs/tensor_tile).toInt 
  
       println("OUTPUT STATS",tensor_tile, broadcast)
        
    var cur_out = ArrayBuffer.empty[Module]
	 // val reduceOutWire = Wire(Vec(tensor_tile ,  UInt(var2prec(out).toInt.W)  )    )
	 // val reduceInWire = Wire(Vec( tensor_tile , Vec(bcast_tile, UInt(var2prec(out).toInt.W) )  ))
	 // val reduceExitReady = Wire(Vec( tensor_tile, Bool() ))
	 // val reduceExitValid = Wire(Vec( tensor_tile, Bool() ))
	 // val reduceEntryReady = Wire(Vec( tensor_tile, Bool() ))
	 // val reduceEntryValid = Wire(Vec( tensor_tile, Bool() ))
	 
 
       if(app_reduce == "add"){
           //All reduce for now
           //Systolic later
            
           val reduce_cfg = Map[String, String](
	     "prec_in" -> var2prec(tensor),
             "prec_sum" -> var2prec(tensor),
             "adderNType" -> "SimpleAdderN", 
            "adderType" -> "SimpleAdder2",
	    "terms" -> broadcast.toString,
            "signed" -> false.toString,
             "same_prec" -> true.toString,
             "pipelined" -> false.toString,
            
	     "buffered" -> false.toString,
             "auto_prec_sum" -> false.toString
          )

          cur_out =  ArrayBuffer.fill(tensor_tile)( Module( AdderNFactory.create(  reduce_cfg   ))	)  


		  // for(t <- 0 until tensor_tile){
			 //  val co : GenericAdderN = cur_out(t).asInstanceOf[GenericAdderN] 
			 //  for(b <- 0 until bcast_tile){
				//  co.io.A(b) := reduceInWire(t)(b)
			 //  }
			 //  co.io.exit.ready  := reduceExitReady(t)
			 //  co.io.entry.valid := reduceEntryValid(t)
			  
			 //  // co.io.exit
		  // }
		  
		  
		  
	// 		 if(jidx == 0){
 //                  io.Out(iidx) := co.io.Sum 
 //              }

 //              co.io.A(jidx) :=  outWire(pidx)
  
 //              co.io.exit.ready := io.exit.ready
 //              co.io.entry.valid := io.entry.valid
 

       } else if(app_reduce == "max"){
		   
			val reduce_cfg = Map(
				("prec", var2prec(tensor)),
				("terms", broadcast.toString)
			)
		
          cur_out =  ArrayBuffer.fill(tensor_tile)( Module(new MaxN(  reduce_cfg   ))	)  
			
			


       }


       for(i <- 0 until tensor_tile){
          var tensor_idx = Map[String, Int]()
          var iidx = 0
          for (m <- tensorArray){
             tensor_idx += m-> ((i / (tensor_tile_map(m))) % iter2tile(m).toInt).toInt
             iidx += tensor_idx(m)*tensor_tile_map(m)
          } 
 
          for(j <- 0 until broadcast){ 
             var jidx = 0
             var bcast_idx = Map[String, Int]()
             for (m <- bcastArray){
                bcast_idx += m-> ((j / bcast_tile_map(m)) % iter2tile(m).toInt).toInt
                jidx += bcast_idx(m)*bcast_tile_map(m)
             }  

             var pidx =0// v1 + v2*V1 + v3*V1*V2
             for (m <- varArray){
                 var v = 0
                 if(bcastArray.contains(m)){
                     v = bcast_idx(m)
                    // println(j,"bcast", v, m, PEs_tile_map(m))
 
                 }else {
                     v = tensor_idx(m)
                   //  println("tensor", v, m, PEs_tile_map(m))
 
                 }
                 pidx += v*PEs_tile_map(m)
            }

           // println(tensor, "PIDX",pidx)
          if(app_reduce == "add"){
              val co : GenericAdderN = cur_out(iidx).asInstanceOf[GenericAdderN] 
              if(jidx == 0){
                  io.Out(iidx) := co.io.Sum 
              }

              co.io.A(jidx) :=  outWire(pidx)
  
              co.io.exit.ready := io.exit.ready
              co.io.entry.valid := io.entry.valid
 


              if(pidx == 0){
                 //io.entry.ready := pp.io.entry.ready
                // io.exit.valid := pp.io.exit.valid
 
              }
          } else if (app_reduce == "max"){

				


          }
 


        }//broadcast

        
       

    
    



   }//tensor






}


// Systolic array
// Maybe just use Rubick/Tensorlib??



object Util{
	def GetPES(PEA  : GenericPEArray): Int = {
	  
	  
	  		val app = PEA.app_in(0)
	  		// 1. Identify
	  		val cfg = app.split(",")
	  		val op = cfg(0)
	  		val op_reduce = cfg(1) 
	  		val out = cfg(2)
	  		
	     // 2. Find index and tilings for the operation based on output, input access indices
	     val mutableSet = Set.empty[String]
	     var varArray = ArrayBuffer.empty[String]
	     for (idx <- 2 until cfg.length){
	       //println("DEBUG: "+op + " " + cfg(idx) )
	       var tensor = cfg(idx)
	       
	       // b;s;hd
	       var access = PEA.var2access.get(tensor).getOrElse("").split(",")
	       for (acc <- access){
	          mutableSet += acc
	       } 
	  
	       //mutableSet += cfg(idx)
	     }
	  // 3. Calculate PE size
	  	var PEs = 1
	  	var PEs_tile_map = Map[String, Int]()
	  	for (m <- mutableSet) {
	  	  //simple map, idx -> tile
	  	  PEs_tile_map += (m -> PEs) 
	  	  PEs *= PEA.iter2tile(m).toInt
	  	  varArray += m
	  	}
		
		
		
		PEs
	  
	  
	  
	}
 
	def GetInnerOuterIndices(PEA  : GenericPEArray): ArrayBuffer[ArrayBuffer[String]] = {
		
		
		val app = PEA.app_in(0)
		// Identify
		val cfg = app.split(",")
		val op = cfg(0)
		val op_reduce = cfg(1) 
		val out = cfg(2)
		
		//Find highest outer tiling
		// Find outer variables
		val outer = PEA.var2access.get(out).getOrElse("").split(",")
		val outt = ArrayBuffer[String]()
		outt ++= outer
		// for(o <- outer){
		// 	println("O"+o)
		// }
		
		// Find inner variables
		val inner = ArrayBuffer[String]()
		// this.iter2tile
		for(i <- PEA.iters){
			if(! outer.contains(i)){
				inner += i
			}
		}
	
		val o = ArrayBuffer[ArrayBuffer[String]]()
		o += inner
		o += outt
		o
	}
	
	def GetTile(PEA  : GenericPEArray, indices : ArrayBuffer[String], iter2tile : Map[String, Int]): Int = {
		var tiling = Map[String, Int]()
		// if(iter2tile != None){
			tiling = iter2tile
		// } else {
		// 	tiling = PEA.iter2tile
		// }
		
		var t = 1
		for (i <- indices){
			
			t = (tiling(i)).toInt
		}
		t
	}
	
	
	def GetSecondaryTile(PEA  : GenericPEArray, inner:ArrayBuffer[String]  ): ArrayBuffer[String] = {
		var innerf = ArrayBuffer[String]()
		for (i <- inner){
			if( (PEA.iter2tile(i+i)).toInt > (PEA.iter2tile(i)).toInt ){
				innerf += (i+i)	
			} else {
				innerf += i
			}
		}
		
		innerf
		
	}
}
// No systolic sparse array
class GeneralSparseArray(HardwareConfig: Map[String, String]) extends GenericPEArray(HardwareConfig){

	////////////////////////////////////////////////////
	//0. Operation
	////////////////////////////////////////////////////
	val app = this.app_in(0)
	val cfg = app.split(",")
	val op = cfg(0)
	val op_reduce = cfg(1) 
	val out = cfg(2)

	////////////////////////////////////////////////////
	//1. Gen pe array
	////////////////////////////////////////////////////
	val PEs = Util.GetPES(this)
	println("PES", PEs)
    var cur_pea = ArrayBuffer.empty[Module]
	// PE outputs ports
	val outWire = Wire(Vec(PEs, UInt(var2prec(out).toInt.W))) // 4个8位无符号整数的线网
	val exit_validWire  = Wire(Vec(PEs, Bool()))
 	val entry_readyWire = Wire(Vec(PEs, Bool()))   
	// PE inputs ports
	val in0Wire = Wire(Vec(PEs, UInt(var2prec(in_ports(0)).toInt.W)))
	val in1Wire = if (in_ports.length > 1) Some( Wire(Vec(PEs, UInt(var2prec(in_ports(1 % in_ports.length)).toInt.W))) ) else None
	val in2Wire = if (in_ports.length > 2) Some( Wire(Vec(PEs, UInt(var2prec(in_ports(2 % in_ports.length )).toInt.W))) ) else None
	val exit_readyWire  = Wire(Vec(PEs, Bool()))
	val entry_validWire = Wire(Vec(PEs, Bool()))
    if(op == "mult"){ 
        val pe_cfg = Map[String, String](
			"prec1" -> var2prec(cfg(3)  ),
			"prec2" -> var2prec(cfg(4)  ),
			"prec_out" -> var2prec(cfg(2)), 

			"prec1_type" -> var2type(cfg(3)  ),
			"prec2_type" -> var2type(cfg(4)  ),
			"prec_out_type" -> var2type(cfg(2)), 

			"auto_prec_out" -> false.toString,
			"radix" -> 256.toString,
			"multiplierType" -> "SimpleMultiplier2",
			"adderType" -> "SimpleAdder2",
			"signed" -> false.toString,
			"buffered" -> false.toString,
			"side" -> "A" 
          )
         cur_pea =  ArrayBuffer.fill(PEs)( Module(Multiplier2Factory.create( pe_cfg   ))	)  
		 for(pidx <- 0 until PEs){
			var pp = cur_pea(pidx).asInstanceOf[GenericMultiplier2]
			pp.io.A := in0Wire(pidx)
			pp.io.B := in1Wire.get(pidx)
			pp.io.exit.ready := exit_readyWire(pidx) 
			pp.io.entry.valid := entry_validWire(pidx)
			outWire(pidx) := pp.io.Out
			exit_validWire(pidx)  := pp.io.exit.valid
			entry_readyWire(pidx) := pp.io.entry.ready   
		 }
    }
	else if(op == "none"){
		cur_pea = ArrayBuffer.fill(PEs)(  Module(new EntryExitWire( var2prec(in_ports(0)).toInt,  var2prec(out).toInt   )))
		for(pidx <- 0 until PEs){
			var pp = cur_pea(pidx).asInstanceOf[EntryExitWire]
			pp.io.in := in0Wire(pidx)
			pp.io.exit.ready := exit_readyWire(pidx) 
			pp.io.entry.valid := entry_validWire(pidx)
			outWire(pidx) := pp.io.out
			exit_validWire(pidx)  := pp.io.exit.valid
			entry_readyWire(pidx) := pp.io.entry.ready   			
		}
	}
    else if(op == "add"){
		//PEA += (app_idx -> ArrayBuffer.fill(PEs)( Module(Adder2Factory.create(pe_cfg) ) ) )
    }
    else if(op == "exp"){
		//PEA += (app_idx  -> Array.fill(PEs)( Module(ExponentFactory.create(HardwareConfig))))
    }

	////////////////////////////////////////////////////
	//2. Gen crossbars for each variable
	////////////////////////////////////////////////////
	//Prepare tilings
	val iters_second_tiles = HardwareConfig.get("iters_second_tiles").getOrElse("").split(",")
	var itersec2tile = Map[String, Int]()
	for (t <- 0 until iters.length  ){
		itersec2tile += ( iters(t) -> iters_second_tiles(t).toInt   )  
		iter2tile += (iters(t)+iters(t) ->  iters_second_tiles(t).toInt   )  
	}
	
    val iters_sparse_tiles = HardwareConfig.get("iters_sparse_tiles").getOrElse("").split(",")
	var iters_sp2tile = Map[String, Int]()
	for (t <- 0 until iters.length  ){
		iters_sp2tile += ( iters(t) -> iters_sparse_tiles(t).toInt   )  
	}	
	
	//Tilings
	val indices = Util.GetInnerOuterIndices(this)
	val inner = indices(0)
	val outer = indices(1)
	
	val innerf = Util.GetSecondaryTile(this,inner)
	val outerf = Util.GetSecondaryTile(this,outer)
	
	// Case 1: Tile Outer == Sparse Outer (Structured)
	// Loop variable X[b,i]
	// num_crossbar = outer_variables / outer second tiling 
	// in_terms = * outer second tiling
	// out_terms =  
	
	//Case 2: Tile Outer < Sparse Outer (Unstructured)	
	val subcase:Int = 0
	var case1 = true
	for(o <- outer){
		case1 = case1 && (itersec2tile(o) == iters_sp2tile(o))
	}
	
	val case2 = !case1
	println("case1", case1)
	println("case2", case2)
	
	// Inner/outer full tiles
	val inner_tile = Util.GetTile(this,inner,this.iter2tile)
	val outer_tile = Util.GetTile(this,outer,this.iter2tile)
	val innerf_tile = Util.GetTile(this,innerf,this.iter2tile)
	val outerf_tile = Util.GetTile(this,outerf,this.iter2tile)
		
	var crossbar_cfg = Map[String, Map[String, Int]]()
	if(case1){
		for(t <- tensors){

			val acc_t = var2access(t).split(",")
			val acc = ArrayBuffer[String]()
			acc ++= acc_t
			val accf = Util.GetSecondaryTile(this,acc)
			
			val outer_t = ArrayBuffer[String]()
			for(o <- outer){
				if(acc.contains(o)){
					outer_t += o
				}
			}
			// val outer_t = acc.filter(outer.contains).distinct
			// val outerf_t = acc.filter(outerf.contains).distinct
			val outerf_t = ArrayBuffer[String]()
			for(o <- outerf){
				if(accf.contains(o)){
					outerf_t += o
				}
			}			
			val inner_t = ArrayBuffer[String]()
			for(i <- inner){
				if(acc.contains(i)){
					inner_t += i
				}
			}
			
			// val out_terms_t = 1
			// for(o <- outer_t){
			// 	if(outerf_t.contains(o)){
			// 		out_terms_t *= 
			// 	}else{
			// 		out_terms_t *= 
			// 	}
			// }
			
			// val out_terms_t = Util.GetTile(this,outer_t,this.iter2tile)	
			// val outf_terms_t = Util.GetTile(this,outerf_t,this.iter2tile)
			// val sparse_terms_t = Util.GetTile(this,outerf_t,this.iters_sp2tile)
			// val innerf_tile_t = Util.GetTile(this, inner_t, this.iters_sp2tile)

			// val group = outf_terms_t / out_terms_t
			
			// println("outf_terms", outf_terms_t)
			// println("out_terms", out_terms_t)
			// // val out_terms_t = group * inner_tile
			// // val number_t = sparse_terms_t / outf_terms_t / group
			// // val in_terms_t = sparse_terms_t / group * inner_tile
			
			// println("TENSOR", t)
			
			// var tcfg = Map[String, Int](
			// 	"in_terms" -> sparse_terms_t / group * innerf_tile_t,
			// 	 "out_terms" ->  group * inner_tile,
			// 	 "prec" -> var2prec(t).toInt,
			// 	 "number" -> sparse_terms_t / outf_terms_t / group,
			// 	 "group" -> group
			// )
			// tcfg.foreach { case (k, v) => println(s"Key: $k, Value: $v") }

						
			// crossbar_cfg = crossbar_cfg + (t -> tcfg)
		}
	}else if(case2){
		
	}

	// var tensor2crossbar = Map[String, GenericZeroMapNetwork]()
	// val CrossbarConfig = Map(
	// 	"in_terms" -> 4,
	// 	"out_terms" -> 2,
	// 	"prec" -> 8
	// )
	// val m = Module(new ZeroMapCrossbar(
	// 	CrossbarConfig
	// ))
	// tensor2crossbar += (t, m)

	////////////////////////////////////////////////////
	//3. Generate Pipeline hardware
	////////////////////////////////////////////////////
	

	////////////////////////////////////////////////////
	//4. Connect crossbar to pe array
	////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////
	//5. Connect crossbar to input/output ports
	////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////
	//6. Connect crossbar zero-map to specified value sparsity
	////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////
	//7. connect pipelining registers and ports
	////////////////////////////////////////////////////
	

	
}


//GeneralSparseArray


