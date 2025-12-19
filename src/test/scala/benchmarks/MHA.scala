package benchmarks

import breeze.linalg.{DenseMatrix, DenseVector, softmax}
import breeze.numerics.sqrt

class MultiHeadAttention(
  val dModel: Int,      // 输入维度
  val numHeads: Int,    // 注意力头数量
  val dK: Int           // 每个头的维度
) {
  require(dModel % numHeads == 0, "dModel必须能被numHeads整除")

  // 初始化权重矩阵
  private val Wq = DenseMatrix.rand[Double](dModel, dModel)
  private val Wk = DenseMatrix.rand[Double](dModel, dModel)
  private val Wv = DenseMatrix.rand[Double](dModel, dModel)
  private val Wo = DenseMatrix.rand[Double](dModel, dModel)

  def forward(
    query: DenseMatrix[Double],
    key: DenseMatrix[Double],
    value: DenseMatrix[Double],
    mask: Option[DenseMatrix[Double]] = None
  ): DenseMatrix[Double] = {
    // 线性变换
    val Q = query * Wq
    val K = key * Wk
    val V = value * Wv

    // 分割多头
    val splitHeads = (matrix: DenseMatrix[Double]) => 
      (0 until numHeads).map { h =>
        val start = h * dK
        val end = (h + 1) * dK
        matrix(::, start until end)
      }

    val headsQ = splitHeads(Q)
    val headsK = splitHeads(K)
    val headsV = splitHeads(V)

    // 并行计算每个头的注意力
    val headOutputs = (0 until numHeads).map { i =>
      scaledDotProductAttention(headsQ(i), headsK(i), headsV(i), mask)
    }

    // 拼接多头输出
    val concatHeads = DenseMatrix.horzcat(headsV: _*)
    
    // 最终线性变换
    concatHeads * Wo
  }

  private def scaledDotProductAttention(
    Q: DenseMatrix[Double],
    K: DenseMatrix[Double],
    V: DenseMatrix[Double],
    mask: Option[DenseMatrix[Double]]
  ): DenseMatrix[Double] = {
    val scores = Q * K.t / sqrt(dK.toDouble)
    
    val maskedScores = mask match {
      case Some(m) => scores * m
      case None => scores
    }

    val weights = softmax(maskedScores)
    weights * V
  }
}

object MHATest extends App{ 
	
    val dModel = 512
    val numHeads = 8
    val dK = 64
    
    val mha = new MultiHeadAttention(dModel, numHeads, dK)
    
    // 示例输入（batch_size=1, seq_len=10）
    val query = DenseMatrix.rand[Double](10, dModel)
    val key = DenseMatrix.rand[Double](10, dModel)
    val value = DenseMatrix.rand[Double](10, dModel)
    
    val output = mha.forward(query, key, value)
    println(s"Output shape: ${output.rows} x ${output.cols}")
}
