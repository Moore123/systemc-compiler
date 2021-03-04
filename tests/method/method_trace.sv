//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: ports_arrays ()
//
module ports_arrays // "PORT_ARRAY"
(
    input logic [1:0] a[4],
    input logic [1:0] b[4],
    output logic [2:0] o[4]
);

//------------------------------------------------------------------------------
// Method process: body (test_trace.cpp:38:3) 

always_comb 
begin : body     // test_trace.cpp:38:3
    integer i;
    for (i = 0; i < 4; i++)
    begin
        o[i] = a[i] + b[i];
    end
end

endmodule


