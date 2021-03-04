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
logic rst;
logic signed [31:0] sig;
logic [3:0] minst_s[2];
logic minst_clk[2];
logic minst_rst[2];

assign minst_clk[0] = clk;
assign minst_clk[1] = clk;
assign minst_rst[0] = rst;
assign minst_rst[1] = rst;

//------------------------------------------------------------------------------
// Clocked THREAD: minst_thread_member_comb (test_cthread_mif_array_ptr_unkwn.cpp:56:5) 

// Thread-local variables
logic [3:0] minst_v[2];
logic signed [31:0] minst_av[2][2];
logic signed [31:0] minst_avv[2][2][3];
logic minst_avp[2][2];

// Next-state combinational logic
always_comb begin : minst_thread_member_comb_comb     // test_cthread_mif_array_ptr_unkwn.cpp:56:5
    minst_thread_member_comb_func;
end
function void minst_thread_member_comb_func;
    integer k;
    minst_v[0] = 1;
    minst_av[0][0] = minst_v[0];
    minst_avv[0][1][2] = minst_v[0];
    k = minst_av[0][0] + minst_avv[0][1][2];
    minst_avp[0][1] = |k;
    minst_avp[0][0] = minst_avp[0][1];
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[0] or posedge minst_rst[0]) 
begin : minst_thread_member_comb_ff
    if (minst_rst[0] ) begin
        logic [3:0] minst_v;
        integer minst_av[2];
        integer minst_avv[2][3];
        minst_v = 0;
        minst_av[0] = minst_v + 1;
        minst_avv[1][2] = minst_av[0];
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: minst_thread_member_reg (test_cthread_mif_array_ptr_unkwn.cpp:93:5) 

// Thread-local variables
logic [3:0] minst_w[2];
logic [3:0] minst_w_next[2];
logic signed [31:0] minst_aw[2][2];
logic signed [31:0] minst_aw_next[2][2];
logic minst_awp[2][2];
logic minst_awp_next[2][2];

// Next-state combinational logic
always_comb begin : minst_thread_member_reg_comb     // test_cthread_mif_array_ptr_unkwn.cpp:93:5
    minst_thread_member_reg_func;
end
function void minst_thread_member_reg_func;
    integer l;
    minst_aw_next[0] = minst_aw[0];
    minst_awp_next[0] = minst_awp[0];
    minst_w_next[0] = minst_w[0];
    l = minst_aw_next[0][0] + signed'({1'b0, minst_w_next[0]}) + signed'({1'b0, minst_s[0]});
    minst_awp_next[0][l] = 0;
    l = minst_awp_next[0][1];
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[0] or posedge minst_rst[0]) 
begin : minst_thread_member_reg_ff
    if (minst_rst[0] ) begin
        minst_w[0] <= 0;
        minst_aw[0][0] <= minst_w[0] + 1;
    end
    else begin
        minst_w[0] <= minst_w_next[0];
        minst_aw[0] <= minst_aw_next[0];
        minst_awp[0] <= minst_awp_next[0];
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: minst_thread_member_comb0 (test_cthread_mif_array_ptr_unkwn.cpp:56:5) 

// Next-state combinational logic
always_comb begin : minst_thread_member_comb0_comb     // test_cthread_mif_array_ptr_unkwn.cpp:56:5
    minst_thread_member_comb0_func;
end
function void minst_thread_member_comb0_func;
    integer k;
    minst_v[1] = 1;
    minst_av[1][0] = minst_v[1];
    minst_avv[1][1][2] = minst_v[1];
    k = minst_av[1][0] + minst_avv[1][1][2];
    minst_avp[1][1] = |k;
    minst_avp[1][0] = minst_avp[1][1];
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[1] or posedge minst_rst[1]) 
begin : minst_thread_member_comb0_ff
    if (minst_rst[1] ) begin
        logic [3:0] minst_v;
        integer minst_av[2];
        integer minst_avv[2][3];
        minst_v = 0;
        minst_av[0] = minst_v + 1;
        minst_avv[1][2] = minst_av[0];
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: minst_thread_member_reg0 (test_cthread_mif_array_ptr_unkwn.cpp:93:5) 

// Next-state combinational logic
always_comb begin : minst_thread_member_reg0_comb     // test_cthread_mif_array_ptr_unkwn.cpp:93:5
    minst_thread_member_reg0_func;
end
function void minst_thread_member_reg0_func;
    integer l;
    minst_aw_next[1] = minst_aw[1];
    minst_awp_next[1] = minst_awp[1];
    minst_w_next[1] = minst_w[1];
    l = minst_aw_next[1][0] + signed'({1'b0, minst_w_next[1]}) + signed'({1'b0, minst_s[1]});
    minst_awp_next[1][l] = 0;
    l = minst_awp_next[1][1];
endfunction

// Syncrhonous register update
always_ff @(posedge minst_clk[1] or posedge minst_rst[1]) 
begin : minst_thread_member_reg0_ff
    if (minst_rst[1] ) begin
        minst_w[1] <= 0;
        minst_aw[1][0] <= minst_w[1] + 1;
    end
    else begin
        minst_w[1] <= minst_w_next[1];
        minst_aw[1] <= minst_aw_next[1];
        minst_awp[1] <= minst_awp_next[1];
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: top_thread_comb_reset (test_cthread_mif_array_ptr_unkwn.cpp:154:5) 

// Thread-local variables
logic [3:0] minst_d[2];
logic signed [31:0] minst_ad[2][3];
logic signed [31:0] minst_adp[2][2];

// Next-state combinational logic
always_comb begin : top_thread_comb_reset_comb     // test_cthread_mif_array_ptr_unkwn.cpp:154:5
    top_thread_comb_reset_func;
end
function void top_thread_comb_reset_func;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or posedge rst) 
begin : top_thread_comb_reset_ff
    if (rst ) begin
        integer j;
        logic [3:0] minst_d[2];
        integer minst_ad[2][3];
        integer minst_adp[2][2];
        j = sig;
        minst_d[j] = 1;
        minst_ad[j][2] = 2;
        minst_adp[j][j + 1] = 3;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: top_thread_comb (test_cthread_mif_array_ptr_unkwn.cpp:168:5) 

// Thread-local variables
logic [3:0] minst_y[2];
logic signed [31:0] minst_ay[2][3];
logic signed [31:0] minst_ayp[2][2];

// Next-state combinational logic
always_comb begin : top_thread_comb_comb     // test_cthread_mif_array_ptr_unkwn.cpp:168:5
    top_thread_comb_func;
end
function void top_thread_comb_func;
    integer i_1;
    minst_y[1] = 2;
    i_1 = minst_y[1];
    minst_ay[1][1] = 3;
    i_1 = minst_ay[1][1];
    minst_ayp[1][1] = 4;
    i_1 = minst_ayp[1][1];
endfunction

// Syncrhonous register update
always_ff @(posedge clk or posedge rst) 
begin : top_thread_comb_ff
    if (rst ) begin
        integer j;
        logic [3:0] minst_y[2];
        integer minst_ay[2][3];
        integer minst_ayp[2][2];
        for (integer i = 0; i < 2; i++)
        begin
            minst_y[i] = i;
            for (integer k = 0; k < 2; k++)
            begin
                minst_ay[i][k] = i + k;
                minst_ayp[i][k] = i - k;
            end
        end
        j = sig;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: top_thread_reg (test_cthread_mif_array_ptr_unkwn.cpp:195:5) 

// Thread-local variables
logic signed [31:0] j;
logic signed [31:0] j_next;
logic [3:0] minst_z[2];
logic [3:0] minst_z_next[2];
logic signed [31:0] minst_az[2][2];
logic signed [31:0] minst_az_next[2][2];

// Next-state combinational logic
always_comb begin : top_thread_reg_comb     // test_cthread_mif_array_ptr_unkwn.cpp:195:5
    top_thread_reg_func;
end
function void top_thread_reg_func;
    integer i;
    j_next = j;
    minst_az_next = minst_az;
    minst_z_next = minst_z;
    minst_z_next[j_next + 1] = 2;
    i = minst_z_next[j_next];
    minst_az_next[j_next][j_next + 1] = 3;
    i = minst_az_next[j_next][1];
endfunction

// Syncrhonous register update
always_ff @(posedge clk or posedge rst) 
begin : top_thread_reg_ff
    if (rst ) begin
        j <= sig;
    end
    else begin
        j <= j_next;
        minst_z <= minst_z_next;
        minst_az <= minst_az_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: top_thread_fcall (test_cthread_mif_array_ptr_unkwn.cpp:212:5) 

// Thread-local variables
logic signed [31:0] jj;
logic signed [31:0] jj_next;
logic [3:0] minst_x[2];
logic [3:0] minst_x_next[2];
logic signed [31:0] minst_ax[2][2];
logic signed [31:0] minst_ax_next[2][2];
logic signed [31:0] l;
logic signed [31:0] l_next;
logic signed [31:0] minst_axp[2][2];
logic signed [31:0] minst_axp_next[2][2];
logic [1:0] top_thread_fcall_PROC_STATE;
logic [1:0] top_thread_fcall_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : top_thread_fcall_comb     // test_cthread_mif_array_ptr_unkwn.cpp:212:5
    top_thread_fcall_func;
end
function void top_thread_fcall_func;
    jj_next = jj;
    l_next = l;
    minst_ax_next = minst_ax;
    minst_axp_next = minst_axp;
    minst_x_next = minst_x;
    top_thread_fcall_PROC_STATE_next = top_thread_fcall_PROC_STATE;
    
    case (top_thread_fcall_PROC_STATE)
        0: begin
            // Call f() begin
            l_next = minst_ax_next[jj_next][minst_x_next[jj_next]];
            minst_x_next[jj_next] = 2;
            top_thread_fcall_PROC_STATE_next = 1; return;    // test_cthread_mif_array_ptr_unkwn.cpp:114:9;
            // Call f() end
        end
        1: begin
            // Call f() begin
            minst_ax_next[jj_next][l_next] = minst_x_next[jj_next];
            minst_x_next[jj_next] = minst_ax_next[jj_next][1];
            minst_axp_next[jj_next][l_next] = 1;
            minst_x_next[jj_next] = minst_axp_next[jj_next][0];
            // Call f() end
            top_thread_fcall_PROC_STATE_next = 2; return;    // test_cthread_mif_array_ptr_unkwn.cpp:219:13;
        end
        2: begin
            // Call f() begin
            l_next = minst_ax_next[jj_next][minst_x_next[jj_next]];
            minst_x_next[jj_next] = 2;
            top_thread_fcall_PROC_STATE_next = 1; return;    // test_cthread_mif_array_ptr_unkwn.cpp:114:9;
            // Call f() end
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or posedge rst) 
begin : top_thread_fcall_ff
    if (rst ) begin
        jj <= sig;
        top_thread_fcall_PROC_STATE <= 0;    // test_cthread_mif_array_ptr_unkwn.cpp:215:9;
    end
    else begin
        jj <= jj_next;
        minst_x <= minst_x_next;
        minst_ax <= minst_ax_next;
        l <= l_next;
        minst_axp <= minst_axp_next;
        top_thread_fcall_PROC_STATE <= top_thread_fcall_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: top_thread_ptr_array (test_cthread_mif_array_ptr_unkwn.cpp:223:5) 

// Thread-local variables
logic signed [31:0] kk;
logic signed [31:0] kk_next;
logic signed [31:0] minst_azp[2][2];
logic signed [31:0] minst_azp_next[2][2];

// Next-state combinational logic
always_comb begin : top_thread_ptr_array_comb     // test_cthread_mif_array_ptr_unkwn.cpp:223:5
    top_thread_ptr_array_func;
end
function void top_thread_ptr_array_func;
    integer i;
    kk_next = kk;
    minst_azp_next = minst_azp;
    minst_azp_next[kk_next][0] = 4;
    i = minst_azp_next[1][kk_next];
endfunction

// Syncrhonous register update
always_ff @(posedge clk or posedge rst) 
begin : top_thread_ptr_array_ff
    if (rst ) begin
        kk <= sig;
    end
    else begin
        kk <= kk_next;
        minst_azp <= minst_azp_next;
    end
end

endmodule


