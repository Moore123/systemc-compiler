//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: top ()
//
module top // "top_inst"
(
    input logic clk
);

// SystemC signals
logic arstn;
logic signed [31:0] s;
logic [3:0] t;

// C++ data variables
localparam logic [31:0] N = 'd2;

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default1 (test_cthread_switch_default.cpp:66:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default1_comb     // test_cthread_switch_default.cpp:66:5
    test_switch_const_default1_func;
end
function void test_switch_const_default1_func;
    case (2)
    default : begin
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default1_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default2 (test_cthread_switch_default.cpp:83:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default2_comb     // test_cthread_switch_default.cpp:83:5
    test_switch_const_default2_func;
end
function void test_switch_const_default2_func;
    integer j;
    case (1)
    1 : begin
        j = 2;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default2_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default3 (test_cthread_switch_default.cpp:100:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default3_comb     // test_cthread_switch_default.cpp:100:5
    test_switch_const_default3_func;
end
function void test_switch_const_default3_func;
    integer j;
    case (0)
    0 : begin
        j = 1;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default3_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default_empty1 (test_cthread_switch_default.cpp:117:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default_empty1_comb     // test_cthread_switch_default.cpp:117:5
    test_switch_const_default_empty1_func;
end
function void test_switch_const_default_empty1_func;
    integer j;
    case (0)
    0 : begin
        j = 1;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default_empty1_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default_empty2 (test_cthread_switch_default.cpp:134:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default_empty2_comb     // test_cthread_switch_default.cpp:134:5
    test_switch_const_default_empty2_func;
end
function void test_switch_const_default_empty2_func;
    integer j;
    case (1)
    1 : begin  // Empty case without break
        j = 2;
    end
    default : begin
        j = 2;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default_empty2_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default_empty3 (test_cthread_switch_default.cpp:151:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default_empty3_comb     // test_cthread_switch_default.cpp:151:5
    test_switch_const_default_empty3_func;
end
function void test_switch_const_default_empty3_func;
    integer j;
    case (1)
    1 : begin  // Empty case without break
        j = 2;
    end
    default : begin
        j = 2;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default_empty3_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_const_default_empty4 (test_cthread_switch_default.cpp:168:5) 

// Next-state combinational logic
always_comb begin : test_switch_const_default_empty4_comb     // test_cthread_switch_default.cpp:168:5
    test_switch_const_default_empty4_func;
end
function void test_switch_const_default_empty4_func;
    integer j;
    case (0)
    0 : begin  // Empty case without break
        j = 2;
    end
    1 : begin  // Empty case without break
        j = 2;
    end
    default : begin
        j = 2;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_const_default_empty4_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default1 (test_cthread_switch_default.cpp:185:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default1_comb     // test_cthread_switch_default.cpp:185:5
    test_switch_simple_default1_func;
end
function void test_switch_simple_default1_func;
    integer j;
    case (t)
    0 : begin
        j = 1;
    end
    1 : begin
        j = 2;
    end
    default : begin
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default1_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default2 (test_cthread_switch_default.cpp:202:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default2_comb     // test_cthread_switch_default.cpp:202:5
    test_switch_simple_default2_func;
end
function void test_switch_simple_default2_func;
    integer j;
    case (t)
    0 : begin
        j = 1;
    end
    1 : begin
        j = 2;
    end
    default : begin
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default2_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default3 (test_cthread_switch_default.cpp:219:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default3_comb     // test_cthread_switch_default.cpp:219:5
    test_switch_simple_default3_func;
end
function void test_switch_simple_default3_func;
    integer j;
    case (t)
    0 : begin
        j = 1;
    end
    1 : begin
        j = 2;
        j++;
    end
    default : begin
        j = 3;
        j--;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default3_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default_empty1 (test_cthread_switch_default.cpp:236:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default_empty1_comb     // test_cthread_switch_default.cpp:236:5
    test_switch_simple_default_empty1_func;
end
function void test_switch_simple_default_empty1_func;
    integer j;
    case (t)
    0 : begin  // Empty case without break
        j = 2;
    end
    1 : begin
        j = 2;
    end
    default : begin
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default_empty1_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default_empty2 (test_cthread_switch_default.cpp:253:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default_empty2_comb     // test_cthread_switch_default.cpp:253:5
    test_switch_simple_default_empty2_func;
end
function void test_switch_simple_default_empty2_func;
    integer j;
    case (t)
    0 : begin  // Empty case without break
        j = 2;
    end
    1 : begin
        j = 2;
    end
    default : begin
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default_empty2_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default_empty3 (test_cthread_switch_default.cpp:270:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default_empty3_comb     // test_cthread_switch_default.cpp:270:5
    test_switch_simple_default_empty3_func;
end
function void test_switch_simple_default_empty3_func;
    integer j;
    case (t)
    0 : begin  // Empty case without break
        j = 2;
        j++;
    end
    1 : begin
        j = 2;
        j++;
    end
    default : begin
        j = 3;
        j--;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default_empty3_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_simple_default_empty4 (test_cthread_switch_default.cpp:287:5) 

// Next-state combinational logic
always_comb begin : test_switch_simple_default_empty4_comb     // test_cthread_switch_default.cpp:287:5
    test_switch_simple_default_empty4_func;
end
function void test_switch_simple_default_empty4_func;
    integer j;
    case (t)
    0 : begin  // Empty case without break
        j = 3;
        j--;
    end
    1 : begin  // Empty case without break
        j = 3;
        j--;
    end
    default : begin
        j = 3;
        j--;
    end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_simple_default_empty4_ff
    if ( ~arstn ) begin
        integer j;
        j = 0;
    end
    else begin
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_default1 (test_cthread_switch_default.cpp:306:5) 

// Thread-local variables
logic signed [31:0] j;
logic signed [31:0] j_next;
logic test_switch_default1_PROC_STATE;
logic test_switch_default1_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : test_switch_default1_comb     // test_cthread_switch_default.cpp:306:5
    test_switch_default1_func;
end
function void test_switch_default1_func;
    logic [3:0] x;
    j_next = j;
    test_switch_default1_PROC_STATE_next = test_switch_default1_PROC_STATE;
    
    case (test_switch_default1_PROC_STATE)
        0: begin
            test_switch_default1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:313:13;
        end
        1: begin
            case (t)
            0 : begin
                j_next = 1;
            end
            1 : begin
                j_next = 2;
            end
            default : begin
                if (s == j_next)
                begin
                    j_next++;
                end
                for (integer k = 0; k < 2; k++)
                begin
                    j_next--;
                    x = 0;
                    case (s)
                    1 : begin
                        j_next++;
                    end
                    default : begin
                        j_next--;
                        x = j_next;
                    end
                    endcase
                end
            end
            endcase
            test_switch_default1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:313:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_default1_ff
    if ( ~arstn ) begin
        j <= 0;
        test_switch_default1_PROC_STATE <= 0;    // test_cthread_switch_default.cpp:309:9;
    end
    else begin
        j <= j_next;
        test_switch_default1_PROC_STATE <= test_switch_default1_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_default_wait1 (test_cthread_switch_default.cpp:337:5) 

// Thread-local variables
logic signed [31:0] j0;
logic signed [31:0] j_next0;
logic signed [31:0] k;
logic signed [31:0] k_next;
logic [1:0] test_switch_default_wait1_PROC_STATE;
logic [1:0] test_switch_default_wait1_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : test_switch_default_wait1_comb     // test_cthread_switch_default.cpp:337:5
    test_switch_default_wait1_func;
end
function void test_switch_default_wait1_func;
    logic [3:0] x;
    j_next0 = j0;
    k_next = k;
    test_switch_default_wait1_PROC_STATE_next = test_switch_default_wait1_PROC_STATE;
    
    case (test_switch_default_wait1_PROC_STATE)
        0: begin
            test_switch_default_wait1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:344:13;
        end
        1: begin
            case (t)
            0 : begin
                j_next0 = 1;
            end
            1 : begin
                j_next0 = 2;
            end
            default : begin
                if (s == j_next0)
                begin
                    j_next0++;
                    test_switch_default_wait1_PROC_STATE_next = 2; return;    // test_cthread_switch_default.cpp:353:25;
                end
                k_next = 0;
                j_next0--;
                test_switch_default_wait1_PROC_STATE_next = 3; return;    // test_cthread_switch_default.cpp:357:25;
            end
            endcase
            test_switch_default_wait1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:344:13;
        end
        2: begin
            k_next = 0;
            j_next0--;
            test_switch_default_wait1_PROC_STATE_next = 3; return;    // test_cthread_switch_default.cpp:357:25;
        end
        3: begin
            x = 0;
            case (s)
            1 : begin
                j_next0++;
            end
            default : begin
                j_next0--;
                x = j_next0;
            end
            endcase
            k_next++;
            if (k_next < 2)
            begin
                j_next0--;
                test_switch_default_wait1_PROC_STATE_next = 3; return;    // test_cthread_switch_default.cpp:357:25;
            end
            test_switch_default_wait1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:344:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_default_wait1_ff
    if ( ~arstn ) begin
        j0 <= 0;
        test_switch_default_wait1_PROC_STATE <= 0;    // test_cthread_switch_default.cpp:340:9;
    end
    else begin
        j0 <= j_next0;
        k <= k_next;
        test_switch_default_wait1_PROC_STATE <= test_switch_default_wait1_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_default_empty1 (test_cthread_switch_default.cpp:372:5) 

// Thread-local variables
logic signed [31:0] j1;
logic signed [31:0] j_next1;
logic test_switch_default_empty1_PROC_STATE;
logic test_switch_default_empty1_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : test_switch_default_empty1_comb     // test_cthread_switch_default.cpp:372:5
    test_switch_default_empty1_func;
end
function void test_switch_default_empty1_func;
    logic [3:0] x;
    j_next1 = j1;
    test_switch_default_empty1_PROC_STATE_next = test_switch_default_empty1_PROC_STATE;
    
    case (test_switch_default_empty1_PROC_STATE)
        0: begin
            test_switch_default_empty1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:379:13;
        end
        1: begin
            case (t)
            0 : begin  // Empty case without break
                j_next1 = 2;
            end
            1 : begin
                j_next1 = 2;
            end
            default : begin
                if (s == j_next1)
                begin
                    j_next1++;
                end
                for (integer k = 0; k < 2; k++)
                begin
                    j_next1--;
                    x = 0;
                    case (s)
                    1 : begin  // Empty case without break
                        j_next1--;
                        x = j_next1;
                    end
                    default : begin
                        j_next1--;
                        x = j_next1;
                    end
                    endcase
                end
            end
            endcase
            test_switch_default_empty1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:379:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_default_empty1_ff
    if ( ~arstn ) begin
        j1 <= 0;
        test_switch_default_empty1_PROC_STATE <= 0;    // test_cthread_switch_default.cpp:375:9;
    end
    else begin
        j1 <= j_next1;
        test_switch_default_empty1_PROC_STATE <= test_switch_default_empty1_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: test_switch_default_wait_empty1 (test_cthread_switch_default.cpp:403:5) 

// Thread-local variables
logic signed [31:0] j2;
logic signed [31:0] j_next2;
logic signed [31:0] k0;
logic signed [31:0] k_next0;
logic [1:0] test_switch_default_wait_empty1_PROC_STATE;
logic [1:0] test_switch_default_wait_empty1_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : test_switch_default_wait_empty1_comb     // test_cthread_switch_default.cpp:403:5
    test_switch_default_wait_empty1_func;
end
function void test_switch_default_wait_empty1_func;
    logic [3:0] x;
    j_next2 = j2;
    k_next0 = k0;
    test_switch_default_wait_empty1_PROC_STATE_next = test_switch_default_wait_empty1_PROC_STATE;
    
    case (test_switch_default_wait_empty1_PROC_STATE)
        0: begin
            test_switch_default_wait_empty1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:410:13;
        end
        1: begin
            case (t)
            0 : begin  // Empty case without break
                j_next2 = 2;
            end
            1 : begin
                j_next2 = 2;
            end
            default : begin
                if (s == j_next2)
                begin
                    j_next2++;
                    test_switch_default_wait_empty1_PROC_STATE_next = 2; return;    // test_cthread_switch_default.cpp:419:25;
                end
                k_next0 = 0;
                j_next2--;
                test_switch_default_wait_empty1_PROC_STATE_next = 3; return;    // test_cthread_switch_default.cpp:423:25;
            end
            endcase
            test_switch_default_wait_empty1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:410:13;
        end
        2: begin
            k_next0 = 0;
            j_next2--;
            test_switch_default_wait_empty1_PROC_STATE_next = 3; return;    // test_cthread_switch_default.cpp:423:25;
        end
        3: begin
            x = 0;
            case (s)
            1 : begin  // Empty case without break
                j_next2--;
                x = j_next2;
            end
            default : begin
                j_next2--;
                x = j_next2;
            end
            endcase
            k_next0++;
            if (k_next0 < 2)
            begin
                j_next2--;
                test_switch_default_wait_empty1_PROC_STATE_next = 3; return;    // test_cthread_switch_default.cpp:423:25;
            end
            test_switch_default_wait_empty1_PROC_STATE_next = 1; return;    // test_cthread_switch_default.cpp:410:13;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge arstn) 
begin : test_switch_default_wait_empty1_ff
    if ( ~arstn ) begin
        j2 <= 0;
        test_switch_default_wait_empty1_PROC_STATE <= 0;    // test_cthread_switch_default.cpp:406:9;
    end
    else begin
        j2 <= j_next2;
        k0 <= k_next0;
        test_switch_default_wait_empty1_PROC_STATE <= test_switch_default_wait_empty1_PROC_STATE_next;
    end
end

endmodule


