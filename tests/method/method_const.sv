//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.7
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
// Module: A (test_const.cpp:547:5)
//
module A // "b_mod.a_mod"
(
);

// SystemC signals
logic [2:0] a;
logic clk;
logic arstn;
logic [31:0] sig1;

// C++ data variables
localparam logic [31:0] ARR[5] = '{ 'd1, 'd2, 'd3, 'd4, 'd5 };
localparam logic signed [31:0] ARR0[4] = '{ 'd1, 'd2, 'd3, 'd4 };

//------------------------------------------------------------------------------
// Method process: std_min_max (test_const.cpp:135:5) 

always_comb 
begin : std_min_max     // test_const.cpp:135:5
    logic [2:0] d;
    d = 0;
    d = a[3 : 2];
    d = a[3 : 2];
    d = a[3 : 2];
end

//------------------------------------------------------------------------------
// Method process: long_literal (test_const.cpp:162:5) 

always_comb 
begin : long_literal     // test_const.cpp:162:5
    logic signed [63:0] v1;
    logic signed [63:0] v2;
    logic signed [63:0] v3;
    logic signed [63:0] v4;
    logic signed [63:0] v5;
    logic signed [63:0] v6;
    logic [63:0] v7;
    logic signed [63:0] v8;
    logic [63:0] TMP_0;
    logic [63:0] r1;
    logic signed [63:0] TMP_2;
    logic signed [63:0] r2;
    logic [63:0] TMP_4;
    logic [2:0] asize;
    logic [63:0] r3;
    logic [63:0] TMP_6;
    logic [63:0] r4;
    v1 = -32'sd2147483647;
    v2 = -33'sh80000000;
    v3 = -33'sh80000001;
    v4 = 2147483647;
    v5 = 'h80000000;
    v6 = 'h80000001;
    v7 = 'hFFFFFFFFFFFFFFFF;
    v8 = -64'sh7FFFFFFFFFFFFFFF;
    // Call long_return() begin
    TMP_0 = 'hFFFFFFFFFFFFFFFF;
    // Call long_return() end
    r1 = TMP_0;
    // Call long_neg_return() begin
    TMP_2 = -64'sh7FFFFFFFFFFFFFFF;
    // Call long_neg_return() end
    r2 = TMP_2;
    asize = a;
    // Call case_long_return() begin
    case (asize)
    0 : begin
        TMP_4 = 1;
    end
    1 : begin
        TMP_4 = 'h3;
    end
    default : begin
        TMP_4 = 'hFFFFFFFFFFFFFFFF;
    end
    endcase
    // Call case_long_return() end
    r3 = TMP_4;
    asize = a;
    // Call case_long_return() begin
    case (asize)
    0 : begin
        TMP_6 = 1;
    end
    1 : begin
        TMP_6 = 'h3;
    end
    default : begin
        TMP_6 = 'hFFFFFFFFFFFFFFFF;
    end
    endcase
    // Call case_long_return() end
    r4 = TMP_6 <<< a;
end

//------------------------------------------------------------------------------
// Method process: long_literal2 (test_const.cpp:183:5) 

always_comb 
begin : long_literal2     // test_const.cpp:183:5
    logic signed [63:0] par1;
    logic signed [31:0] par1_1;
    par1 = 'h80000000;
    par1 = -33'sh80000000;
    par1_1 = 32'h80000000;
    par1_1 = -32'sh80000000;
end

//------------------------------------------------------------------------------
// Method process: signed_long_literal (test_const.cpp:191:5) 

always_comb 
begin : signed_long_literal     // test_const.cpp:191:5
    logic signed [63:0] v1;
    logic signed [63:0] v2;
    logic signed [63:0] v3;
    logic signed [63:0] v4;
    logic signed [63:0] w1;
    logic signed [63:0] w2;
    logic signed [63:0] x1;
    logic signed [63:0] x2;
    logic signed [63:0] x3;
    logic signed [63:0] x4;
    logic signed [63:0] y1;
    logic signed [63:0] y2;
    logic signed [63:0] y3;
    logic signed [63:0] y4;
    logic signed [63:0] y5;
    logic signed [63:0] y6;
    logic signed [63:0] y7;
    v1 = 42;
    v2 = -7'sd42;
    v3 = -7'sd42;
    v4 = 42;
    w1 = 1 - (-7'sd42);
    w2 = 42 - 42;
    x1 = 33'h80000000;
    x2 = -33'sh80000000;
    x3 = -33'sh80000000;
    x4 = 33'h80000000;
    y1 = 33'h80000000;
    y2 = -33'sh80000000;
    y3 = -33'sh80000000;
    y4 = 33'h80000000;
    y5 = 33'h80000000;
    y6 = -33'sh80000000;
    y7 = -33'sh80000000;
end

//------------------------------------------------------------------------------
// Method process: smem_if_loop_const (test_const.cpp:217:5) 

always_comb 
begin : smem_if_loop_const     // test_const.cpp:217:5
    integer k_1;
    k_1 = 0;
end

//------------------------------------------------------------------------------
// Method process: cout_test (test_const.cpp:233:5) 

always_comb 
begin : cout_test     // test_const.cpp:233:5
    logic TMP_0;
    logic val;
    val = 1;
    // Call g() begin
    TMP_0 = !val;
    // Call g() end
end

//------------------------------------------------------------------------------
// Method process: template1 (test_const.cpp:239:5) 

always_comb 
begin : template1     // test_const.cpp:239:5
    integer i;
    i = 3;
    i = 1;
    i = 10;
    i = 2 * 10 + 3 * 12;
end

//------------------------------------------------------------------------------
// Method process: const1 (test_const.cpp:248:5) 

always_comb 
begin : const1     // test_const.cpp:248:5
    integer i;
    i = 1;
    i = 2 + 3;
    i = 1 + 12;
    i = 5;
end

//------------------------------------------------------------------------------
// Method process: const2 (test_const.cpp:266:5) 

always_comb 
begin : const2     // test_const.cpp:266:5
    logic b;
    integer i;
    b = 1;
    b = 0;
    i = 4;
    i = 5;
    i = 12;
    i = (4 >>> 2) + 1;
end

//------------------------------------------------------------------------------
// Method process: const_array (test_const.cpp:290:5) 

always_comb 
begin : const_array     // test_const.cpp:290:5
    integer m[3];
    integer A[3];
    integer i;
    A[0] = 1; A[1] = 2; A[2] = 3;
    i = 2;
    i = 3;
    i = ARR[4];
    m[1] = 1;
    i = m[1];
    m[2] = 1 + 1 + ARR[0];
end

//------------------------------------------------------------------------------
// Method process: sign_const (test_const.cpp:304:5) 

always_comb 
begin : sign_const     // test_const.cpp:304:5
    integer i;
    integer unsigned j;
    logic [2:0] y;
    logic signed [2:0] x_1;
    logic b2;
    logic b4;
    logic b6;
    i = 5;
    i = -3'sd2;
    j = 5;
    j = -3'sd2;
    y = 5;
    y = -3'sd2;
    x_1 = 3'sd5;
    x_1 = -3'sd2;
    i = 5 * j + (-3'sd2);
    b2 = 1;
    b4 = 0;
    b6 = 0;
end

//------------------------------------------------------------------------------
// Method process: cond_stmt_const (test_const.cpp:334:5) 

always_comb 
begin : cond_stmt_const     // test_const.cpp:334:5
    logic b5;
    logic b6;
    logic b7;
    logic b8;
    b5 = 0;
    b6 = 1;
    b7 = 1;
    b8 = 1;
end

//------------------------------------------------------------------------------
// Method process: int_const_expr (test_const.cpp:344:5) 

always_comb 
begin : int_const_expr     // test_const.cpp:344:5
    integer unsigned u2;
    integer unsigned u3;
    logic signed [4:0] x4;
    u2 = 16 + 4;
    u3 = 5;
    x4 = 5 + 5'sd15;
end

//------------------------------------------------------------------------------
// Method process: switch_const (test_const.cpp:368:5) 

always_comb 
begin : switch_const     // test_const.cpp:368:5
    integer k_1;
    k_1 = 0;
    case (4)
    1 : begin
    end
    4 : begin
        k_1 = 2;
    end
    default : begin
    end
    endcase
end

//------------------------------------------------------------------------------
// Method process: cond_const (test_const.cpp:387:5) 

always_comb 
begin : cond_const     // test_const.cpp:387:5
    integer a_1;
    logic b1;
    logic b2;
    integer unsigned b3;
    a_1 = 1;
    b1 = 1;
    b2 = 1;
    b3 = 2;
end

//------------------------------------------------------------------------------
// Method process: loop_const (test_const.cpp:395:5) 

always_comb 
begin : loop_const     // test_const.cpp:395:5
    integer k_1;
    integer i;
    integer j;
    integer i_2;
    k_1 = 0;
    i = 0;
    for (integer i = 0; i < 2; i++)
    begin
        if (|i)
        begin
            k_1 = 2;
        end
    end
    j = 0;
    j = 1;
    if (1)
    begin
        k_1 = 3;
    end
    i_2 = 4;
end

//------------------------------------------------------------------------------
// Method process: sc_type_const (test_const.cpp:276:5) 

always_comb 
begin : sc_type_const     // test_const.cpp:276:5
    logic signed [7:0] x2;
    logic signed [15:0] y2;
    x2 = 2;
    y2 = 0;
end

//------------------------------------------------------------------------------
// Method process: local_static_const (test_const.cpp:431:5) 

always_comb 
begin : local_static_const     // test_const.cpp:431:5
    integer i;
    i = 5 + 1;
end

//------------------------------------------------------------------------------
// Clocked THREAD: local_static_const1 (test_const.cpp:439:5) 

// Thread-local constants
logic [31:0] CONST_E;

// Next-state combinational logic
always_comb begin : local_static_const1_comb     // test_const.cpp:439:5
    local_static_const1_func;
end
function void local_static_const1_func;
    integer i;
    integer unsigned CONST_F;
    i = CONST_E;
    CONST_F = sig1;
    i = CONST_E + CONST_F;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : local_static_const1_ff
    if ( ~arstn ) begin
        CONST_E = sig1;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: local_static_const2 (test_const.cpp:451:5) 

// Next-state combinational logic
always_comb begin : local_static_const2_comb     // test_const.cpp:451:5
    local_static_const2_func;
end
function void local_static_const2_func;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : local_static_const2_ff
    if ( ~arstn ) begin
        logic [4:0] j;
        logic [5:0] jj;
        j = 0;
        jj = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: local_static_const3 (test_const.cpp:474:5) 

// Next-state combinational logic
always_comb begin : local_static_const3_comb     // test_const.cpp:474:5
    local_static_const3_func;
end
function void local_static_const3_func;
    integer unsigned TMP_0;
    integer unsigned CONST_G1;
    integer i;
    integer unsigned TMP_2;
    integer unsigned CONST_H1;
    // Call f2() begin
    CONST_H1 = sig1;
    TMP_2 = CONST_H1 + 2;
    // Call f2() end
    i = TMP_2;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : local_static_const3_ff
    if ( ~arstn ) begin
        integer unsigned TMP_0;
        integer unsigned CONST_G1;
        integer i;
        // Call f1() begin
        CONST_G1 = sig1;
        TMP_0 = CONST_G1 + 1;
        // Call f1() end
        i = TMP_0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Method process: neg_literal (test_const.cpp:484:5) 

always_comb 
begin : neg_literal     // test_const.cpp:484:5
    logic signed [127:0] i;
    i = -5'sd10;
end

//------------------------------------------------------------------------------
// Method process: binary_const_pointers (test_const.cpp:489:5) 

// Process-local variables
logic signed [31:0] p2;

always_comb 
begin : binary_const_pointers     // test_const.cpp:489:5
    logic b1;
    logic b2;
    logic b3;
    logic b4;
    b1 = 0;
    b2 = 1;
    b1 = 1 && |p2;
    b2 = 0 || |p2;
    b3 = 0;
    b4 = 1;
end

//------------------------------------------------------------------------------
// Method process: pointer_to_const (test_const.cpp:504:5) 

// Process-local variables
logic signed [31:0] c5;

always_comb 
begin : pointer_to_const     // test_const.cpp:504:5
    integer j;
    j = 1 + 43 + c5;
    j = 1;
    j = 43;
    c5 = 2;
    j = c5;
end

//------------------------------------------------------------------------------
// Method process: const_func_call (test_const.cpp:519:5) 

always_comb 
begin : const_func_call     // test_const.cpp:519:5
    integer unsigned TMP_0;
    integer unsigned val;
    integer unsigned u1;
    integer unsigned u2;
    val = 1;
    // Call f1() begin
    TMP_0 = 1 + 1;
    // Call f1() end
    u1 = TMP_0;
    u2 = u1;
end

//------------------------------------------------------------------------------
// Method process: sc_int_func (test_const.cpp:526:5) 

always_comb 
begin : sc_int_func     // test_const.cpp:526:5
    integer i;
    i = 32'sd15;
end

endmodule

