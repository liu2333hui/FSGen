;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit MHA_V1 : 
  module SimpleMultiplier2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module Queue : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_1 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_1 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_2 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_2 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_3 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_3 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module SimpleAdderN : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module BaselineSystolicPE : 
    input clock : Clock
    input reset : Reset
    output io : {flip W : UInt<8>[4], flip X : UInt<8>[4], PE_OUT : UInt<16>[8], Y : UInt<8>[4], Y_valid : UInt<1>[4], flip valid : UInt<1>, DEBUG_VALID : UInt<1>[8]}
    
    inst PEA_0 of SimpleMultiplier2 @[GEMMBaseline.scala 84:47]
    PEA_0.clock <= clock
    PEA_0.reset <= reset
    inst PEA_1 of SimpleMultiplier2_1 @[GEMMBaseline.scala 84:47]
    PEA_1.clock <= clock
    PEA_1.reset <= reset
    inst PEA_2 of SimpleMultiplier2_2 @[GEMMBaseline.scala 84:47]
    PEA_2.clock <= clock
    PEA_2.reset <= reset
    inst PEA_3 of SimpleMultiplier2_3 @[GEMMBaseline.scala 84:47]
    PEA_3.clock <= clock
    PEA_3.reset <= reset
    inst PEA_4 of SimpleMultiplier2_4 @[GEMMBaseline.scala 84:47]
    PEA_4.clock <= clock
    PEA_4.reset <= reset
    inst PEA_5 of SimpleMultiplier2_5 @[GEMMBaseline.scala 84:47]
    PEA_5.clock <= clock
    PEA_5.reset <= reset
    inst PEA_6 of SimpleMultiplier2_6 @[GEMMBaseline.scala 84:47]
    PEA_6.clock <= clock
    PEA_6.reset <= reset
    inst PEA_7 of SimpleMultiplier2_7 @[GEMMBaseline.scala 84:47]
    PEA_7.clock <= clock
    PEA_7.reset <= reset
    io.PE_OUT[0] <= PEA_0.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[1] <= PEA_1.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[2] <= PEA_2.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[3] <= PEA_3.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[4] <= PEA_4.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[5] <= PEA_5.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[6] <= PEA_6.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[7] <= PEA_7.io.Out @[GEMMBaseline.scala 86:30]
    wire VALID_PE : UInt<1>[8] @[GEMMBaseline.scala 89:28]
    reg REG_A : UInt<8>[8], clock @[GEMMBaseline.scala 92:24]
    reg REG_B : UInt<8>[8], clock @[GEMMBaseline.scala 93:24]
    PEA_0.io.A <= REG_A[0] @[GEMMBaseline.scala 98:47]
    PEA_0.io.B <= REG_B[0] @[GEMMBaseline.scala 99:47]
    PEA_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_4.io.A <= REG_A[4] @[GEMMBaseline.scala 98:47]
    PEA_4.io.B <= REG_B[4] @[GEMMBaseline.scala 99:47]
    PEA_4.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_4.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_2.io.A <= REG_A[2] @[GEMMBaseline.scala 98:47]
    PEA_2.io.B <= REG_B[2] @[GEMMBaseline.scala 99:47]
    PEA_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_6.io.A <= REG_A[6] @[GEMMBaseline.scala 98:47]
    PEA_6.io.B <= REG_B[6] @[GEMMBaseline.scala 99:47]
    PEA_6.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_6.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_1.io.A <= REG_A[1] @[GEMMBaseline.scala 98:47]
    PEA_1.io.B <= REG_B[1] @[GEMMBaseline.scala 99:47]
    PEA_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_5.io.A <= REG_A[5] @[GEMMBaseline.scala 98:47]
    PEA_5.io.B <= REG_B[5] @[GEMMBaseline.scala 99:47]
    PEA_5.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_5.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_3.io.A <= REG_A[3] @[GEMMBaseline.scala 98:47]
    PEA_3.io.B <= REG_B[3] @[GEMMBaseline.scala 99:47]
    PEA_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_7.io.A <= REG_A[7] @[GEMMBaseline.scala 98:47]
    PEA_7.io.B <= REG_B[7] @[GEMMBaseline.scala 99:47]
    PEA_7.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_7.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    inst WQueue_0 of Queue @[GEMMBaseline.scala 120:55]
    WQueue_0.clock <= clock
    WQueue_0.reset <= reset
    inst WQueue_1 of Queue_1 @[GEMMBaseline.scala 120:55]
    WQueue_1.clock <= clock
    WQueue_1.reset <= reset
    inst WQueue_2 of Queue_2 @[GEMMBaseline.scala 120:55]
    WQueue_2.clock <= clock
    WQueue_2.reset <= reset
    inst WQueue_3 of Queue_3 @[GEMMBaseline.scala 120:55]
    WQueue_3.clock <= clock
    WQueue_3.reset <= reset
    inst WPipe_0 of PipelineChainValid @[GEMMBaseline.scala 135:42]
    WPipe_0.clock <= clock
    WPipe_0.reset <= reset
    inst WPipe_1 of PipelineChainValid_1 @[GEMMBaseline.scala 135:42]
    WPipe_1.clock <= clock
    WPipe_1.reset <= reset
    inst XQueue_0 of Queue_4 @[GEMMBaseline.scala 154:55]
    XQueue_0.clock <= clock
    XQueue_0.reset <= reset
    inst XQueue_1 of Queue_5 @[GEMMBaseline.scala 154:55]
    XQueue_1.clock <= clock
    XQueue_1.reset <= reset
    inst XQueue_2 of Queue_6 @[GEMMBaseline.scala 154:55]
    XQueue_2.clock <= clock
    XQueue_2.reset <= reset
    inst XQueue_3 of Queue_7 @[GEMMBaseline.scala 154:55]
    XQueue_3.clock <= clock
    XQueue_3.reset <= reset
    inst XPipe_0 of PipelineChainValid_2 @[GEMMBaseline.scala 170:42]
    XPipe_0.clock <= clock
    XPipe_0.reset <= reset
    inst XPipe_1 of PipelineChainValid_3 @[GEMMBaseline.scala 170:42]
    XPipe_1.clock <= clock
    XPipe_1.reset <= reset
    WQueue_0.io.enq.bits <= io.W[0] @[GEMMBaseline.scala 188:47]
    WQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[0] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_0.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_1.io.enq.bits <= io.W[1] @[GEMMBaseline.scala 188:47]
    WQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[1] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_1.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_0.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_0.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_2.io.enq.bits <= io.W[2] @[GEMMBaseline.scala 188:47]
    WQueue_2.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[2] <= WQueue_2.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_2.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_1.io.validin <= WQueue_2.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_1.io.validin <= WQueue_2.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_3.io.enq.bits <= io.W[3] @[GEMMBaseline.scala 188:47]
    WQueue_3.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[3] <= WQueue_3.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_3.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_1.io.validin <= WQueue_3.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_1.io.validin <= WQueue_3.io.deq.valid @[GEMMBaseline.scala 198:45]
    REG_B[4] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[5] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[6] <= WQueue_2.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[7] <= WQueue_3.io.deq.bits @[GEMMBaseline.scala 221:37]
    XQueue_0.io.enq.bits <= io.X[0] @[GEMMBaseline.scala 234:47]
    XQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[0] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_0.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_0.io.validin <= XQueue_0.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_1.io.enq.bits <= io.X[1] @[GEMMBaseline.scala 234:47]
    XQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[1] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_1.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_0.io.validin <= XQueue_1.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_2.io.enq.bits <= io.X[2] @[GEMMBaseline.scala 234:47]
    XQueue_2.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[4] <= XQueue_2.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_2.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_1.io.validin <= XQueue_2.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_3.io.enq.bits <= io.X[3] @[GEMMBaseline.scala 234:47]
    XQueue_3.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[5] <= XQueue_3.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_3.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_1.io.validin <= XQueue_3.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    REG_A[2] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[3] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[6] <= XQueue_2.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[7] <= XQueue_3.io.deq.bits @[GEMMBaseline.scala 262:37]
    node _T = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[0] <= _T @[GEMMBaseline.scala 272:48]
    node _T_1 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 292:134]
    io.DEBUG_VALID[0] <= _T_1 @[GEMMBaseline.scala 292:79]
    node _T_2 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[1] <= _T_2 @[GEMMBaseline.scala 272:48]
    node _T_3 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 292:134]
    io.DEBUG_VALID[1] <= _T_3 @[GEMMBaseline.scala 292:79]
    node _T_4 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[2] <= _T_4 @[GEMMBaseline.scala 272:48]
    node _T_5 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 282:118]
    node _T_6 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 284:57]
    node _T_7 = and(_T_5, _T_6) @[GEMMBaseline.scala 283:108]
    io.DEBUG_VALID[2] <= _T_7 @[GEMMBaseline.scala 282:63]
    node _T_8 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[3] <= _T_8 @[GEMMBaseline.scala 272:48]
    node _T_9 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 282:118]
    node _T_10 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 284:57]
    node _T_11 = and(_T_9, _T_10) @[GEMMBaseline.scala 283:108]
    io.DEBUG_VALID[3] <= _T_11 @[GEMMBaseline.scala 282:63]
    node _T_12 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[4] <= _T_12 @[GEMMBaseline.scala 272:48]
    node _T_13 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 287:118]
    node _T_14 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 289:57]
    node _T_15 = and(_T_13, _T_14) @[GEMMBaseline.scala 288:108]
    io.DEBUG_VALID[4] <= _T_15 @[GEMMBaseline.scala 287:63]
    node _T_16 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[5] <= _T_16 @[GEMMBaseline.scala 272:48]
    node _T_17 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 287:118]
    node _T_18 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 289:57]
    node _T_19 = and(_T_17, _T_18) @[GEMMBaseline.scala 288:108]
    io.DEBUG_VALID[5] <= _T_19 @[GEMMBaseline.scala 287:63]
    node _T_20 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[6] <= _T_20 @[GEMMBaseline.scala 272:48]
    node _T_21 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 276:118]
    node _T_22 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 278:57]
    node _T_23 = and(_T_21, _T_22) @[GEMMBaseline.scala 277:108]
    node _T_24 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 279:57]
    node _T_25 = and(_T_23, _T_24) @[GEMMBaseline.scala 278:110]
    io.DEBUG_VALID[6] <= _T_25 @[GEMMBaseline.scala 276:63]
    node _T_26 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[7] <= _T_26 @[GEMMBaseline.scala 272:48]
    node _T_27 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 276:118]
    node _T_28 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 278:57]
    node _T_29 = and(_T_27, _T_28) @[GEMMBaseline.scala 277:108]
    node _T_30 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 279:57]
    node _T_31 = and(_T_29, _T_30) @[GEMMBaseline.scala 278:110]
    io.DEBUG_VALID[7] <= _T_31 @[GEMMBaseline.scala 276:63]
    inst YQueue_0 of Queue_8 @[GEMMBaseline.scala 329:47]
    YQueue_0.clock <= clock
    YQueue_0.reset <= reset
    inst YQueue_1 of Queue_9 @[GEMMBaseline.scala 329:47]
    YQueue_1.clock <= clock
    YQueue_1.reset <= reset
    inst YQueue_2 of Queue_10 @[GEMMBaseline.scala 329:47]
    YQueue_2.clock <= clock
    YQueue_2.reset <= reset
    inst YQueue_3 of Queue_11 @[GEMMBaseline.scala 329:47]
    YQueue_3.clock <= clock
    YQueue_3.reset <= reset
    inst YQueue_4 of Queue_12 @[GEMMBaseline.scala 329:47]
    YQueue_4.clock <= clock
    YQueue_4.reset <= reset
    inst YQueue_5 of Queue_13 @[GEMMBaseline.scala 329:47]
    YQueue_5.clock <= clock
    YQueue_5.reset <= reset
    inst YQueue_6 of Queue_14 @[GEMMBaseline.scala 329:47]
    YQueue_6.clock <= clock
    YQueue_6.reset <= reset
    inst YQueue_7 of Queue_15 @[GEMMBaseline.scala 329:47]
    YQueue_7.clock <= clock
    YQueue_7.reset <= reset
    inst YAdder_0 of SimpleAdderN @[GEMMBaseline.scala 356:57]
    YAdder_0.clock <= clock
    YAdder_0.reset <= reset
    inst YAdder_1 of SimpleAdderN_1 @[GEMMBaseline.scala 356:57]
    YAdder_1.clock <= clock
    YAdder_1.reset <= reset
    inst YAdder_2 of SimpleAdderN_2 @[GEMMBaseline.scala 356:57]
    YAdder_2.clock <= clock
    YAdder_2.reset <= reset
    inst YAdder_3 of SimpleAdderN_3 @[GEMMBaseline.scala 356:57]
    YAdder_3.clock <= clock
    YAdder_3.reset <= reset
    reg Y_REG : UInt<16>[4], clock @[GEMMBaseline.scala 388:24]
    io.Y[0] <= Y_REG[0] @[GEMMBaseline.scala 402:22]
    io.Y[1] <= Y_REG[1] @[GEMMBaseline.scala 402:22]
    io.Y[2] <= Y_REG[2] @[GEMMBaseline.scala 402:22]
    io.Y[3] <= Y_REG[3] @[GEMMBaseline.scala 402:22]
    io.Y_valid[0] <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 409:53]
    io.Y_valid[1] <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 409:53]
    io.Y_valid[2] <= io.DEBUG_VALID[4] @[GEMMBaseline.scala 409:53]
    io.Y_valid[3] <= io.DEBUG_VALID[6] @[GEMMBaseline.scala 409:53]
    YQueue_0.io.enq.bits <= PEA_0.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_0.io.enq.valid <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 423:56]
    YQueue_1.io.enq.bits <= PEA_1.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_1.io.enq.valid <= io.DEBUG_VALID[1] @[GEMMBaseline.scala 423:56]
    YQueue_0.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_0.io.A[0] <= YQueue_0.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.A[1] <= YQueue_0.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[0] <= YAdder_0.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_1.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_0.io.A[0] <= YQueue_1.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.A[1] <= YQueue_1.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[0] <= YAdder_0.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_2.io.enq.bits <= PEA_2.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_2.io.enq.valid <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 423:56]
    YQueue_3.io.enq.bits <= PEA_3.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_3.io.enq.valid <= io.DEBUG_VALID[3] @[GEMMBaseline.scala 423:56]
    YQueue_2.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_1.io.A[0] <= YQueue_2.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.A[1] <= YQueue_2.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[1] <= YAdder_1.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_3.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_1.io.A[0] <= YQueue_3.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.A[1] <= YQueue_3.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[1] <= YAdder_1.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_4.io.enq.bits <= PEA_4.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_4.io.enq.valid <= io.DEBUG_VALID[4] @[GEMMBaseline.scala 423:56]
    YQueue_5.io.enq.bits <= PEA_5.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_5.io.enq.valid <= io.DEBUG_VALID[5] @[GEMMBaseline.scala 423:56]
    YQueue_4.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_2.io.A[0] <= YQueue_4.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.A[1] <= YQueue_4.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[2] <= YAdder_2.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_5.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_2.io.A[0] <= YQueue_5.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.A[1] <= YQueue_5.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[2] <= YAdder_2.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_6.io.enq.bits <= PEA_6.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_6.io.enq.valid <= io.DEBUG_VALID[6] @[GEMMBaseline.scala 423:56]
    YQueue_7.io.enq.bits <= PEA_7.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_7.io.enq.valid <= io.DEBUG_VALID[7] @[GEMMBaseline.scala 423:56]
    YQueue_6.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_3.io.A[0] <= YQueue_6.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.A[1] <= YQueue_6.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[3] <= YAdder_3.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_7.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_3.io.A[0] <= YQueue_7.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.A[1] <= YQueue_7.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[3] <= YAdder_3.io.Sum @[GEMMBaseline.scala 475:53]
    
  module Queue_16 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_17 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_18 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_19 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module SimpleAdderN_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SRAMS : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SimpleMultiplier2_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module Queue_20 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_21 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_22 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_23 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_4 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_4 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_5 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_5 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_24 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_25 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_26 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_27 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_6 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_6 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_7 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_7 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_28 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_29 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_30 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_31 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_32 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_33 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_34 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_35 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module SimpleAdderN_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[2], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<16> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<16> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module BaselineSystolicPE_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip W : UInt<8>[4], flip X : UInt<8>[4], PE_OUT : UInt<16>[8], Y : UInt<8>[4], Y_valid : UInt<1>[4], flip valid : UInt<1>, DEBUG_VALID : UInt<1>[8]}
    
    inst PEA_0 of SimpleMultiplier2_8 @[GEMMBaseline.scala 84:47]
    PEA_0.clock <= clock
    PEA_0.reset <= reset
    inst PEA_1 of SimpleMultiplier2_9 @[GEMMBaseline.scala 84:47]
    PEA_1.clock <= clock
    PEA_1.reset <= reset
    inst PEA_2 of SimpleMultiplier2_10 @[GEMMBaseline.scala 84:47]
    PEA_2.clock <= clock
    PEA_2.reset <= reset
    inst PEA_3 of SimpleMultiplier2_11 @[GEMMBaseline.scala 84:47]
    PEA_3.clock <= clock
    PEA_3.reset <= reset
    inst PEA_4 of SimpleMultiplier2_12 @[GEMMBaseline.scala 84:47]
    PEA_4.clock <= clock
    PEA_4.reset <= reset
    inst PEA_5 of SimpleMultiplier2_13 @[GEMMBaseline.scala 84:47]
    PEA_5.clock <= clock
    PEA_5.reset <= reset
    inst PEA_6 of SimpleMultiplier2_14 @[GEMMBaseline.scala 84:47]
    PEA_6.clock <= clock
    PEA_6.reset <= reset
    inst PEA_7 of SimpleMultiplier2_15 @[GEMMBaseline.scala 84:47]
    PEA_7.clock <= clock
    PEA_7.reset <= reset
    io.PE_OUT[0] <= PEA_0.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[1] <= PEA_1.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[2] <= PEA_2.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[3] <= PEA_3.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[4] <= PEA_4.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[5] <= PEA_5.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[6] <= PEA_6.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[7] <= PEA_7.io.Out @[GEMMBaseline.scala 86:30]
    wire VALID_PE : UInt<1>[8] @[GEMMBaseline.scala 89:28]
    reg REG_A : UInt<8>[8], clock @[GEMMBaseline.scala 92:24]
    reg REG_B : UInt<8>[8], clock @[GEMMBaseline.scala 93:24]
    PEA_0.io.A <= REG_A[0] @[GEMMBaseline.scala 98:47]
    PEA_0.io.B <= REG_B[0] @[GEMMBaseline.scala 99:47]
    PEA_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_4.io.A <= REG_A[4] @[GEMMBaseline.scala 98:47]
    PEA_4.io.B <= REG_B[4] @[GEMMBaseline.scala 99:47]
    PEA_4.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_4.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_2.io.A <= REG_A[2] @[GEMMBaseline.scala 98:47]
    PEA_2.io.B <= REG_B[2] @[GEMMBaseline.scala 99:47]
    PEA_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_6.io.A <= REG_A[6] @[GEMMBaseline.scala 98:47]
    PEA_6.io.B <= REG_B[6] @[GEMMBaseline.scala 99:47]
    PEA_6.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_6.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_1.io.A <= REG_A[1] @[GEMMBaseline.scala 98:47]
    PEA_1.io.B <= REG_B[1] @[GEMMBaseline.scala 99:47]
    PEA_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_5.io.A <= REG_A[5] @[GEMMBaseline.scala 98:47]
    PEA_5.io.B <= REG_B[5] @[GEMMBaseline.scala 99:47]
    PEA_5.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_5.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_3.io.A <= REG_A[3] @[GEMMBaseline.scala 98:47]
    PEA_3.io.B <= REG_B[3] @[GEMMBaseline.scala 99:47]
    PEA_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_7.io.A <= REG_A[7] @[GEMMBaseline.scala 98:47]
    PEA_7.io.B <= REG_B[7] @[GEMMBaseline.scala 99:47]
    PEA_7.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_7.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    inst WQueue_0 of Queue_20 @[GEMMBaseline.scala 120:55]
    WQueue_0.clock <= clock
    WQueue_0.reset <= reset
    inst WQueue_1 of Queue_21 @[GEMMBaseline.scala 120:55]
    WQueue_1.clock <= clock
    WQueue_1.reset <= reset
    inst WQueue_2 of Queue_22 @[GEMMBaseline.scala 120:55]
    WQueue_2.clock <= clock
    WQueue_2.reset <= reset
    inst WQueue_3 of Queue_23 @[GEMMBaseline.scala 120:55]
    WQueue_3.clock <= clock
    WQueue_3.reset <= reset
    inst WPipe_0 of PipelineChainValid_4 @[GEMMBaseline.scala 135:42]
    WPipe_0.clock <= clock
    WPipe_0.reset <= reset
    inst WPipe_1 of PipelineChainValid_5 @[GEMMBaseline.scala 135:42]
    WPipe_1.clock <= clock
    WPipe_1.reset <= reset
    inst XQueue_0 of Queue_24 @[GEMMBaseline.scala 154:55]
    XQueue_0.clock <= clock
    XQueue_0.reset <= reset
    inst XQueue_1 of Queue_25 @[GEMMBaseline.scala 154:55]
    XQueue_1.clock <= clock
    XQueue_1.reset <= reset
    inst XQueue_2 of Queue_26 @[GEMMBaseline.scala 154:55]
    XQueue_2.clock <= clock
    XQueue_2.reset <= reset
    inst XQueue_3 of Queue_27 @[GEMMBaseline.scala 154:55]
    XQueue_3.clock <= clock
    XQueue_3.reset <= reset
    inst XPipe_0 of PipelineChainValid_6 @[GEMMBaseline.scala 170:42]
    XPipe_0.clock <= clock
    XPipe_0.reset <= reset
    inst XPipe_1 of PipelineChainValid_7 @[GEMMBaseline.scala 170:42]
    XPipe_1.clock <= clock
    XPipe_1.reset <= reset
    WQueue_0.io.enq.bits <= io.W[0] @[GEMMBaseline.scala 188:47]
    WQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[0] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_0.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_1.io.enq.bits <= io.W[1] @[GEMMBaseline.scala 188:47]
    WQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[1] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_1.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_0.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_0.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_2.io.enq.bits <= io.W[2] @[GEMMBaseline.scala 188:47]
    WQueue_2.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[2] <= WQueue_2.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_2.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_1.io.validin <= WQueue_2.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_1.io.validin <= WQueue_2.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_3.io.enq.bits <= io.W[3] @[GEMMBaseline.scala 188:47]
    WQueue_3.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[3] <= WQueue_3.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_3.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_1.io.validin <= WQueue_3.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_1.io.validin <= WQueue_3.io.deq.valid @[GEMMBaseline.scala 198:45]
    REG_B[4] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[5] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[6] <= WQueue_2.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[7] <= WQueue_3.io.deq.bits @[GEMMBaseline.scala 221:37]
    XQueue_0.io.enq.bits <= io.X[0] @[GEMMBaseline.scala 234:47]
    XQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[0] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_0.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_0.io.validin <= XQueue_0.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_1.io.enq.bits <= io.X[1] @[GEMMBaseline.scala 234:47]
    XQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[1] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_1.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_0.io.validin <= XQueue_1.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_2.io.enq.bits <= io.X[2] @[GEMMBaseline.scala 234:47]
    XQueue_2.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[4] <= XQueue_2.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_2.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_1.io.validin <= XQueue_2.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_3.io.enq.bits <= io.X[3] @[GEMMBaseline.scala 234:47]
    XQueue_3.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[5] <= XQueue_3.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_3.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_1.io.validin <= XQueue_3.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    REG_A[2] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[3] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[6] <= XQueue_2.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[7] <= XQueue_3.io.deq.bits @[GEMMBaseline.scala 262:37]
    node _T = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[0] <= _T @[GEMMBaseline.scala 272:48]
    node _T_1 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 292:134]
    io.DEBUG_VALID[0] <= _T_1 @[GEMMBaseline.scala 292:79]
    node _T_2 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[1] <= _T_2 @[GEMMBaseline.scala 272:48]
    node _T_3 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 292:134]
    io.DEBUG_VALID[1] <= _T_3 @[GEMMBaseline.scala 292:79]
    node _T_4 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[2] <= _T_4 @[GEMMBaseline.scala 272:48]
    node _T_5 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 282:118]
    node _T_6 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 284:57]
    node _T_7 = and(_T_5, _T_6) @[GEMMBaseline.scala 283:108]
    io.DEBUG_VALID[2] <= _T_7 @[GEMMBaseline.scala 282:63]
    node _T_8 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[3] <= _T_8 @[GEMMBaseline.scala 272:48]
    node _T_9 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 282:118]
    node _T_10 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 284:57]
    node _T_11 = and(_T_9, _T_10) @[GEMMBaseline.scala 283:108]
    io.DEBUG_VALID[3] <= _T_11 @[GEMMBaseline.scala 282:63]
    node _T_12 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[4] <= _T_12 @[GEMMBaseline.scala 272:48]
    node _T_13 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 287:118]
    node _T_14 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 289:57]
    node _T_15 = and(_T_13, _T_14) @[GEMMBaseline.scala 288:108]
    io.DEBUG_VALID[4] <= _T_15 @[GEMMBaseline.scala 287:63]
    node _T_16 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[5] <= _T_16 @[GEMMBaseline.scala 272:48]
    node _T_17 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 287:118]
    node _T_18 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 289:57]
    node _T_19 = and(_T_17, _T_18) @[GEMMBaseline.scala 288:108]
    io.DEBUG_VALID[5] <= _T_19 @[GEMMBaseline.scala 287:63]
    node _T_20 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[6] <= _T_20 @[GEMMBaseline.scala 272:48]
    node _T_21 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 276:118]
    node _T_22 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 278:57]
    node _T_23 = and(_T_21, _T_22) @[GEMMBaseline.scala 277:108]
    node _T_24 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 279:57]
    node _T_25 = and(_T_23, _T_24) @[GEMMBaseline.scala 278:110]
    io.DEBUG_VALID[6] <= _T_25 @[GEMMBaseline.scala 276:63]
    node _T_26 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[7] <= _T_26 @[GEMMBaseline.scala 272:48]
    node _T_27 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 276:118]
    node _T_28 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 278:57]
    node _T_29 = and(_T_27, _T_28) @[GEMMBaseline.scala 277:108]
    node _T_30 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 279:57]
    node _T_31 = and(_T_29, _T_30) @[GEMMBaseline.scala 278:110]
    io.DEBUG_VALID[7] <= _T_31 @[GEMMBaseline.scala 276:63]
    inst YQueue_0 of Queue_28 @[GEMMBaseline.scala 329:47]
    YQueue_0.clock <= clock
    YQueue_0.reset <= reset
    inst YQueue_1 of Queue_29 @[GEMMBaseline.scala 329:47]
    YQueue_1.clock <= clock
    YQueue_1.reset <= reset
    inst YQueue_2 of Queue_30 @[GEMMBaseline.scala 329:47]
    YQueue_2.clock <= clock
    YQueue_2.reset <= reset
    inst YQueue_3 of Queue_31 @[GEMMBaseline.scala 329:47]
    YQueue_3.clock <= clock
    YQueue_3.reset <= reset
    inst YQueue_4 of Queue_32 @[GEMMBaseline.scala 329:47]
    YQueue_4.clock <= clock
    YQueue_4.reset <= reset
    inst YQueue_5 of Queue_33 @[GEMMBaseline.scala 329:47]
    YQueue_5.clock <= clock
    YQueue_5.reset <= reset
    inst YQueue_6 of Queue_34 @[GEMMBaseline.scala 329:47]
    YQueue_6.clock <= clock
    YQueue_6.reset <= reset
    inst YQueue_7 of Queue_35 @[GEMMBaseline.scala 329:47]
    YQueue_7.clock <= clock
    YQueue_7.reset <= reset
    inst YAdder_0 of SimpleAdderN_8 @[GEMMBaseline.scala 356:57]
    YAdder_0.clock <= clock
    YAdder_0.reset <= reset
    inst YAdder_1 of SimpleAdderN_9 @[GEMMBaseline.scala 356:57]
    YAdder_1.clock <= clock
    YAdder_1.reset <= reset
    inst YAdder_2 of SimpleAdderN_10 @[GEMMBaseline.scala 356:57]
    YAdder_2.clock <= clock
    YAdder_2.reset <= reset
    inst YAdder_3 of SimpleAdderN_11 @[GEMMBaseline.scala 356:57]
    YAdder_3.clock <= clock
    YAdder_3.reset <= reset
    reg Y_REG : UInt<16>[4], clock @[GEMMBaseline.scala 388:24]
    io.Y[0] <= Y_REG[0] @[GEMMBaseline.scala 402:22]
    io.Y[1] <= Y_REG[1] @[GEMMBaseline.scala 402:22]
    io.Y[2] <= Y_REG[2] @[GEMMBaseline.scala 402:22]
    io.Y[3] <= Y_REG[3] @[GEMMBaseline.scala 402:22]
    io.Y_valid[0] <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 409:53]
    io.Y_valid[1] <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 409:53]
    io.Y_valid[2] <= io.DEBUG_VALID[4] @[GEMMBaseline.scala 409:53]
    io.Y_valid[3] <= io.DEBUG_VALID[6] @[GEMMBaseline.scala 409:53]
    YQueue_0.io.enq.bits <= PEA_0.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_0.io.enq.valid <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 423:56]
    YQueue_1.io.enq.bits <= PEA_1.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_1.io.enq.valid <= io.DEBUG_VALID[1] @[GEMMBaseline.scala 423:56]
    YQueue_0.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_0.io.A[0] <= YQueue_0.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.A[1] <= YQueue_0.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[0] <= YAdder_0.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_1.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_0.io.A[0] <= YQueue_1.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.A[1] <= YQueue_1.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[0] <= YAdder_0.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_2.io.enq.bits <= PEA_2.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_2.io.enq.valid <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 423:56]
    YQueue_3.io.enq.bits <= PEA_3.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_3.io.enq.valid <= io.DEBUG_VALID[3] @[GEMMBaseline.scala 423:56]
    YQueue_2.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_1.io.A[0] <= YQueue_2.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.A[1] <= YQueue_2.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[1] <= YAdder_1.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_3.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_1.io.A[0] <= YQueue_3.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.A[1] <= YQueue_3.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[1] <= YAdder_1.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_4.io.enq.bits <= PEA_4.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_4.io.enq.valid <= io.DEBUG_VALID[4] @[GEMMBaseline.scala 423:56]
    YQueue_5.io.enq.bits <= PEA_5.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_5.io.enq.valid <= io.DEBUG_VALID[5] @[GEMMBaseline.scala 423:56]
    YQueue_4.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_2.io.A[0] <= YQueue_4.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.A[1] <= YQueue_4.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[2] <= YAdder_2.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_5.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_2.io.A[0] <= YQueue_5.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.A[1] <= YQueue_5.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[2] <= YAdder_2.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_6.io.enq.bits <= PEA_6.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_6.io.enq.valid <= io.DEBUG_VALID[6] @[GEMMBaseline.scala 423:56]
    YQueue_7.io.enq.bits <= PEA_7.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_7.io.enq.valid <= io.DEBUG_VALID[7] @[GEMMBaseline.scala 423:56]
    YQueue_6.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_3.io.A[0] <= YQueue_6.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.A[1] <= YQueue_6.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[3] <= YAdder_3.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_7.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_3.io.A[0] <= YQueue_7.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.A[1] <= YQueue_7.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[3] <= YAdder_3.io.Sum @[GEMMBaseline.scala 475:53]
    
  module Queue_36 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_37 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_38 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_39 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module SimpleAdderN_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SRAMS_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<6>, flip raddr : UInt<6>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[64], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SimpleMultiplier2_16 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_17 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_18 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_19 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module Queue_40 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_41 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_8 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_8 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_9 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_9 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_42 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_43 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_10 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_10 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_11 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_11 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_44 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_45 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_46 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_47 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module SimpleAdderN_16 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_17 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_18 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_19 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module BaselineSystolicPE_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip W : UInt<8>[2], flip X : UInt<8>[2], PE_OUT : UInt<16>[4], Y : UInt<8>[4], Y_valid : UInt<1>[4], flip valid : UInt<1>, DEBUG_VALID : UInt<1>[4]}
    
    inst PEA_0 of SimpleMultiplier2_16 @[GEMMBaseline.scala 84:47]
    PEA_0.clock <= clock
    PEA_0.reset <= reset
    inst PEA_1 of SimpleMultiplier2_17 @[GEMMBaseline.scala 84:47]
    PEA_1.clock <= clock
    PEA_1.reset <= reset
    inst PEA_2 of SimpleMultiplier2_18 @[GEMMBaseline.scala 84:47]
    PEA_2.clock <= clock
    PEA_2.reset <= reset
    inst PEA_3 of SimpleMultiplier2_19 @[GEMMBaseline.scala 84:47]
    PEA_3.clock <= clock
    PEA_3.reset <= reset
    io.PE_OUT[0] <= PEA_0.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[1] <= PEA_1.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[2] <= PEA_2.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[3] <= PEA_3.io.Out @[GEMMBaseline.scala 86:30]
    wire VALID_PE : UInt<1>[4] @[GEMMBaseline.scala 89:28]
    reg REG_A : UInt<8>[4], clock @[GEMMBaseline.scala 92:24]
    reg REG_B : UInt<8>[4], clock @[GEMMBaseline.scala 93:24]
    PEA_0.io.A <= REG_A[0] @[GEMMBaseline.scala 98:47]
    PEA_0.io.B <= REG_B[0] @[GEMMBaseline.scala 99:47]
    PEA_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_2.io.A <= REG_A[2] @[GEMMBaseline.scala 98:47]
    PEA_2.io.B <= REG_B[2] @[GEMMBaseline.scala 99:47]
    PEA_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_1.io.A <= REG_A[1] @[GEMMBaseline.scala 98:47]
    PEA_1.io.B <= REG_B[1] @[GEMMBaseline.scala 99:47]
    PEA_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_3.io.A <= REG_A[3] @[GEMMBaseline.scala 98:47]
    PEA_3.io.B <= REG_B[3] @[GEMMBaseline.scala 99:47]
    PEA_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    inst WQueue_0 of Queue_40 @[GEMMBaseline.scala 120:55]
    WQueue_0.clock <= clock
    WQueue_0.reset <= reset
    inst WQueue_1 of Queue_41 @[GEMMBaseline.scala 120:55]
    WQueue_1.clock <= clock
    WQueue_1.reset <= reset
    inst WPipe_0 of PipelineChainValid_8 @[GEMMBaseline.scala 135:42]
    WPipe_0.clock <= clock
    WPipe_0.reset <= reset
    inst WPipe_1 of PipelineChainValid_9 @[GEMMBaseline.scala 135:42]
    WPipe_1.clock <= clock
    WPipe_1.reset <= reset
    inst XQueue_0 of Queue_42 @[GEMMBaseline.scala 154:55]
    XQueue_0.clock <= clock
    XQueue_0.reset <= reset
    inst XQueue_1 of Queue_43 @[GEMMBaseline.scala 154:55]
    XQueue_1.clock <= clock
    XQueue_1.reset <= reset
    inst XPipe_0 of PipelineChainValid_10 @[GEMMBaseline.scala 170:42]
    XPipe_0.clock <= clock
    XPipe_0.reset <= reset
    inst XPipe_1 of PipelineChainValid_11 @[GEMMBaseline.scala 170:42]
    XPipe_1.clock <= clock
    XPipe_1.reset <= reset
    WQueue_0.io.enq.bits <= io.W[0] @[GEMMBaseline.scala 188:47]
    WQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[0] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_0.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_1.io.enq.bits <= io.W[1] @[GEMMBaseline.scala 188:47]
    WQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[1] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_1.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_1.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_1.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 198:45]
    REG_B[2] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[3] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 221:37]
    XQueue_0.io.enq.bits <= io.X[0] @[GEMMBaseline.scala 234:47]
    XQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[0] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_0.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_0.io.validin <= XQueue_0.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_1.io.enq.bits <= io.X[1] @[GEMMBaseline.scala 234:47]
    XQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[2] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_1.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_1.io.validin <= XQueue_1.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    REG_A[1] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[3] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 262:37]
    node _T = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[0] <= _T @[GEMMBaseline.scala 272:48]
    node _T_1 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 292:134]
    io.DEBUG_VALID[0] <= _T_1 @[GEMMBaseline.scala 292:79]
    node _T_2 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[1] <= _T_2 @[GEMMBaseline.scala 272:48]
    node _T_3 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 282:118]
    node _T_4 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 284:57]
    node _T_5 = and(_T_3, _T_4) @[GEMMBaseline.scala 283:108]
    io.DEBUG_VALID[1] <= _T_5 @[GEMMBaseline.scala 282:63]
    node _T_6 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[2] <= _T_6 @[GEMMBaseline.scala 272:48]
    node _T_7 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 287:118]
    node _T_8 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 289:57]
    node _T_9 = and(_T_7, _T_8) @[GEMMBaseline.scala 288:108]
    io.DEBUG_VALID[2] <= _T_9 @[GEMMBaseline.scala 287:63]
    node _T_10 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[3] <= _T_10 @[GEMMBaseline.scala 272:48]
    node _T_11 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 276:118]
    node _T_12 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 278:57]
    node _T_13 = and(_T_11, _T_12) @[GEMMBaseline.scala 277:108]
    node _T_14 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 279:57]
    node _T_15 = and(_T_13, _T_14) @[GEMMBaseline.scala 278:110]
    io.DEBUG_VALID[3] <= _T_15 @[GEMMBaseline.scala 276:63]
    inst YQueue_0 of Queue_44 @[GEMMBaseline.scala 329:47]
    YQueue_0.clock <= clock
    YQueue_0.reset <= reset
    inst YQueue_1 of Queue_45 @[GEMMBaseline.scala 329:47]
    YQueue_1.clock <= clock
    YQueue_1.reset <= reset
    inst YQueue_2 of Queue_46 @[GEMMBaseline.scala 329:47]
    YQueue_2.clock <= clock
    YQueue_2.reset <= reset
    inst YQueue_3 of Queue_47 @[GEMMBaseline.scala 329:47]
    YQueue_3.clock <= clock
    YQueue_3.reset <= reset
    inst YAdder_0 of SimpleAdderN_16 @[GEMMBaseline.scala 356:57]
    YAdder_0.clock <= clock
    YAdder_0.reset <= reset
    inst YAdder_1 of SimpleAdderN_17 @[GEMMBaseline.scala 356:57]
    YAdder_1.clock <= clock
    YAdder_1.reset <= reset
    inst YAdder_2 of SimpleAdderN_18 @[GEMMBaseline.scala 356:57]
    YAdder_2.clock <= clock
    YAdder_2.reset <= reset
    inst YAdder_3 of SimpleAdderN_19 @[GEMMBaseline.scala 356:57]
    YAdder_3.clock <= clock
    YAdder_3.reset <= reset
    reg Y_REG : UInt<16>[4], clock @[GEMMBaseline.scala 388:24]
    io.Y[0] <= Y_REG[0] @[GEMMBaseline.scala 402:22]
    io.Y[1] <= Y_REG[1] @[GEMMBaseline.scala 402:22]
    io.Y[2] <= Y_REG[2] @[GEMMBaseline.scala 402:22]
    io.Y[3] <= Y_REG[3] @[GEMMBaseline.scala 402:22]
    io.Y_valid[0] <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 409:53]
    io.Y_valid[1] <= io.DEBUG_VALID[1] @[GEMMBaseline.scala 409:53]
    io.Y_valid[2] <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 409:53]
    io.Y_valid[3] <= io.DEBUG_VALID[3] @[GEMMBaseline.scala 409:53]
    YQueue_0.io.enq.bits <= PEA_0.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_0.io.enq.valid <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 423:56]
    YQueue_0.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_0.io.A[0] <= YQueue_0.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[0] <= YAdder_0.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_1.io.enq.bits <= PEA_1.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_1.io.enq.valid <= io.DEBUG_VALID[1] @[GEMMBaseline.scala 423:56]
    YQueue_1.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_1.io.A[0] <= YQueue_1.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[1] <= YAdder_1.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_2.io.enq.bits <= PEA_2.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_2.io.enq.valid <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 423:56]
    YQueue_2.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_2.io.A[0] <= YQueue_2.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[2] <= YAdder_2.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_3.io.enq.bits <= PEA_3.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_3.io.enq.valid <= io.DEBUG_VALID[3] @[GEMMBaseline.scala 423:56]
    YQueue_3.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_3.io.A[0] <= YQueue_3.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[3] <= YAdder_3.io.Sum @[GEMMBaseline.scala 475:53]
    
  module SimpleMultiplier2_20 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_21 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_22 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module SimpleMultiplier2_23 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>, flip B : UInt<8>, Out : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    node _T = mul(io.A, io.B) @[SimpleMultiplier2.scala 13:23]
    io.Out <= _T @[SimpleMultiplier2.scala 13:16]
    io.entry.ready <= UInt<1>("h01") @[SimpleMultiplier2.scala 14:24]
    io.exit.valid <= UInt<1>("h01") @[SimpleMultiplier2.scala 15:23]
    
  module Queue_48 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_49 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_12 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_12 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_13 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_13 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_50 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_51 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<1>}
    
    cmem ram : UInt<8>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module PipelineUnit_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_14 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_14 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module PipelineUnit_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, flip pipe1_ready_go : UInt<1>, pipe_allowin : UInt<1>, pipe_valid_reg : UInt<1>}
    
    reg pipe_valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[pipeline.scala 138:33]
    reg pipe_data : UInt<1>, clock @[pipeline.scala 139:28]
    io.pipe_valid_reg <= pipe_valid @[pipeline.scala 141:27]
    when io.pipe_allowin : @[pipeline.scala 143:30]
      pipe_valid <= io.validin @[pipeline.scala 144:28]
      skip @[pipeline.scala 143:30]
    node _T = and(io.validin, io.pipe_allowin) @[pipeline.scala 147:25]
    when _T : @[pipeline.scala 147:44]
      pipe_data <= io.datain @[pipeline.scala 148:27]
      skip @[pipeline.scala 147:44]
    node _T_1 = eq(pipe_valid, UInt<1>("h00")) @[pipeline.scala 151:28]
    node _T_2 = and(io.pipe1_ready_go, io.out_allow) @[pipeline.scala 151:61]
    node _T_3 = or(_T_1, _T_2) @[pipeline.scala 151:40]
    io.pipe_allowin <= _T_3 @[pipeline.scala 151:25]
    node _T_4 = and(pipe_valid, io.pipe1_ready_go) @[pipeline.scala 154:35]
    io.validout <= _T_4 @[pipeline.scala 154:21]
    io.dataout <= pipe_data @[pipeline.scala 155:21]
    
  module PipelineChain_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip datain : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, dataout : UInt<1>, validin_internal : UInt<1>[1], pipe_allowin_internal : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst f of PipelineUnit_15 @[pipeline.scala 74:45]
    f.clock <= clock
    f.reset <= reset
    f.io.pipe1_ready_go <= io.pipe_ready_go[0] @[pipeline.scala 78:37]
    f.io.validin <= io.validin @[pipeline.scala 82:22]
    f.io.datain <= io.datain @[pipeline.scala 83:22]
    io.validin_internal[0] <= io.validin @[pipeline.scala 85:32]
    io.pipe_allowin_internal[0] <= io.pipe_allowin @[pipeline.scala 86:37]
    io.pipe_allowin <= f.io.pipe_allowin @[pipeline.scala 88:25]
    f.io.out_allow <= io.out_allow @[pipeline.scala 91:24]
    io.validout <= f.io.validout @[pipeline.scala 92:21]
    io.dataout <= f.io.dataout @[pipeline.scala 93:20]
    io.validout_internal[0] <= f.io.pipe_valid_reg @[pipeline.scala 95:33]
    
  module PipelineChainValid_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip validin : UInt<1>, flip out_allow : UInt<1>, validout : UInt<1>, data_update : UInt<1>[1], validout_internal : UInt<1>[1], flip pipe_ready_go : UInt<1>[1], pipe_allowin : UInt<1>}
    
    inst m of PipelineChain_15 @[pipeline.scala 29:23]
    m.clock <= clock
    m.reset <= reset
    m.io.validin <= io.validin @[pipeline.scala 33:22]
    m.io.datain <= UInt<1>("h00") @[pipeline.scala 34:21]
    m.io.out_allow <= io.out_allow @[pipeline.scala 35:24]
    io.validout <= m.io.validout @[pipeline.scala 37:21]
    m.io.pipe_ready_go[0] <= io.pipe_ready_go[0] @[pipeline.scala 39:28]
    io.pipe_allowin <= m.io.pipe_allowin @[pipeline.scala 40:25]
    node _T = and(m.io.validin_internal[0], m.io.pipe_allowin_internal[0]) @[pipeline.scala 43:66]
    io.data_update[0] <= _T @[pipeline.scala 43:35]
    io.validout_internal[0] <= m.io.validout_internal[0] @[pipeline.scala 46:30]
    
  module Queue_52 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_53 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_54 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module Queue_55 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<16>}, count : UInt<1>}
    
    cmem ram : UInt<16>[1] @[Decoupled.scala 209:16]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[UInt<1>("h00")], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      skip @[Decoupled.scala 224:17]
    node _T_4 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_4 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_5 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_5 @[Decoupled.scala 231:16]
    node _T_6 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_6 @[Decoupled.scala 232:16]
    infer mport _T_7 = ram[UInt<1>("h00")], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_7 @[Decoupled.scala 233:15]
    node _T_8 = sub(UInt<1>("h00"), UInt<1>("h00")) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_8, 1) @[Decoupled.scala 248:32]
    node _T_9 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_10 = mux(_T_9, UInt<1>("h01"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_11 = or(_T_10, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_11 @[Decoupled.scala 250:14]
    
  module SimpleAdderN_20 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_21 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_22 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_23 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<16>[1], Sum : UInt<16>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire root : UInt<16> @[SimpleAdderN.scala 8:20]
    root <= io.A[0] @[SimpleAdderN.scala 9:14]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module BaselineSystolicPE_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip W : UInt<8>[2], flip X : UInt<8>[2], PE_OUT : UInt<16>[4], Y : UInt<8>[4], Y_valid : UInt<1>[4], flip valid : UInt<1>, DEBUG_VALID : UInt<1>[4]}
    
    inst PEA_0 of SimpleMultiplier2_20 @[GEMMBaseline.scala 84:47]
    PEA_0.clock <= clock
    PEA_0.reset <= reset
    inst PEA_1 of SimpleMultiplier2_21 @[GEMMBaseline.scala 84:47]
    PEA_1.clock <= clock
    PEA_1.reset <= reset
    inst PEA_2 of SimpleMultiplier2_22 @[GEMMBaseline.scala 84:47]
    PEA_2.clock <= clock
    PEA_2.reset <= reset
    inst PEA_3 of SimpleMultiplier2_23 @[GEMMBaseline.scala 84:47]
    PEA_3.clock <= clock
    PEA_3.reset <= reset
    io.PE_OUT[0] <= PEA_0.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[1] <= PEA_1.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[2] <= PEA_2.io.Out @[GEMMBaseline.scala 86:30]
    io.PE_OUT[3] <= PEA_3.io.Out @[GEMMBaseline.scala 86:30]
    wire VALID_PE : UInt<1>[4] @[GEMMBaseline.scala 89:28]
    reg REG_A : UInt<8>[4], clock @[GEMMBaseline.scala 92:24]
    reg REG_B : UInt<8>[4], clock @[GEMMBaseline.scala 93:24]
    PEA_0.io.A <= REG_A[0] @[GEMMBaseline.scala 98:47]
    PEA_0.io.B <= REG_B[0] @[GEMMBaseline.scala 99:47]
    PEA_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_2.io.A <= REG_A[2] @[GEMMBaseline.scala 98:47]
    PEA_2.io.B <= REG_B[2] @[GEMMBaseline.scala 99:47]
    PEA_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_1.io.A <= REG_A[1] @[GEMMBaseline.scala 98:47]
    PEA_1.io.B <= REG_B[1] @[GEMMBaseline.scala 99:47]
    PEA_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    PEA_3.io.A <= REG_A[3] @[GEMMBaseline.scala 98:47]
    PEA_3.io.B <= REG_B[3] @[GEMMBaseline.scala 99:47]
    PEA_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 100:57]
    PEA_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 101:56]
    inst WQueue_0 of Queue_48 @[GEMMBaseline.scala 120:55]
    WQueue_0.clock <= clock
    WQueue_0.reset <= reset
    inst WQueue_1 of Queue_49 @[GEMMBaseline.scala 120:55]
    WQueue_1.clock <= clock
    WQueue_1.reset <= reset
    inst WPipe_0 of PipelineChainValid_12 @[GEMMBaseline.scala 135:42]
    WPipe_0.clock <= clock
    WPipe_0.reset <= reset
    inst WPipe_1 of PipelineChainValid_13 @[GEMMBaseline.scala 135:42]
    WPipe_1.clock <= clock
    WPipe_1.reset <= reset
    inst XQueue_0 of Queue_50 @[GEMMBaseline.scala 154:55]
    XQueue_0.clock <= clock
    XQueue_0.reset <= reset
    inst XQueue_1 of Queue_51 @[GEMMBaseline.scala 154:55]
    XQueue_1.clock <= clock
    XQueue_1.reset <= reset
    inst XPipe_0 of PipelineChainValid_14 @[GEMMBaseline.scala 170:42]
    XPipe_0.clock <= clock
    XPipe_0.reset <= reset
    inst XPipe_1 of PipelineChainValid_15 @[GEMMBaseline.scala 170:42]
    XPipe_1.clock <= clock
    XPipe_1.reset <= reset
    WQueue_0.io.enq.bits <= io.W[0] @[GEMMBaseline.scala 188:47]
    WQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[0] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_0.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_0.io.validin <= WQueue_0.io.deq.valid @[GEMMBaseline.scala 198:45]
    WQueue_1.io.enq.bits <= io.W[1] @[GEMMBaseline.scala 188:47]
    WQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 189:48]
    REG_B[1] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 191:36]
    WQueue_1.io.deq.ready <= XPipe_0.io.data_update[0] @[GEMMBaseline.scala 192:48]
    WPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 194:47]
    WPipe_1.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 195:45]
    WPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 196:54]
    WPipe_1.io.validin <= WQueue_1.io.deq.valid @[GEMMBaseline.scala 198:45]
    REG_B[2] <= WQueue_0.io.deq.bits @[GEMMBaseline.scala 221:37]
    REG_B[3] <= WQueue_1.io.deq.bits @[GEMMBaseline.scala 221:37]
    XQueue_0.io.enq.bits <= io.X[0] @[GEMMBaseline.scala 234:47]
    XQueue_0.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[0] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_0.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_0.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_0.io.validin <= XQueue_0.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_0.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    XQueue_1.io.enq.bits <= io.X[1] @[GEMMBaseline.scala 234:47]
    XQueue_1.io.enq.valid <= io.valid @[GEMMBaseline.scala 235:48]
    REG_A[2] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 237:36]
    XQueue_1.io.deq.ready <= WPipe_0.io.data_update[0] @[GEMMBaseline.scala 238:48]
    XPipe_1.io.out_allow <= UInt<1>("h01") @[GEMMBaseline.scala 240:47]
    XPipe_1.io.validin <= XQueue_1.io.deq.valid @[GEMMBaseline.scala 241:45]
    XPipe_1.io.pipe_ready_go[0] <= UInt<1>("h01") @[GEMMBaseline.scala 242:54]
    REG_A[1] <= XQueue_0.io.deq.bits @[GEMMBaseline.scala 262:37]
    REG_A[3] <= XQueue_1.io.deq.bits @[GEMMBaseline.scala 262:37]
    node _T = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[0] <= _T @[GEMMBaseline.scala 272:48]
    node _T_1 = and(XPipe_0.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 292:134]
    io.DEBUG_VALID[0] <= _T_1 @[GEMMBaseline.scala 292:79]
    node _T_2 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[1] <= _T_2 @[GEMMBaseline.scala 272:48]
    node _T_3 = and(XPipe_0.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 282:118]
    node _T_4 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 284:57]
    node _T_5 = and(_T_3, _T_4) @[GEMMBaseline.scala 283:108]
    io.DEBUG_VALID[1] <= _T_5 @[GEMMBaseline.scala 282:63]
    node _T_6 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[2] <= _T_6 @[GEMMBaseline.scala 272:48]
    node _T_7 = and(XPipe_1.io.validout_internal[0], WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 287:118]
    node _T_8 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 289:57]
    node _T_9 = and(_T_7, _T_8) @[GEMMBaseline.scala 288:108]
    io.DEBUG_VALID[2] <= _T_9 @[GEMMBaseline.scala 287:63]
    node _T_10 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 272:103]
    VALID_PE[3] <= _T_10 @[GEMMBaseline.scala 272:48]
    node _T_11 = and(XPipe_1.io.validout_internal[0], WPipe_1.io.validout_internal[0]) @[GEMMBaseline.scala 276:118]
    node _T_12 = not(XPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 278:57]
    node _T_13 = and(_T_11, _T_12) @[GEMMBaseline.scala 277:108]
    node _T_14 = not(WPipe_0.io.validout_internal[0]) @[GEMMBaseline.scala 279:57]
    node _T_15 = and(_T_13, _T_14) @[GEMMBaseline.scala 278:110]
    io.DEBUG_VALID[3] <= _T_15 @[GEMMBaseline.scala 276:63]
    inst YQueue_0 of Queue_52 @[GEMMBaseline.scala 329:47]
    YQueue_0.clock <= clock
    YQueue_0.reset <= reset
    inst YQueue_1 of Queue_53 @[GEMMBaseline.scala 329:47]
    YQueue_1.clock <= clock
    YQueue_1.reset <= reset
    inst YQueue_2 of Queue_54 @[GEMMBaseline.scala 329:47]
    YQueue_2.clock <= clock
    YQueue_2.reset <= reset
    inst YQueue_3 of Queue_55 @[GEMMBaseline.scala 329:47]
    YQueue_3.clock <= clock
    YQueue_3.reset <= reset
    inst YAdder_0 of SimpleAdderN_20 @[GEMMBaseline.scala 356:57]
    YAdder_0.clock <= clock
    YAdder_0.reset <= reset
    inst YAdder_1 of SimpleAdderN_21 @[GEMMBaseline.scala 356:57]
    YAdder_1.clock <= clock
    YAdder_1.reset <= reset
    inst YAdder_2 of SimpleAdderN_22 @[GEMMBaseline.scala 356:57]
    YAdder_2.clock <= clock
    YAdder_2.reset <= reset
    inst YAdder_3 of SimpleAdderN_23 @[GEMMBaseline.scala 356:57]
    YAdder_3.clock <= clock
    YAdder_3.reset <= reset
    reg Y_REG : UInt<16>[4], clock @[GEMMBaseline.scala 388:24]
    io.Y[0] <= Y_REG[0] @[GEMMBaseline.scala 402:22]
    io.Y[1] <= Y_REG[1] @[GEMMBaseline.scala 402:22]
    io.Y[2] <= Y_REG[2] @[GEMMBaseline.scala 402:22]
    io.Y[3] <= Y_REG[3] @[GEMMBaseline.scala 402:22]
    io.Y_valid[0] <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 409:53]
    io.Y_valid[1] <= io.DEBUG_VALID[1] @[GEMMBaseline.scala 409:53]
    io.Y_valid[2] <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 409:53]
    io.Y_valid[3] <= io.DEBUG_VALID[3] @[GEMMBaseline.scala 409:53]
    YQueue_0.io.enq.bits <= PEA_0.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_0.io.enq.valid <= io.DEBUG_VALID[0] @[GEMMBaseline.scala 423:56]
    YQueue_0.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_0.io.A[0] <= YQueue_0.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_0.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_0.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[0] <= YAdder_0.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_1.io.enq.bits <= PEA_1.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_1.io.enq.valid <= io.DEBUG_VALID[1] @[GEMMBaseline.scala 423:56]
    YQueue_1.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_1.io.A[0] <= YQueue_1.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_1.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_1.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[1] <= YAdder_1.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_2.io.enq.bits <= PEA_2.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_2.io.enq.valid <= io.DEBUG_VALID[2] @[GEMMBaseline.scala 423:56]
    YQueue_2.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_2.io.A[0] <= YQueue_2.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_2.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_2.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[2] <= YAdder_2.io.Sum @[GEMMBaseline.scala 475:53]
    YQueue_3.io.enq.bits <= PEA_3.io.Out @[GEMMBaseline.scala 422:55]
    YQueue_3.io.enq.valid <= io.DEBUG_VALID[3] @[GEMMBaseline.scala 423:56]
    YQueue_3.io.deq.ready <= UInt<1>("h01") @[GEMMBaseline.scala 467:64]
    YAdder_3.io.A[0] <= YQueue_3.io.deq.bits @[GEMMBaseline.scala 469:70]
    YAdder_3.io.exit.ready <= UInt<1>("h01") @[GEMMBaseline.scala 471:68]
    YAdder_3.io.entry.valid <= UInt<1>("h01") @[GEMMBaseline.scala 472:69]
    Y_REG[3] <= YAdder_3.io.Sum @[GEMMBaseline.scala 475:53]
    
  module Queue_56 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_57 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_58 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_59 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_60 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_61 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_62 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module Queue_63 : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}
    
    cmem ram : UInt<8>[8] @[Decoupled.scala 209:16]
    reg enq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 212:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 214:33]
    node _T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 215:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 215:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 216:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 220:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 221:8]
      _T_3 <= io.enq.bits @[Decoupled.scala 221:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip @[Decoupled.scala 220:17]
    when do_deq : @[Decoupled.scala 224:17]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h07")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h01")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip @[Decoupled.scala 224:17]
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 227:16]
    when _T_8 : @[Decoupled.scala 227:28]
      maybe_full <= do_enq @[Decoupled.scala 228:16]
      skip @[Decoupled.scala 227:28]
    node _T_9 = eq(empty, UInt<1>("h00")) @[Decoupled.scala 231:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 231:16]
    node _T_10 = eq(full, UInt<1>("h00")) @[Decoupled.scala 232:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 232:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 233:21]
    io.deq.bits <= _T_11 @[Decoupled.scala 233:15]
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 248:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 248:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 250:32]
    node _T_14 = mux(_T_13, UInt<4>("h08"), UInt<1>("h00")) @[Decoupled.scala 250:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 250:62]
    io.count <= _T_15 @[Decoupled.scala 250:14]
    
  module SimpleAdderN_24 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_25 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_26 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_27 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_28 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_29 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_30 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SimpleAdderN_31 : 
    input clock : Clock
    input reset : Reset
    output io : {flip A : UInt<8>[2], Sum : UInt<8>, entry : {flip valid : UInt<1>, ready : UInt<1>}, exit : {valid : UInt<1>, flip ready : UInt<1>}}
    
    wire _T : UInt<8> @[SimpleAdderN.scala 8:20]
    _T <= io.A[0] @[SimpleAdderN.scala 9:14]
    wire root : UInt<8> @[SimpleAdderN.scala 12:32]
    node _T_1 = add(_T, io.A[1]) @[SimpleAdderN.scala 13:30]
    node _T_2 = tail(_T_1, 1) @[SimpleAdderN.scala 13:30]
    root <= _T_2 @[SimpleAdderN.scala 13:22]
    io.Sum <= root @[SimpleAdderN.scala 17:12]
    io.entry.ready <= UInt<1>("h01") @[SimpleAdderN.scala 20:20]
    io.exit.valid <= UInt<1>("h01") @[SimpleAdderN.scala 21:23]
    
  module SRAMS_8 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_9 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_10 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_11 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_12 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_13 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_14 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module SRAMS_15 : 
    input clock : Clock
    input reset : Reset
    output io : {flip waddr : UInt<2>, flip raddr : UInt<2>, flip wen : UInt<1>, flip ren : UInt<1>, flip wdata : UInt<8>, rdata : UInt<8>}
    
    smem lut : UInt<8>[4], undefined @[SRAMS.scala 50:24]
    when io.ren : @[SRAMS.scala 54:15]
      infer mport _T = lut[io.raddr], clock @[SRAMS.scala 55:20]
      io.rdata <= _T @[SRAMS.scala 55:14]
      skip @[SRAMS.scala 54:15]
    else : @[SRAMS.scala 56:14]
      infer mport _T_1 = lut[io.raddr], clock @[SRAMS.scala 57:24]
      io.rdata <= _T_1 @[SRAMS.scala 57:18]
      skip @[SRAMS.scala 56:14]
    when io.wen : @[SRAMS.scala 60:15]
      infer mport _T_2 = lut[io.waddr], clock @[SRAMS.scala 61:14]
      _T_2 <= io.wdata @[SRAMS.scala 61:25]
      skip @[SRAMS.scala 60:15]
    
  module MHA_V1 : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip Xk : UInt<8>[4], flip Xq : UInt<8>[4], flip Wq : UInt<8>[4], flip Wk : UInt<8>[4], DEBUG_K : UInt<8>[4], DEBUG_Q : UInt<8>[4], DEBUG_S : UInt<8>[8], flip valid : UInt<1>, flip N : UInt<32>, flip M : UInt<32>, flip H : UInt<32>, flip B : UInt<32>, flip O : UInt<32>, flip E : UInt<32>, flip D : UInt<32>, flip DimN : UInt<32>, flip DimM : UInt<32>, flip DimH : UInt<32>, flip DimB : UInt<32>, flip DimO : UInt<32>, flip DimE : UInt<32>, flip DimD : UInt<32>}
    
    inst BaselineSystolicPE of BaselineSystolicPE @[AttentionUnit.scala 118:43]
    BaselineSystolicPE.clock <= clock
    BaselineSystolicPE.reset <= reset
    BaselineSystolicPE.io.X[0] <= io.Xq[0] @[AttentionUnit.scala 120:22]
    BaselineSystolicPE.io.X[1] <= io.Xq[1] @[AttentionUnit.scala 120:22]
    BaselineSystolicPE.io.X[2] <= io.Xq[2] @[AttentionUnit.scala 120:22]
    BaselineSystolicPE.io.X[3] <= io.Xq[3] @[AttentionUnit.scala 120:22]
    BaselineSystolicPE.io.W[0] <= io.Wq[0] @[AttentionUnit.scala 121:22]
    BaselineSystolicPE.io.W[1] <= io.Wq[1] @[AttentionUnit.scala 121:22]
    BaselineSystolicPE.io.W[2] <= io.Wq[2] @[AttentionUnit.scala 121:22]
    BaselineSystolicPE.io.W[3] <= io.Wq[3] @[AttentionUnit.scala 121:22]
    BaselineSystolicPE.io.valid <= io.valid @[AttentionUnit.scala 122:26]
    inst MM_Q_queue_0 of Queue_16 @[AttentionUnit.scala 144:47]
    MM_Q_queue_0.clock <= clock
    MM_Q_queue_0.reset <= reset
    MM_Q_queue_0.io.enq.bits <= BaselineSystolicPE.io.Y[0] @[AttentionUnit.scala 147:47]
    MM_Q_queue_0.io.enq.valid <= io.valid @[AttentionUnit.scala 148:48]
    inst MM_Q_queue_1 of Queue_17 @[AttentionUnit.scala 144:47]
    MM_Q_queue_1.clock <= clock
    MM_Q_queue_1.reset <= reset
    MM_Q_queue_1.io.enq.bits <= BaselineSystolicPE.io.Y[1] @[AttentionUnit.scala 147:47]
    MM_Q_queue_1.io.enq.valid <= io.valid @[AttentionUnit.scala 148:48]
    inst MM_Q_queue_2 of Queue_18 @[AttentionUnit.scala 144:47]
    MM_Q_queue_2.clock <= clock
    MM_Q_queue_2.reset <= reset
    MM_Q_queue_2.io.enq.bits <= BaselineSystolicPE.io.Y[2] @[AttentionUnit.scala 147:47]
    MM_Q_queue_2.io.enq.valid <= io.valid @[AttentionUnit.scala 148:48]
    inst MM_Q_queue_3 of Queue_19 @[AttentionUnit.scala 144:47]
    MM_Q_queue_3.clock <= clock
    MM_Q_queue_3.reset <= reset
    MM_Q_queue_3.io.enq.bits <= BaselineSystolicPE.io.Y[3] @[AttentionUnit.scala 147:47]
    MM_Q_queue_3.io.enq.valid <= io.valid @[AttentionUnit.scala 148:48]
    inst SimpleAdderN of SimpleAdderN_4 @[AttentionUnit.scala 171:57]
    SimpleAdderN.clock <= clock
    SimpleAdderN.reset <= reset
    inst SimpleAdderN_1 of SimpleAdderN_5 @[AttentionUnit.scala 171:57]
    SimpleAdderN_1.clock <= clock
    SimpleAdderN_1.reset <= reset
    inst SimpleAdderN_2 of SimpleAdderN_6 @[AttentionUnit.scala 171:57]
    SimpleAdderN_2.clock <= clock
    SimpleAdderN_2.reset <= reset
    inst SimpleAdderN_3 of SimpleAdderN_7 @[AttentionUnit.scala 171:57]
    SimpleAdderN_3.clock <= clock
    SimpleAdderN_3.reset <= reset
    inst SRAMS of SRAMS @[AttentionUnit.scala 174:59]
    SRAMS.clock <= clock
    SRAMS.reset <= reset
    inst SRAMS_1 of SRAMS_1 @[AttentionUnit.scala 174:59]
    SRAMS_1.clock <= clock
    SRAMS_1.reset <= reset
    inst SRAMS_2 of SRAMS_2 @[AttentionUnit.scala 174:59]
    SRAMS_2.clock <= clock
    SRAMS_2.reset <= reset
    inst SRAMS_3 of SRAMS_3 @[AttentionUnit.scala 174:59]
    SRAMS_3.clock <= clock
    SRAMS_3.reset <= reset
    node _T = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 189:58]
    SRAMS.io.raddr <= _T @[AttentionUnit.scala 189:50]
    SRAMS.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 190:48]
    SRAMS.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 192:50]
    node _T_1 = gt(io.M, UInt<1>("h00")) @[AttentionUnit.scala 193:59]
    node _T_2 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 193:72]
    node _T_3 = or(_T_1, _T_2) @[AttentionUnit.scala 193:65]
    node _T_4 = not(_T_3) @[AttentionUnit.scala 193:51]
    SRAMS.io.wen <= _T_4 @[AttentionUnit.scala 193:48]
    node _T_5 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 194:36]
    when _T_5 : @[AttentionUnit.scala 194:44]
      SRAMS.io.wdata <= SimpleAdderN.io.Sum @[AttentionUnit.scala 195:58]
      skip @[AttentionUnit.scala 194:44]
    else : @[AttentionUnit.scala 196:36]
      SRAMS.io.wdata <= MM_Q_queue_0.io.deq.bits @[AttentionUnit.scala 197:58]
      skip @[AttentionUnit.scala 196:36]
    io.DEBUG_Q[0] <= SRAMS.io.rdata @[AttentionUnit.scala 200:41]
    SimpleAdderN.io.A[1] <= SRAMS.io.rdata @[AttentionUnit.scala 202:49]
    SimpleAdderN.io.A[0] <= MM_Q_queue_0.io.deq.bits @[AttentionUnit.scala 203:49]
    SimpleAdderN.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 205:56]
    SimpleAdderN.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 206:55]
    MM_Q_queue_0.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 209:48]
    node _T_6 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 189:58]
    SRAMS_1.io.raddr <= _T_6 @[AttentionUnit.scala 189:50]
    SRAMS_1.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 190:48]
    SRAMS_1.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 192:50]
    node _T_7 = gt(io.M, UInt<1>("h00")) @[AttentionUnit.scala 193:59]
    node _T_8 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 193:72]
    node _T_9 = or(_T_7, _T_8) @[AttentionUnit.scala 193:65]
    node _T_10 = not(_T_9) @[AttentionUnit.scala 193:51]
    SRAMS_1.io.wen <= _T_10 @[AttentionUnit.scala 193:48]
    node _T_11 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 194:36]
    when _T_11 : @[AttentionUnit.scala 194:44]
      SRAMS_1.io.wdata <= SimpleAdderN_1.io.Sum @[AttentionUnit.scala 195:58]
      skip @[AttentionUnit.scala 194:44]
    else : @[AttentionUnit.scala 196:36]
      SRAMS_1.io.wdata <= MM_Q_queue_1.io.deq.bits @[AttentionUnit.scala 197:58]
      skip @[AttentionUnit.scala 196:36]
    io.DEBUG_Q[1] <= SRAMS_1.io.rdata @[AttentionUnit.scala 200:41]
    SimpleAdderN_1.io.A[1] <= SRAMS_1.io.rdata @[AttentionUnit.scala 202:49]
    SimpleAdderN_1.io.A[0] <= MM_Q_queue_1.io.deq.bits @[AttentionUnit.scala 203:49]
    SimpleAdderN_1.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 205:56]
    SimpleAdderN_1.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 206:55]
    MM_Q_queue_1.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 209:48]
    node _T_12 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 189:58]
    SRAMS_2.io.raddr <= _T_12 @[AttentionUnit.scala 189:50]
    SRAMS_2.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 190:48]
    SRAMS_2.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 192:50]
    node _T_13 = gt(io.M, UInt<1>("h00")) @[AttentionUnit.scala 193:59]
    node _T_14 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 193:72]
    node _T_15 = or(_T_13, _T_14) @[AttentionUnit.scala 193:65]
    node _T_16 = not(_T_15) @[AttentionUnit.scala 193:51]
    SRAMS_2.io.wen <= _T_16 @[AttentionUnit.scala 193:48]
    node _T_17 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 194:36]
    when _T_17 : @[AttentionUnit.scala 194:44]
      SRAMS_2.io.wdata <= SimpleAdderN_2.io.Sum @[AttentionUnit.scala 195:58]
      skip @[AttentionUnit.scala 194:44]
    else : @[AttentionUnit.scala 196:36]
      SRAMS_2.io.wdata <= MM_Q_queue_2.io.deq.bits @[AttentionUnit.scala 197:58]
      skip @[AttentionUnit.scala 196:36]
    io.DEBUG_Q[2] <= SRAMS_2.io.rdata @[AttentionUnit.scala 200:41]
    SimpleAdderN_2.io.A[1] <= SRAMS_2.io.rdata @[AttentionUnit.scala 202:49]
    SimpleAdderN_2.io.A[0] <= MM_Q_queue_2.io.deq.bits @[AttentionUnit.scala 203:49]
    SimpleAdderN_2.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 205:56]
    SimpleAdderN_2.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 206:55]
    MM_Q_queue_2.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 209:48]
    node _T_18 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 189:58]
    SRAMS_3.io.raddr <= _T_18 @[AttentionUnit.scala 189:50]
    SRAMS_3.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 190:48]
    SRAMS_3.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 192:50]
    node _T_19 = gt(io.M, UInt<1>("h00")) @[AttentionUnit.scala 193:59]
    node _T_20 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 193:72]
    node _T_21 = or(_T_19, _T_20) @[AttentionUnit.scala 193:65]
    node _T_22 = not(_T_21) @[AttentionUnit.scala 193:51]
    SRAMS_3.io.wen <= _T_22 @[AttentionUnit.scala 193:48]
    node _T_23 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 194:36]
    when _T_23 : @[AttentionUnit.scala 194:44]
      SRAMS_3.io.wdata <= SimpleAdderN_3.io.Sum @[AttentionUnit.scala 195:58]
      skip @[AttentionUnit.scala 194:44]
    else : @[AttentionUnit.scala 196:36]
      SRAMS_3.io.wdata <= MM_Q_queue_3.io.deq.bits @[AttentionUnit.scala 197:58]
      skip @[AttentionUnit.scala 196:36]
    io.DEBUG_Q[3] <= SRAMS_3.io.rdata @[AttentionUnit.scala 200:41]
    SimpleAdderN_3.io.A[1] <= SRAMS_3.io.rdata @[AttentionUnit.scala 202:49]
    SimpleAdderN_3.io.A[0] <= MM_Q_queue_3.io.deq.bits @[AttentionUnit.scala 203:49]
    SimpleAdderN_3.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 205:56]
    SimpleAdderN_3.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 206:55]
    MM_Q_queue_3.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 209:48]
    wire Q_valid : UInt<1> @[AttentionUnit.scala 213:27]
    node _T_24 = add(io.E, UInt<1>("h01")) @[AttentionUnit.scala 214:26]
    node _T_25 = tail(_T_24, 1) @[AttentionUnit.scala 214:26]
    node _T_26 = geq(_T_25, io.DimE) @[AttentionUnit.scala 214:32]
    Q_valid <= _T_26 @[AttentionUnit.scala 214:17]
    inst BaselineSystolicPE_1 of BaselineSystolicPE_1 @[AttentionUnit.scala 231:43]
    BaselineSystolicPE_1.clock <= clock
    BaselineSystolicPE_1.reset <= reset
    BaselineSystolicPE_1.io.X[0] <= io.Xk[0] @[AttentionUnit.scala 233:22]
    BaselineSystolicPE_1.io.X[1] <= io.Xk[1] @[AttentionUnit.scala 233:22]
    BaselineSystolicPE_1.io.X[2] <= io.Xk[2] @[AttentionUnit.scala 233:22]
    BaselineSystolicPE_1.io.X[3] <= io.Xk[3] @[AttentionUnit.scala 233:22]
    BaselineSystolicPE_1.io.W[0] <= io.Wk[0] @[AttentionUnit.scala 234:22]
    BaselineSystolicPE_1.io.W[1] <= io.Wk[1] @[AttentionUnit.scala 234:22]
    BaselineSystolicPE_1.io.W[2] <= io.Wk[2] @[AttentionUnit.scala 234:22]
    BaselineSystolicPE_1.io.W[3] <= io.Wk[3] @[AttentionUnit.scala 234:22]
    BaselineSystolicPE_1.io.valid <= io.valid @[AttentionUnit.scala 235:26]
    inst MM_K_queue_0 of Queue_36 @[AttentionUnit.scala 252:47]
    MM_K_queue_0.clock <= clock
    MM_K_queue_0.reset <= reset
    MM_K_queue_0.io.enq.bits <= BaselineSystolicPE.io.Y[0] @[AttentionUnit.scala 255:47]
    MM_K_queue_0.io.enq.valid <= io.valid @[AttentionUnit.scala 256:48]
    inst MM_K_queue_1 of Queue_37 @[AttentionUnit.scala 252:47]
    MM_K_queue_1.clock <= clock
    MM_K_queue_1.reset <= reset
    MM_K_queue_1.io.enq.bits <= BaselineSystolicPE.io.Y[1] @[AttentionUnit.scala 255:47]
    MM_K_queue_1.io.enq.valid <= io.valid @[AttentionUnit.scala 256:48]
    inst MM_K_queue_2 of Queue_38 @[AttentionUnit.scala 252:47]
    MM_K_queue_2.clock <= clock
    MM_K_queue_2.reset <= reset
    MM_K_queue_2.io.enq.bits <= BaselineSystolicPE.io.Y[2] @[AttentionUnit.scala 255:47]
    MM_K_queue_2.io.enq.valid <= io.valid @[AttentionUnit.scala 256:48]
    inst MM_K_queue_3 of Queue_39 @[AttentionUnit.scala 252:47]
    MM_K_queue_3.clock <= clock
    MM_K_queue_3.reset <= reset
    MM_K_queue_3.io.enq.bits <= BaselineSystolicPE.io.Y[3] @[AttentionUnit.scala 255:47]
    MM_K_queue_3.io.enq.valid <= io.valid @[AttentionUnit.scala 256:48]
    inst SimpleAdderN_4 of SimpleAdderN_12 @[AttentionUnit.scala 279:57]
    SimpleAdderN_4.clock <= clock
    SimpleAdderN_4.reset <= reset
    inst SimpleAdderN_5 of SimpleAdderN_13 @[AttentionUnit.scala 279:57]
    SimpleAdderN_5.clock <= clock
    SimpleAdderN_5.reset <= reset
    inst SimpleAdderN_6 of SimpleAdderN_14 @[AttentionUnit.scala 279:57]
    SimpleAdderN_6.clock <= clock
    SimpleAdderN_6.reset <= reset
    inst SimpleAdderN_7 of SimpleAdderN_15 @[AttentionUnit.scala 279:57]
    SimpleAdderN_7.clock <= clock
    SimpleAdderN_7.reset <= reset
    inst SRAMS_4 of SRAMS_4 @[AttentionUnit.scala 282:59]
    SRAMS_4.clock <= clock
    SRAMS_4.reset <= reset
    inst SRAMS_5 of SRAMS_5 @[AttentionUnit.scala 282:59]
    SRAMS_5.clock <= clock
    SRAMS_5.reset <= reset
    inst SRAMS_6 of SRAMS_6 @[AttentionUnit.scala 282:59]
    SRAMS_6.clock <= clock
    SRAMS_6.reset <= reset
    inst SRAMS_7 of SRAMS_7 @[AttentionUnit.scala 282:59]
    SRAMS_7.clock <= clock
    SRAMS_7.reset <= reset
    node _T_27 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 297:58]
    SRAMS_4.io.raddr <= _T_27 @[AttentionUnit.scala 297:50]
    SRAMS_4.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 298:48]
    SRAMS_4.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 300:50]
    node _T_28 = gt(io.N, UInt<1>("h00")) @[AttentionUnit.scala 301:59]
    node _T_29 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 301:72]
    node _T_30 = or(_T_28, _T_29) @[AttentionUnit.scala 301:65]
    node _T_31 = not(_T_30) @[AttentionUnit.scala 301:51]
    SRAMS_4.io.wen <= _T_31 @[AttentionUnit.scala 301:48]
    node _T_32 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 302:36]
    when _T_32 : @[AttentionUnit.scala 302:44]
      SRAMS_4.io.wdata <= SimpleAdderN_4.io.Sum @[AttentionUnit.scala 303:58]
      skip @[AttentionUnit.scala 302:44]
    else : @[AttentionUnit.scala 304:36]
      SRAMS_4.io.wdata <= MM_K_queue_0.io.deq.bits @[AttentionUnit.scala 305:58]
      skip @[AttentionUnit.scala 304:36]
    io.DEBUG_K[0] <= SRAMS_4.io.rdata @[AttentionUnit.scala 308:41]
    SimpleAdderN_4.io.A[1] <= SRAMS_4.io.rdata @[AttentionUnit.scala 310:49]
    SimpleAdderN_4.io.A[0] <= MM_K_queue_0.io.deq.bits @[AttentionUnit.scala 311:49]
    SimpleAdderN_4.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 313:56]
    SimpleAdderN_4.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 314:55]
    MM_K_queue_0.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 317:48]
    node _T_33 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 297:58]
    SRAMS_5.io.raddr <= _T_33 @[AttentionUnit.scala 297:50]
    SRAMS_5.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 298:48]
    SRAMS_5.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 300:50]
    node _T_34 = gt(io.N, UInt<1>("h00")) @[AttentionUnit.scala 301:59]
    node _T_35 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 301:72]
    node _T_36 = or(_T_34, _T_35) @[AttentionUnit.scala 301:65]
    node _T_37 = not(_T_36) @[AttentionUnit.scala 301:51]
    SRAMS_5.io.wen <= _T_37 @[AttentionUnit.scala 301:48]
    node _T_38 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 302:36]
    when _T_38 : @[AttentionUnit.scala 302:44]
      SRAMS_5.io.wdata <= SimpleAdderN_5.io.Sum @[AttentionUnit.scala 303:58]
      skip @[AttentionUnit.scala 302:44]
    else : @[AttentionUnit.scala 304:36]
      SRAMS_5.io.wdata <= MM_K_queue_1.io.deq.bits @[AttentionUnit.scala 305:58]
      skip @[AttentionUnit.scala 304:36]
    io.DEBUG_K[1] <= SRAMS_5.io.rdata @[AttentionUnit.scala 308:41]
    SimpleAdderN_5.io.A[1] <= SRAMS_5.io.rdata @[AttentionUnit.scala 310:49]
    SimpleAdderN_5.io.A[0] <= MM_K_queue_1.io.deq.bits @[AttentionUnit.scala 311:49]
    SimpleAdderN_5.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 313:56]
    SimpleAdderN_5.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 314:55]
    MM_K_queue_1.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 317:48]
    node _T_39 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 297:58]
    SRAMS_6.io.raddr <= _T_39 @[AttentionUnit.scala 297:50]
    SRAMS_6.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 298:48]
    SRAMS_6.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 300:50]
    node _T_40 = gt(io.N, UInt<1>("h00")) @[AttentionUnit.scala 301:59]
    node _T_41 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 301:72]
    node _T_42 = or(_T_40, _T_41) @[AttentionUnit.scala 301:65]
    node _T_43 = not(_T_42) @[AttentionUnit.scala 301:51]
    SRAMS_6.io.wen <= _T_43 @[AttentionUnit.scala 301:48]
    node _T_44 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 302:36]
    when _T_44 : @[AttentionUnit.scala 302:44]
      SRAMS_6.io.wdata <= SimpleAdderN_6.io.Sum @[AttentionUnit.scala 303:58]
      skip @[AttentionUnit.scala 302:44]
    else : @[AttentionUnit.scala 304:36]
      SRAMS_6.io.wdata <= MM_K_queue_2.io.deq.bits @[AttentionUnit.scala 305:58]
      skip @[AttentionUnit.scala 304:36]
    io.DEBUG_K[2] <= SRAMS_6.io.rdata @[AttentionUnit.scala 308:41]
    SimpleAdderN_6.io.A[1] <= SRAMS_6.io.rdata @[AttentionUnit.scala 310:49]
    SimpleAdderN_6.io.A[0] <= MM_K_queue_2.io.deq.bits @[AttentionUnit.scala 311:49]
    SimpleAdderN_6.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 313:56]
    SimpleAdderN_6.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 314:55]
    MM_K_queue_2.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 317:48]
    node _T_45 = rem(io.D, UInt<7>("h040")) @[AttentionUnit.scala 297:58]
    SRAMS_7.io.raddr <= _T_45 @[AttentionUnit.scala 297:50]
    SRAMS_7.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 298:48]
    SRAMS_7.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 300:50]
    node _T_46 = gt(io.N, UInt<1>("h00")) @[AttentionUnit.scala 301:59]
    node _T_47 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 301:72]
    node _T_48 = or(_T_46, _T_47) @[AttentionUnit.scala 301:65]
    node _T_49 = not(_T_48) @[AttentionUnit.scala 301:51]
    SRAMS_7.io.wen <= _T_49 @[AttentionUnit.scala 301:48]
    node _T_50 = gt(io.E, UInt<1>("h00")) @[AttentionUnit.scala 302:36]
    when _T_50 : @[AttentionUnit.scala 302:44]
      SRAMS_7.io.wdata <= SimpleAdderN_7.io.Sum @[AttentionUnit.scala 303:58]
      skip @[AttentionUnit.scala 302:44]
    else : @[AttentionUnit.scala 304:36]
      SRAMS_7.io.wdata <= MM_K_queue_3.io.deq.bits @[AttentionUnit.scala 305:58]
      skip @[AttentionUnit.scala 304:36]
    io.DEBUG_K[3] <= SRAMS_7.io.rdata @[AttentionUnit.scala 308:41]
    SimpleAdderN_7.io.A[1] <= SRAMS_7.io.rdata @[AttentionUnit.scala 310:49]
    SimpleAdderN_7.io.A[0] <= MM_K_queue_3.io.deq.bits @[AttentionUnit.scala 311:49]
    SimpleAdderN_7.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 313:56]
    SimpleAdderN_7.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 314:55]
    MM_K_queue_3.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 317:48]
    wire K_valid : UInt<1> @[AttentionUnit.scala 321:27]
    node _T_51 = add(io.E, UInt<1>("h01")) @[AttentionUnit.scala 322:26]
    node _T_52 = tail(_T_51, 1) @[AttentionUnit.scala 322:26]
    node _T_53 = geq(_T_52, io.DimE) @[AttentionUnit.scala 322:32]
    K_valid <= _T_53 @[AttentionUnit.scala 322:17]
    reg mux_Q : UInt<8>[4], clock @[AttentionUnit.scala 329:24]
    reg mux_K : UInt<8>[4], clock @[AttentionUnit.scala 330:24]
    mux_Q[0] <= io.DEBUG_Q[0] @[AttentionUnit.scala 332:15]
    mux_Q[1] <= io.DEBUG_Q[1] @[AttentionUnit.scala 332:15]
    mux_Q[2] <= io.DEBUG_Q[2] @[AttentionUnit.scala 332:15]
    mux_Q[3] <= io.DEBUG_Q[3] @[AttentionUnit.scala 332:15]
    mux_K[0] <= io.DEBUG_K[0] @[AttentionUnit.scala 333:15]
    mux_K[1] <= io.DEBUG_K[1] @[AttentionUnit.scala 333:15]
    mux_K[2] <= io.DEBUG_K[2] @[AttentionUnit.scala 333:15]
    mux_K[3] <= io.DEBUG_K[3] @[AttentionUnit.scala 333:15]
    inst BaselineSystolicPE_2 of BaselineSystolicPE_2 @[AttentionUnit.scala 349:47]
    BaselineSystolicPE_2.clock <= clock
    BaselineSystolicPE_2.reset <= reset
    inst BaselineSystolicPE_3 of BaselineSystolicPE_3 @[AttentionUnit.scala 349:47]
    BaselineSystolicPE_3.clock <= clock
    BaselineSystolicPE_3.reset <= reset
    node _T_54 = and(K_valid, Q_valid) @[AttentionUnit.scala 354:49]
    BaselineSystolicPE_2.io.valid <= _T_54 @[AttentionUnit.scala 354:38]
    BaselineSystolicPE_2.io.W[0] <= mux_K[0] @[AttentionUnit.scala 358:60]
    BaselineSystolicPE_2.io.W[1] <= mux_K[1] @[AttentionUnit.scala 358:60]
    BaselineSystolicPE_2.io.X[0] <= mux_Q[0] @[AttentionUnit.scala 364:60]
    BaselineSystolicPE_2.io.X[1] <= mux_Q[1] @[AttentionUnit.scala 364:60]
    node _T_55 = and(K_valid, Q_valid) @[AttentionUnit.scala 354:49]
    BaselineSystolicPE_3.io.valid <= _T_55 @[AttentionUnit.scala 354:38]
    BaselineSystolicPE_3.io.W[0] <= mux_K[2] @[AttentionUnit.scala 358:60]
    BaselineSystolicPE_3.io.W[1] <= mux_K[3] @[AttentionUnit.scala 358:60]
    BaselineSystolicPE_3.io.X[0] <= mux_Q[2] @[AttentionUnit.scala 364:60]
    BaselineSystolicPE_3.io.X[1] <= mux_Q[3] @[AttentionUnit.scala 364:60]
    inst MM_S_queue_0 of Queue_56 @[AttentionUnit.scala 388:55]
    MM_S_queue_0.clock <= clock
    MM_S_queue_0.reset <= reset
    MM_S_queue_0.io.enq.bits <= BaselineSystolicPE_2.io.Y[0] @[AttentionUnit.scala 390:55]
    MM_S_queue_0.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_1 of Queue_57 @[AttentionUnit.scala 388:55]
    MM_S_queue_1.clock <= clock
    MM_S_queue_1.reset <= reset
    MM_S_queue_1.io.enq.bits <= BaselineSystolicPE_2.io.Y[1] @[AttentionUnit.scala 390:55]
    MM_S_queue_1.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_2 of Queue_58 @[AttentionUnit.scala 388:55]
    MM_S_queue_2.clock <= clock
    MM_S_queue_2.reset <= reset
    MM_S_queue_2.io.enq.bits <= BaselineSystolicPE_2.io.Y[2] @[AttentionUnit.scala 390:55]
    MM_S_queue_2.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_3 of Queue_59 @[AttentionUnit.scala 388:55]
    MM_S_queue_3.clock <= clock
    MM_S_queue_3.reset <= reset
    MM_S_queue_3.io.enq.bits <= BaselineSystolicPE_2.io.Y[3] @[AttentionUnit.scala 390:55]
    MM_S_queue_3.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_4 of Queue_60 @[AttentionUnit.scala 388:55]
    MM_S_queue_4.clock <= clock
    MM_S_queue_4.reset <= reset
    MM_S_queue_4.io.enq.bits <= BaselineSystolicPE_3.io.Y[0] @[AttentionUnit.scala 390:55]
    MM_S_queue_4.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_5 of Queue_61 @[AttentionUnit.scala 388:55]
    MM_S_queue_5.clock <= clock
    MM_S_queue_5.reset <= reset
    MM_S_queue_5.io.enq.bits <= BaselineSystolicPE_3.io.Y[1] @[AttentionUnit.scala 390:55]
    MM_S_queue_5.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_6 of Queue_62 @[AttentionUnit.scala 388:55]
    MM_S_queue_6.clock <= clock
    MM_S_queue_6.reset <= reset
    MM_S_queue_6.io.enq.bits <= BaselineSystolicPE_3.io.Y[2] @[AttentionUnit.scala 390:55]
    MM_S_queue_6.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst MM_S_queue_7 of Queue_63 @[AttentionUnit.scala 388:55]
    MM_S_queue_7.clock <= clock
    MM_S_queue_7.reset <= reset
    MM_S_queue_7.io.enq.bits <= BaselineSystolicPE_3.io.Y[3] @[AttentionUnit.scala 390:55]
    MM_S_queue_7.io.enq.valid <= io.valid @[AttentionUnit.scala 391:56]
    inst SimpleAdderN_8 of SimpleAdderN_24 @[AttentionUnit.scala 410:57]
    SimpleAdderN_8.clock <= clock
    SimpleAdderN_8.reset <= reset
    inst SimpleAdderN_9 of SimpleAdderN_25 @[AttentionUnit.scala 410:57]
    SimpleAdderN_9.clock <= clock
    SimpleAdderN_9.reset <= reset
    inst SimpleAdderN_10 of SimpleAdderN_26 @[AttentionUnit.scala 410:57]
    SimpleAdderN_10.clock <= clock
    SimpleAdderN_10.reset <= reset
    inst SimpleAdderN_11 of SimpleAdderN_27 @[AttentionUnit.scala 410:57]
    SimpleAdderN_11.clock <= clock
    SimpleAdderN_11.reset <= reset
    inst SimpleAdderN_12 of SimpleAdderN_28 @[AttentionUnit.scala 410:57]
    SimpleAdderN_12.clock <= clock
    SimpleAdderN_12.reset <= reset
    inst SimpleAdderN_13 of SimpleAdderN_29 @[AttentionUnit.scala 410:57]
    SimpleAdderN_13.clock <= clock
    SimpleAdderN_13.reset <= reset
    inst SimpleAdderN_14 of SimpleAdderN_30 @[AttentionUnit.scala 410:57]
    SimpleAdderN_14.clock <= clock
    SimpleAdderN_14.reset <= reset
    inst SimpleAdderN_15 of SimpleAdderN_31 @[AttentionUnit.scala 410:57]
    SimpleAdderN_15.clock <= clock
    SimpleAdderN_15.reset <= reset
    inst SRAMS_8 of SRAMS_8 @[AttentionUnit.scala 413:59]
    SRAMS_8.clock <= clock
    SRAMS_8.reset <= reset
    inst SRAMS_9 of SRAMS_9 @[AttentionUnit.scala 413:59]
    SRAMS_9.clock <= clock
    SRAMS_9.reset <= reset
    inst SRAMS_10 of SRAMS_10 @[AttentionUnit.scala 413:59]
    SRAMS_10.clock <= clock
    SRAMS_10.reset <= reset
    inst SRAMS_11 of SRAMS_11 @[AttentionUnit.scala 413:59]
    SRAMS_11.clock <= clock
    SRAMS_11.reset <= reset
    inst SRAMS_12 of SRAMS_12 @[AttentionUnit.scala 413:59]
    SRAMS_12.clock <= clock
    SRAMS_12.reset <= reset
    inst SRAMS_13 of SRAMS_13 @[AttentionUnit.scala 413:59]
    SRAMS_13.clock <= clock
    SRAMS_13.reset <= reset
    inst SRAMS_14 of SRAMS_14 @[AttentionUnit.scala 413:59]
    SRAMS_14.clock <= clock
    SRAMS_14.reset <= reset
    inst SRAMS_15 of SRAMS_15 @[AttentionUnit.scala 413:59]
    SRAMS_15.clock <= clock
    SRAMS_15.reset <= reset
    SRAMS_8.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_8.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_8.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_56 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_57 = not(_T_56) @[AttentionUnit.scala 436:59]
    SRAMS_8.io.wen <= _T_57 @[AttentionUnit.scala 436:56]
    node _T_58 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_58 : @[AttentionUnit.scala 437:52]
      SRAMS_8.io.wdata <= SimpleAdderN_8.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_8.io.wdata <= MM_S_queue_0.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[0] <= SRAMS_8.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_8.io.A[1] <= SRAMS_8.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_8.io.A[0] <= MM_S_queue_0.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_8.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_8.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_0.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_9.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_9.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_9.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_59 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_60 = not(_T_59) @[AttentionUnit.scala 436:59]
    SRAMS_9.io.wen <= _T_60 @[AttentionUnit.scala 436:56]
    node _T_61 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_61 : @[AttentionUnit.scala 437:52]
      SRAMS_9.io.wdata <= SimpleAdderN_9.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_9.io.wdata <= MM_S_queue_1.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[1] <= SRAMS_9.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_9.io.A[1] <= SRAMS_9.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_9.io.A[0] <= MM_S_queue_1.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_9.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_9.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_1.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_10.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_10.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_10.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_62 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_63 = not(_T_62) @[AttentionUnit.scala 436:59]
    SRAMS_10.io.wen <= _T_63 @[AttentionUnit.scala 436:56]
    node _T_64 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_64 : @[AttentionUnit.scala 437:52]
      SRAMS_10.io.wdata <= SimpleAdderN_10.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_10.io.wdata <= MM_S_queue_2.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[2] <= SRAMS_10.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_10.io.A[1] <= SRAMS_10.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_10.io.A[0] <= MM_S_queue_2.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_10.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_10.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_2.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_11.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_11.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_11.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_65 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_66 = not(_T_65) @[AttentionUnit.scala 436:59]
    SRAMS_11.io.wen <= _T_66 @[AttentionUnit.scala 436:56]
    node _T_67 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_67 : @[AttentionUnit.scala 437:52]
      SRAMS_11.io.wdata <= SimpleAdderN_11.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_11.io.wdata <= MM_S_queue_3.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[3] <= SRAMS_11.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_11.io.A[1] <= SRAMS_11.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_11.io.A[0] <= MM_S_queue_3.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_11.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_11.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_3.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_12.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_12.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_12.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_68 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_69 = not(_T_68) @[AttentionUnit.scala 436:59]
    SRAMS_12.io.wen <= _T_69 @[AttentionUnit.scala 436:56]
    node _T_70 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_70 : @[AttentionUnit.scala 437:52]
      SRAMS_12.io.wdata <= SimpleAdderN_12.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_12.io.wdata <= MM_S_queue_4.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[4] <= SRAMS_12.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_12.io.A[1] <= SRAMS_12.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_12.io.A[0] <= MM_S_queue_4.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_12.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_12.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_4.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_13.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_13.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_13.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_71 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_72 = not(_T_71) @[AttentionUnit.scala 436:59]
    SRAMS_13.io.wen <= _T_72 @[AttentionUnit.scala 436:56]
    node _T_73 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_73 : @[AttentionUnit.scala 437:52]
      SRAMS_13.io.wdata <= SimpleAdderN_13.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_13.io.wdata <= MM_S_queue_5.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[5] <= SRAMS_13.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_13.io.A[1] <= SRAMS_13.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_13.io.A[0] <= MM_S_queue_5.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_13.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_13.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_5.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_14.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_14.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_14.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_74 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_75 = not(_T_74) @[AttentionUnit.scala 436:59]
    SRAMS_14.io.wen <= _T_75 @[AttentionUnit.scala 436:56]
    node _T_76 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_76 : @[AttentionUnit.scala 437:52]
      SRAMS_14.io.wdata <= SimpleAdderN_14.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_14.io.wdata <= MM_S_queue_6.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[6] <= SRAMS_14.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_14.io.A[1] <= SRAMS_14.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_14.io.A[0] <= MM_S_queue_6.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_14.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_14.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_6.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    SRAMS_15.io.raddr <= UInt<1>("h00") @[AttentionUnit.scala 432:58]
    SRAMS_15.io.ren <= UInt<1>("h01") @[AttentionUnit.scala 433:56]
    SRAMS_15.io.waddr <= UInt<1>("h00") @[AttentionUnit.scala 435:58]
    node _T_77 = gt(io.O, UInt<1>("h00")) @[AttentionUnit.scala 436:67]
    node _T_78 = not(_T_77) @[AttentionUnit.scala 436:59]
    SRAMS_15.io.wen <= _T_78 @[AttentionUnit.scala 436:56]
    node _T_79 = gt(io.D, UInt<1>("h00")) @[AttentionUnit.scala 437:44]
    when _T_79 : @[AttentionUnit.scala 437:52]
      SRAMS_15.io.wdata <= SimpleAdderN_15.io.Sum @[AttentionUnit.scala 438:66]
      skip @[AttentionUnit.scala 437:52]
    else : @[AttentionUnit.scala 439:44]
      SRAMS_15.io.wdata <= MM_S_queue_7.io.deq.bits @[AttentionUnit.scala 440:66]
      skip @[AttentionUnit.scala 439:44]
    io.DEBUG_S[7] <= SRAMS_15.io.rdata @[AttentionUnit.scala 443:49]
    SimpleAdderN_15.io.A[1] <= SRAMS_15.io.rdata @[AttentionUnit.scala 445:57]
    SimpleAdderN_15.io.A[0] <= MM_S_queue_7.io.deq.bits @[AttentionUnit.scala 446:57]
    SimpleAdderN_15.io.entry.valid <= UInt<1>("h01") @[AttentionUnit.scala 447:64]
    SimpleAdderN_15.io.exit.ready <= UInt<1>("h01") @[AttentionUnit.scala 448:63]
    MM_S_queue_7.io.deq.ready <= UInt<1>("h01") @[AttentionUnit.scala 451:56]
    wire S_valid : UInt<1> @[AttentionUnit.scala 456:27]
    node _T_80 = add(io.D, UInt<1>("h01")) @[AttentionUnit.scala 457:26]
    node _T_81 = tail(_T_80, 1) @[AttentionUnit.scala 457:26]
    node _T_82 = geq(_T_81, io.DimD) @[AttentionUnit.scala 457:32]
    S_valid <= _T_82 @[AttentionUnit.scala 457:17]
    
