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
// Module: A (test_array_param.cpp:174:5)
//
module A // "b_mod.a_mod"
(
);

// SystemC signals
logic signed [31:0] s;

//------------------------------------------------------------------------------
// Method process: array_in_func (test_array_param.cpp:81:5) 

always_comb 
begin : array_in_func     // test_array_param.cpp:81:5
    integer arr[3];
    integer i;
    integer i_1;
    integer i_2;
    logic [2:0] arr_sc[3];
    logic [2:0] i_3;
    arr[0] = 1;
    arr[1] = 2;
    arr[2] = 3;
    // Call arr_func1() begin
    i = arr[0];
    i = arr[s];
    // Call arr_func1() end
    // Call arr_func2() begin
    i_1 = arr[0];
    i_1 = arr[s];
    // Call arr_func2() end
    // Call arr_func3() begin
    i_2 = arr[0];
    i_2 = arr[s];
    // Call arr_func3() end
    arr_sc[0] = 0; arr_sc[1] = 0; arr_sc[2] = 0;
    arr_sc[0] = 1;
    arr_sc[1] = 2;
    arr_sc[2] = 3;
    // Call arr_sc_func() begin
    i_3 = 0;
    i_3 = arr_sc[0];
    // Call arr_sc_func() end
end

//------------------------------------------------------------------------------
// Method process: array_2d_in_func (test_array_param.cpp:115:5) 

always_comb 
begin : array_2d_in_func     // test_array_param.cpp:115:5
    integer arr[3][2];
    integer i;
    integer i_1;
    arr[0][0] = 1;
    arr[1][1] = 2;
    arr[2][1] = 3;
    // Call arr_2D_func1() begin
    i = arr[1][1];
    i = arr[s][s + 1];
    // Call arr_2D_func1() end
    // Call arr_2D_func2() begin
    i_1 = arr[1][1];
    i_1 = arr[s][s + 1];
    // Call arr_2D_func2() end
end

//------------------------------------------------------------------------------
// Method process: array_pointers_in_func (test_array_param.cpp:143:5) 

// Process-local variables
logic signed [31:0] ap[3][2];

always_comb 
begin : array_pointers_in_func     // test_array_param.cpp:143:5
    integer i;
    integer i_1;
    ap[0][0] = 1;
    ap[1][1] = 2;
    ap[2][1] = 3;
    // Call arr_ptr_func1() begin
    i = ap[1][1];
    i = ap[s][s + 1];
    // Call arr_ptr_func1() end
    // Call arr_ptr_func2() begin
    i_1 = ap[1][1];
    i_1 = ap[s][s + 1];
    // Call arr_ptr_func2() end
end

//------------------------------------------------------------------------------
// Method process: double_pointers_in_func (test_array_param.cpp:162:5) 

// Process-local variables
logic signed [31:0] pp[3][2];

always_comb 
begin : double_pointers_in_func     // test_array_param.cpp:162:5
    integer i;
    pp[0][0] = 1;
    pp[1][1] = 2;
    pp[2][1] = 3;
    // Call dbl_ptr_func1() begin
    i = pp[1][1];
    i = pp[s][s + 1];
    // Call dbl_ptr_func1() end
end

endmodule


