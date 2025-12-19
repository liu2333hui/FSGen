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


import scala.collection.mutable.Set

import scala.collection.mutable.ArrayBuffer






object PEArrayFactory{

  def create( HardwareConfig : Map[String, String]): GenericPEArray = {

	  val template = HardwareConfig("template")
	  template match {
	    case "GeneralSpatialArray" => new GeneralSpatialArray(HardwareConfig)
	    //case "SystolicPEArray" => new SystolicPEArray(HardwareConfig)
	    case "GeneralSparseArray" => new GeneralSparseArray(HardwareConfig)    
	case _     => throw new IllegalArgumentException("Unknown PEArray type " + template)
	  }



	  
  }
  
}




 class GenericPEArray (  HardwareConfig : Map[String, String] ) extends Module {
	 
	 
    val app_in = HardwareConfig.get("app_in").getOrElse("").split(" ")
    val app_reduce = HardwareConfig.get("app_reduce").getOrElse("")
  
    val in_ports = HardwareConfig.get("in_ports").getOrElse("").split(",")
    val out_ports = HardwareConfig.get("out_ports").getOrElse("").split(",")
   
  
   
    val tensors = HardwareConfig.get("tensors").getOrElse("").split(",")
    val tensors_prec = HardwareConfig.get("tensors_prec").getOrElse("").split(",")
    val tensors_type = HardwareConfig.get("tensors_type").getOrElse("").split(",")
    val tensors_access = HardwareConfig.get("tensors_access").getOrElse("").split(" ")
    val tensors_movement = HardwareConfig.get("tensors_movement").getOrElse("").split(",")
  
    val iters = HardwareConfig.get("iters").getOrElse("").split(",")
    var iters_tiles = HardwareConfig.get("iters_tiles").getOrElse("").split(",")
  
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
  	var var2prec = Map[String, String ]()
  	var var2type = Map[String, String ]()
  	var var2access = Map[String, String]()
  	var var2movement = Map[String, String]()
  
  	for (t <- 0 until tensors.length){ 
  	   var2prec += ( tensors(t)  -> tensors_prec(t) )
  	   var2type += ( tensors(t)  -> tensors_type(t))
  	   var2access += ( tensors(t) -> tensors_access(t)   )
  	   var2movement += ( tensors(t) -> tensors_movement(t)  )
  	}
  
  	//Tile corresponding to the iteration index
  	//i.e. i -> 8
  	var iter2tile = Map[String, Int]()
  	for (t <- 0 until iters.length  ){
  		iter2tile += ( iters(t) -> iters_tiles(t).toInt   )  
  	}
  
  	//Number of a given tensor
  	var var2num = Map[String, Int]()
  
  	//Input variable to index
  	//i.e. X --> In0, Y --> In1
  	var var2in = Map[String, Int]()
  	var iidx = 0
  	for (i <- in_ports){
  		var2in += (i -> iidx) 
  		//println("VAR2IN",i,var2in(i))
  		iidx = iidx + 1
  	}
  
  	var ports = out_ports
  	for (tensor <- in_ports){
  		   //println("DEBUG: "+op + " " + cfg(idx) )
  		   var tensorSet = Set.empty[String] 
  		   var access = var2access.get(tensor).getOrElse("").split(",")
  		   for (acc <- access){
  			  tensorSet += acc
  		   } 
  		   var tensor_tile = 1
  		   var tensor_tile_map = Map[String, Int]()
  		   var tensorArray = ArrayBuffer.empty[String]
  		   for(m <- access){
  				//println("ACCESS", m)
  		   }
  		   for (m <- access) {
  			 //println(m)
  			 if( tensorSet.contains(m)) {
  				tensor_tile *= iter2tile(m).toInt  
  			 }
  		   }
  
  		   //Save tensor tile
  			   var2num += (tensor-> tensor_tile  ) //tensor_tile_map
  	}
  
  	for (tensor <- out_ports){
  		   var tensorSet = Set.empty[String] 
  		   var access = var2access.get(tensor).getOrElse("").split(",")
  		   for (acc <- access){
  			  tensorSet += acc
  		   } 
  		   var tensor_tile = 1
  		   var tensor_tile_map = Map[String, Int]()
  		   var tensorArray = ArrayBuffer.empty[String]
  		   for(m <- access){
  				//println("ACCESS", m)
  		   }
  		   for (m <- access) {
  			 if( tensorSet.contains(m)) {
  				tensor_tile *= iter2tile(m).toInt  
  			 }
  		   }
  
  		  var2num += (tensor-> tensor_tile  ) //tensor_tile_map
  	}
  
  	for(i <- var2num){
  	   println("VAR2NUM"+i)
  	}
  
  
  
  	// (todos) hardcoded max 3 tensor inputs ?
  	// Input and output ports
  	val io = IO(new Bundle {		
  			val In0 = Input (Vec( var2num(in_ports(0))   , UInt( (var2prec(in_ports(0)).toInt).W ) ))
  			val In1 = if (in_ports.length > 1) Some(Input(Vec( var2num(in_ports(1))  , UInt ((var2prec(in_ports(1) ).toInt).W)  ))) else None
  			val In2= if (in_ports.length > 2) Some(Input(Vec( var2num(in_ports(2))  , UInt ((var2prec(in_ports(2) ).toInt).W)  ))) else None
  
  			val Out  = Output(Vec( var2num(out_ports(0)) , UInt(  (var2prec(out_ports(0)).toInt).W)))	
  			val entry = new EntryIO()
  			val exit = new ExitIO()
  		})
}

