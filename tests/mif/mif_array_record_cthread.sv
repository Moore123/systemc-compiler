//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: Top ()
//
module Top // "top"
(
    input logic clk
);

// SystemC signals
logic minst_nrst[2];
logic minst_s[2];
logic minst_clk[2];

assign minst_clk[0] = clk;
assign minst_clk[1] = clk;

//------------------------------------------------------------------------------
// Clocked THREAD: minst_memRecThread (test_array_record_cthread.cpp:43:5) 

// Thread-local variables
logic signed [31:0] minst_rr_rec_arr_c[2][2];
logic signed [31:0] minst_rr_rec_arr_c_next[2][2];
logic minst_r_a[2];
logic minst_r_a_next[2];
logic [3:0] minst_r_b[2][3];
logic [3:0] minst_r_b_next[2][3];
logic signed [31:0] minst_r_rec_c[2];
logic minst_rr_a[2];
logic [3:0] minst_rr_b[2][3];

// Next-state combinational logic
always_comb begin : minst_memRecThread_comb     // test_array_record_cthread.cpp:43:5
    minst_memRecThread_func;
end
function void minst_memRecThread_func;
    integer i;
    minst_r_a_next[0] = minst_r_a[0];
    minst_r_b_next[0] = minst_r_b[0];
    minst_rr_rec_arr_c_next[0] = minst_rr_rec_arr_c[0];
    minst_r_b_next[0][0] = 1;
    minst_r_rec_c[0] = 2;
    minst_rr_a[0] = minst_s[0];
    minst_rr_b[0][2] = 3;
    minst_rr_rec_arr_c_next[0][1] = 4;
    i = minst_rr_rec_arr_c_next[0][0] + signed'({1'b0, minst_r_b_next[0][1]});
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[0] or negedge minst_nrst[0]) 
begin : minst_memRecThread_ff
    if ( ~minst_nrst[0] ) begin
    end
    else begin
        minst_rr_rec_arr_c[0] <= minst_rr_rec_arr_c_next[0];
        minst_r_a[0] <= minst_r_a_next[0];
        minst_r_b[0] <= minst_r_b_next[0];
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: minst_memRecArrThread (test_array_record_cthread.cpp:63:5) 

// Thread-local variables
logic signed [31:0] minst_w_rec_c[2][2];
logic signed [31:0] minst_w_rec_c_next[2][2];
logic signed [31:0] minst_ww_rec_c[2][3];
logic signed [31:0] minst_ww_rec_c_next[2][3];
logic minst_w_a[2][2];
logic [3:0] minst_w_b[2][2][3];
logic signed [31:0] minst_w_rec_arr_c[2][2][2];
logic signed [31:0] minst_ww_rec_arr_c[2][3][2];

// Next-state combinational logic
always_comb begin : minst_memRecArrThread_comb     // test_array_record_cthread.cpp:63:5
    minst_memRecArrThread_func;
end
function void minst_memRecArrThread_func;
    integer i;
    minst_w_rec_c_next[0] = minst_w_rec_c[0];
    minst_ww_rec_c_next[0] = minst_ww_rec_c[0];
    minst_w_a[0][0] = minst_s[0];
    minst_w_b[0][0][1] = 1;
    minst_w_rec_c_next[0][1] = 2;
    minst_w_rec_arr_c[0][0][1] = 3;
    minst_ww_rec_arr_c[0][0][1] = 4;
    i = minst_w_rec_arr_c[0][0][1] + minst_ww_rec_arr_c[0][0][1] + minst_w_rec_c_next[0][0] + minst_ww_rec_c_next[0][0];
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[0] or negedge minst_nrst[0]) 
begin : minst_memRecArrThread_ff
    if ( ~minst_nrst[0] ) begin
    end
    else begin
        minst_w_rec_c[0] <= minst_w_rec_c_next[0];
        minst_ww_rec_c[0] <= minst_ww_rec_c_next[0];
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: minst_memRecThread0 (test_array_record_cthread.cpp:43:5) 

// Next-state combinational logic
always_comb begin : minst_memRecThread0_comb     // test_array_record_cthread.cpp:43:5
    minst_memRecThread0_func;
end
function void minst_memRecThread0_func;
    integer i;
    minst_r_a_next[1] = minst_r_a[1];
    minst_r_b_next[1] = minst_r_b[1];
    minst_rr_rec_arr_c_next[1] = minst_rr_rec_arr_c[1];
    minst_r_b_next[1][0] = 1;
    minst_r_rec_c[1] = 2;
    minst_rr_a[1] = minst_s[1];
    minst_rr_b[1][2] = 3;
    minst_rr_rec_arr_c_next[1][1] = 4;
    i = minst_rr_rec_arr_c_next[1][0] + signed'({1'b0, minst_r_b_next[1][1]});
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[1] or negedge minst_nrst[1]) 
begin : minst_memRecThread0_ff
    if ( ~minst_nrst[1] ) begin
    end
    else begin
        minst_rr_rec_arr_c[1] <= minst_rr_rec_arr_c_next[1];
        minst_r_a[1] <= minst_r_a_next[1];
        minst_r_b[1] <= minst_r_b_next[1];
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: minst_memRecArrThread0 (test_array_record_cthread.cpp:63:5) 

// Next-state combinational logic
always_comb begin : minst_memRecArrThread0_comb     // test_array_record_cthread.cpp:63:5
    minst_memRecArrThread0_func;
end
function void minst_memRecArrThread0_func;
    integer i;
    minst_w_rec_c_next[1] = minst_w_rec_c[1];
    minst_ww_rec_c_next[1] = minst_ww_rec_c[1];
    minst_w_a[1][0] = minst_s[1];
    minst_w_b[1][0][1] = 1;
    minst_w_rec_c_next[1][1] = 2;
    minst_w_rec_arr_c[1][0][1] = 3;
    minst_ww_rec_arr_c[1][0][1] = 4;
    i = minst_w_rec_arr_c[1][0][1] + minst_ww_rec_arr_c[1][0][1] + minst_w_rec_c_next[1][0] + minst_ww_rec_c_next[1][0];
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[1] or negedge minst_nrst[1]) 
begin : minst_memRecArrThread0_ff
    if ( ~minst_nrst[1] ) begin
    end
    else begin
        minst_w_rec_c[1] <= minst_w_rec_c_next[1];
        minst_ww_rec_c[1] <= minst_ww_rec_c_next[1];
    end
end

endmodule


