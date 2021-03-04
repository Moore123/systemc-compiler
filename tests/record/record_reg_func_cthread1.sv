//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: A ()
//
module A // "a"
(
    input logic clk
);

// SystemC signals
logic rstn;

//------------------------------------------------------------------------------
// Clocked THREAD: record_reg (test_reg_func_cthread1.cpp:37:5) 

// Next-state combinational logic
always_comb begin : record_reg_comb     // test_reg_func_cthread1.cpp:37:5
    record_reg_func;
end
function void record_reg_func;
    integer val;
    integer r_sin;
    integer r_cos;
    integer i;
    val = 1;
    // Call f() begin
    r_sin = 1;
    r_cos = 2;
    i = r_sin + val;
    // Call f() end
    val = 2;
    // Call f() begin
    r_sin = 1;
    r_cos = 2;
    i = r_sin + val;
    // Call f() end
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : record_reg_ff
    if ( ~rstn ) begin
    end
    else begin
    end
end

endmodule


