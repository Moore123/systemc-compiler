//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: B_top ()
//
module B_top // "b_mod"
(
);


//------------------------------------------------------------------------------

A a_mod
(

);

endmodule



//==============================================================================
//
// Module: A (test_stdouts_prints.cpp:101:5)
//
module A // "b_mod.a_mod"
(
);

// SystemC signals
logic dummy;

//------------------------------------------------------------------------------
// Method process: meth_print (test_stdouts_prints.cpp:48:5) 

// Process-local variables
logic signed [31:0] m;

always_comb 
begin : meth_print     // test_stdouts_prints.cpp:48:5
    integer i;
    i = m;
end

//------------------------------------------------------------------------------
// Method process: meth_printf (test_stdouts_prints.cpp:55:5) 

always_comb 
begin : meth_printf     // test_stdouts_prints.cpp:55:5
end

//------------------------------------------------------------------------------
// Method process: meth_cerr (test_stdouts_prints.cpp:63:5) 

always_comb 
begin : meth_cerr     // test_stdouts_prints.cpp:63:5
    logic a;
    a = dummy;
end

//------------------------------------------------------------------------------
// Method process: meth_cout (test_stdouts_prints.cpp:69:5) 

always_comb 
begin : meth_cout     // test_stdouts_prints.cpp:69:5
    integer i;
end

//------------------------------------------------------------------------------
// Method process: meth_cin (test_stdouts_prints.cpp:77:5) 

always_comb 
begin : meth_cin     // test_stdouts_prints.cpp:77:5
    integer i;
end

//------------------------------------------------------------------------------
// Method process: meth_sc_print (test_stdouts_prints.cpp:82:5) 

always_comb 
begin : meth_sc_print     // test_stdouts_prints.cpp:82:5
end

//------------------------------------------------------------------------------
// Method process: meth_sc_dump (test_stdouts_prints.cpp:87:5) 

always_comb 
begin : meth_sc_dump     // test_stdouts_prints.cpp:87:5
end

//------------------------------------------------------------------------------
// Method process: meth_sc_kind (test_stdouts_prints.cpp:92:5) 

always_comb 
begin : meth_sc_kind     // test_stdouts_prints.cpp:92:5
end

endmodule


