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

// SystemC signals
logic a;
logic b;
logic c;


//------------------------------------------------------------------------------

A a_mod
(
  .a(a),
  .b(b),
  .c(c)
);

endmodule



//==============================================================================
//
// Module: A (test_bool.cpp:218:5)
//
module A // "b_mod.a_mod"
(
    input logic a,
    output logic b,
    output logic c
);

// SystemC signals
logic s;
logic ps;

//------------------------------------------------------------------------------
// Method process: test_bool_to_bool (test_bool.cpp:57:5) 

always_comb 
begin : test_bool_to_bool     // test_bool.cpp:57:5
    logic b1;
    logic b2;
    b1 = a;
    b1 = a;
    b2 = b1;
    b2 = b1;
    b = b1;
    b = b1;
    b = a;
    b = a;
    b = a;
    b = a;
    s = b;
    s = b1;
    b = s;
    b = s;
    ps = b1;
    ps = b;
    b = ps;
    b = ps;
end

//------------------------------------------------------------------------------
// Method process: test_bool_unary (test_bool.cpp:82:5) 

always_comb 
begin : test_bool_unary     // test_bool.cpp:82:5
    integer unsigned i;
    logic b_1;
    i = 2;
    b_1 = |i;
    b_1 = |(-i);
    b_1 = |(i++);
    b_1 = |(--i);
end

//------------------------------------------------------------------------------
// Method process: test_sc_to_bool (test_bool.cpp:92:5) 

// Process-local variables
logic [4:0] px;

always_comb 
begin : test_sc_to_bool     // test_bool.cpp:92:5
    logic b1;
    logic [2:0] x;
    x = 0;
    b1 = x[1];
    b1 = |x[2 : 1];
    b1 = |x;
    b1 = px[1];
    b1 = |px[2 : 1];
    b1 = |px;
    b1 = |(px + x);
    s = x[1];
    s = |x[2 : 1];
    s = |x;
    ps = x[1];
    ps = |x[2 : 1];
    ps = |x;
end

//------------------------------------------------------------------------------
// Method process: test_ptr_comp (test_bool.cpp:116:5) 

// Process-local variables
logic signed [31:0] p1;

always_comb 
begin : test_ptr_comp     // test_bool.cpp:116:5
    logic b_1;
    b_1 = 1;
    b_1 = 0;
    b_1 = 0;
    b_1 = 1;
    b_1 = 0;
    b_1 = 1;
    b_1 = 0;
    b_1 = 1;
    b_1 = 1;
    b_1 = 0;
    b_1 = 1;
    b_1 = 0;
end

//------------------------------------------------------------------------------
// Method process: test_int_comp (test_bool.cpp:136:5) 

// Process-local variables
logic signed [31:0] p2;

always_comb 
begin : test_int_comp     // test_bool.cpp:136:5
    logic b1;
    integer i;
    logic [3:0] x;
    x = 0;
    b1 = i == 0;
    b1 = x > 1;
    b1 = i != x;
    b = i < 3;
    b = x >= i;
    s = x == i;
    s = p2 > 0;
    ps = x != 0;
    ps = i == p2;
end

//------------------------------------------------------------------------------
// Method process: test_sc_comp (test_bool.cpp:156:5) 

always_comb 
begin : test_sc_comp     // test_bool.cpp:156:5
    logic b1;
    logic signed [3:0] x;
    logic signed [11:0] ux;
    logic b2;
    x = 0;
    ux = 0;
    b2 = b1 == ux;
    b2 = b1 == x;
end

//------------------------------------------------------------------------------
// Method process: test_bool1 (test_bool.cpp:166:5) 

// Process-local variables
logic signed [31:0] m;

always_comb 
begin : test_bool1     // test_bool.cpp:166:5
    integer unsigned i;
    logic b1;
    i = 2;
    b1 = 1;
    b1 = |i;
    b1 = |i;
    b1 = |i;
    b1 = |(i + 1);
    b1 = |(|i + 1);
    b1 = |(a ? m : m == i);
    b1 = |m ? |(++m) : m > 0;
end

//------------------------------------------------------------------------------
// Method process: test_bool2 (test_bool.cpp:180:5) 

always_comb 
begin : test_bool2     // test_bool.cpp:180:5
    logic [3:0] x;
    logic b_1;
    x = 6;
    b_1 = x[2];
    b_1 = |x[3 : 1];
    b_1 = |x;
    b_1 = !(|x);
    b_1 = !x[2];
    b_1 = !(|x[3 : 1]);
    b_1 = |(x + x[3 : 1]);
end

//------------------------------------------------------------------------------
// Method process: test_bool4 (test_bool.cpp:194:5) 

// Process-local variables
logic signed [31:0] p;

always_comb 
begin : test_bool4     // test_bool.cpp:194:5
    integer unsigned i;
    if (1)
    begin
        i = 1;
    end
    if (1)
    begin
        i = 2;
    end
    if (1)
    begin
        i = 3;
    end
    if (1)
    begin
        i = 4;
    end
end

endmodule


