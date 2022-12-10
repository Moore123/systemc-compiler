//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.4.16
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: A ()
//
module A // "a_mod"
(
    input logic clk
);

// Variables generated for SystemC signals
logic nrst;
logic [3:0] s;

// Local parameters generated for C++ constants
localparam logic [41:0] d = 0;

//------------------------------------------------------------------------------
// Clocked THREAD: var1 (test_cthread_read_defined_2.cpp:46:5) 

// Thread-local variables
logic [3:0] a;
logic [3:0] a_next;
logic signed [71:0] e;
logic signed [71:0] e_next;
logic signed [31:0] l;
logic signed [31:0] l_next;
logic signed [15:0] c;
logic [1:0] var1_PROC_STATE;
logic [1:0] var1_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : var1_comb     // test_cthread_read_defined_2.cpp:46:5
    var1_func;
end
function void var1_func;
    a_next = a;
    e_next = e;
    l_next = l;
    var1_PROC_STATE_next = var1_PROC_STATE;
    
    case (var1_PROC_STATE)
        0: begin
            l_next = 32'(d) + a_next;
            if (l_next < e_next)
            begin
                var1_PROC_STATE_next = 1; return;    // test_cthread_read_defined_2.cpp:66:17;
            end
            var1_PROC_STATE_next = 2; return;    // test_cthread_read_defined_2.cpp:69:13;
        end
        1: begin
            if (l_next < e_next)
            begin
                var1_PROC_STATE_next = 1; return;    // test_cthread_read_defined_2.cpp:66:17;
            end
            var1_PROC_STATE_next = 2; return;    // test_cthread_read_defined_2.cpp:69:13;
        end
        2: begin
            l_next = 32'(d) + a_next;
            if (l_next < e_next)
            begin
                var1_PROC_STATE_next = 1; return;    // test_cthread_read_defined_2.cpp:66:17;
            end
            var1_PROC_STATE_next = 2; return;    // test_cthread_read_defined_2.cpp:69:13;
        end
    endcase
endfunction

// Synchronous register update
always_ff @(posedge clk or negedge nrst) 
begin : var1_ff
    if ( ~nrst ) begin
        logic signed [15:0] c;
        a <= 1;
        if (|s)
        begin
            c = a;
        end
        var1_PROC_STATE <= 0;    // test_cthread_read_defined_2.cpp:55:9;
    end
    else begin
        a <= a_next;
        e <= e_next;
        l <= l_next;
        var1_PROC_STATE <= var1_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: arr1 (test_cthread_read_defined_2.cpp:73:5) 

// Thread-local variables
logic [3:0] arra[4];
logic [3:0] arra_next[4];
logic arrb[8][8];
logic arrb_next[8][8];
logic signed [63:0] arrc[2][1];
logic signed [63:0] arrc_next[2][1];
logic [31:0] arrd[7];
logic signed [31:0] arre[2];
logic [1:0] arr1_PROC_STATE;
logic [1:0] arr1_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : arr1_comb     // test_cthread_read_defined_2.cpp:73:5
    arr1_func;
end
function void arr1_func;
    integer i_1;
    arra_next = arra;
    arrb_next = arrb;
    arrc_next = arrc;
    arr1_PROC_STATE_next = arr1_PROC_STATE;
    
    case (arr1_PROC_STATE)
        0: begin
            if (arra_next[1] == s)
            begin
                arrb_next[s][s + 1] = |arra_next[2];
            end
            arr1_PROC_STATE_next = 1; return;    // test_cthread_read_defined_2.cpp:90:13;
        end
        1: begin
            i_1 = arra_next[s];
            do
            begin
                i_1--;
                arrc_next[i_1 + 1][0] = arrb_next[i_1][i_1] ? 32'(s) : 1;
            end
            while (i_1 > 0 && |arrc_next[i_1][0]);
            arr1_PROC_STATE_next = 2; return;    // test_cthread_read_defined_2.cpp:99:13;
        end
        2: begin
            arre[0] = 1;
            if (arra_next[1] == s)
            begin
                arrb_next[s][s + 1] = |arra_next[2];
            end
            arr1_PROC_STATE_next = 1; return;    // test_cthread_read_defined_2.cpp:90:13;
        end
    endcase
endfunction

// Synchronous register update
always_ff @(posedge clk or negedge nrst) 
begin : arr1_ff
    if ( ~nrst ) begin
        integer unsigned arrd[7];
        for (integer i = 0; i < 4; i++)
        begin
            arra[i] <= i;
            arrd[i] = 0;
        end
        arr1_PROC_STATE <= 0;    // test_cthread_read_defined_2.cpp:81:9;
    end
    else begin
        arra <= arra_next;
        arrb <= arrb_next;
        arrc <= arrc_next;
        arr1_PROC_STATE <= arr1_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Method process: for_stmt1 (test_cthread_read_defined_2.cpp:106:5) 

always_comb 
begin : for_stmt1     // test_cthread_read_defined_2.cpp:106:5
    integer ii;
    integer jj;
    integer lo;
    integer hi;
    integer k;
    lo = 1;
    hi = 2;
    for (integer i = lo; i < hi; i++)
    begin
        k = ii;
        k = jj + 1;
    end
end

//------------------------------------------------------------------------------
// Method process: while_stmt1 (test_cthread_read_defined_2.cpp:119:5) 

always_comb 
begin : while_stmt1     // test_cthread_read_defined_2.cpp:119:5
    integer lo;
    integer hi;
    integer i;
    lo = 1;
    hi = 2;
    i = lo;
    while (i < hi)
    begin
        i++;
    end
end

endmodule

