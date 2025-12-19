package llm
import chisel3._
import chisel3.iotesters._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers



// Tester class (iotesters style)
class MatMulIndexCounterTester(dut: MatMulIndexCounter) extends PeekPokeTester(dut) {
  private val I = dut.I
  private val J = dut.J
  private val K = dut.K
  private val total = I * J * K

  // Helper to check current state
  def expectIndices(exp_i: Int, exp_j: Int, exp_k: Int, cycle: Int): Unit = {
    expect(dut.io.i, exp_i)
    expect(dut.io.j, exp_j)
    expect(dut.io.k, exp_k)
    expect(dut.io.valid, true)
    val isLast = (exp_i == I - 1) && (exp_j == J - 1) && (exp_k == K - 1)
    expect(dut.io.last, if (isLast) 1 else 0)
    println(f"Cycle $cycle%2d: i=$exp_i%2d, j=$exp_j%2d, k=$exp_k%2d, last=${if(isLast)1 else 0}")
  }

  // Reset
  poke(dut.io.start, 0)
  step(1)

  // Start
  poke(dut.io.start, 1)
  step(1)  // Now at first index (0,0,0)

  var idx = 0
  for (i <- 0 until I; j <- 0 until J; k <- 0 until K) {
    expectIndices(i, j, k, idx + 1)
    step(1)
    idx += 1
  }

  // After final index, should be done
  expect(dut.io.valid, 0)
  expect(dut.io.finish, 1)
  expect(dut.io.last, 0)  // last only high *on* last cycle, not after

  println(s"✅ Completed $total iterations for ${I}x${J}x${K} matrix multiply.")
}

// Test harness
class MatMulIndexCounterTest extends AnyFlatSpec with Matchers {
  "MatMulIndexCounter" should "work with iotesters" in {
    iotesters.Driver.execute(
      args = Array("--backend-name", "firrtl"),
      dut = () => new MatMulIndexCounter(I = 2, J = 3, K = 2)
    ) { dut =>
      new MatMulIndexCounterTester(dut)
    } shouldBe true
  }
}