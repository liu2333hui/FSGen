package helper

import chisel3._



class EntryExitWire( val prec_in:Int, val prec_out:Int, val buffered:Boolean = false ) extends Module {
  val io = IO(new Bundle {
    val in    = Input(UInt(prec_in.W))
    val out  = Output(UInt(prec_out.W))
	
	
	val entry = new EntryIO()
	val exit = new ExitIO()
	
	
  })
  
  if(buffered){
		val reg1 = RegInit(0.U(prec_out.W))
		reg1 := io.in
		io.out := reg1
	
		
		
  }else{
  
	  io.out := io.in
	  io.exit <> io.entry
  }

}


