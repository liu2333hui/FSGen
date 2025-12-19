// package units

// import chisel3._
// import chisel3.util._

// import counters.{CounterMax, CascadedCounter}

// //i, j, k
// //ii, jj, kk, i, j, k
// class GEMMUnitCounter() extends Module {

// 	  val io = IO(new Bundle {
// 	    val en     = Input(Bool())      // 全局使能
// 	    val max_i  = Input(UInt(8.W))   // i 的最大值（0 ~ max_i）
// 	    val max_j  = Input(UInt(8.W))   // j 的最大值
// 	    val max_k  = Input(UInt(8.W))   // k 的最大值
	
// 	    val i = Output(UInt(8.W))       // 对应第0级（最快变化）
// 	    val j = Output(UInt(8.W))       // 第1级
// 	    val k = Output(UInt(8.W))       // 第2级（最慢变化）
// 	  })
	
// 	  // 实例化三级串联计数器（每级8位）
// 	  val cascaded = Module(new CascadedCounter(levels = 3, width = width))
	
// 	  // 连接使能
// 	  cascaded.io.en := io.en
	
// 	  // 连接每级的最大值
// 	  cascaded.io.max(0) := io.max_i
// 	  cascaded.io.max(1) := io.max_j
// 	  cascaded.io.max(2) := io.max_k
	
// 	  // 输出映射：count(0) → i, count(1) → j, count(2) → k
// 	  io.i := cascaded.io.count(0)
// 	  io.j := cascaded.io.count(1)
// 	  io.k := cascaded.io.count(2)
	
// }


// class GEMMUnitAGU(val width: Int = 8) extends Module {
//   val io = IO(new Bundle {
//     // 输入
//     val i     = Input(UInt(width.W))
//     val j     = Input(UInt(width.W))
//     val k     = Input(UInt(width.W))
//     val max_i = Input(UInt(width.W))
//     val max_j = Input(UInt(width.W))

//     // 输出地址
//     val xaddr = Output(UInt((2 * width).W))  // 乘法可能翻倍位宽
//     val waddr = Output(UInt((2 * width).W))
//   })
 
//   /* Clock issues
//   // 计算 xaddr = i + j * max_i
//   val j_times_max_i = io.j * io.max_i
//   io.xaddr := io.i + j_times_max_i

//   // 计算 waddr = j + k * max_j
//   val k_times_max_j = io.k * io.max_j
//   io.waddr := io.j + k_times_max_j
// 	*/


// 	val x_addr = Module(new CascadedCounter(levels = 2, width = 2*width))
	
// 	val w_addr = Module(new CascadedCounter(levels = 2, width = 2*width))

// }


// class GEMMUnit(HardwareConfig: Map[String, String]) extends Module {
 
 
 
//  //Pipeline:
//  //1. 计数器
//  //2. 地址生成
//  //3. 读取数据
//   val counter = Module(new GEMMUnitCounter())
  
//   val agu = Module(new GEMMUnitAGU())
  


// }