package llm


import chisel3._
import chisel3.util._

class MatMulIndexCounter(
  val I: Int,  // Row dimension of A/C
  val J: Int,  // Column dimension of B/C
  val K: Int   // Common dimension (A.cols = B.rows)
) extends Module {
  val io = IO(new Bundle {
    val start     = Input(Bool())      // Pulse to start computation
    val finish    = Output(Bool())     // Asserts when all indices done
    val valid     = Output(Bool())     // Asserts when (i,j,k) is valid
    val i         = Output(UInt(log2Up(I).W))
    val j         = Output(UInt(log2Up(J).W))
    val k         = Output(UInt(log2Up(K).W))
    val last      = Output(Bool())     // Asserts on final (i,j,k)
  })

  // Internal state registers
  val i_reg = RegInit(0.U(log2Up(I).W))
  val j_reg = RegInit(0.U(log2Up(J).W))
  val k_reg = RegInit(0.U(log2Up(K).W))

  val done = RegInit(false.B)  // Set when all indices completed

  // Control logic
  val en_counter = io.start || (!done && io.valid)
  val last_k = (k_reg === (K - 1).U)
  val last_j = (j_reg === (J - 1).U) && last_k
  val last_i = (i_reg === (I - 1).U) && last_j

  // Update logic
  when(reset.asBool) {
    i_reg := 0.U
    j_reg := 0.U
    k_reg := 0.U
    done := false.B
  }.elsewhen(en_counter && !done) {
    when(last_k) {
      k_reg := 0.U
      when(last_j) {
        j_reg := 0.U
        when(last_i) {
          i_reg := 0.U
          done := true.B
        }.otherwise {
          i_reg := i_reg + 1.U
        }
      }.otherwise {
        j_reg := j_reg + 1.U
      }
    }.otherwise {
      k_reg := k_reg + 1.U
    }
  }

  // Output assignments
  io.i := i_reg
  io.j := j_reg
  io.k := k_reg
  io.valid := !done
  io.finish := done
  io.last := last_i && last_j && last_k
}