//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: test_referece_met ()
//
module test_referece_met // "tinst"
(
);

// SystemC signals
logic sig;
logic sigArray[2];

//------------------------------------------------------------------------------
// Method process: test_method (test_reference_met.cpp:30:5) 

// Process-local variables
logic signed [31:0] x;

always_comb 
begin : test_method     // test_reference_met.cpp:30:5
    x = sig;
    x = 2;
    sigArray[0] = 1;
    sigArray[1] = 0;
end

endmodule


