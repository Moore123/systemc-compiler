//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: A ()
//
module A // "a"
(
    input logic clk
);

// SystemC signals
logic rstn;
logic signed [31:0] sig;

//------------------------------------------------------------------------------
// Clocked THREAD: single_rec_call_reg (test_fcall_glob_cthread.cpp:91:5) 

// Thread-local variables
logic s_a;
logic s_a_next;
logic signed [31:0] s_b;
logic signed [31:0] s_b_next;
logic single_rec_call_reg_PROC_STATE;
logic single_rec_call_reg_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : single_rec_call_reg_comb     // test_fcall_glob_cthread.cpp:91:5
    single_rec_call_reg_func;
end
function void single_rec_call_reg_func;
    logic par;
    logic TMP_0;
    logic c;
    s_a_next = s_a;
    s_b_next = s_b;
    single_rec_call_reg_PROC_STATE_next = single_rec_call_reg_PROC_STATE;
    
    case (single_rec_call_reg_PROC_STATE)
        0: begin
            par = 1;
            // Call setA() begin
            s_a_next = par;
            // Call setA() end
            single_rec_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:97:13;
        end
        1: begin
            // Call getA() begin
            TMP_0 = s_a_next;
            // Call getA() end
            c = TMP_0;
            par = 1;
            // Call setA() begin
            s_a_next = par;
            // Call setA() end
            single_rec_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:97:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : single_rec_call_reg_ff
    if ( ~rstn ) begin
        single_rec_call_reg_PROC_STATE <= 0;    // test_fcall_glob_cthread.cpp:93:9;
    end
    else begin
        s_a <= s_a_next;
        s_b <= s_b_next;
        single_rec_call_reg_PROC_STATE <= single_rec_call_reg_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: single_rec_call_comb (test_fcall_glob_cthread.cpp:105:5) 

// Thread-local variables
logic r_a;
logic signed [31:0] r_b;

// Next-state combinational logic
always_comb begin : single_rec_call_comb_comb     // test_fcall_glob_cthread.cpp:105:5
    single_rec_call_comb_func;
end
function void single_rec_call_comb_func;
    logic par;
    logic TMP_0;
    logic c;
    par = 1;
    // Call setA() begin
    r_a = par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = r_a;
    // Call getA() end
    c = TMP_0;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : single_rec_call_comb_ff
    if ( ~rstn ) begin
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: pointer_rec_call_reg (test_fcall_glob_cthread.cpp:119:5) 

// Thread-local variables
logic sp_a;
logic sp_a_next;
logic signed [31:0] sp_b;
logic signed [31:0] sp_b_next;
logic pointer_rec_call_reg_PROC_STATE;
logic pointer_rec_call_reg_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : pointer_rec_call_reg_comb     // test_fcall_glob_cthread.cpp:119:5
    pointer_rec_call_reg_func;
end
function void pointer_rec_call_reg_func;
    logic par;
    logic TMP_0;
    logic c;
    sp_a_next = sp_a;
    sp_b_next = sp_b;
    pointer_rec_call_reg_PROC_STATE_next = pointer_rec_call_reg_PROC_STATE;
    
    case (pointer_rec_call_reg_PROC_STATE)
        0: begin
            par = 1;
            // Call setA() begin
            sp_a_next = par;
            // Call setA() end
            pointer_rec_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:125:13;
        end
        1: begin
            // Call getA() begin
            TMP_0 = sp_a_next;
            // Call getA() end
            c = TMP_0;
            par = 1;
            // Call setA() begin
            sp_a_next = par;
            // Call setA() end
            pointer_rec_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:125:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : pointer_rec_call_reg_ff
    if ( ~rstn ) begin
        pointer_rec_call_reg_PROC_STATE <= 0;    // test_fcall_glob_cthread.cpp:121:9;
    end
    else begin
        sp_a <= sp_a_next;
        sp_b <= sp_b_next;
        pointer_rec_call_reg_PROC_STATE <= pointer_rec_call_reg_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: pointer_rec_call_comb (test_fcall_glob_cthread.cpp:133:5) 

// Thread-local variables
logic rp_a;
logic signed [31:0] rp_b;

// Next-state combinational logic
always_comb begin : pointer_rec_call_comb_comb     // test_fcall_glob_cthread.cpp:133:5
    pointer_rec_call_comb_func;
end
function void pointer_rec_call_comb_func;
    logic par;
    logic TMP_0;
    logic c;
    par = 1;
    // Call setA() begin
    rp_a = par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = rp_a;
    // Call getA() end
    c = TMP_0;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : pointer_rec_call_comb_ff
    if ( ~rstn ) begin
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: rec_arr_call_reg (test_fcall_glob_cthread.cpp:148:5) 

// Thread-local variables
logic t_a[2];
logic t_a_next[2];
logic signed [31:0] t_b[2];
logic signed [31:0] t_b_next[2];
logic rec_arr_call_reg_PROC_STATE;
logic rec_arr_call_reg_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : rec_arr_call_reg_comb     // test_fcall_glob_cthread.cpp:148:5
    rec_arr_call_reg_func;
end
function void rec_arr_call_reg_func;
    logic par;
    logic TMP_0;
    logic c;
    t_a_next = t_a;
    t_b_next = t_b;
    rec_arr_call_reg_PROC_STATE_next = rec_arr_call_reg_PROC_STATE;
    
    case (rec_arr_call_reg_PROC_STATE)
        0: begin
            par = 1;
            // Call setA() begin
            t_a_next[1] = par;
            // Call setA() end
            rec_arr_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:154:13;
        end
        1: begin
            // Call getA() begin
            TMP_0 = t_a_next[1];
            // Call getA() end
            c = TMP_0;
            par = 1;
            // Call setA() begin
            t_a_next[1] = par;
            // Call setA() end
            rec_arr_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:154:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : rec_arr_call_reg_ff
    if ( ~rstn ) begin
        rec_arr_call_reg_PROC_STATE <= 0;    // test_fcall_glob_cthread.cpp:150:9;
    end
    else begin
        t_a <= t_a_next;
        t_b <= t_b_next;
        rec_arr_call_reg_PROC_STATE <= rec_arr_call_reg_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: rec_arr_call_comb (test_fcall_glob_cthread.cpp:162:5) 

// Thread-local variables
logic q_a[2];
logic signed [31:0] q_b[2];

// Next-state combinational logic
always_comb begin : rec_arr_call_comb_comb     // test_fcall_glob_cthread.cpp:162:5
    rec_arr_call_comb_func;
end
function void rec_arr_call_comb_func;
    logic par;
    logic TMP_0;
    logic c;
    par = 1;
    // Call setA() begin
    q_a[1] = par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = q_a[1];
    // Call getA() end
    c = TMP_0;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : rec_arr_call_comb_ff
    if ( ~rstn ) begin
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: pointer_arr_call_reg (test_fcall_glob_cthread.cpp:174:5) 

// Thread-local variables
logic w_a[2];
logic w_a_next[2];
logic signed [31:0] w_b[2];
logic signed [31:0] w_b_next[2];
logic pointer_arr_call_reg_PROC_STATE;
logic pointer_arr_call_reg_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : pointer_arr_call_reg_comb     // test_fcall_glob_cthread.cpp:174:5
    pointer_arr_call_reg_func;
end
function void pointer_arr_call_reg_func;
    logic par;
    logic TMP_0;
    logic c;
    w_a_next = w_a;
    w_b_next = w_b;
    pointer_arr_call_reg_PROC_STATE_next = pointer_arr_call_reg_PROC_STATE;
    
    case (pointer_arr_call_reg_PROC_STATE)
        0: begin
            par = 1;
            // Call setA() begin
            w_a_next[1] = par;
            // Call setA() end
            pointer_arr_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:180:13;
        end
        1: begin
            // Call getA() begin
            TMP_0 = w_a_next[1];
            // Call getA() end
            c = TMP_0;
            par = 1;
            // Call setA() begin
            w_a_next[1] = par;
            // Call setA() end
            pointer_arr_call_reg_PROC_STATE_next = 1; return;    // test_fcall_glob_cthread.cpp:180:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : pointer_arr_call_reg_ff
    if ( ~rstn ) begin
        pointer_arr_call_reg_PROC_STATE <= 0;    // test_fcall_glob_cthread.cpp:176:9;
    end
    else begin
        w_a <= w_a_next;
        w_b <= w_b_next;
        pointer_arr_call_reg_PROC_STATE <= pointer_arr_call_reg_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: pointer_arr_call_comb (test_fcall_glob_cthread.cpp:187:5) 

// Thread-local variables
logic z_a[2];
logic signed [31:0] z_b[2];

// Next-state combinational logic
always_comb begin : pointer_arr_call_comb_comb     // test_fcall_glob_cthread.cpp:187:5
    pointer_arr_call_comb_func;
end
function void pointer_arr_call_comb_func;
    logic par;
    logic TMP_0;
    logic c;
    par = 1;
    // Call setA() begin
    z_a[1] = par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = z_a[1];
    // Call getA() end
    c = TMP_0;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : pointer_arr_call_comb_ff
    if ( ~rstn ) begin
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: pointer_arr_call_unknw_reg (test_fcall_glob_cthread.cpp:201:5) 

// Thread-local variables
logic g_a[2];
logic g_a_next[2];
logic signed [31:0] g_b[2];
logic signed [31:0] g_b_next[2];

// Next-state combinational logic
always_comb begin : pointer_arr_call_unknw_reg_comb     // test_fcall_glob_cthread.cpp:201:5
    pointer_arr_call_unknw_reg_func;
end
function void pointer_arr_call_unknw_reg_func;
    integer j;
    logic par;
    logic TMP_0;
    logic c;
    g_a_next = g_a;
    g_b_next = g_b;
    j = sig;
    par = 1;
    // Call setA() begin
    g_a_next[1] = par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = g_a_next[j];
    // Call getA() end
    c = TMP_0;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : pointer_arr_call_unknw_reg_ff
    if ( ~rstn ) begin
    end
    else begin
        g_a <= g_a_next;
        g_b <= g_b_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: pointer_arr_call_unknw_reg2 (test_fcall_glob_cthread.cpp:216:5) 

// Thread-local variables
logic f_a[2];
logic f_a_next[2];
logic signed [31:0] f_b[2];
logic signed [31:0] f_b_next[2];

// Next-state combinational logic
always_comb begin : pointer_arr_call_unknw_reg2_comb     // test_fcall_glob_cthread.cpp:216:5
    pointer_arr_call_unknw_reg2_func;
end
function void pointer_arr_call_unknw_reg2_func;
    integer j;
    logic par;
    logic TMP_0;
    logic c;
    f_a_next = f_a;
    f_b_next = f_b;
    j = sig;
    par = 1;
    // Call setA() begin
    f_a_next[j] = par;
    // Call setA() end
    // Call getA() begin
    TMP_0 = f_a_next[j];
    // Call getA() end
    c = TMP_0;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : pointer_arr_call_unknw_reg2_ff
    if ( ~rstn ) begin
    end
    else begin
        f_a <= f_a_next;
        f_b <= f_b_next;
    end
end

endmodule


