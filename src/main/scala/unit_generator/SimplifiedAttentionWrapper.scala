package units

import chisel3._
import chisel3.util._
import helper._
import multipliers.{GenericMultiplier2,Multiplier2Factory}
import adders.{GenericAdderN,AdderNFactory}
import networks.{Multicast, PipelineChainValid}
import maxmin.{MaxN}

import memories.{SRAMS}

import components.{BaselineSystolicPE}

import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer


class SimplifiedAttentionWrapper(val hw : Map[String, String]) extends Module {

	val io = AttentionIO()

	/////////////////////////////////////////////////
	//High-level user configurations
	//dataflow
	val PE = hw("PE").toInt
	val Dataflow = hw("Dataflow")
	
	//precision
	val inputPrec = hw("inputPrec").toInt
	val weightPrec = hw("weightPrec").toInt
	
	//Systolic
	val systolic = hw("systolic")

	//Memory
	val cacheSize = hw("cacheSize").toInt
	
	//Sparsity
	val SparsityOptimization = hw("SparsityLevel").toInt
	val SparsityRatio = hw("SparsityRatio").toDouble
	/////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////
	//Low-level detailed Configuration
	var HardwareConfig:Map[String,String]	
	
	val Tile :Int = Math.Sqrt(PE).as[Int]
	var B = 1
	var N = 1
	var M = 1
	var D = 1
	var E = 1
	var H = 1
	var O = 1
	if(Dataflow == "Input"){
		N = Tile
		E = Tile
	}else if(Dataflow == "KV"){
		M = Tile
		N = Tile		
		D = Tile
	}else if(Dataflow == "Weight"){
		E = Tile
		N = Tile
		M = Tile
	}else{
		O = Tile
		B = Tile
	}
	
	val inputSys = systolic
	val weightSys = systolic
	val outputSys = systolic
	var computeValueSparsity
	var computeGroupSparsity
	var memoryValueSparsity 
	var memoryGroupSparsity 	
	if(SparsityOptimization == 0){
		computeValueSparsity = 0
		computeGroupSparsity = 0
		memoryValueSparsity  = 0
		memoryGroupSparsity  = 0	
	} else if(SparistyOptimization == 1){
		computeValueSparsity = 1
		computeGroupSparsity = 0
		memoryValueSparsity  = 0
		memoryGroupSparsity  = 0	
	} else if (SparsityOptimization == 2){	
		computeValueSparsity = 1
		computeGroupSparsity = 1
		memoryValueSparsity  = 0
		memoryGroupSparsity  = 0	
	} else if (SparsityOptimization == 3){
		computeValueSparsity = 1
		computeGroupSparsity = 0
		memoryValueSparsity  = 1
		memoryGroupSparsity  = 0			
	} else if (SparsityOptimization == 4){
		computeValueSparsity = 1
		computeGroupSparsity = 0
		memoryValueSparsity  = 1
		memoryGroupSparsity  = 1				
	} else {
		computeValueSparsity = 1
		computeGroupSparsity = 1
		memoryValueSparsity  = 1
		memoryGroupSparsity  = 1		
	}
		
	HardwareConfig("PX") = inputPrec
	HardwareConfig("PWq") = weightPrec
	HardwareConfig("PWk") = weightPrec
	HardwareConfig("PWv") =  weightPrec    
	HardwareConfig("PQ") =  inputPrec
	HardwareConfig("PK") =  inputPrec
	HardwareConfig("PS") = inputPrec
	HardwareConfig("PP") = inputPrec
	HardwareConfig("PO") = inputPrec
	HardwareConfig("PSoftmaxFrac") =  inputPrec/2   
	HardwareConfig("PV") =  inputPrec

	HardwareConfig("B1") = B
	HardwareConfig("N1") = N
	HardwareConfig("H1") = H
	HardwareConfig("D1") = D
	HardwareConfig("E1") = E
	HardwareConfig("M1") = M
	HardwareConfig("B2") = B
	HardwareConfig("N2") = N
	HardwareConfig("H2") = H
	HardwareConfig("D2") = D
	HardwareConfig("M2") = M
	HardwareConfig("B3") = B
	HardwareConfig("N3") = N
	HardwareConfig("H3") = H
	HardwareConfig("M3") = M
	HardwareConfig("O3") = O
	HardwareConfig("E3") = E
	
	HardwareConfig("XqNet") = inputSys
	HardwareConfig("XkNet") = inputSys
	HardwareConfig("XvNet") = inputSys
	HardwareConfig("WqNet") = weightSys
	HardwareConfig("WkNet") = weightSys
	HardwareConfig("WvNet") = weightSys
	HardwareConfig("QNet") = outputSys
	HardwareConfig("KNet") = outputSys
	HardwareConfig("SNet") = outputSys
	HardwareConfig("VNet") = outputSys
	HardwareConfig("ONet") = outputSys
	HardwareConfig("PNet") = outputSys

	HardwareConfig("PhiX") = computeValueSparsity
	HardwareConfig("PhiW") = computeValueSparsity
	HardwareConfig("PhiSparseAttenTopK") = computeGroupSparsity
	HardwareConfig("WindowAttenComp")    = computeGroupSparsity 
	HardwareConfig("PhiXMem") = memoryValueSparsity
	HardwareConfig("PhiWMem") = memoryValueSparsity
	HardwareConfig("WindowAttenMem") = memoryGroupSparsity
		
	HardwareConfig("PhiXRatio") = SparsityRatio
	HardwareConfig("PhiWRatio") = SparsityRatio
	HardwareConfig("PhiSparseAttenTopKRatio") = SparsityRatio
	HardwareConfig("WindowAttenCompRatio")    = SparsityRatio 
	HardwareConfig("PhiXMemRatio") = SparsityRatio
	HardwareConfig("PhiWMemRatio") = SparsityRatio
	HardwareConfig("WindowAttenMemRatio") = SparsityRatio	

	HardwareConfig("PQCache") = cacheSize 
	HardwareConfig("PKCache") = cacheSize 
	HardwareConfig("PVCache") = cacheSize 
	HardwareConfig("PPCache") = cacheSize 
	HardwareConfig("POCache") = cacheSize 
	HardwareConfig("PSCache") = cacheSize
	/////////////////////////////////////////////////
	
	val attn = Module(new Attention(HardwareConfig))
	attn.io <> io

}