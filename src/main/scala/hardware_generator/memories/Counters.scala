// package counters

// import chisel3._
// import chisel3.util._

// class CounterWithMax(width: Int = 8) extends Module {
//   val io = IO(new Bundle {
//     val en  = Input(Bool())
//     val max = Input(UInt(width.W))   // 最大计数值（达到后归零）
//     val count = Output(UInt(width.W))
//   })

//   val counter = RegInit(0.U(width.W))

//   when(reset.asBool) {
//     counter := 0.U
//   }.elsewhen(io.en) {
//     // 如果当前值 >= max，则归零；否则加 1
//     when(counter >= io.max) {
//       counter := 0.U
//     }.otherwise {
//       counter := counter + 1.U
//     }
//   }
//   // 如果 en = 0，保持当前值（寄存器自动保持）

//   io.count := counter
// }

// class CascadedCounter(
//   levels: Int = 3,
//   width: Int = 4  // 每级位宽，例如 BCD 用 4-bit
// ) extends Module {
//   val io = IO(new Bundle {
//     val en     = Input(Bool())                 // 全局使能
//     val max    = Input(Vec(levels, UInt(width.W)))  // 每级的最大值
//     val count  = Output(Vec(levels, UInt(width.W))) // 每级计数值
//   })

//   // 实例化多个计数器
//   val counters = Array.fill(levels)(Module(new CounterWithMax(width)))

//   // 连接第一级
//   counters(0).io.en  := io.en
//   counters(0).io.max := io.max(0)

//   // 串联：用前一级的 carry 驱动下一级的 en
//   for (i <- 1 until levels) {
//     counters(i).io.en  := counters(i - 1).io.carry
//     counters(i).io.max := io.max(i)
//   }

//   // 输出
//   for (i <- 0 until levels) {
//     io.count(i) := counters(i).io.count
//   }
// }