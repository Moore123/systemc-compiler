//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.7
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: top ()
//
module top // "t"
(
);

// SystemC signals
logic clk;


//------------------------------------------------------------------------------

derived d
(
  .clk(clk)
);

endmodule



//==============================================================================
//
// Module: derived (test_cthread_virtual_wait.cpp:49:5)
//
module derived // "t.d"
(
    input logic clk
);

// SystemC signals
logic x;

//------------------------------------------------------------------------------
// Clocked THREAD: test_thread (test_cthread_virtual_wait.cpp:20:5) 

// Thread-local variables
logic x_next;
logic [1:0] test_thread_PROC_STATE;
logic [1:0] test_thread_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : test_thread_comb     // test_cthread_virtual_wait.cpp:20:5
    test_thread_func;
end
function void test_thread_func;
    x_next = x;
    test_thread_PROC_STATE_next = test_thread_PROC_STATE;
    
    case (test_thread_PROC_STATE)
        default : begin
            test_thread_PROC_STATE_next = 0; return;    // test_cthread_virtual_wait.cpp:21:9;
        end
        0: begin
            // Call virtual_wait() begin
            x_next = 0;
            test_thread_PROC_STATE_next = 1; return;    // test_cthread_virtual_wait.cpp:38:9;
            // Call virtual_wait() end
        end
        1: begin
            // Call virtual_wait() begin
            x_next = 1;
            test_thread_PROC_STATE_next = 2; return;    // test_cthread_virtual_wait.cpp:40:9;
            // Call virtual_wait() end
        end
        2: begin
            // Call virtual_wait() begin
            x_next = 0;
            test_thread_PROC_STATE_next = 1; return;    // test_cthread_virtual_wait.cpp:38:9;
            // Call virtual_wait() end
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk) 
begin : test_thread_ff
    begin
        x <= x_next;
        test_thread_PROC_STATE <= test_thread_PROC_STATE_next;
    end
end

endmodule

