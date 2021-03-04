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

AA a_mod
(
  .a(a),
  .b(b),
  .c(c)
);

endmodule



//==============================================================================
//
// Module: AA (test_binary_sc_types.cpp:162:5)
//
module AA // "b_mod.a_mod"
(
    input logic a,
    output logic b,
    output logic c
);

// SystemC signals

//------------------------------------------------------------------------------
// Method process: tilda (test_binary_sc_types.cpp:48:5) 

always_comb 
begin : tilda     // test_binary_sc_types.cpp:48:5
    logic signed [9:0] A;
    logic signed [63:0] bn;
    logic [15:0] ad;
    logic [15:0] wd;
    A = 0;
    bn = ~A;
    ad = 'hABCD;
    wd = 0;
    wd[0] = ~ad[8];
    wd[1] = ~ad[9];
    wd[2] = ~ad[10];
    wd[3] = ~ad[11];
end

//------------------------------------------------------------------------------
// Method process: sc_signed_ops_neg_consts_fns (test_binary_sc_types.cpp:132:4) 

always_comb 
begin : sc_signed_ops_neg_consts_fns     // test_binary_sc_types.cpp:132:4
    logic signed [9:0] par1;
    logic signed [11:0] par2;
    logic [21:0] par3;
    logic [29:0] par4;
    logic signed [15:0] par5;
    logic signed [13:0] par6;
    logic [21:0] par7;
    logic [21:0] par8;
    logic signed [31:0] par9;
    logic signed [63:0] par10;
    logic signed [63:0] par11;
    logic signed [63:0] par12;
    logic signed [31:0] par13;
    logic signed [31:0] par14;
    logic signed [31:0] par15;
    logic signed [31:0] par16;
    logic signed [31:0] par17;
    logic signed [9:0] par18;
    logic signed [31:0] par19;
    logic signed [31:0] par20;
    logic signed [31:0] par21;
    logic signed [9:0] par22;
    logic signed [9:0] A;
    logic signed [11:0] B;
    logic signed [15:0] E;
    logic signed [13:0] F;
    logic eq;
    logic lll;
    logic neq;
    logic lt;
    logic gte;
    logic lte;
    logic gt;
    logic signed [63:0] sum;
    logic signed [63:0] diff;
    logic signed [63:0] mult;
    logic signed [63:0] div;
    logic signed [63:0] ba;
    logic signed [63:0] bo;
    logic signed [63:0] bx;
    logic signed [63:0] bn;
    logic signed [9:0] par1_1;
    logic signed [11:0] par2_1;
    logic signed [21:0] par3_1;
    logic signed [29:0] par4_1;
    logic signed [15:0] par5_1;
    logic signed [13:0] par6_1;
    logic signed [21:0] par7_1;
    logic signed [21:0] par8_1;
    logic signed [31:0] par9_1;
    logic signed [63:0] par10_1;
    logic signed [63:0] par11_1;
    logic signed [63:0] par12_1;
    logic signed [31:0] par13_1;
    logic signed [31:0] par14_1;
    logic signed [31:0] par15_1;
    logic signed [31:0] par16_1;
    logic signed [63:0] par17_1;
    logic signed [54:0] par18_1;
    logic signed [39:0] par19_1;
    logic signed [31:0] par20_1;
    logic signed [31:0] par21_1;
    logic signed [9:0] par22_1;
    logic signed [9:0] A_1;
    logic signed [11:0] B_1;
    logic signed [15:0] E_1;
    logic signed [13:0] F_1;
    logic eq_1;
    logic lll_1;
    logic neq_1;
    logic lt_1;
    logic gte_1;
    logic lte_1;
    logic gt_1;
    logic signed [63:0] sum_1;
    logic signed [63:0] diff_1;
    logic signed [63:0] mult_1;
    logic signed [63:0] div_1;
    logic signed [63:0] ba_1;
    logic signed [63:0] bo_1;
    logic signed [63:0] bx_1;
    logic signed [63:0] bn_1;
    par1 = -10'sd5; par2 = -12'sd5; par3 = 22'd1; par4 = 30'd0; par5 = -16'sd10; par6 = -14'sd5; par7 = 22'd0; par8 = 22'd1; par9 = -32'sd10; par10 = 64'd50; par11 = 64'd2; par12 = -64'sd15; par13 = -32'sd5; par14 = -32'sd5; par15 = 32'd0; par16 = 32'd4; par17 = 32'd1; par18 = 10'd1; par19 = 32'd0; par20 = -32'sd5; par21 = -32'sd5; par22 = 10'd0;
    // Call sc_signed_ops_neg_consts() begin
    A = par1;
    B = par2;
    E = par5;
    F = par6;
    eq = (A == B);
    lll = (eq == par3);
    assert (eq == par3) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    neq = (A != B);
    assert (neq == par4) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    lt = E > F;
    gte = A >= B;
    lte = A <= B;
    assert (gte == par17) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (lte == par18) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (lt == par7) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    gt = E < F;
    assert (gt == par8) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    sum = A + B;
    diff = A - B;
    assert (sum == par9) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    sum = sum + B;
    assert (sum == par12) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (diff == par19) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    mult = E * F;
    div = E / F;
    assert (mult == par10) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (div == par11) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    ba = A & B;
    assert (ba == par13) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bo = A | B;
    assert (bo == par14) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bx = A ^ B;
    assert (bx == par15) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bn = ~A;
    bo = bo & A;
    assert (bo == par20) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    ba = ba | bo;
    assert (bo == par21) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bo = bo ^ A;
    assert (bo == par22) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    // Call sc_signed_ops_neg_consts() end
    par1_1 = 10'd0; par2_1 = -12'sd5; par3_1 = 22'd0; par4_1 = 30'd1; par5_1 = 16'd0; par6_1 = -14'sd10; par7_1 = 22'd1; par8_1 = 22'd0; par9_1 = -32'sd5; par10_1 = 64'd0; par11_1 = 64'd0; par12_1 = -64'sd10; par13_1 = 32'd0; par14_1 = -32'sd5; par15_1 = -32'sd5; par16_1 = -32'sd1; par17_1 = 64'd1; par18_1 = 55'd0; par19_1 = 40'd5; par20_1 = 32'd0; par21_1 = 32'd0; par22_1 = 10'd0;
    // Call sc_signed_ops_neg_consts() begin
    A_1 = par1_1;
    B_1 = par2_1;
    E_1 = par5_1;
    F_1 = par6_1;
    eq_1 = (A_1 == B_1);
    lll_1 = (eq_1 == par3_1);
    assert (eq_1 == par3_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    neq_1 = (A_1 != B_1);
    assert (neq_1 == par4_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    lt_1 = E_1 > F_1;
    gte_1 = A_1 >= B_1;
    lte_1 = A_1 <= B_1;
    assert (gte_1 == par17_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (lte_1 == par18_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (lt_1 == par7_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    gt_1 = E_1 < F_1;
    assert (gt_1 == par8_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    sum_1 = A_1 + B_1;
    diff_1 = A_1 - B_1;
    assert (sum_1 == par9_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    sum_1 = sum_1 + B_1;
    assert (sum_1 == par12_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (diff_1 == par19_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    mult_1 = E_1 * F_1;
    div_1 = E_1 / F_1;
    assert (mult_1 == par10_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    assert (div_1 == par11_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    ba_1 = A_1 & B_1;
    assert (ba_1 == par13_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bo_1 = A_1 | B_1;
    assert (bo_1 == par14_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bx_1 = A_1 ^ B_1;
    assert (bx_1 == par15_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bn_1 = ~A_1;
    bo_1 = bo_1 & A_1;
    assert (bo_1 == par20_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    ba_1 = ba_1 | bo_1;
    assert (bo_1 == par21_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    bo_1 = bo_1 ^ A_1;
    assert (bo_1 == par22_1) else $error("Assertion failed at test_binary_sc_types.cpp:39:24>");
    // Call sc_signed_ops_neg_consts() end
end

endmodule


