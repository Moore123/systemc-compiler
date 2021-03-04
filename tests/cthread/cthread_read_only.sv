//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: test_split_array_reg ()
//
module test_split_array_reg // "test"
(
);

// SystemC signals
logic clk;
logic rstn;
logic signed [31:0] sig0;
logic signed [31:0] sig1;
logic signed [31:0] arr[2];

// C++ data variables
localparam logic signed [31:0] x = 'd12;

//------------------------------------------------------------------------------
// Clocked THREAD: test_thread (test_cthread_read_only.cpp:33:5) 

// Thread-local variables
logic signed [31:0] sig0_next;
logic signed [31:0] arr0[2];

// Next-state combinational logic
always_comb begin : test_thread_comb     // test_cthread_read_only.cpp:33:5
    test_thread_func;
end
function void test_thread_func;
    sig0_next = sig0;
    sig0_next = sig1 + x;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : test_thread_ff
    if ( ~rstn ) begin
        integer arr0[2];
        arr0[1] = 0;
    end
    else begin
        sig0 <= sig0_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_thread1 (test_cthread_read_only.cpp:44:5) 

// Thread-local variables
logic signed [31:0] sig1_next;

// Next-state combinational logic
always_comb begin : test_thread1_comb     // test_cthread_read_only.cpp:44:5
    test_thread1_func;
end
function void test_thread1_func;
    sig1_next = sig1;
    sig1_next = x;
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rstn) 
begin : test_thread1_ff
    if ( ~rstn ) begin
        sig1 <= 0;
        arr[sig0] <= 0;
    end
    else begin
        sig1 <= sig1_next;
    end
end

endmodule


