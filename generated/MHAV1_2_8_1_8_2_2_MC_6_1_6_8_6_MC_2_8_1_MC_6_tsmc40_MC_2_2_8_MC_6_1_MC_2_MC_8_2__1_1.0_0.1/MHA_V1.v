module SimpleMultiplier2(
  input  [7:0]  io_A,
  input  [7:0]  io_B,
  output [15:0] io_Out
);
  assign io_Out = io_A * io_B; // @[SimpleMultiplier2.scala 13:16]
endmodule
module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:0]; // @[Decoupled.scala 209:16]
  wire [7:0] ram__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram__T_7_addr; // @[Decoupled.scala 209:16]
  wire [7:0] ram__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram__T_3_en; // @[Decoupled.scala 209:16]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  assign ram__T_7_addr = 1'h0;
  assign ram__T_7_data = ram[ram__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram__T_3_data = io_enq_bits;
  assign ram__T_3_addr = 1'h0;
  assign ram__T_3_mask = 1'h1;
  assign ram__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~maybe_full; // @[Decoupled.scala 232:16]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits = ram__T_7_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  maybe_full = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram__T_3_en & ram__T_3_mask) begin
      ram[ram__T_3_addr] <= ram__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_4) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module PipelineUnit(
  input   clock,
  input   reset,
  input   io_validin,
  output  io_pipe_allowin,
  output  io_pipe_valid_reg
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  pipe_valid; // @[pipeline.scala 138:33]
  assign io_pipe_allowin = 1'h1; // @[pipeline.scala 151:25]
  assign io_pipe_valid_reg = pipe_valid; // @[pipeline.scala 141:27]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pipe_valid = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      pipe_valid <= 1'h0;
    end else if (io_pipe_allowin) begin
      pipe_valid <= io_validin;
    end
  end
endmodule
module PipelineChain(
  input   clock,
  input   reset,
  input   io_validin,
  output  io_validin_internal_0,
  output  io_pipe_allowin_internal_0,
  output  io_validout_internal_0,
  output  io_pipe_allowin
);
  wire  f_clock; // @[pipeline.scala 74:45]
  wire  f_reset; // @[pipeline.scala 74:45]
  wire  f_io_validin; // @[pipeline.scala 74:45]
  wire  f_io_pipe_allowin; // @[pipeline.scala 74:45]
  wire  f_io_pipe_valid_reg; // @[pipeline.scala 74:45]
  PipelineUnit f ( // @[pipeline.scala 74:45]
    .clock(f_clock),
    .reset(f_reset),
    .io_validin(f_io_validin),
    .io_pipe_allowin(f_io_pipe_allowin),
    .io_pipe_valid_reg(f_io_pipe_valid_reg)
  );
  assign io_validin_internal_0 = io_validin; // @[pipeline.scala 85:32]
  assign io_pipe_allowin_internal_0 = io_pipe_allowin; // @[pipeline.scala 86:37]
  assign io_validout_internal_0 = f_io_pipe_valid_reg; // @[pipeline.scala 95:33]
  assign io_pipe_allowin = 1'h1; // @[pipeline.scala 88:25]
  assign f_clock = clock;
  assign f_reset = reset;
  assign f_io_validin = io_validin; // @[pipeline.scala 82:22]
endmodule
module PipelineChainValid(
  input   clock,
  input   reset,
  input   io_validin,
  output  io_data_update_0,
  output  io_validout_internal_0
);
  wire  m_clock; // @[pipeline.scala 29:23]
  wire  m_reset; // @[pipeline.scala 29:23]
  wire  m_io_validin; // @[pipeline.scala 29:23]
  wire  m_io_validin_internal_0; // @[pipeline.scala 29:23]
  wire  m_io_pipe_allowin_internal_0; // @[pipeline.scala 29:23]
  wire  m_io_validout_internal_0; // @[pipeline.scala 29:23]
  wire  m_io_pipe_allowin; // @[pipeline.scala 29:23]
  PipelineChain m ( // @[pipeline.scala 29:23]
    .clock(m_clock),
    .reset(m_reset),
    .io_validin(m_io_validin),
    .io_validin_internal_0(m_io_validin_internal_0),
    .io_pipe_allowin_internal_0(m_io_pipe_allowin_internal_0),
    .io_validout_internal_0(m_io_validout_internal_0),
    .io_pipe_allowin(m_io_pipe_allowin)
  );
  assign io_data_update_0 = m_io_validin_internal_0 & m_io_pipe_allowin_internal_0; // @[pipeline.scala 43:35]
  assign io_validout_internal_0 = m_io_validout_internal_0; // @[pipeline.scala 46:30]
  assign m_clock = clock;
  assign m_reset = reset;
  assign m_io_validin = io_validin; // @[pipeline.scala 33:22]
endmodule
module Queue_8(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [15:0] io_enq_bits,
  output        io_deq_valid,
  output [15:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] ram [0:0]; // @[Decoupled.scala 209:16]
  wire [15:0] ram__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram__T_7_addr; // @[Decoupled.scala 209:16]
  wire [15:0] ram__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram__T_3_en; // @[Decoupled.scala 209:16]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = do_enq != io_deq_valid; // @[Decoupled.scala 227:16]
  assign ram__T_7_addr = 1'h0;
  assign ram__T_7_data = ram[ram__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram__T_3_data = io_enq_bits;
  assign ram__T_3_addr = 1'h0;
  assign ram__T_3_mask = 1'h1;
  assign ram__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~maybe_full; // @[Decoupled.scala 232:16]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits = ram__T_7_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram[initvar] = _RAND_0[15:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  maybe_full = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram__T_3_en & ram__T_3_mask) begin
      ram[ram__T_3_addr] <= ram__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_4) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module SimpleAdderN(
  input  [15:0] io_A_0,
  input  [15:0] io_A_1,
  output [15:0] io_Sum
);
  assign io_Sum = io_A_0 + io_A_1; // @[SimpleAdderN.scala 17:12]
endmodule
module BaselineSystolicPE(
  input        clock,
  input        reset,
  input  [7:0] io_W_0,
  input  [7:0] io_W_1,
  input  [7:0] io_W_2,
  input  [7:0] io_W_3,
  input  [7:0] io_X_0,
  input  [7:0] io_X_1,
  input  [7:0] io_X_2,
  input  [7:0] io_X_3,
  output [7:0] io_Y_0,
  output [7:0] io_Y_1,
  output [7:0] io_Y_2,
  output [7:0] io_Y_3,
  input        io_valid,
  output       io_DEBUG_VALID_0,
  output       io_DEBUG_VALID_1,
  output       io_DEBUG_VALID_2,
  output       io_DEBUG_VALID_3,
  output       io_DEBUG_VALID_4,
  output       io_DEBUG_VALID_5,
  output       io_DEBUG_VALID_6,
  output       io_DEBUG_VALID_7
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] PEA_0_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_0_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_0_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_1_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_1_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_1_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_2_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_2_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_2_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_3_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_3_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_3_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_4_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_4_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_4_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_5_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_5_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_5_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_6_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_6_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_6_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_7_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_7_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_7_io_Out; // @[GEMMBaseline.scala 84:47]
  wire  WQueue_0_clock; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_reset; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_enq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_enq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_0_io_enq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_deq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_deq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_0_io_deq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_clock; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_reset; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_enq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_enq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_1_io_enq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_deq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_deq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_1_io_deq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_2_clock; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_2_reset; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_2_io_enq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_2_io_enq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_2_io_enq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_2_io_deq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_2_io_deq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_2_io_deq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_3_clock; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_3_reset; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_3_io_enq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_3_io_enq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_3_io_enq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_3_io_deq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_3_io_deq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_3_io_deq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WPipe_0_clock; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_reset; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_io_validin; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_clock; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_reset; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_io_validin; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_io_data_update_0; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 135:42]
  wire  XQueue_0_clock; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_reset; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_enq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_enq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_0_io_enq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_deq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_deq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_0_io_deq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_clock; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_reset; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_enq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_enq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_1_io_enq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_deq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_deq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_1_io_deq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_2_clock; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_2_reset; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_2_io_enq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_2_io_enq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_2_io_enq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_2_io_deq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_2_io_deq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_2_io_deq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_3_clock; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_3_reset; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_3_io_enq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_3_io_enq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_3_io_enq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_3_io_deq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_3_io_deq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_3_io_deq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XPipe_0_clock; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_reset; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_io_validin; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_clock; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_reset; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_io_validin; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_io_data_update_0; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 170:42]
  wire  YQueue_0_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_0_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_0_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_1_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_1_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_2_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_2_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_3_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_3_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_4_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_4_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_4_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_4_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_4_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_4_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_4_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_5_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_5_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_5_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_5_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_5_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_5_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_5_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_6_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_6_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_6_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_6_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_6_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_6_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_6_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_7_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_7_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_7_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_7_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_7_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_7_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_7_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YAdder_0_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_0_io_A_1; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_0_io_Sum; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_1_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_1_io_A_1; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_1_io_Sum; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_2_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_2_io_A_1; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_2_io_Sum; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_3_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_3_io_A_1; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_3_io_Sum; // @[GEMMBaseline.scala 356:57]
  reg [7:0] REG_A_0; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_1; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_2; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_3; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_4; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_5; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_6; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_7; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_B_0; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_1; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_2; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_3; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_4; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_5; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_6; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_7; // @[GEMMBaseline.scala 93:24]
  wire  VALID_PE_2 = XPipe_0_io_validout_internal_0 & WPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 272:103]
  wire  _T_6 = ~WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 284:57]
  wire  VALID_PE_4 = XPipe_1_io_validout_internal_0 & WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 272:103]
  wire  _T_14 = ~XPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 289:57]
  wire  VALID_PE_6 = XPipe_1_io_validout_internal_0 & WPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 272:103]
  wire  _T_23 = VALID_PE_6 & _T_14; // @[GEMMBaseline.scala 277:108]
  reg [15:0] Y_REG_0; // @[GEMMBaseline.scala 388:24]
  reg [15:0] Y_REG_1; // @[GEMMBaseline.scala 388:24]
  reg [15:0] Y_REG_2; // @[GEMMBaseline.scala 388:24]
  reg [15:0] Y_REG_3; // @[GEMMBaseline.scala 388:24]
  SimpleMultiplier2 PEA_0 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_0_io_A),
    .io_B(PEA_0_io_B),
    .io_Out(PEA_0_io_Out)
  );
  SimpleMultiplier2 PEA_1 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_1_io_A),
    .io_B(PEA_1_io_B),
    .io_Out(PEA_1_io_Out)
  );
  SimpleMultiplier2 PEA_2 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_2_io_A),
    .io_B(PEA_2_io_B),
    .io_Out(PEA_2_io_Out)
  );
  SimpleMultiplier2 PEA_3 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_3_io_A),
    .io_B(PEA_3_io_B),
    .io_Out(PEA_3_io_Out)
  );
  SimpleMultiplier2 PEA_4 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_4_io_A),
    .io_B(PEA_4_io_B),
    .io_Out(PEA_4_io_Out)
  );
  SimpleMultiplier2 PEA_5 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_5_io_A),
    .io_B(PEA_5_io_B),
    .io_Out(PEA_5_io_Out)
  );
  SimpleMultiplier2 PEA_6 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_6_io_A),
    .io_B(PEA_6_io_B),
    .io_Out(PEA_6_io_Out)
  );
  SimpleMultiplier2 PEA_7 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_7_io_A),
    .io_B(PEA_7_io_B),
    .io_Out(PEA_7_io_Out)
  );
  Queue WQueue_0 ( // @[GEMMBaseline.scala 120:55]
    .clock(WQueue_0_clock),
    .reset(WQueue_0_reset),
    .io_enq_ready(WQueue_0_io_enq_ready),
    .io_enq_valid(WQueue_0_io_enq_valid),
    .io_enq_bits(WQueue_0_io_enq_bits),
    .io_deq_ready(WQueue_0_io_deq_ready),
    .io_deq_valid(WQueue_0_io_deq_valid),
    .io_deq_bits(WQueue_0_io_deq_bits)
  );
  Queue WQueue_1 ( // @[GEMMBaseline.scala 120:55]
    .clock(WQueue_1_clock),
    .reset(WQueue_1_reset),
    .io_enq_ready(WQueue_1_io_enq_ready),
    .io_enq_valid(WQueue_1_io_enq_valid),
    .io_enq_bits(WQueue_1_io_enq_bits),
    .io_deq_ready(WQueue_1_io_deq_ready),
    .io_deq_valid(WQueue_1_io_deq_valid),
    .io_deq_bits(WQueue_1_io_deq_bits)
  );
  Queue WQueue_2 ( // @[GEMMBaseline.scala 120:55]
    .clock(WQueue_2_clock),
    .reset(WQueue_2_reset),
    .io_enq_ready(WQueue_2_io_enq_ready),
    .io_enq_valid(WQueue_2_io_enq_valid),
    .io_enq_bits(WQueue_2_io_enq_bits),
    .io_deq_ready(WQueue_2_io_deq_ready),
    .io_deq_valid(WQueue_2_io_deq_valid),
    .io_deq_bits(WQueue_2_io_deq_bits)
  );
  Queue WQueue_3 ( // @[GEMMBaseline.scala 120:55]
    .clock(WQueue_3_clock),
    .reset(WQueue_3_reset),
    .io_enq_ready(WQueue_3_io_enq_ready),
    .io_enq_valid(WQueue_3_io_enq_valid),
    .io_enq_bits(WQueue_3_io_enq_bits),
    .io_deq_ready(WQueue_3_io_deq_ready),
    .io_deq_valid(WQueue_3_io_deq_valid),
    .io_deq_bits(WQueue_3_io_deq_bits)
  );
  PipelineChainValid WPipe_0 ( // @[GEMMBaseline.scala 135:42]
    .clock(WPipe_0_clock),
    .reset(WPipe_0_reset),
    .io_validin(WPipe_0_io_validin),
    .io_data_update_0(WPipe_0_io_data_update_0),
    .io_validout_internal_0(WPipe_0_io_validout_internal_0)
  );
  PipelineChainValid WPipe_1 ( // @[GEMMBaseline.scala 135:42]
    .clock(WPipe_1_clock),
    .reset(WPipe_1_reset),
    .io_validin(WPipe_1_io_validin),
    .io_data_update_0(WPipe_1_io_data_update_0),
    .io_validout_internal_0(WPipe_1_io_validout_internal_0)
  );
  Queue XQueue_0 ( // @[GEMMBaseline.scala 154:55]
    .clock(XQueue_0_clock),
    .reset(XQueue_0_reset),
    .io_enq_ready(XQueue_0_io_enq_ready),
    .io_enq_valid(XQueue_0_io_enq_valid),
    .io_enq_bits(XQueue_0_io_enq_bits),
    .io_deq_ready(XQueue_0_io_deq_ready),
    .io_deq_valid(XQueue_0_io_deq_valid),
    .io_deq_bits(XQueue_0_io_deq_bits)
  );
  Queue XQueue_1 ( // @[GEMMBaseline.scala 154:55]
    .clock(XQueue_1_clock),
    .reset(XQueue_1_reset),
    .io_enq_ready(XQueue_1_io_enq_ready),
    .io_enq_valid(XQueue_1_io_enq_valid),
    .io_enq_bits(XQueue_1_io_enq_bits),
    .io_deq_ready(XQueue_1_io_deq_ready),
    .io_deq_valid(XQueue_1_io_deq_valid),
    .io_deq_bits(XQueue_1_io_deq_bits)
  );
  Queue XQueue_2 ( // @[GEMMBaseline.scala 154:55]
    .clock(XQueue_2_clock),
    .reset(XQueue_2_reset),
    .io_enq_ready(XQueue_2_io_enq_ready),
    .io_enq_valid(XQueue_2_io_enq_valid),
    .io_enq_bits(XQueue_2_io_enq_bits),
    .io_deq_ready(XQueue_2_io_deq_ready),
    .io_deq_valid(XQueue_2_io_deq_valid),
    .io_deq_bits(XQueue_2_io_deq_bits)
  );
  Queue XQueue_3 ( // @[GEMMBaseline.scala 154:55]
    .clock(XQueue_3_clock),
    .reset(XQueue_3_reset),
    .io_enq_ready(XQueue_3_io_enq_ready),
    .io_enq_valid(XQueue_3_io_enq_valid),
    .io_enq_bits(XQueue_3_io_enq_bits),
    .io_deq_ready(XQueue_3_io_deq_ready),
    .io_deq_valid(XQueue_3_io_deq_valid),
    .io_deq_bits(XQueue_3_io_deq_bits)
  );
  PipelineChainValid XPipe_0 ( // @[GEMMBaseline.scala 170:42]
    .clock(XPipe_0_clock),
    .reset(XPipe_0_reset),
    .io_validin(XPipe_0_io_validin),
    .io_data_update_0(XPipe_0_io_data_update_0),
    .io_validout_internal_0(XPipe_0_io_validout_internal_0)
  );
  PipelineChainValid XPipe_1 ( // @[GEMMBaseline.scala 170:42]
    .clock(XPipe_1_clock),
    .reset(XPipe_1_reset),
    .io_validin(XPipe_1_io_validin),
    .io_data_update_0(XPipe_1_io_data_update_0),
    .io_validout_internal_0(XPipe_1_io_validout_internal_0)
  );
  Queue_8 YQueue_0 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_0_clock),
    .reset(YQueue_0_reset),
    .io_enq_ready(YQueue_0_io_enq_ready),
    .io_enq_valid(YQueue_0_io_enq_valid),
    .io_enq_bits(YQueue_0_io_enq_bits),
    .io_deq_valid(YQueue_0_io_deq_valid),
    .io_deq_bits(YQueue_0_io_deq_bits)
  );
  Queue_8 YQueue_1 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_1_clock),
    .reset(YQueue_1_reset),
    .io_enq_ready(YQueue_1_io_enq_ready),
    .io_enq_valid(YQueue_1_io_enq_valid),
    .io_enq_bits(YQueue_1_io_enq_bits),
    .io_deq_valid(YQueue_1_io_deq_valid),
    .io_deq_bits(YQueue_1_io_deq_bits)
  );
  Queue_8 YQueue_2 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_2_clock),
    .reset(YQueue_2_reset),
    .io_enq_ready(YQueue_2_io_enq_ready),
    .io_enq_valid(YQueue_2_io_enq_valid),
    .io_enq_bits(YQueue_2_io_enq_bits),
    .io_deq_valid(YQueue_2_io_deq_valid),
    .io_deq_bits(YQueue_2_io_deq_bits)
  );
  Queue_8 YQueue_3 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_3_clock),
    .reset(YQueue_3_reset),
    .io_enq_ready(YQueue_3_io_enq_ready),
    .io_enq_valid(YQueue_3_io_enq_valid),
    .io_enq_bits(YQueue_3_io_enq_bits),
    .io_deq_valid(YQueue_3_io_deq_valid),
    .io_deq_bits(YQueue_3_io_deq_bits)
  );
  Queue_8 YQueue_4 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_4_clock),
    .reset(YQueue_4_reset),
    .io_enq_ready(YQueue_4_io_enq_ready),
    .io_enq_valid(YQueue_4_io_enq_valid),
    .io_enq_bits(YQueue_4_io_enq_bits),
    .io_deq_valid(YQueue_4_io_deq_valid),
    .io_deq_bits(YQueue_4_io_deq_bits)
  );
  Queue_8 YQueue_5 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_5_clock),
    .reset(YQueue_5_reset),
    .io_enq_ready(YQueue_5_io_enq_ready),
    .io_enq_valid(YQueue_5_io_enq_valid),
    .io_enq_bits(YQueue_5_io_enq_bits),
    .io_deq_valid(YQueue_5_io_deq_valid),
    .io_deq_bits(YQueue_5_io_deq_bits)
  );
  Queue_8 YQueue_6 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_6_clock),
    .reset(YQueue_6_reset),
    .io_enq_ready(YQueue_6_io_enq_ready),
    .io_enq_valid(YQueue_6_io_enq_valid),
    .io_enq_bits(YQueue_6_io_enq_bits),
    .io_deq_valid(YQueue_6_io_deq_valid),
    .io_deq_bits(YQueue_6_io_deq_bits)
  );
  Queue_8 YQueue_7 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_7_clock),
    .reset(YQueue_7_reset),
    .io_enq_ready(YQueue_7_io_enq_ready),
    .io_enq_valid(YQueue_7_io_enq_valid),
    .io_enq_bits(YQueue_7_io_enq_bits),
    .io_deq_valid(YQueue_7_io_deq_valid),
    .io_deq_bits(YQueue_7_io_deq_bits)
  );
  SimpleAdderN YAdder_0 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_0_io_A_0),
    .io_A_1(YAdder_0_io_A_1),
    .io_Sum(YAdder_0_io_Sum)
  );
  SimpleAdderN YAdder_1 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_1_io_A_0),
    .io_A_1(YAdder_1_io_A_1),
    .io_Sum(YAdder_1_io_Sum)
  );
  SimpleAdderN YAdder_2 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_2_io_A_0),
    .io_A_1(YAdder_2_io_A_1),
    .io_Sum(YAdder_2_io_Sum)
  );
  SimpleAdderN YAdder_3 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_3_io_A_0),
    .io_A_1(YAdder_3_io_A_1),
    .io_Sum(YAdder_3_io_Sum)
  );
  assign io_Y_0 = Y_REG_0[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_Y_1 = Y_REG_1[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_Y_2 = Y_REG_2[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_Y_3 = Y_REG_3[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_DEBUG_VALID_0 = XPipe_0_io_validout_internal_0 & WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 292:79]
  assign io_DEBUG_VALID_1 = XPipe_0_io_validout_internal_0 & WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 292:79]
  assign io_DEBUG_VALID_2 = VALID_PE_2 & _T_6; // @[GEMMBaseline.scala 282:63]
  assign io_DEBUG_VALID_3 = VALID_PE_2 & _T_6; // @[GEMMBaseline.scala 282:63]
  assign io_DEBUG_VALID_4 = VALID_PE_4 & _T_14; // @[GEMMBaseline.scala 287:63]
  assign io_DEBUG_VALID_5 = VALID_PE_4 & _T_14; // @[GEMMBaseline.scala 287:63]
  assign io_DEBUG_VALID_6 = _T_23 & _T_6; // @[GEMMBaseline.scala 276:63]
  assign io_DEBUG_VALID_7 = _T_23 & _T_6; // @[GEMMBaseline.scala 276:63]
  assign PEA_0_io_A = REG_A_0; // @[GEMMBaseline.scala 98:47]
  assign PEA_0_io_B = REG_B_0; // @[GEMMBaseline.scala 99:47]
  assign PEA_1_io_A = REG_A_1; // @[GEMMBaseline.scala 98:47]
  assign PEA_1_io_B = REG_B_1; // @[GEMMBaseline.scala 99:47]
  assign PEA_2_io_A = REG_A_2; // @[GEMMBaseline.scala 98:47]
  assign PEA_2_io_B = REG_B_2; // @[GEMMBaseline.scala 99:47]
  assign PEA_3_io_A = REG_A_3; // @[GEMMBaseline.scala 98:47]
  assign PEA_3_io_B = REG_B_3; // @[GEMMBaseline.scala 99:47]
  assign PEA_4_io_A = REG_A_4; // @[GEMMBaseline.scala 98:47]
  assign PEA_4_io_B = REG_B_4; // @[GEMMBaseline.scala 99:47]
  assign PEA_5_io_A = REG_A_5; // @[GEMMBaseline.scala 98:47]
  assign PEA_5_io_B = REG_B_5; // @[GEMMBaseline.scala 99:47]
  assign PEA_6_io_A = REG_A_6; // @[GEMMBaseline.scala 98:47]
  assign PEA_6_io_B = REG_B_6; // @[GEMMBaseline.scala 99:47]
  assign PEA_7_io_A = REG_A_7; // @[GEMMBaseline.scala 98:47]
  assign PEA_7_io_B = REG_B_7; // @[GEMMBaseline.scala 99:47]
  assign WQueue_0_clock = clock;
  assign WQueue_0_reset = reset;
  assign WQueue_0_io_enq_valid = io_valid; // @[GEMMBaseline.scala 189:48]
  assign WQueue_0_io_enq_bits = io_W_0; // @[GEMMBaseline.scala 188:47]
  assign WQueue_0_io_deq_ready = XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 192:48]
  assign WQueue_1_clock = clock;
  assign WQueue_1_reset = reset;
  assign WQueue_1_io_enq_valid = io_valid; // @[GEMMBaseline.scala 189:48]
  assign WQueue_1_io_enq_bits = io_W_1; // @[GEMMBaseline.scala 188:47]
  assign WQueue_1_io_deq_ready = XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 192:48]
  assign WQueue_2_clock = clock;
  assign WQueue_2_reset = reset;
  assign WQueue_2_io_enq_valid = io_valid; // @[GEMMBaseline.scala 189:48]
  assign WQueue_2_io_enq_bits = io_W_2; // @[GEMMBaseline.scala 188:47]
  assign WQueue_2_io_deq_ready = XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 192:48]
  assign WQueue_3_clock = clock;
  assign WQueue_3_reset = reset;
  assign WQueue_3_io_enq_valid = io_valid; // @[GEMMBaseline.scala 189:48]
  assign WQueue_3_io_enq_bits = io_W_3; // @[GEMMBaseline.scala 188:47]
  assign WQueue_3_io_deq_ready = XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 192:48]
  assign WPipe_0_clock = clock;
  assign WPipe_0_reset = reset;
  assign WPipe_0_io_validin = WQueue_1_io_deq_valid; // @[GEMMBaseline.scala 195:45 GEMMBaseline.scala 198:45 GEMMBaseline.scala 195:45 GEMMBaseline.scala 198:45]
  assign WPipe_1_clock = clock;
  assign WPipe_1_reset = reset;
  assign WPipe_1_io_validin = WQueue_3_io_deq_valid; // @[GEMMBaseline.scala 195:45 GEMMBaseline.scala 198:45 GEMMBaseline.scala 195:45 GEMMBaseline.scala 198:45]
  assign XQueue_0_clock = clock;
  assign XQueue_0_reset = reset;
  assign XQueue_0_io_enq_valid = io_valid; // @[GEMMBaseline.scala 235:48]
  assign XQueue_0_io_enq_bits = io_X_0; // @[GEMMBaseline.scala 234:47]
  assign XQueue_0_io_deq_ready = WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 238:48]
  assign XQueue_1_clock = clock;
  assign XQueue_1_reset = reset;
  assign XQueue_1_io_enq_valid = io_valid; // @[GEMMBaseline.scala 235:48]
  assign XQueue_1_io_enq_bits = io_X_1; // @[GEMMBaseline.scala 234:47]
  assign XQueue_1_io_deq_ready = WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 238:48]
  assign XQueue_2_clock = clock;
  assign XQueue_2_reset = reset;
  assign XQueue_2_io_enq_valid = io_valid; // @[GEMMBaseline.scala 235:48]
  assign XQueue_2_io_enq_bits = io_X_2; // @[GEMMBaseline.scala 234:47]
  assign XQueue_2_io_deq_ready = WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 238:48]
  assign XQueue_3_clock = clock;
  assign XQueue_3_reset = reset;
  assign XQueue_3_io_enq_valid = io_valid; // @[GEMMBaseline.scala 235:48]
  assign XQueue_3_io_enq_bits = io_X_3; // @[GEMMBaseline.scala 234:47]
  assign XQueue_3_io_deq_ready = WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 238:48]
  assign XPipe_0_clock = clock;
  assign XPipe_0_reset = reset;
  assign XPipe_0_io_validin = XQueue_1_io_deq_valid; // @[GEMMBaseline.scala 241:45 GEMMBaseline.scala 241:45]
  assign XPipe_1_clock = clock;
  assign XPipe_1_reset = reset;
  assign XPipe_1_io_validin = XQueue_3_io_deq_valid; // @[GEMMBaseline.scala 241:45 GEMMBaseline.scala 241:45]
  assign YQueue_0_clock = clock;
  assign YQueue_0_reset = reset;
  assign YQueue_0_io_enq_valid = io_DEBUG_VALID_0; // @[GEMMBaseline.scala 423:56]
  assign YQueue_0_io_enq_bits = PEA_0_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_1_clock = clock;
  assign YQueue_1_reset = reset;
  assign YQueue_1_io_enq_valid = io_DEBUG_VALID_1; // @[GEMMBaseline.scala 423:56]
  assign YQueue_1_io_enq_bits = PEA_1_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_2_clock = clock;
  assign YQueue_2_reset = reset;
  assign YQueue_2_io_enq_valid = io_DEBUG_VALID_2; // @[GEMMBaseline.scala 423:56]
  assign YQueue_2_io_enq_bits = PEA_2_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_3_clock = clock;
  assign YQueue_3_reset = reset;
  assign YQueue_3_io_enq_valid = io_DEBUG_VALID_3; // @[GEMMBaseline.scala 423:56]
  assign YQueue_3_io_enq_bits = PEA_3_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_4_clock = clock;
  assign YQueue_4_reset = reset;
  assign YQueue_4_io_enq_valid = io_DEBUG_VALID_4; // @[GEMMBaseline.scala 423:56]
  assign YQueue_4_io_enq_bits = PEA_4_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_5_clock = clock;
  assign YQueue_5_reset = reset;
  assign YQueue_5_io_enq_valid = io_DEBUG_VALID_5; // @[GEMMBaseline.scala 423:56]
  assign YQueue_5_io_enq_bits = PEA_5_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_6_clock = clock;
  assign YQueue_6_reset = reset;
  assign YQueue_6_io_enq_valid = io_DEBUG_VALID_6; // @[GEMMBaseline.scala 423:56]
  assign YQueue_6_io_enq_bits = PEA_6_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_7_clock = clock;
  assign YQueue_7_reset = reset;
  assign YQueue_7_io_enq_valid = io_DEBUG_VALID_7; // @[GEMMBaseline.scala 423:56]
  assign YQueue_7_io_enq_bits = PEA_7_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YAdder_0_io_A_0 = YQueue_1_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_0_io_A_1 = YQueue_1_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_1_io_A_0 = YQueue_3_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_1_io_A_1 = YQueue_3_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_2_io_A_0 = YQueue_5_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_2_io_A_1 = YQueue_5_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_3_io_A_0 = YQueue_7_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
  assign YAdder_3_io_A_1 = YQueue_7_io_deq_bits; // @[GEMMBaseline.scala 469:70 GEMMBaseline.scala 469:70]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  REG_A_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  REG_A_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  REG_A_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  REG_A_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  REG_A_4 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  REG_A_5 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  REG_A_6 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  REG_A_7 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  REG_B_0 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  REG_B_1 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  REG_B_2 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  REG_B_3 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  REG_B_4 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  REG_B_5 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  REG_B_6 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  REG_B_7 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  Y_REG_0 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  Y_REG_1 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  Y_REG_2 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  Y_REG_3 = _RAND_19[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    REG_A_0 <= XQueue_0_io_deq_bits;
    REG_A_1 <= XQueue_1_io_deq_bits;
    REG_A_2 <= XQueue_0_io_deq_bits;
    REG_A_3 <= XQueue_1_io_deq_bits;
    REG_A_4 <= XQueue_2_io_deq_bits;
    REG_A_5 <= XQueue_3_io_deq_bits;
    REG_A_6 <= XQueue_2_io_deq_bits;
    REG_A_7 <= XQueue_3_io_deq_bits;
    REG_B_0 <= WQueue_0_io_deq_bits;
    REG_B_1 <= WQueue_1_io_deq_bits;
    REG_B_2 <= WQueue_2_io_deq_bits;
    REG_B_3 <= WQueue_3_io_deq_bits;
    REG_B_4 <= WQueue_0_io_deq_bits;
    REG_B_5 <= WQueue_1_io_deq_bits;
    REG_B_6 <= WQueue_2_io_deq_bits;
    REG_B_7 <= WQueue_3_io_deq_bits;
    Y_REG_0 <= YAdder_0_io_Sum;
    Y_REG_1 <= YAdder_1_io_Sum;
    Y_REG_2 <= YAdder_2_io_Sum;
    Y_REG_3 <= YAdder_3_io_Sum;
  end
endmodule
module Queue_16(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:7]; // @[Decoupled.scala 209:16]
  wire [7:0] ram__T_11_data; // @[Decoupled.scala 209:16]
  wire [2:0] ram__T_11_addr; // @[Decoupled.scala 209:16]
  wire [7:0] ram__T_3_data; // @[Decoupled.scala 209:16]
  wire [2:0] ram__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] enq_ptr_value; // @[Counter.scala 29:33]
  reg [2:0] deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire [2:0] _T_5 = enq_ptr_value + 3'h1; // @[Counter.scala 39:22]
  wire [2:0] _T_7 = deq_ptr_value + 3'h1; // @[Counter.scala 39:22]
  wire  _T_8 = do_enq != io_deq_valid; // @[Decoupled.scala 227:16]
  assign ram__T_11_addr = deq_ptr_value;
  assign ram__T_11_data = ram[ram__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram__T_3_data = io_enq_bits;
  assign ram__T_3_addr = enq_ptr_value;
  assign ram__T_3_mask = 1'h1;
  assign ram__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 232:16]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits = ram__T_11_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram__T_3_en & ram__T_3_mask) begin
      ram[ram__T_3_addr] <= ram__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 3'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 3'h0;
    end else if (io_deq_valid) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module SimpleAdderN_4(
  input  [7:0] io_A_0,
  input  [7:0] io_A_1,
  output [7:0] io_Sum
);
  assign io_Sum = io_A_0 + io_A_1; // @[SimpleAdderN.scala 17:12]
endmodule
module SRAMS(
  input        clock,
  input  [5:0] io_raddr,
  input        io_wen,
  input  [7:0] io_wdata,
  output [7:0] io_rdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] lut [0:63]; // @[SRAMS.scala 50:24]
  wire [7:0] lut__T_data; // @[SRAMS.scala 50:24]
  wire [5:0] lut__T_addr; // @[SRAMS.scala 50:24]
  wire [7:0] lut__T_1_data; // @[SRAMS.scala 50:24]
  wire [5:0] lut__T_1_addr; // @[SRAMS.scala 50:24]
  wire [7:0] lut__T_2_data; // @[SRAMS.scala 50:24]
  wire [5:0] lut__T_2_addr; // @[SRAMS.scala 50:24]
  wire  lut__T_2_mask; // @[SRAMS.scala 50:24]
  wire  lut__T_2_en; // @[SRAMS.scala 50:24]
  reg [5:0] lut__T_addr_pipe_0;
  assign lut__T_addr = lut__T_addr_pipe_0;
  assign lut__T_data = lut[lut__T_addr]; // @[SRAMS.scala 50:24]
  assign lut__T_1_addr = 6'h0;
  assign lut__T_1_data = lut[lut__T_1_addr]; // @[SRAMS.scala 50:24]
  assign lut__T_2_data = io_wdata;
  assign lut__T_2_addr = 6'h0;
  assign lut__T_2_mask = 1'h1;
  assign lut__T_2_en = io_wen;
  assign io_rdata = lut__T_data; // @[SRAMS.scala 55:14 SRAMS.scala 57:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    lut[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  lut__T_addr_pipe_0 = _RAND_1[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(lut__T_2_en & lut__T_2_mask) begin
      lut[lut__T_2_addr] <= lut__T_2_data; // @[SRAMS.scala 50:24]
    end
    lut__T_addr_pipe_0 <= io_raddr;
  end
endmodule
module SimpleAdderN_16(
  input  [15:0] io_A_0,
  output [15:0] io_Sum
);
  assign io_Sum = io_A_0; // @[SimpleAdderN.scala 17:12]
endmodule
module BaselineSystolicPE_2(
  input        clock,
  input        reset,
  input  [7:0] io_W_0,
  input  [7:0] io_W_1,
  input  [7:0] io_X_0,
  input  [7:0] io_X_1,
  output [7:0] io_Y_0,
  output [7:0] io_Y_1,
  output [7:0] io_Y_2,
  output [7:0] io_Y_3,
  input        io_valid,
  output       io_DEBUG_VALID_0,
  output       io_DEBUG_VALID_1,
  output       io_DEBUG_VALID_2,
  output       io_DEBUG_VALID_3
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] PEA_0_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_0_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_0_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_1_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_1_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_1_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_2_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_2_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_2_io_Out; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_3_io_A; // @[GEMMBaseline.scala 84:47]
  wire [7:0] PEA_3_io_B; // @[GEMMBaseline.scala 84:47]
  wire [15:0] PEA_3_io_Out; // @[GEMMBaseline.scala 84:47]
  wire  WQueue_0_clock; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_reset; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_enq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_enq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_0_io_enq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_deq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_0_io_deq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_0_io_deq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_clock; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_reset; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_enq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_enq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_1_io_enq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_deq_ready; // @[GEMMBaseline.scala 120:55]
  wire  WQueue_1_io_deq_valid; // @[GEMMBaseline.scala 120:55]
  wire [7:0] WQueue_1_io_deq_bits; // @[GEMMBaseline.scala 120:55]
  wire  WPipe_0_clock; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_reset; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_io_validin; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_clock; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_reset; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_io_validin; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_io_data_update_0; // @[GEMMBaseline.scala 135:42]
  wire  WPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 135:42]
  wire  XQueue_0_clock; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_reset; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_enq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_enq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_0_io_enq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_deq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_0_io_deq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_0_io_deq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_clock; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_reset; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_enq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_enq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_1_io_enq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_deq_ready; // @[GEMMBaseline.scala 154:55]
  wire  XQueue_1_io_deq_valid; // @[GEMMBaseline.scala 154:55]
  wire [7:0] XQueue_1_io_deq_bits; // @[GEMMBaseline.scala 154:55]
  wire  XPipe_0_clock; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_reset; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_io_validin; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_clock; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_reset; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_io_validin; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_io_data_update_0; // @[GEMMBaseline.scala 170:42]
  wire  XPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 170:42]
  wire  YQueue_0_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_0_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_0_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_0_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_1_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_1_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_1_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_2_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_2_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_2_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_clock; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_reset; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_io_enq_ready; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_io_enq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_3_io_enq_bits; // @[GEMMBaseline.scala 329:47]
  wire  YQueue_3_io_deq_valid; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YQueue_3_io_deq_bits; // @[GEMMBaseline.scala 329:47]
  wire [15:0] YAdder_0_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_0_io_Sum; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_1_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_1_io_Sum; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_2_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_2_io_Sum; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_3_io_A_0; // @[GEMMBaseline.scala 356:57]
  wire [15:0] YAdder_3_io_Sum; // @[GEMMBaseline.scala 356:57]
  reg [7:0] REG_A_0; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_1; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_2; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_A_3; // @[GEMMBaseline.scala 92:24]
  reg [7:0] REG_B_0; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_1; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_2; // @[GEMMBaseline.scala 93:24]
  reg [7:0] REG_B_3; // @[GEMMBaseline.scala 93:24]
  wire  VALID_PE_1 = XPipe_0_io_validout_internal_0 & WPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 272:103]
  wire  _T_4 = ~WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 284:57]
  wire  VALID_PE_2 = XPipe_1_io_validout_internal_0 & WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 272:103]
  wire  _T_8 = ~XPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 289:57]
  wire  VALID_PE_3 = XPipe_1_io_validout_internal_0 & WPipe_1_io_validout_internal_0; // @[GEMMBaseline.scala 272:103]
  wire  _T_13 = VALID_PE_3 & _T_8; // @[GEMMBaseline.scala 277:108]
  reg [15:0] Y_REG_0; // @[GEMMBaseline.scala 388:24]
  reg [15:0] Y_REG_1; // @[GEMMBaseline.scala 388:24]
  reg [15:0] Y_REG_2; // @[GEMMBaseline.scala 388:24]
  reg [15:0] Y_REG_3; // @[GEMMBaseline.scala 388:24]
  SimpleMultiplier2 PEA_0 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_0_io_A),
    .io_B(PEA_0_io_B),
    .io_Out(PEA_0_io_Out)
  );
  SimpleMultiplier2 PEA_1 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_1_io_A),
    .io_B(PEA_1_io_B),
    .io_Out(PEA_1_io_Out)
  );
  SimpleMultiplier2 PEA_2 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_2_io_A),
    .io_B(PEA_2_io_B),
    .io_Out(PEA_2_io_Out)
  );
  SimpleMultiplier2 PEA_3 ( // @[GEMMBaseline.scala 84:47]
    .io_A(PEA_3_io_A),
    .io_B(PEA_3_io_B),
    .io_Out(PEA_3_io_Out)
  );
  Queue WQueue_0 ( // @[GEMMBaseline.scala 120:55]
    .clock(WQueue_0_clock),
    .reset(WQueue_0_reset),
    .io_enq_ready(WQueue_0_io_enq_ready),
    .io_enq_valid(WQueue_0_io_enq_valid),
    .io_enq_bits(WQueue_0_io_enq_bits),
    .io_deq_ready(WQueue_0_io_deq_ready),
    .io_deq_valid(WQueue_0_io_deq_valid),
    .io_deq_bits(WQueue_0_io_deq_bits)
  );
  Queue WQueue_1 ( // @[GEMMBaseline.scala 120:55]
    .clock(WQueue_1_clock),
    .reset(WQueue_1_reset),
    .io_enq_ready(WQueue_1_io_enq_ready),
    .io_enq_valid(WQueue_1_io_enq_valid),
    .io_enq_bits(WQueue_1_io_enq_bits),
    .io_deq_ready(WQueue_1_io_deq_ready),
    .io_deq_valid(WQueue_1_io_deq_valid),
    .io_deq_bits(WQueue_1_io_deq_bits)
  );
  PipelineChainValid WPipe_0 ( // @[GEMMBaseline.scala 135:42]
    .clock(WPipe_0_clock),
    .reset(WPipe_0_reset),
    .io_validin(WPipe_0_io_validin),
    .io_data_update_0(WPipe_0_io_data_update_0),
    .io_validout_internal_0(WPipe_0_io_validout_internal_0)
  );
  PipelineChainValid WPipe_1 ( // @[GEMMBaseline.scala 135:42]
    .clock(WPipe_1_clock),
    .reset(WPipe_1_reset),
    .io_validin(WPipe_1_io_validin),
    .io_data_update_0(WPipe_1_io_data_update_0),
    .io_validout_internal_0(WPipe_1_io_validout_internal_0)
  );
  Queue XQueue_0 ( // @[GEMMBaseline.scala 154:55]
    .clock(XQueue_0_clock),
    .reset(XQueue_0_reset),
    .io_enq_ready(XQueue_0_io_enq_ready),
    .io_enq_valid(XQueue_0_io_enq_valid),
    .io_enq_bits(XQueue_0_io_enq_bits),
    .io_deq_ready(XQueue_0_io_deq_ready),
    .io_deq_valid(XQueue_0_io_deq_valid),
    .io_deq_bits(XQueue_0_io_deq_bits)
  );
  Queue XQueue_1 ( // @[GEMMBaseline.scala 154:55]
    .clock(XQueue_1_clock),
    .reset(XQueue_1_reset),
    .io_enq_ready(XQueue_1_io_enq_ready),
    .io_enq_valid(XQueue_1_io_enq_valid),
    .io_enq_bits(XQueue_1_io_enq_bits),
    .io_deq_ready(XQueue_1_io_deq_ready),
    .io_deq_valid(XQueue_1_io_deq_valid),
    .io_deq_bits(XQueue_1_io_deq_bits)
  );
  PipelineChainValid XPipe_0 ( // @[GEMMBaseline.scala 170:42]
    .clock(XPipe_0_clock),
    .reset(XPipe_0_reset),
    .io_validin(XPipe_0_io_validin),
    .io_data_update_0(XPipe_0_io_data_update_0),
    .io_validout_internal_0(XPipe_0_io_validout_internal_0)
  );
  PipelineChainValid XPipe_1 ( // @[GEMMBaseline.scala 170:42]
    .clock(XPipe_1_clock),
    .reset(XPipe_1_reset),
    .io_validin(XPipe_1_io_validin),
    .io_data_update_0(XPipe_1_io_data_update_0),
    .io_validout_internal_0(XPipe_1_io_validout_internal_0)
  );
  Queue_8 YQueue_0 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_0_clock),
    .reset(YQueue_0_reset),
    .io_enq_ready(YQueue_0_io_enq_ready),
    .io_enq_valid(YQueue_0_io_enq_valid),
    .io_enq_bits(YQueue_0_io_enq_bits),
    .io_deq_valid(YQueue_0_io_deq_valid),
    .io_deq_bits(YQueue_0_io_deq_bits)
  );
  Queue_8 YQueue_1 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_1_clock),
    .reset(YQueue_1_reset),
    .io_enq_ready(YQueue_1_io_enq_ready),
    .io_enq_valid(YQueue_1_io_enq_valid),
    .io_enq_bits(YQueue_1_io_enq_bits),
    .io_deq_valid(YQueue_1_io_deq_valid),
    .io_deq_bits(YQueue_1_io_deq_bits)
  );
  Queue_8 YQueue_2 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_2_clock),
    .reset(YQueue_2_reset),
    .io_enq_ready(YQueue_2_io_enq_ready),
    .io_enq_valid(YQueue_2_io_enq_valid),
    .io_enq_bits(YQueue_2_io_enq_bits),
    .io_deq_valid(YQueue_2_io_deq_valid),
    .io_deq_bits(YQueue_2_io_deq_bits)
  );
  Queue_8 YQueue_3 ( // @[GEMMBaseline.scala 329:47]
    .clock(YQueue_3_clock),
    .reset(YQueue_3_reset),
    .io_enq_ready(YQueue_3_io_enq_ready),
    .io_enq_valid(YQueue_3_io_enq_valid),
    .io_enq_bits(YQueue_3_io_enq_bits),
    .io_deq_valid(YQueue_3_io_deq_valid),
    .io_deq_bits(YQueue_3_io_deq_bits)
  );
  SimpleAdderN_16 YAdder_0 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_0_io_A_0),
    .io_Sum(YAdder_0_io_Sum)
  );
  SimpleAdderN_16 YAdder_1 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_1_io_A_0),
    .io_Sum(YAdder_1_io_Sum)
  );
  SimpleAdderN_16 YAdder_2 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_2_io_A_0),
    .io_Sum(YAdder_2_io_Sum)
  );
  SimpleAdderN_16 YAdder_3 ( // @[GEMMBaseline.scala 356:57]
    .io_A_0(YAdder_3_io_A_0),
    .io_Sum(YAdder_3_io_Sum)
  );
  assign io_Y_0 = Y_REG_0[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_Y_1 = Y_REG_1[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_Y_2 = Y_REG_2[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_Y_3 = Y_REG_3[7:0]; // @[GEMMBaseline.scala 402:22]
  assign io_DEBUG_VALID_0 = XPipe_0_io_validout_internal_0 & WPipe_0_io_validout_internal_0; // @[GEMMBaseline.scala 292:79]
  assign io_DEBUG_VALID_1 = VALID_PE_1 & _T_4; // @[GEMMBaseline.scala 282:63]
  assign io_DEBUG_VALID_2 = VALID_PE_2 & _T_8; // @[GEMMBaseline.scala 287:63]
  assign io_DEBUG_VALID_3 = _T_13 & _T_4; // @[GEMMBaseline.scala 276:63]
  assign PEA_0_io_A = REG_A_0; // @[GEMMBaseline.scala 98:47]
  assign PEA_0_io_B = REG_B_0; // @[GEMMBaseline.scala 99:47]
  assign PEA_1_io_A = REG_A_1; // @[GEMMBaseline.scala 98:47]
  assign PEA_1_io_B = REG_B_1; // @[GEMMBaseline.scala 99:47]
  assign PEA_2_io_A = REG_A_2; // @[GEMMBaseline.scala 98:47]
  assign PEA_2_io_B = REG_B_2; // @[GEMMBaseline.scala 99:47]
  assign PEA_3_io_A = REG_A_3; // @[GEMMBaseline.scala 98:47]
  assign PEA_3_io_B = REG_B_3; // @[GEMMBaseline.scala 99:47]
  assign WQueue_0_clock = clock;
  assign WQueue_0_reset = reset;
  assign WQueue_0_io_enq_valid = io_valid; // @[GEMMBaseline.scala 189:48]
  assign WQueue_0_io_enq_bits = io_W_0; // @[GEMMBaseline.scala 188:47]
  assign WQueue_0_io_deq_ready = XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 192:48]
  assign WQueue_1_clock = clock;
  assign WQueue_1_reset = reset;
  assign WQueue_1_io_enq_valid = io_valid; // @[GEMMBaseline.scala 189:48]
  assign WQueue_1_io_enq_bits = io_W_1; // @[GEMMBaseline.scala 188:47]
  assign WQueue_1_io_deq_ready = XPipe_0_io_data_update_0; // @[GEMMBaseline.scala 192:48]
  assign WPipe_0_clock = clock;
  assign WPipe_0_reset = reset;
  assign WPipe_0_io_validin = WQueue_0_io_deq_valid; // @[GEMMBaseline.scala 195:45 GEMMBaseline.scala 198:45]
  assign WPipe_1_clock = clock;
  assign WPipe_1_reset = reset;
  assign WPipe_1_io_validin = WQueue_1_io_deq_valid; // @[GEMMBaseline.scala 195:45 GEMMBaseline.scala 198:45]
  assign XQueue_0_clock = clock;
  assign XQueue_0_reset = reset;
  assign XQueue_0_io_enq_valid = io_valid; // @[GEMMBaseline.scala 235:48]
  assign XQueue_0_io_enq_bits = io_X_0; // @[GEMMBaseline.scala 234:47]
  assign XQueue_0_io_deq_ready = WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 238:48]
  assign XQueue_1_clock = clock;
  assign XQueue_1_reset = reset;
  assign XQueue_1_io_enq_valid = io_valid; // @[GEMMBaseline.scala 235:48]
  assign XQueue_1_io_enq_bits = io_X_1; // @[GEMMBaseline.scala 234:47]
  assign XQueue_1_io_deq_ready = WPipe_0_io_data_update_0; // @[GEMMBaseline.scala 238:48]
  assign XPipe_0_clock = clock;
  assign XPipe_0_reset = reset;
  assign XPipe_0_io_validin = XQueue_0_io_deq_valid; // @[GEMMBaseline.scala 241:45]
  assign XPipe_1_clock = clock;
  assign XPipe_1_reset = reset;
  assign XPipe_1_io_validin = XQueue_1_io_deq_valid; // @[GEMMBaseline.scala 241:45]
  assign YQueue_0_clock = clock;
  assign YQueue_0_reset = reset;
  assign YQueue_0_io_enq_valid = io_DEBUG_VALID_0; // @[GEMMBaseline.scala 423:56]
  assign YQueue_0_io_enq_bits = PEA_0_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_1_clock = clock;
  assign YQueue_1_reset = reset;
  assign YQueue_1_io_enq_valid = io_DEBUG_VALID_1; // @[GEMMBaseline.scala 423:56]
  assign YQueue_1_io_enq_bits = PEA_1_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_2_clock = clock;
  assign YQueue_2_reset = reset;
  assign YQueue_2_io_enq_valid = io_DEBUG_VALID_2; // @[GEMMBaseline.scala 423:56]
  assign YQueue_2_io_enq_bits = PEA_2_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YQueue_3_clock = clock;
  assign YQueue_3_reset = reset;
  assign YQueue_3_io_enq_valid = io_DEBUG_VALID_3; // @[GEMMBaseline.scala 423:56]
  assign YQueue_3_io_enq_bits = PEA_3_io_Out; // @[GEMMBaseline.scala 422:55]
  assign YAdder_0_io_A_0 = YQueue_0_io_deq_bits; // @[GEMMBaseline.scala 469:70]
  assign YAdder_1_io_A_0 = YQueue_1_io_deq_bits; // @[GEMMBaseline.scala 469:70]
  assign YAdder_2_io_A_0 = YQueue_2_io_deq_bits; // @[GEMMBaseline.scala 469:70]
  assign YAdder_3_io_A_0 = YQueue_3_io_deq_bits; // @[GEMMBaseline.scala 469:70]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  REG_A_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  REG_A_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  REG_A_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  REG_A_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  REG_B_0 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  REG_B_1 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  REG_B_2 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  REG_B_3 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  Y_REG_0 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  Y_REG_1 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  Y_REG_2 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  Y_REG_3 = _RAND_11[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    REG_A_0 <= XQueue_0_io_deq_bits;
    REG_A_1 <= XQueue_0_io_deq_bits;
    REG_A_2 <= XQueue_1_io_deq_bits;
    REG_A_3 <= XQueue_1_io_deq_bits;
    REG_B_0 <= WQueue_0_io_deq_bits;
    REG_B_1 <= WQueue_1_io_deq_bits;
    REG_B_2 <= WQueue_0_io_deq_bits;
    REG_B_3 <= WQueue_1_io_deq_bits;
    Y_REG_0 <= YAdder_0_io_Sum;
    Y_REG_1 <= YAdder_1_io_Sum;
    Y_REG_2 <= YAdder_2_io_Sum;
    Y_REG_3 <= YAdder_3_io_Sum;
  end
endmodule
module SRAMS_8(
  input        clock,
  input        io_wen,
  input  [7:0] io_wdata,
  output [7:0] io_rdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [7:0] lut [0:3]; // @[SRAMS.scala 50:24]
  wire [7:0] lut__T_data; // @[SRAMS.scala 50:24]
  wire [1:0] lut__T_addr; // @[SRAMS.scala 50:24]
  wire [7:0] lut__T_1_data; // @[SRAMS.scala 50:24]
  wire [1:0] lut__T_1_addr; // @[SRAMS.scala 50:24]
  wire [7:0] lut__T_2_data; // @[SRAMS.scala 50:24]
  wire [1:0] lut__T_2_addr; // @[SRAMS.scala 50:24]
  wire  lut__T_2_mask; // @[SRAMS.scala 50:24]
  wire  lut__T_2_en; // @[SRAMS.scala 50:24]
  assign lut__T_addr = 2'h0;
  assign lut__T_data = lut[lut__T_addr]; // @[SRAMS.scala 50:24]
  assign lut__T_1_addr = 2'h0;
  assign lut__T_1_data = lut[lut__T_1_addr]; // @[SRAMS.scala 50:24]
  assign lut__T_2_data = io_wdata;
  assign lut__T_2_addr = 2'h0;
  assign lut__T_2_mask = 1'h1;
  assign lut__T_2_en = io_wen;
  assign io_rdata = lut__T_data; // @[SRAMS.scala 55:14 SRAMS.scala 57:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    lut[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(lut__T_2_en & lut__T_2_mask) begin
      lut[lut__T_2_addr] <= lut__T_2_data; // @[SRAMS.scala 50:24]
    end
  end
endmodule
module MHA_V1(
  input         clock,
  input         reset,
  input  [7:0]  io_Xk_0,
  input  [7:0]  io_Xk_1,
  input  [7:0]  io_Xk_2,
  input  [7:0]  io_Xk_3,
  input  [7:0]  io_Xq_0,
  input  [7:0]  io_Xq_1,
  input  [7:0]  io_Xq_2,
  input  [7:0]  io_Xq_3,
  input  [7:0]  io_Wq_0,
  input  [7:0]  io_Wq_1,
  input  [7:0]  io_Wq_2,
  input  [7:0]  io_Wq_3,
  input  [7:0]  io_Wk_0,
  input  [7:0]  io_Wk_1,
  input  [7:0]  io_Wk_2,
  input  [7:0]  io_Wk_3,
  output [7:0]  io_DEBUG_K_0,
  output [7:0]  io_DEBUG_K_1,
  output [7:0]  io_DEBUG_K_2,
  output [7:0]  io_DEBUG_K_3,
  output [7:0]  io_DEBUG_Q_0,
  output [7:0]  io_DEBUG_Q_1,
  output [7:0]  io_DEBUG_Q_2,
  output [7:0]  io_DEBUG_Q_3,
  output [7:0]  io_DEBUG_S_0,
  output [7:0]  io_DEBUG_S_1,
  output [7:0]  io_DEBUG_S_2,
  output [7:0]  io_DEBUG_S_3,
  output [7:0]  io_DEBUG_S_4,
  output [7:0]  io_DEBUG_S_5,
  output [7:0]  io_DEBUG_S_6,
  output [7:0]  io_DEBUG_S_7,
  input         io_valid,
  input  [31:0] io_N,
  input  [31:0] io_M,
  input  [31:0] io_H,
  input  [31:0] io_B,
  input  [31:0] io_O,
  input  [31:0] io_E,
  input  [31:0] io_D,
  input  [31:0] io_DimN,
  input  [31:0] io_DimM,
  input  [31:0] io_DimH,
  input  [31:0] io_DimB,
  input  [31:0] io_DimO,
  input  [31:0] io_DimE,
  input  [31:0] io_DimD
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire  BaselineSystolicPE_clock; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_reset; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_W_0; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_W_1; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_W_2; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_W_3; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_X_0; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_X_1; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_X_2; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_X_3; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_Y_0; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_Y_1; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_Y_2; // @[AttentionUnit.scala 118:43]
  wire [7:0] BaselineSystolicPE_io_Y_3; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_valid; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_0; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_1; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_2; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_3; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_4; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_5; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_6; // @[AttentionUnit.scala 118:43]
  wire  BaselineSystolicPE_io_DEBUG_VALID_7; // @[AttentionUnit.scala 118:43]
  wire  MM_Q_queue_0_clock; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_0_reset; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_0_io_enq_ready; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_0_io_enq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_0_io_enq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_0_io_deq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_0_io_deq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_1_clock; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_1_reset; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_1_io_enq_ready; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_1_io_enq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_1_io_enq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_1_io_deq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_1_io_deq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_2_clock; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_2_reset; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_2_io_enq_ready; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_2_io_enq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_2_io_enq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_2_io_deq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_2_io_deq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_3_clock; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_3_reset; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_3_io_enq_ready; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_3_io_enq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_3_io_enq_bits; // @[AttentionUnit.scala 144:47]
  wire  MM_Q_queue_3_io_deq_valid; // @[AttentionUnit.scala 144:47]
  wire [7:0] MM_Q_queue_3_io_deq_bits; // @[AttentionUnit.scala 144:47]
  wire [7:0] SimpleAdderN_io_A_0; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_io_A_1; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_io_Sum; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_1_io_A_0; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_1_io_A_1; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_1_io_Sum; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_2_io_A_0; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_2_io_A_1; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_2_io_Sum; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_3_io_A_0; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_3_io_A_1; // @[AttentionUnit.scala 171:57]
  wire [7:0] SimpleAdderN_3_io_Sum; // @[AttentionUnit.scala 171:57]
  wire  SRAMS_clock; // @[AttentionUnit.scala 174:59]
  wire [5:0] SRAMS_io_raddr; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_io_wen; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_io_wdata; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_io_rdata; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_1_clock; // @[AttentionUnit.scala 174:59]
  wire [5:0] SRAMS_1_io_raddr; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_1_io_wen; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_1_io_wdata; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_1_io_rdata; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_2_clock; // @[AttentionUnit.scala 174:59]
  wire [5:0] SRAMS_2_io_raddr; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_2_io_wen; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_2_io_wdata; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_2_io_rdata; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_3_clock; // @[AttentionUnit.scala 174:59]
  wire [5:0] SRAMS_3_io_raddr; // @[AttentionUnit.scala 174:59]
  wire  SRAMS_3_io_wen; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_3_io_wdata; // @[AttentionUnit.scala 174:59]
  wire [7:0] SRAMS_3_io_rdata; // @[AttentionUnit.scala 174:59]
  wire  BaselineSystolicPE_1_clock; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_reset; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_W_0; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_W_1; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_W_2; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_W_3; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_X_0; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_X_1; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_X_2; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_X_3; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_Y_0; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_Y_1; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_Y_2; // @[AttentionUnit.scala 231:43]
  wire [7:0] BaselineSystolicPE_1_io_Y_3; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_valid; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_0; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_1; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_2; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_3; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_4; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_5; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_6; // @[AttentionUnit.scala 231:43]
  wire  BaselineSystolicPE_1_io_DEBUG_VALID_7; // @[AttentionUnit.scala 231:43]
  wire  MM_K_queue_0_clock; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_0_reset; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_0_io_enq_ready; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_0_io_enq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_0_io_enq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_0_io_deq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_0_io_deq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_1_clock; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_1_reset; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_1_io_enq_ready; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_1_io_enq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_1_io_enq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_1_io_deq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_1_io_deq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_2_clock; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_2_reset; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_2_io_enq_ready; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_2_io_enq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_2_io_enq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_2_io_deq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_2_io_deq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_3_clock; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_3_reset; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_3_io_enq_ready; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_3_io_enq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_3_io_enq_bits; // @[AttentionUnit.scala 252:47]
  wire  MM_K_queue_3_io_deq_valid; // @[AttentionUnit.scala 252:47]
  wire [7:0] MM_K_queue_3_io_deq_bits; // @[AttentionUnit.scala 252:47]
  wire [7:0] SimpleAdderN_4_io_A_0; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_4_io_A_1; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_4_io_Sum; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_5_io_A_0; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_5_io_A_1; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_5_io_Sum; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_6_io_A_0; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_6_io_A_1; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_6_io_Sum; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_7_io_A_0; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_7_io_A_1; // @[AttentionUnit.scala 279:57]
  wire [7:0] SimpleAdderN_7_io_Sum; // @[AttentionUnit.scala 279:57]
  wire  SRAMS_4_clock; // @[AttentionUnit.scala 282:59]
  wire [5:0] SRAMS_4_io_raddr; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_4_io_wen; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_4_io_wdata; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_4_io_rdata; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_5_clock; // @[AttentionUnit.scala 282:59]
  wire [5:0] SRAMS_5_io_raddr; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_5_io_wen; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_5_io_wdata; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_5_io_rdata; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_6_clock; // @[AttentionUnit.scala 282:59]
  wire [5:0] SRAMS_6_io_raddr; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_6_io_wen; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_6_io_wdata; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_6_io_rdata; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_7_clock; // @[AttentionUnit.scala 282:59]
  wire [5:0] SRAMS_7_io_raddr; // @[AttentionUnit.scala 282:59]
  wire  SRAMS_7_io_wen; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_7_io_wdata; // @[AttentionUnit.scala 282:59]
  wire [7:0] SRAMS_7_io_rdata; // @[AttentionUnit.scala 282:59]
  wire  BaselineSystolicPE_2_clock; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_2_reset; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_W_0; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_W_1; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_X_0; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_X_1; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_Y_0; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_Y_1; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_Y_2; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_2_io_Y_3; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_2_io_valid; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_2_io_DEBUG_VALID_0; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_2_io_DEBUG_VALID_1; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_2_io_DEBUG_VALID_2; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_2_io_DEBUG_VALID_3; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_clock; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_reset; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_W_0; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_W_1; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_X_0; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_X_1; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_Y_0; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_Y_1; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_Y_2; // @[AttentionUnit.scala 349:47]
  wire [7:0] BaselineSystolicPE_3_io_Y_3; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_io_valid; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_io_DEBUG_VALID_0; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_io_DEBUG_VALID_1; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_io_DEBUG_VALID_2; // @[AttentionUnit.scala 349:47]
  wire  BaselineSystolicPE_3_io_DEBUG_VALID_3; // @[AttentionUnit.scala 349:47]
  wire  MM_S_queue_0_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_0_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_0_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_0_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_0_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_0_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_0_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_1_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_1_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_1_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_1_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_1_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_1_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_1_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_2_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_2_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_2_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_2_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_2_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_2_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_2_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_3_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_3_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_3_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_3_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_3_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_3_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_3_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_4_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_4_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_4_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_4_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_4_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_4_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_4_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_5_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_5_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_5_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_5_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_5_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_5_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_5_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_6_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_6_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_6_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_6_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_6_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_6_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_6_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_7_clock; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_7_reset; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_7_io_enq_ready; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_7_io_enq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_7_io_enq_bits; // @[AttentionUnit.scala 388:55]
  wire  MM_S_queue_7_io_deq_valid; // @[AttentionUnit.scala 388:55]
  wire [7:0] MM_S_queue_7_io_deq_bits; // @[AttentionUnit.scala 388:55]
  wire [7:0] SimpleAdderN_8_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_8_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_8_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_9_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_9_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_9_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_10_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_10_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_10_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_11_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_11_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_11_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_12_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_12_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_12_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_13_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_13_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_13_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_14_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_14_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_14_io_Sum; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_15_io_A_0; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_15_io_A_1; // @[AttentionUnit.scala 410:57]
  wire [7:0] SimpleAdderN_15_io_Sum; // @[AttentionUnit.scala 410:57]
  wire  SRAMS_8_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_8_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_8_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_8_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_9_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_9_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_9_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_9_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_10_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_10_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_10_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_10_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_11_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_11_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_11_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_11_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_12_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_12_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_12_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_12_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_13_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_13_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_13_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_13_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_14_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_14_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_14_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_14_io_rdata; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_15_clock; // @[AttentionUnit.scala 413:59]
  wire  SRAMS_15_io_wen; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_15_io_wdata; // @[AttentionUnit.scala 413:59]
  wire [7:0] SRAMS_15_io_rdata; // @[AttentionUnit.scala 413:59]
  wire [31:0] _GEN_0 = io_D % 32'h40; // @[AttentionUnit.scala 189:58]
  wire [6:0] _T = _GEN_0[6:0]; // @[AttentionUnit.scala 189:58]
  wire  _T_1 = io_M > 32'h0; // @[AttentionUnit.scala 193:59]
  wire  _T_2 = io_O > 32'h0; // @[AttentionUnit.scala 193:72]
  wire  _T_3 = _T_1 | _T_2; // @[AttentionUnit.scala 193:65]
  wire  _T_5 = io_E > 32'h0; // @[AttentionUnit.scala 194:36]
  wire [31:0] _T_25 = io_E + 32'h1; // @[AttentionUnit.scala 214:26]
  wire  Q_valid = _T_25 >= io_DimE; // @[AttentionUnit.scala 214:32]
  wire  _T_28 = io_N > 32'h0; // @[AttentionUnit.scala 301:59]
  wire  _T_30 = _T_28 | _T_2; // @[AttentionUnit.scala 301:65]
  reg [7:0] mux_Q_0; // @[AttentionUnit.scala 329:24]
  reg [7:0] mux_Q_1; // @[AttentionUnit.scala 329:24]
  reg [7:0] mux_Q_2; // @[AttentionUnit.scala 329:24]
  reg [7:0] mux_Q_3; // @[AttentionUnit.scala 329:24]
  reg [7:0] mux_K_0; // @[AttentionUnit.scala 330:24]
  reg [7:0] mux_K_1; // @[AttentionUnit.scala 330:24]
  reg [7:0] mux_K_2; // @[AttentionUnit.scala 330:24]
  reg [7:0] mux_K_3; // @[AttentionUnit.scala 330:24]
  wire  _T_58 = io_D > 32'h0; // @[AttentionUnit.scala 437:44]
  BaselineSystolicPE BaselineSystolicPE ( // @[AttentionUnit.scala 118:43]
    .clock(BaselineSystolicPE_clock),
    .reset(BaselineSystolicPE_reset),
    .io_W_0(BaselineSystolicPE_io_W_0),
    .io_W_1(BaselineSystolicPE_io_W_1),
    .io_W_2(BaselineSystolicPE_io_W_2),
    .io_W_3(BaselineSystolicPE_io_W_3),
    .io_X_0(BaselineSystolicPE_io_X_0),
    .io_X_1(BaselineSystolicPE_io_X_1),
    .io_X_2(BaselineSystolicPE_io_X_2),
    .io_X_3(BaselineSystolicPE_io_X_3),
    .io_Y_0(BaselineSystolicPE_io_Y_0),
    .io_Y_1(BaselineSystolicPE_io_Y_1),
    .io_Y_2(BaselineSystolicPE_io_Y_2),
    .io_Y_3(BaselineSystolicPE_io_Y_3),
    .io_valid(BaselineSystolicPE_io_valid),
    .io_DEBUG_VALID_0(BaselineSystolicPE_io_DEBUG_VALID_0),
    .io_DEBUG_VALID_1(BaselineSystolicPE_io_DEBUG_VALID_1),
    .io_DEBUG_VALID_2(BaselineSystolicPE_io_DEBUG_VALID_2),
    .io_DEBUG_VALID_3(BaselineSystolicPE_io_DEBUG_VALID_3),
    .io_DEBUG_VALID_4(BaselineSystolicPE_io_DEBUG_VALID_4),
    .io_DEBUG_VALID_5(BaselineSystolicPE_io_DEBUG_VALID_5),
    .io_DEBUG_VALID_6(BaselineSystolicPE_io_DEBUG_VALID_6),
    .io_DEBUG_VALID_7(BaselineSystolicPE_io_DEBUG_VALID_7)
  );
  Queue_16 MM_Q_queue_0 ( // @[AttentionUnit.scala 144:47]
    .clock(MM_Q_queue_0_clock),
    .reset(MM_Q_queue_0_reset),
    .io_enq_ready(MM_Q_queue_0_io_enq_ready),
    .io_enq_valid(MM_Q_queue_0_io_enq_valid),
    .io_enq_bits(MM_Q_queue_0_io_enq_bits),
    .io_deq_valid(MM_Q_queue_0_io_deq_valid),
    .io_deq_bits(MM_Q_queue_0_io_deq_bits)
  );
  Queue_16 MM_Q_queue_1 ( // @[AttentionUnit.scala 144:47]
    .clock(MM_Q_queue_1_clock),
    .reset(MM_Q_queue_1_reset),
    .io_enq_ready(MM_Q_queue_1_io_enq_ready),
    .io_enq_valid(MM_Q_queue_1_io_enq_valid),
    .io_enq_bits(MM_Q_queue_1_io_enq_bits),
    .io_deq_valid(MM_Q_queue_1_io_deq_valid),
    .io_deq_bits(MM_Q_queue_1_io_deq_bits)
  );
  Queue_16 MM_Q_queue_2 ( // @[AttentionUnit.scala 144:47]
    .clock(MM_Q_queue_2_clock),
    .reset(MM_Q_queue_2_reset),
    .io_enq_ready(MM_Q_queue_2_io_enq_ready),
    .io_enq_valid(MM_Q_queue_2_io_enq_valid),
    .io_enq_bits(MM_Q_queue_2_io_enq_bits),
    .io_deq_valid(MM_Q_queue_2_io_deq_valid),
    .io_deq_bits(MM_Q_queue_2_io_deq_bits)
  );
  Queue_16 MM_Q_queue_3 ( // @[AttentionUnit.scala 144:47]
    .clock(MM_Q_queue_3_clock),
    .reset(MM_Q_queue_3_reset),
    .io_enq_ready(MM_Q_queue_3_io_enq_ready),
    .io_enq_valid(MM_Q_queue_3_io_enq_valid),
    .io_enq_bits(MM_Q_queue_3_io_enq_bits),
    .io_deq_valid(MM_Q_queue_3_io_deq_valid),
    .io_deq_bits(MM_Q_queue_3_io_deq_bits)
  );
  SimpleAdderN_4 SimpleAdderN ( // @[AttentionUnit.scala 171:57]
    .io_A_0(SimpleAdderN_io_A_0),
    .io_A_1(SimpleAdderN_io_A_1),
    .io_Sum(SimpleAdderN_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_1 ( // @[AttentionUnit.scala 171:57]
    .io_A_0(SimpleAdderN_1_io_A_0),
    .io_A_1(SimpleAdderN_1_io_A_1),
    .io_Sum(SimpleAdderN_1_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_2 ( // @[AttentionUnit.scala 171:57]
    .io_A_0(SimpleAdderN_2_io_A_0),
    .io_A_1(SimpleAdderN_2_io_A_1),
    .io_Sum(SimpleAdderN_2_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_3 ( // @[AttentionUnit.scala 171:57]
    .io_A_0(SimpleAdderN_3_io_A_0),
    .io_A_1(SimpleAdderN_3_io_A_1),
    .io_Sum(SimpleAdderN_3_io_Sum)
  );
  SRAMS SRAMS ( // @[AttentionUnit.scala 174:59]
    .clock(SRAMS_clock),
    .io_raddr(SRAMS_io_raddr),
    .io_wen(SRAMS_io_wen),
    .io_wdata(SRAMS_io_wdata),
    .io_rdata(SRAMS_io_rdata)
  );
  SRAMS SRAMS_1 ( // @[AttentionUnit.scala 174:59]
    .clock(SRAMS_1_clock),
    .io_raddr(SRAMS_1_io_raddr),
    .io_wen(SRAMS_1_io_wen),
    .io_wdata(SRAMS_1_io_wdata),
    .io_rdata(SRAMS_1_io_rdata)
  );
  SRAMS SRAMS_2 ( // @[AttentionUnit.scala 174:59]
    .clock(SRAMS_2_clock),
    .io_raddr(SRAMS_2_io_raddr),
    .io_wen(SRAMS_2_io_wen),
    .io_wdata(SRAMS_2_io_wdata),
    .io_rdata(SRAMS_2_io_rdata)
  );
  SRAMS SRAMS_3 ( // @[AttentionUnit.scala 174:59]
    .clock(SRAMS_3_clock),
    .io_raddr(SRAMS_3_io_raddr),
    .io_wen(SRAMS_3_io_wen),
    .io_wdata(SRAMS_3_io_wdata),
    .io_rdata(SRAMS_3_io_rdata)
  );
  BaselineSystolicPE BaselineSystolicPE_1 ( // @[AttentionUnit.scala 231:43]
    .clock(BaselineSystolicPE_1_clock),
    .reset(BaselineSystolicPE_1_reset),
    .io_W_0(BaselineSystolicPE_1_io_W_0),
    .io_W_1(BaselineSystolicPE_1_io_W_1),
    .io_W_2(BaselineSystolicPE_1_io_W_2),
    .io_W_3(BaselineSystolicPE_1_io_W_3),
    .io_X_0(BaselineSystolicPE_1_io_X_0),
    .io_X_1(BaselineSystolicPE_1_io_X_1),
    .io_X_2(BaselineSystolicPE_1_io_X_2),
    .io_X_3(BaselineSystolicPE_1_io_X_3),
    .io_Y_0(BaselineSystolicPE_1_io_Y_0),
    .io_Y_1(BaselineSystolicPE_1_io_Y_1),
    .io_Y_2(BaselineSystolicPE_1_io_Y_2),
    .io_Y_3(BaselineSystolicPE_1_io_Y_3),
    .io_valid(BaselineSystolicPE_1_io_valid),
    .io_DEBUG_VALID_0(BaselineSystolicPE_1_io_DEBUG_VALID_0),
    .io_DEBUG_VALID_1(BaselineSystolicPE_1_io_DEBUG_VALID_1),
    .io_DEBUG_VALID_2(BaselineSystolicPE_1_io_DEBUG_VALID_2),
    .io_DEBUG_VALID_3(BaselineSystolicPE_1_io_DEBUG_VALID_3),
    .io_DEBUG_VALID_4(BaselineSystolicPE_1_io_DEBUG_VALID_4),
    .io_DEBUG_VALID_5(BaselineSystolicPE_1_io_DEBUG_VALID_5),
    .io_DEBUG_VALID_6(BaselineSystolicPE_1_io_DEBUG_VALID_6),
    .io_DEBUG_VALID_7(BaselineSystolicPE_1_io_DEBUG_VALID_7)
  );
  Queue_16 MM_K_queue_0 ( // @[AttentionUnit.scala 252:47]
    .clock(MM_K_queue_0_clock),
    .reset(MM_K_queue_0_reset),
    .io_enq_ready(MM_K_queue_0_io_enq_ready),
    .io_enq_valid(MM_K_queue_0_io_enq_valid),
    .io_enq_bits(MM_K_queue_0_io_enq_bits),
    .io_deq_valid(MM_K_queue_0_io_deq_valid),
    .io_deq_bits(MM_K_queue_0_io_deq_bits)
  );
  Queue_16 MM_K_queue_1 ( // @[AttentionUnit.scala 252:47]
    .clock(MM_K_queue_1_clock),
    .reset(MM_K_queue_1_reset),
    .io_enq_ready(MM_K_queue_1_io_enq_ready),
    .io_enq_valid(MM_K_queue_1_io_enq_valid),
    .io_enq_bits(MM_K_queue_1_io_enq_bits),
    .io_deq_valid(MM_K_queue_1_io_deq_valid),
    .io_deq_bits(MM_K_queue_1_io_deq_bits)
  );
  Queue_16 MM_K_queue_2 ( // @[AttentionUnit.scala 252:47]
    .clock(MM_K_queue_2_clock),
    .reset(MM_K_queue_2_reset),
    .io_enq_ready(MM_K_queue_2_io_enq_ready),
    .io_enq_valid(MM_K_queue_2_io_enq_valid),
    .io_enq_bits(MM_K_queue_2_io_enq_bits),
    .io_deq_valid(MM_K_queue_2_io_deq_valid),
    .io_deq_bits(MM_K_queue_2_io_deq_bits)
  );
  Queue_16 MM_K_queue_3 ( // @[AttentionUnit.scala 252:47]
    .clock(MM_K_queue_3_clock),
    .reset(MM_K_queue_3_reset),
    .io_enq_ready(MM_K_queue_3_io_enq_ready),
    .io_enq_valid(MM_K_queue_3_io_enq_valid),
    .io_enq_bits(MM_K_queue_3_io_enq_bits),
    .io_deq_valid(MM_K_queue_3_io_deq_valid),
    .io_deq_bits(MM_K_queue_3_io_deq_bits)
  );
  SimpleAdderN_4 SimpleAdderN_4 ( // @[AttentionUnit.scala 279:57]
    .io_A_0(SimpleAdderN_4_io_A_0),
    .io_A_1(SimpleAdderN_4_io_A_1),
    .io_Sum(SimpleAdderN_4_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_5 ( // @[AttentionUnit.scala 279:57]
    .io_A_0(SimpleAdderN_5_io_A_0),
    .io_A_1(SimpleAdderN_5_io_A_1),
    .io_Sum(SimpleAdderN_5_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_6 ( // @[AttentionUnit.scala 279:57]
    .io_A_0(SimpleAdderN_6_io_A_0),
    .io_A_1(SimpleAdderN_6_io_A_1),
    .io_Sum(SimpleAdderN_6_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_7 ( // @[AttentionUnit.scala 279:57]
    .io_A_0(SimpleAdderN_7_io_A_0),
    .io_A_1(SimpleAdderN_7_io_A_1),
    .io_Sum(SimpleAdderN_7_io_Sum)
  );
  SRAMS SRAMS_4 ( // @[AttentionUnit.scala 282:59]
    .clock(SRAMS_4_clock),
    .io_raddr(SRAMS_4_io_raddr),
    .io_wen(SRAMS_4_io_wen),
    .io_wdata(SRAMS_4_io_wdata),
    .io_rdata(SRAMS_4_io_rdata)
  );
  SRAMS SRAMS_5 ( // @[AttentionUnit.scala 282:59]
    .clock(SRAMS_5_clock),
    .io_raddr(SRAMS_5_io_raddr),
    .io_wen(SRAMS_5_io_wen),
    .io_wdata(SRAMS_5_io_wdata),
    .io_rdata(SRAMS_5_io_rdata)
  );
  SRAMS SRAMS_6 ( // @[AttentionUnit.scala 282:59]
    .clock(SRAMS_6_clock),
    .io_raddr(SRAMS_6_io_raddr),
    .io_wen(SRAMS_6_io_wen),
    .io_wdata(SRAMS_6_io_wdata),
    .io_rdata(SRAMS_6_io_rdata)
  );
  SRAMS SRAMS_7 ( // @[AttentionUnit.scala 282:59]
    .clock(SRAMS_7_clock),
    .io_raddr(SRAMS_7_io_raddr),
    .io_wen(SRAMS_7_io_wen),
    .io_wdata(SRAMS_7_io_wdata),
    .io_rdata(SRAMS_7_io_rdata)
  );
  BaselineSystolicPE_2 BaselineSystolicPE_2 ( // @[AttentionUnit.scala 349:47]
    .clock(BaselineSystolicPE_2_clock),
    .reset(BaselineSystolicPE_2_reset),
    .io_W_0(BaselineSystolicPE_2_io_W_0),
    .io_W_1(BaselineSystolicPE_2_io_W_1),
    .io_X_0(BaselineSystolicPE_2_io_X_0),
    .io_X_1(BaselineSystolicPE_2_io_X_1),
    .io_Y_0(BaselineSystolicPE_2_io_Y_0),
    .io_Y_1(BaselineSystolicPE_2_io_Y_1),
    .io_Y_2(BaselineSystolicPE_2_io_Y_2),
    .io_Y_3(BaselineSystolicPE_2_io_Y_3),
    .io_valid(BaselineSystolicPE_2_io_valid),
    .io_DEBUG_VALID_0(BaselineSystolicPE_2_io_DEBUG_VALID_0),
    .io_DEBUG_VALID_1(BaselineSystolicPE_2_io_DEBUG_VALID_1),
    .io_DEBUG_VALID_2(BaselineSystolicPE_2_io_DEBUG_VALID_2),
    .io_DEBUG_VALID_3(BaselineSystolicPE_2_io_DEBUG_VALID_3)
  );
  BaselineSystolicPE_2 BaselineSystolicPE_3 ( // @[AttentionUnit.scala 349:47]
    .clock(BaselineSystolicPE_3_clock),
    .reset(BaselineSystolicPE_3_reset),
    .io_W_0(BaselineSystolicPE_3_io_W_0),
    .io_W_1(BaselineSystolicPE_3_io_W_1),
    .io_X_0(BaselineSystolicPE_3_io_X_0),
    .io_X_1(BaselineSystolicPE_3_io_X_1),
    .io_Y_0(BaselineSystolicPE_3_io_Y_0),
    .io_Y_1(BaselineSystolicPE_3_io_Y_1),
    .io_Y_2(BaselineSystolicPE_3_io_Y_2),
    .io_Y_3(BaselineSystolicPE_3_io_Y_3),
    .io_valid(BaselineSystolicPE_3_io_valid),
    .io_DEBUG_VALID_0(BaselineSystolicPE_3_io_DEBUG_VALID_0),
    .io_DEBUG_VALID_1(BaselineSystolicPE_3_io_DEBUG_VALID_1),
    .io_DEBUG_VALID_2(BaselineSystolicPE_3_io_DEBUG_VALID_2),
    .io_DEBUG_VALID_3(BaselineSystolicPE_3_io_DEBUG_VALID_3)
  );
  Queue_16 MM_S_queue_0 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_0_clock),
    .reset(MM_S_queue_0_reset),
    .io_enq_ready(MM_S_queue_0_io_enq_ready),
    .io_enq_valid(MM_S_queue_0_io_enq_valid),
    .io_enq_bits(MM_S_queue_0_io_enq_bits),
    .io_deq_valid(MM_S_queue_0_io_deq_valid),
    .io_deq_bits(MM_S_queue_0_io_deq_bits)
  );
  Queue_16 MM_S_queue_1 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_1_clock),
    .reset(MM_S_queue_1_reset),
    .io_enq_ready(MM_S_queue_1_io_enq_ready),
    .io_enq_valid(MM_S_queue_1_io_enq_valid),
    .io_enq_bits(MM_S_queue_1_io_enq_bits),
    .io_deq_valid(MM_S_queue_1_io_deq_valid),
    .io_deq_bits(MM_S_queue_1_io_deq_bits)
  );
  Queue_16 MM_S_queue_2 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_2_clock),
    .reset(MM_S_queue_2_reset),
    .io_enq_ready(MM_S_queue_2_io_enq_ready),
    .io_enq_valid(MM_S_queue_2_io_enq_valid),
    .io_enq_bits(MM_S_queue_2_io_enq_bits),
    .io_deq_valid(MM_S_queue_2_io_deq_valid),
    .io_deq_bits(MM_S_queue_2_io_deq_bits)
  );
  Queue_16 MM_S_queue_3 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_3_clock),
    .reset(MM_S_queue_3_reset),
    .io_enq_ready(MM_S_queue_3_io_enq_ready),
    .io_enq_valid(MM_S_queue_3_io_enq_valid),
    .io_enq_bits(MM_S_queue_3_io_enq_bits),
    .io_deq_valid(MM_S_queue_3_io_deq_valid),
    .io_deq_bits(MM_S_queue_3_io_deq_bits)
  );
  Queue_16 MM_S_queue_4 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_4_clock),
    .reset(MM_S_queue_4_reset),
    .io_enq_ready(MM_S_queue_4_io_enq_ready),
    .io_enq_valid(MM_S_queue_4_io_enq_valid),
    .io_enq_bits(MM_S_queue_4_io_enq_bits),
    .io_deq_valid(MM_S_queue_4_io_deq_valid),
    .io_deq_bits(MM_S_queue_4_io_deq_bits)
  );
  Queue_16 MM_S_queue_5 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_5_clock),
    .reset(MM_S_queue_5_reset),
    .io_enq_ready(MM_S_queue_5_io_enq_ready),
    .io_enq_valid(MM_S_queue_5_io_enq_valid),
    .io_enq_bits(MM_S_queue_5_io_enq_bits),
    .io_deq_valid(MM_S_queue_5_io_deq_valid),
    .io_deq_bits(MM_S_queue_5_io_deq_bits)
  );
  Queue_16 MM_S_queue_6 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_6_clock),
    .reset(MM_S_queue_6_reset),
    .io_enq_ready(MM_S_queue_6_io_enq_ready),
    .io_enq_valid(MM_S_queue_6_io_enq_valid),
    .io_enq_bits(MM_S_queue_6_io_enq_bits),
    .io_deq_valid(MM_S_queue_6_io_deq_valid),
    .io_deq_bits(MM_S_queue_6_io_deq_bits)
  );
  Queue_16 MM_S_queue_7 ( // @[AttentionUnit.scala 388:55]
    .clock(MM_S_queue_7_clock),
    .reset(MM_S_queue_7_reset),
    .io_enq_ready(MM_S_queue_7_io_enq_ready),
    .io_enq_valid(MM_S_queue_7_io_enq_valid),
    .io_enq_bits(MM_S_queue_7_io_enq_bits),
    .io_deq_valid(MM_S_queue_7_io_deq_valid),
    .io_deq_bits(MM_S_queue_7_io_deq_bits)
  );
  SimpleAdderN_4 SimpleAdderN_8 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_8_io_A_0),
    .io_A_1(SimpleAdderN_8_io_A_1),
    .io_Sum(SimpleAdderN_8_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_9 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_9_io_A_0),
    .io_A_1(SimpleAdderN_9_io_A_1),
    .io_Sum(SimpleAdderN_9_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_10 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_10_io_A_0),
    .io_A_1(SimpleAdderN_10_io_A_1),
    .io_Sum(SimpleAdderN_10_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_11 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_11_io_A_0),
    .io_A_1(SimpleAdderN_11_io_A_1),
    .io_Sum(SimpleAdderN_11_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_12 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_12_io_A_0),
    .io_A_1(SimpleAdderN_12_io_A_1),
    .io_Sum(SimpleAdderN_12_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_13 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_13_io_A_0),
    .io_A_1(SimpleAdderN_13_io_A_1),
    .io_Sum(SimpleAdderN_13_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_14 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_14_io_A_0),
    .io_A_1(SimpleAdderN_14_io_A_1),
    .io_Sum(SimpleAdderN_14_io_Sum)
  );
  SimpleAdderN_4 SimpleAdderN_15 ( // @[AttentionUnit.scala 410:57]
    .io_A_0(SimpleAdderN_15_io_A_0),
    .io_A_1(SimpleAdderN_15_io_A_1),
    .io_Sum(SimpleAdderN_15_io_Sum)
  );
  SRAMS_8 SRAMS_8 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_8_clock),
    .io_wen(SRAMS_8_io_wen),
    .io_wdata(SRAMS_8_io_wdata),
    .io_rdata(SRAMS_8_io_rdata)
  );
  SRAMS_8 SRAMS_9 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_9_clock),
    .io_wen(SRAMS_9_io_wen),
    .io_wdata(SRAMS_9_io_wdata),
    .io_rdata(SRAMS_9_io_rdata)
  );
  SRAMS_8 SRAMS_10 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_10_clock),
    .io_wen(SRAMS_10_io_wen),
    .io_wdata(SRAMS_10_io_wdata),
    .io_rdata(SRAMS_10_io_rdata)
  );
  SRAMS_8 SRAMS_11 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_11_clock),
    .io_wen(SRAMS_11_io_wen),
    .io_wdata(SRAMS_11_io_wdata),
    .io_rdata(SRAMS_11_io_rdata)
  );
  SRAMS_8 SRAMS_12 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_12_clock),
    .io_wen(SRAMS_12_io_wen),
    .io_wdata(SRAMS_12_io_wdata),
    .io_rdata(SRAMS_12_io_rdata)
  );
  SRAMS_8 SRAMS_13 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_13_clock),
    .io_wen(SRAMS_13_io_wen),
    .io_wdata(SRAMS_13_io_wdata),
    .io_rdata(SRAMS_13_io_rdata)
  );
  SRAMS_8 SRAMS_14 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_14_clock),
    .io_wen(SRAMS_14_io_wen),
    .io_wdata(SRAMS_14_io_wdata),
    .io_rdata(SRAMS_14_io_rdata)
  );
  SRAMS_8 SRAMS_15 ( // @[AttentionUnit.scala 413:59]
    .clock(SRAMS_15_clock),
    .io_wen(SRAMS_15_io_wen),
    .io_wdata(SRAMS_15_io_wdata),
    .io_rdata(SRAMS_15_io_rdata)
  );
  assign io_DEBUG_K_0 = SRAMS_4_io_rdata; // @[AttentionUnit.scala 308:41]
  assign io_DEBUG_K_1 = SRAMS_5_io_rdata; // @[AttentionUnit.scala 308:41]
  assign io_DEBUG_K_2 = SRAMS_6_io_rdata; // @[AttentionUnit.scala 308:41]
  assign io_DEBUG_K_3 = SRAMS_7_io_rdata; // @[AttentionUnit.scala 308:41]
  assign io_DEBUG_Q_0 = SRAMS_io_rdata; // @[AttentionUnit.scala 200:41]
  assign io_DEBUG_Q_1 = SRAMS_1_io_rdata; // @[AttentionUnit.scala 200:41]
  assign io_DEBUG_Q_2 = SRAMS_2_io_rdata; // @[AttentionUnit.scala 200:41]
  assign io_DEBUG_Q_3 = SRAMS_3_io_rdata; // @[AttentionUnit.scala 200:41]
  assign io_DEBUG_S_0 = SRAMS_8_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_1 = SRAMS_9_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_2 = SRAMS_10_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_3 = SRAMS_11_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_4 = SRAMS_12_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_5 = SRAMS_13_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_6 = SRAMS_14_io_rdata; // @[AttentionUnit.scala 443:49]
  assign io_DEBUG_S_7 = SRAMS_15_io_rdata; // @[AttentionUnit.scala 443:49]
  assign BaselineSystolicPE_clock = clock;
  assign BaselineSystolicPE_reset = reset;
  assign BaselineSystolicPE_io_W_0 = io_Wq_0; // @[AttentionUnit.scala 121:22]
  assign BaselineSystolicPE_io_W_1 = io_Wq_1; // @[AttentionUnit.scala 121:22]
  assign BaselineSystolicPE_io_W_2 = io_Wq_2; // @[AttentionUnit.scala 121:22]
  assign BaselineSystolicPE_io_W_3 = io_Wq_3; // @[AttentionUnit.scala 121:22]
  assign BaselineSystolicPE_io_X_0 = io_Xq_0; // @[AttentionUnit.scala 120:22]
  assign BaselineSystolicPE_io_X_1 = io_Xq_1; // @[AttentionUnit.scala 120:22]
  assign BaselineSystolicPE_io_X_2 = io_Xq_2; // @[AttentionUnit.scala 120:22]
  assign BaselineSystolicPE_io_X_3 = io_Xq_3; // @[AttentionUnit.scala 120:22]
  assign BaselineSystolicPE_io_valid = io_valid; // @[AttentionUnit.scala 122:26]
  assign MM_Q_queue_0_clock = clock;
  assign MM_Q_queue_0_reset = reset;
  assign MM_Q_queue_0_io_enq_valid = io_valid; // @[AttentionUnit.scala 148:48]
  assign MM_Q_queue_0_io_enq_bits = BaselineSystolicPE_io_Y_0; // @[AttentionUnit.scala 147:47]
  assign MM_Q_queue_1_clock = clock;
  assign MM_Q_queue_1_reset = reset;
  assign MM_Q_queue_1_io_enq_valid = io_valid; // @[AttentionUnit.scala 148:48]
  assign MM_Q_queue_1_io_enq_bits = BaselineSystolicPE_io_Y_1; // @[AttentionUnit.scala 147:47]
  assign MM_Q_queue_2_clock = clock;
  assign MM_Q_queue_2_reset = reset;
  assign MM_Q_queue_2_io_enq_valid = io_valid; // @[AttentionUnit.scala 148:48]
  assign MM_Q_queue_2_io_enq_bits = BaselineSystolicPE_io_Y_2; // @[AttentionUnit.scala 147:47]
  assign MM_Q_queue_3_clock = clock;
  assign MM_Q_queue_3_reset = reset;
  assign MM_Q_queue_3_io_enq_valid = io_valid; // @[AttentionUnit.scala 148:48]
  assign MM_Q_queue_3_io_enq_bits = BaselineSystolicPE_io_Y_3; // @[AttentionUnit.scala 147:47]
  assign SimpleAdderN_io_A_0 = MM_Q_queue_0_io_deq_bits; // @[AttentionUnit.scala 203:49]
  assign SimpleAdderN_io_A_1 = SRAMS_io_rdata; // @[AttentionUnit.scala 202:49]
  assign SimpleAdderN_1_io_A_0 = MM_Q_queue_1_io_deq_bits; // @[AttentionUnit.scala 203:49]
  assign SimpleAdderN_1_io_A_1 = SRAMS_1_io_rdata; // @[AttentionUnit.scala 202:49]
  assign SimpleAdderN_2_io_A_0 = MM_Q_queue_2_io_deq_bits; // @[AttentionUnit.scala 203:49]
  assign SimpleAdderN_2_io_A_1 = SRAMS_2_io_rdata; // @[AttentionUnit.scala 202:49]
  assign SimpleAdderN_3_io_A_0 = MM_Q_queue_3_io_deq_bits; // @[AttentionUnit.scala 203:49]
  assign SimpleAdderN_3_io_A_1 = SRAMS_3_io_rdata; // @[AttentionUnit.scala 202:49]
  assign SRAMS_clock = clock;
  assign SRAMS_io_raddr = _T[5:0]; // @[AttentionUnit.scala 189:50]
  assign SRAMS_io_wen = ~_T_3; // @[AttentionUnit.scala 193:48]
  assign SRAMS_io_wdata = _T_5 ? SimpleAdderN_io_Sum : MM_Q_queue_0_io_deq_bits; // @[AttentionUnit.scala 195:58 AttentionUnit.scala 197:58]
  assign SRAMS_1_clock = clock;
  assign SRAMS_1_io_raddr = _T[5:0]; // @[AttentionUnit.scala 189:50]
  assign SRAMS_1_io_wen = ~_T_3; // @[AttentionUnit.scala 193:48]
  assign SRAMS_1_io_wdata = _T_5 ? SimpleAdderN_1_io_Sum : MM_Q_queue_1_io_deq_bits; // @[AttentionUnit.scala 195:58 AttentionUnit.scala 197:58]
  assign SRAMS_2_clock = clock;
  assign SRAMS_2_io_raddr = _T[5:0]; // @[AttentionUnit.scala 189:50]
  assign SRAMS_2_io_wen = ~_T_3; // @[AttentionUnit.scala 193:48]
  assign SRAMS_2_io_wdata = _T_5 ? SimpleAdderN_2_io_Sum : MM_Q_queue_2_io_deq_bits; // @[AttentionUnit.scala 195:58 AttentionUnit.scala 197:58]
  assign SRAMS_3_clock = clock;
  assign SRAMS_3_io_raddr = _T[5:0]; // @[AttentionUnit.scala 189:50]
  assign SRAMS_3_io_wen = ~_T_3; // @[AttentionUnit.scala 193:48]
  assign SRAMS_3_io_wdata = _T_5 ? SimpleAdderN_3_io_Sum : MM_Q_queue_3_io_deq_bits; // @[AttentionUnit.scala 195:58 AttentionUnit.scala 197:58]
  assign BaselineSystolicPE_1_clock = clock;
  assign BaselineSystolicPE_1_reset = reset;
  assign BaselineSystolicPE_1_io_W_0 = io_Wk_0; // @[AttentionUnit.scala 234:22]
  assign BaselineSystolicPE_1_io_W_1 = io_Wk_1; // @[AttentionUnit.scala 234:22]
  assign BaselineSystolicPE_1_io_W_2 = io_Wk_2; // @[AttentionUnit.scala 234:22]
  assign BaselineSystolicPE_1_io_W_3 = io_Wk_3; // @[AttentionUnit.scala 234:22]
  assign BaselineSystolicPE_1_io_X_0 = io_Xk_0; // @[AttentionUnit.scala 233:22]
  assign BaselineSystolicPE_1_io_X_1 = io_Xk_1; // @[AttentionUnit.scala 233:22]
  assign BaselineSystolicPE_1_io_X_2 = io_Xk_2; // @[AttentionUnit.scala 233:22]
  assign BaselineSystolicPE_1_io_X_3 = io_Xk_3; // @[AttentionUnit.scala 233:22]
  assign BaselineSystolicPE_1_io_valid = io_valid; // @[AttentionUnit.scala 235:26]
  assign MM_K_queue_0_clock = clock;
  assign MM_K_queue_0_reset = reset;
  assign MM_K_queue_0_io_enq_valid = io_valid; // @[AttentionUnit.scala 256:48]
  assign MM_K_queue_0_io_enq_bits = BaselineSystolicPE_io_Y_0; // @[AttentionUnit.scala 255:47]
  assign MM_K_queue_1_clock = clock;
  assign MM_K_queue_1_reset = reset;
  assign MM_K_queue_1_io_enq_valid = io_valid; // @[AttentionUnit.scala 256:48]
  assign MM_K_queue_1_io_enq_bits = BaselineSystolicPE_io_Y_1; // @[AttentionUnit.scala 255:47]
  assign MM_K_queue_2_clock = clock;
  assign MM_K_queue_2_reset = reset;
  assign MM_K_queue_2_io_enq_valid = io_valid; // @[AttentionUnit.scala 256:48]
  assign MM_K_queue_2_io_enq_bits = BaselineSystolicPE_io_Y_2; // @[AttentionUnit.scala 255:47]
  assign MM_K_queue_3_clock = clock;
  assign MM_K_queue_3_reset = reset;
  assign MM_K_queue_3_io_enq_valid = io_valid; // @[AttentionUnit.scala 256:48]
  assign MM_K_queue_3_io_enq_bits = BaselineSystolicPE_io_Y_3; // @[AttentionUnit.scala 255:47]
  assign SimpleAdderN_4_io_A_0 = MM_K_queue_0_io_deq_bits; // @[AttentionUnit.scala 311:49]
  assign SimpleAdderN_4_io_A_1 = SRAMS_4_io_rdata; // @[AttentionUnit.scala 310:49]
  assign SimpleAdderN_5_io_A_0 = MM_K_queue_1_io_deq_bits; // @[AttentionUnit.scala 311:49]
  assign SimpleAdderN_5_io_A_1 = SRAMS_5_io_rdata; // @[AttentionUnit.scala 310:49]
  assign SimpleAdderN_6_io_A_0 = MM_K_queue_2_io_deq_bits; // @[AttentionUnit.scala 311:49]
  assign SimpleAdderN_6_io_A_1 = SRAMS_6_io_rdata; // @[AttentionUnit.scala 310:49]
  assign SimpleAdderN_7_io_A_0 = MM_K_queue_3_io_deq_bits; // @[AttentionUnit.scala 311:49]
  assign SimpleAdderN_7_io_A_1 = SRAMS_7_io_rdata; // @[AttentionUnit.scala 310:49]
  assign SRAMS_4_clock = clock;
  assign SRAMS_4_io_raddr = _T[5:0]; // @[AttentionUnit.scala 297:50]
  assign SRAMS_4_io_wen = ~_T_30; // @[AttentionUnit.scala 301:48]
  assign SRAMS_4_io_wdata = _T_5 ? SimpleAdderN_4_io_Sum : MM_K_queue_0_io_deq_bits; // @[AttentionUnit.scala 303:58 AttentionUnit.scala 305:58]
  assign SRAMS_5_clock = clock;
  assign SRAMS_5_io_raddr = _T[5:0]; // @[AttentionUnit.scala 297:50]
  assign SRAMS_5_io_wen = ~_T_30; // @[AttentionUnit.scala 301:48]
  assign SRAMS_5_io_wdata = _T_5 ? SimpleAdderN_5_io_Sum : MM_K_queue_1_io_deq_bits; // @[AttentionUnit.scala 303:58 AttentionUnit.scala 305:58]
  assign SRAMS_6_clock = clock;
  assign SRAMS_6_io_raddr = _T[5:0]; // @[AttentionUnit.scala 297:50]
  assign SRAMS_6_io_wen = ~_T_30; // @[AttentionUnit.scala 301:48]
  assign SRAMS_6_io_wdata = _T_5 ? SimpleAdderN_6_io_Sum : MM_K_queue_2_io_deq_bits; // @[AttentionUnit.scala 303:58 AttentionUnit.scala 305:58]
  assign SRAMS_7_clock = clock;
  assign SRAMS_7_io_raddr = _T[5:0]; // @[AttentionUnit.scala 297:50]
  assign SRAMS_7_io_wen = ~_T_30; // @[AttentionUnit.scala 301:48]
  assign SRAMS_7_io_wdata = _T_5 ? SimpleAdderN_7_io_Sum : MM_K_queue_3_io_deq_bits; // @[AttentionUnit.scala 303:58 AttentionUnit.scala 305:58]
  assign BaselineSystolicPE_2_clock = clock;
  assign BaselineSystolicPE_2_reset = reset;
  assign BaselineSystolicPE_2_io_W_0 = mux_K_0; // @[AttentionUnit.scala 358:60]
  assign BaselineSystolicPE_2_io_W_1 = mux_K_1; // @[AttentionUnit.scala 358:60]
  assign BaselineSystolicPE_2_io_X_0 = mux_Q_0; // @[AttentionUnit.scala 364:60]
  assign BaselineSystolicPE_2_io_X_1 = mux_Q_1; // @[AttentionUnit.scala 364:60]
  assign BaselineSystolicPE_2_io_valid = Q_valid & Q_valid; // @[AttentionUnit.scala 354:38]
  assign BaselineSystolicPE_3_clock = clock;
  assign BaselineSystolicPE_3_reset = reset;
  assign BaselineSystolicPE_3_io_W_0 = mux_K_2; // @[AttentionUnit.scala 358:60]
  assign BaselineSystolicPE_3_io_W_1 = mux_K_3; // @[AttentionUnit.scala 358:60]
  assign BaselineSystolicPE_3_io_X_0 = mux_Q_2; // @[AttentionUnit.scala 364:60]
  assign BaselineSystolicPE_3_io_X_1 = mux_Q_3; // @[AttentionUnit.scala 364:60]
  assign BaselineSystolicPE_3_io_valid = Q_valid & Q_valid; // @[AttentionUnit.scala 354:38]
  assign MM_S_queue_0_clock = clock;
  assign MM_S_queue_0_reset = reset;
  assign MM_S_queue_0_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_0_io_enq_bits = BaselineSystolicPE_2_io_Y_0; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_1_clock = clock;
  assign MM_S_queue_1_reset = reset;
  assign MM_S_queue_1_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_1_io_enq_bits = BaselineSystolicPE_2_io_Y_1; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_2_clock = clock;
  assign MM_S_queue_2_reset = reset;
  assign MM_S_queue_2_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_2_io_enq_bits = BaselineSystolicPE_2_io_Y_2; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_3_clock = clock;
  assign MM_S_queue_3_reset = reset;
  assign MM_S_queue_3_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_3_io_enq_bits = BaselineSystolicPE_2_io_Y_3; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_4_clock = clock;
  assign MM_S_queue_4_reset = reset;
  assign MM_S_queue_4_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_4_io_enq_bits = BaselineSystolicPE_3_io_Y_0; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_5_clock = clock;
  assign MM_S_queue_5_reset = reset;
  assign MM_S_queue_5_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_5_io_enq_bits = BaselineSystolicPE_3_io_Y_1; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_6_clock = clock;
  assign MM_S_queue_6_reset = reset;
  assign MM_S_queue_6_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_6_io_enq_bits = BaselineSystolicPE_3_io_Y_2; // @[AttentionUnit.scala 390:55]
  assign MM_S_queue_7_clock = clock;
  assign MM_S_queue_7_reset = reset;
  assign MM_S_queue_7_io_enq_valid = io_valid; // @[AttentionUnit.scala 391:56]
  assign MM_S_queue_7_io_enq_bits = BaselineSystolicPE_3_io_Y_3; // @[AttentionUnit.scala 390:55]
  assign SimpleAdderN_8_io_A_0 = MM_S_queue_0_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_8_io_A_1 = SRAMS_8_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_9_io_A_0 = MM_S_queue_1_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_9_io_A_1 = SRAMS_9_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_10_io_A_0 = MM_S_queue_2_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_10_io_A_1 = SRAMS_10_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_11_io_A_0 = MM_S_queue_3_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_11_io_A_1 = SRAMS_11_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_12_io_A_0 = MM_S_queue_4_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_12_io_A_1 = SRAMS_12_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_13_io_A_0 = MM_S_queue_5_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_13_io_A_1 = SRAMS_13_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_14_io_A_0 = MM_S_queue_6_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_14_io_A_1 = SRAMS_14_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SimpleAdderN_15_io_A_0 = MM_S_queue_7_io_deq_bits; // @[AttentionUnit.scala 446:57]
  assign SimpleAdderN_15_io_A_1 = SRAMS_15_io_rdata; // @[AttentionUnit.scala 445:57]
  assign SRAMS_8_clock = clock;
  assign SRAMS_8_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_8_io_wdata = _T_58 ? SimpleAdderN_8_io_Sum : MM_S_queue_0_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_9_clock = clock;
  assign SRAMS_9_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_9_io_wdata = _T_58 ? SimpleAdderN_9_io_Sum : MM_S_queue_1_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_10_clock = clock;
  assign SRAMS_10_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_10_io_wdata = _T_58 ? SimpleAdderN_10_io_Sum : MM_S_queue_2_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_11_clock = clock;
  assign SRAMS_11_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_11_io_wdata = _T_58 ? SimpleAdderN_11_io_Sum : MM_S_queue_3_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_12_clock = clock;
  assign SRAMS_12_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_12_io_wdata = _T_58 ? SimpleAdderN_12_io_Sum : MM_S_queue_4_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_13_clock = clock;
  assign SRAMS_13_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_13_io_wdata = _T_58 ? SimpleAdderN_13_io_Sum : MM_S_queue_5_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_14_clock = clock;
  assign SRAMS_14_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_14_io_wdata = _T_58 ? SimpleAdderN_14_io_Sum : MM_S_queue_6_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
  assign SRAMS_15_clock = clock;
  assign SRAMS_15_io_wen = ~_T_2; // @[AttentionUnit.scala 436:56]
  assign SRAMS_15_io_wdata = _T_58 ? SimpleAdderN_15_io_Sum : MM_S_queue_7_io_deq_bits; // @[AttentionUnit.scala 438:66 AttentionUnit.scala 440:66]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mux_Q_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  mux_Q_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mux_Q_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  mux_Q_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  mux_K_0 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  mux_K_1 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  mux_K_2 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  mux_K_3 = _RAND_7[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    mux_Q_0 <= io_DEBUG_Q_0;
    mux_Q_1 <= io_DEBUG_Q_1;
    mux_Q_2 <= io_DEBUG_Q_2;
    mux_Q_3 <= io_DEBUG_Q_3;
    mux_K_0 <= io_DEBUG_K_0;
    mux_K_1 <= io_DEBUG_K_1;
    mux_K_2 <= io_DEBUG_K_2;
    mux_K_3 <= io_DEBUG_K_3;
  end
endmodule
