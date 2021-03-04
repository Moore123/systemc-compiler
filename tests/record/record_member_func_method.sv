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
// Module: A (test_member_func_method.cpp:178:5)
//
module A // "b_mod.a_mod"
(
);

// SystemC signals
logic [1:0] sig;

//------------------------------------------------------------------------------
// Method process: record_meth0 (test_member_func_method.cpp:62:5) 

always_comb 
begin : record_meth0     // test_member_func_method.cpp:62:5
    logic s_a[2];
    logic s_par;
    logic [1:0] i;
    s_par = 1;
    // Call setA() begin
    s_a[1] = s_par;
    // Call setA() end
    i = sig;
    s_par = 0;
    // Call setA() begin
    s_a[i] = s_par;
    // Call setA() end
end

//------------------------------------------------------------------------------
// Method process: record_meth1 (test_member_func_method.cpp:77:5) 

always_comb 
begin : record_meth1     // test_member_func_method.cpp:77:5
    logic s_a[2];
    logic s_par;
    logic TMP_0;
    logic b;
    logic [1:0] i;
    logic TMP_2;
    s_par = 1;
    // Call setA() begin
    s_a[1] = s_par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = s_a[1];
    // Call getA() end
    b = TMP_0;
    i = sig;
    s_par = 0;
    // Call setA() begin
    s_a[i] = s_par;
    // Call setA() end
    // Call getA() begin
    TMP_2 = s_a[i];
    // Call getA() end
    b = TMP_2;
end

//------------------------------------------------------------------------------
// Method process: record_meth2 (test_member_func_method.cpp:97:5) 

always_comb 
begin : record_meth2     // test_member_func_method.cpp:97:5
    logic s_a[2][3];
    logic b;
    logic s_par;
    logic TMP_0;
    b = 1;
    for (integer i = 0; i < 2; i++)
    begin
        s_par = |i;
        // Call setA() begin
        s_a[i][1] = s_par;
        // Call setA() end
        // Call getA() begin
        TMP_0 = s_a[i][1];
        // Call getA() end
        b = b && TMP_0;
    end
end

//------------------------------------------------------------------------------
// Method process: record_meth2a (test_member_func_method.cpp:108:5) 

always_comb 
begin : record_meth2a     // test_member_func_method.cpp:108:5
    logic s_a[2];
    logic b;
    logic s_par;
    logic TMP_0;
    b = 0;
    for (integer i = 0; i < 2; i++)
    begin
        s_par = |i;
        // Call setA() begin
        s_a[i] = s_par;
        // Call setA() end
        // Call getA() begin
        TMP_0 = s_a[i];
        // Call getA() end
        b = b || TMP_0;
    end
end

//------------------------------------------------------------------------------
// Method process: record_meth2b (test_member_func_method.cpp:120:5) 

always_comb 
begin : record_meth2b     // test_member_func_method.cpp:120:5
    logic s_a[2];
    logic b;
    logic s_par;
    b = 1;
    for (integer i = 0; i < 2; i++)
    begin
        s_par = |i;
        // Call setA() begin
        s_a[i] = s_par;
        // Call setA() end
        b = 1;
    end
end

//------------------------------------------------------------------------------
// Method process: record_meth3 (test_member_func_method.cpp:132:5) 

always_comb 
begin : record_meth3     // test_member_func_method.cpp:132:5
    logic s_a[2];
    logic TMP_0;
    logic s_par;
    logic s_l;
    logic b;
    logic [1:0] i;
    logic TMP_2;
    s_par = 1;
    // Call localVar() begin
    s_l = 1;
    TMP_0 = s_l;
    // Call localVar() end
    b = TMP_0;
    i = sig;
    s_par = 0;
    // Call localVar() begin
    s_l = s_par || s_a[i];
    TMP_2 = s_l;
    // Call localVar() end
    b = TMP_2;
end

//------------------------------------------------------------------------------
// Method process: record_multi_calls (test_member_func_method.cpp:155:5) 

always_comb 
begin : record_multi_calls     // test_member_func_method.cpp:155:5
    logic s_a[2];
    logic [1:0] i;
    logic TMP_0;
    logic s_par;
    logic s_l;
    logic b;
    integer TMP_2;
    integer par;
    integer l;
    integer j;
    logic s_par_1;
    integer TMP_4;
    integer TMP_6;
    i = sig;
    s_par = 1;
    // Call localVar() begin
    s_l = s_par || s_a[i];
    TMP_0 = s_l;
    // Call localVar() end
    b = TMP_0;
    par = 4;
    // Call f() begin
    l = par + 1;
    TMP_2 = l;
    // Call f() end
    j = TMP_2;
    s_par_1 = |i;
    // Call setA() begin
    s_a[i] = s_par_1;
    // Call setA() end
    par = 5;
    // Call f() begin
    l = par + 1;
    TMP_4 = l;
    // Call f() end
    s_par_1 = |TMP_4;
    // Call setA() begin
    s_a[i + 1] = s_par_1;
    // Call setA() end
    par = 6;
    // Call f() begin
    l = par + 1;
    TMP_6 = l;
    // Call f() end
end

endmodule


