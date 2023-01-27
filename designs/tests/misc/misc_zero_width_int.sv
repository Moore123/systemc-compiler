//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.5.5
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: MyModule ()
//
module MyModule // "top_mod"
(
);

// Variables generated for SystemC signals
logic [7:0] s;

//------------------------------------------------------------------------------
// Method process: varProc (test_zero_width_int.cpp:40:5) 

always_comb 
begin : varProc     // test_zero_width_int.cpp:40:5
    integer l;
    integer j;
    l = 0;
    l = 0;
    l = 0 + 1;
    l = 0 - 0;
    l = 2 * (0 + 1);
    j = 0; l = j;
    l = 0;
    l = 0;
end

//------------------------------------------------------------------------------
// Method process: concatProc (test_zero_width_int.cpp:76:5) 

always_comb 
begin : concatProc     // test_zero_width_int.cpp:76:5
    logic [3:0] a;
    logic [15:0] c;
    logic signed [3:0] i;
    logic signed [22:0] bi;
    a = 'hF;
    c = 0;
    c = {a, 1'd1};
    c = {a, 1'd1};
    c = 0;
    c = a;
    c = a;
    c = a;
    c = {a, a};
    c = {a, a};
    c = a;
    c = a;
    c = a;
    c = {a, a};
    c = {a, a};
    c = {a, 10'd0};
    c = 10'd11;
    i = 0;
    bi = 0;
    c = i;
    c = bi;
    c = {i, bi};
end

//------------------------------------------------------------------------------
// Method process: unaryProc (test_zero_width_int.cpp:125:5) 

always_comb 
begin : unaryProc     // test_zero_width_int.cpp:125:5
    logic [9:0] u;
    logic signed [9:0] i;
    integer l;
    u = 0;
    i = 0;
    u = 0;
    i = 0;
    u = 0;
    i = 0;
    i = 1;
    u = 1;
    l = 0;
    l = 1;
    l = 0;
    i = 0 + 1;
end

//------------------------------------------------------------------------------
// Method process: compoundProc (test_zero_width_int.cpp:148:5) 

always_comb 
begin : compoundProc     // test_zero_width_int.cpp:148:5
    logic [9:0] u;
    logic signed [9:0] i;
    integer l;
    logic b;
    u = 2;
    i = 3;
    l = 0;
    l = l - 0;
    i = i >>> 0;
    u = u & 0;
end

//------------------------------------------------------------------------------
// Method process: binaryProc (test_zero_width_int.cpp:165:5) 

always_comb 
begin : binaryProc     // test_zero_width_int.cpp:165:5
    integer l;
    logic [9:0] u;
    logic signed [9:0] i;
    logic [9:0] bu;
    logic signed [9:0] bi;
    logic signed [9:0] l1;
    logic [9:0] l2;
    logic [9:0] nu;
    u = 2;
    i = 3;
    bu = 4;
    bi = 5;
    l = 0 + 0;
    l = u + 0;
    l = 0 + i;
    l = 0 + 3;
    l = 2 * 0;
    l1 = 10'(l / bi);
    l2 = 10'((0 + 1) * bu);
    l = 0;
    l = 0;
    l = 0 >>> u;
    l = u >>> 0;
    l = 0 <<< i;
    l = 0 <<< 0;
    nu = 0;
    l = s;
    l = 0;
end

//------------------------------------------------------------------------------
// Method process: castProc (test_zero_width_int.cpp:214:5) 

always_comb 
begin : castProc     // test_zero_width_int.cpp:214:5
    integer l;
    l = 0;
    l = 0;
    l = 1;
    l = 0;
    l = 0;
    l = 0;
    l = 0;
    l = 0;
    l = 0 + 1;
    l = 0;
end

//------------------------------------------------------------------------------
// Method process: partSelProc (test_zero_width_int.cpp:248:5) 

always_comb 
begin : partSelProc     // test_zero_width_int.cpp:248:5
    integer l;
    logic [9:0] u;
    logic signed [9:0] i;
    logic [9:0] bu;
    logic signed [9:0] bi;
    u = 0;
    i = 0;
    bu = 0;
    bi = 0;
    l = 0;
    u = 0;
    bi = 0;
    l = 0;
    i = 0;
    bu = 0;
end

//------------------------------------------------------------------------------
// Method process: compareProc (test_zero_width_int.cpp:278:5) 

always_comb 
begin : compareProc     // test_zero_width_int.cpp:278:5
    logic l;
    logic [9:0] u;
    logic signed [9:0] i;
    logic [9:0] bu;
    logic signed [9:0] bi;
    u = 1;
    i = 2;
    bu = 3;
    bi = 4;
    l = 0 == 0;
    l = 0 == u;
    l = 0 != i;
    l = 0 == bu;
    l = bu > 0;
    l = bi != 0;
end

//------------------------------------------------------------------------------
// Method process: arrProc (test_zero_width_int.cpp:317:5) 

always_comb 
begin : arrProc     // test_zero_width_int.cpp:317:5
    integer unsigned k;
    integer l;
    integer j;
    k = s;
    l = 0;
    l = 0;
    l = 0 + 1;
    l = 0 - 0;
    l = 2 * (0 + 1);
    j = 0; l = j;
    l = 0;
    l = 0;
    l = 0;
    l = 0;
end

//------------------------------------------------------------------------------
// Method process: recSomeProc (test_zero_width_int.cpp:375:5) 

// Process-local variables
logic [31:0] mr_mu;

always_comb 
begin : recSomeProc     // test_zero_width_int.cpp:375:5
    integer unsigned k;
    integer unsigned lr_mu;
    integer unsigned lr2_mu;
    integer unsigned par;
    integer unsigned lr3_mu;
    integer unsigned lr4_mu;
    integer l;
    integer j;
    k = s;
    par = 42;
    lr3_mu = par;
    par = 42;
    lr4_mu = par;
    lr_mu = mr_mu;
    l = 0;
    l = 0;
    l = 0;
    l = 0 + lr_mu;
    l = mr_mu + 0;
    l = 0 + 0;
    mr_mu = lr_mu + 0;
    j = 0; l = j;
    l = 0;
    l = 0;
end

//------------------------------------------------------------------------------
// Method process: recAllProc (test_zero_width_int.cpp:409:5) 

always_comb 
begin : recAllProc     // test_zero_width_int.cpp:409:5
    integer unsigned k;
    integer unsigned par;
    integer l;
    integer j;
    k = s;
    par = 42;
    par = 42;
    l = 0;
    l = 0;
    l = 0;
    l = 0 + 1;
    l = 2 + 0;
    l = 0 + 0;
    j = 0; l = j;
    l = 0;
    l = 0;
end

//------------------------------------------------------------------------------
// Method process: recArrProc (test_zero_width_int.cpp:444:5) 

// Process-local variables
logic [31:0] sarr_mu[3];

always_comb 
begin : recArrProc     // test_zero_width_int.cpp:444:5
    integer unsigned k;
    integer unsigned lsarr_mu[3];
    k = s;
    sarr_mu[0] = lsarr_mu[1];
    sarr_mu[k + 1] = lsarr_mu[k];
end

endmodule

