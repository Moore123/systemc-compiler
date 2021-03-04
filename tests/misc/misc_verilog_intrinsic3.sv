//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: testbench ()
//
module testbench // "tb_inst"
(
);

// SystemC signals
logic clock_gen;
logic arstn;
logic [31:0] din;
logic [31:0] tmp0;
logic [31:0] tmp1;
logic [31:0] dout;

//------------------------------------------------------------------------------
// Clocked THREAD: test_thread (test_verilog_intrinsic3.cpp:113:5) 

// Thread-local variables
logic test_thread_PROC_STATE;
logic test_thread_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : test_thread_comb     // test_verilog_intrinsic3.cpp:113:5
    test_thread_func;
end
function void test_thread_func;
    test_thread_PROC_STATE_next = test_thread_PROC_STATE;
    
    case (test_thread_PROC_STATE)
        default : begin
            test_thread_PROC_STATE_next = 0; return;    // test_verilog_intrinsic3.cpp:117:9;
        end
        0: begin
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clock_gen) 
begin : test_thread_ff
    begin
        test_thread_PROC_STATE <= test_thread_PROC_STATE_next;
    end
end


//------------------------------------------------------------------------------

my_register reg0
(
  .clk(clock_gen),
  .arstn(arstn),
  .din(din),
  .dout(tmp0)
);

my_register reg1
(
  .clk(clock_gen),
  .arstn(arstn),
  .din(tmp0),
  .dout(tmp1)
);

my_register reg2
(
  .clk(clock_gen),
  .arstn(arstn),
  .din(tmp1),
  .dout(dout)
);

empty_intrinsic empty1
(
  .clk(clock_gen)
);

empty_intrinsic empty2
(
  .clk(clock_gen)
);

endmodule



//==============================================================================
//
// Verilog intrinsic for module: my_register (test_verilog_intrinsic3.cpp:81:5)
//
module my_register (
    input  logic        clk,
    input  logic        arstn,
    input  logic [31:0] din,
    output logic [31:0] dout
);


always_ff @(posedge clk or negedge arstn) begin
    if (~arstn) begin
        dout <= 0;
    end else
    begin
        dout <= din;
    end
end

endmodule

