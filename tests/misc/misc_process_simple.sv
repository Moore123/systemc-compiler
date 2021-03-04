//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: MyModule ()
//
module MyModule // "tb_inst.top_mod"
(
    input logic in,
    output logic out
);

// SystemC signals
logic signed [31:0] sig;

//------------------------------------------------------------------------------
// Method process: methodProc (test_process_simple.cpp:20:5) 

always_comb 
begin : methodProc     // test_process_simple.cpp:20:5
    logic b;
    b = in;
    if (sig != 0)
    begin
        out = b;
    end else begin
        out = 0;
    end
end

endmodule


