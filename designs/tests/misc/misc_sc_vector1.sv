//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.4.32
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: Top ()
//
module Top // "top"
(
    input logic clk,
    input logic req[3],
    output logic res[3],
    output logic res_[3]
);

// Variables generated for SystemC signals
logic rstn;
logic enb[4];
logic [4:0] val[4];
logic signed [6:0] mval[2];
logic signed [31:0] val2d[2][3];

//------------------------------------------------------------------------------
// Method process: simpleMeth (test_sc_vector1.cpp:54:5) 

always_comb 
begin : simpleMeth     // test_sc_vector1.cpp:54:5
    logic b;
    integer r;
    b = enb[3];
    for (integer i = 0; i < 3; ++i)
    begin
        b = b ^ req[i] ^ req[i];
    end
    for (integer i_1 = 0; i_1 < 2; ++i_1)
    begin
        r = 0;
        for (integer j = 0; j < 3; ++j)
        begin
            r = r - val2d[i_1][j];
        end
        mval[i_1] = r;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: matchThread (test_sc_vector1.cpp:71:5) 

// Thread-local variables
logic res_next[3];
logic res__next[3];
logic matchThread_PROC_STATE;
logic matchThread_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : matchThread_comb     // test_sc_vector1.cpp:71:5
    matchThread_func;
end
function void matchThread_func;
    logic b;
    logic c;
    res__next = res_;
    res_next = res;
    matchThread_PROC_STATE_next = matchThread_PROC_STATE;
    
    case (matchThread_PROC_STATE)
        0: begin
            for (integer i_1 = 0; i_1 < 3; ++i_1)
            begin
                res_next[i_1] = req[i_1];
                res__next[i_1] = req[i_1];
            end
            matchThread_PROC_STATE_next = 1; return;    // test_sc_vector1.cpp:82:13;
        end
        1: begin
            b = res[1];
            c = res_[1];
            for (integer i_1 = 0; i_1 < 3; ++i_1)
            begin
                res_next[i_1] = req[i_1];
                res__next[i_1] = req[i_1];
            end
            matchThread_PROC_STATE_next = 1; return;    // test_sc_vector1.cpp:82:13;
        end
    endcase
endfunction

// Synchronous register update
always_ff @(posedge clk or negedge rstn) 
begin : matchThread_ff
    if ( ~rstn ) begin
        for (integer i = 0; i < 3; ++i)
        begin
            res[i] <= 0;
            res_[i] <= 0;
        end
        matchThread_PROC_STATE <= 0;    // test_sc_vector1.cpp:76:9;
    end
    else begin
        res <= res_next;
        res_ <= res__next;
        matchThread_PROC_STATE <= matchThread_PROC_STATE_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: signalThread (test_sc_vector1.cpp:89:5) 

// Thread-local variables
logic [4:0] val_next[4];
logic enb_next[4];

// Next-state combinational logic
always_comb begin : signalThread_comb     // test_sc_vector1.cpp:89:5
    signalThread_func;
end
function void signalThread_func;
    enb_next = enb;
    val_next = val;
    for (integer i_1 = 0; i_1 < 4; ++i_1)
    begin
        val_next[i_1] = enb[i_1] ? i_1 : i_1 + 1;
    end
    if (val[1] == val[2])
    begin
        enb_next[1] = 0;
    end
endfunction

// Synchronous register update
always_ff @(posedge clk or negedge rstn) 
begin : signalThread_ff
    if ( ~rstn ) begin
        for (integer i = 0; i < 3; ++i)
        begin
            val[i + 1] <= i;
            enb[i] <= 0;
        end
        enb[3] <= 1;
    end
    else begin
        val <= val_next;
        enb <= enb_next;
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: vector2DThread (test_sc_vector1.cpp:110:5) 

// Thread-local variables
logic signed [31:0] val2d_next[2][3];
logic vector2DThread_PROC_STATE;
logic vector2DThread_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : vector2DThread_comb     // test_sc_vector1.cpp:110:5
    vector2DThread_func;
end
function void vector2DThread_func;
    logic b;
    val2d_next = val2d;
    vector2DThread_PROC_STATE_next = vector2DThread_PROC_STATE;
    
    case (vector2DThread_PROC_STATE)
        0: begin
            for (integer j_1 = 0; j_1 < 3; ++j_1)
            begin
                val2d_next[0][j_1] = val[j_1] + 1;
            end
            vector2DThread_PROC_STATE_next = 1; return;    // test_sc_vector1.cpp:122:13;
        end
        1: begin
            b = |(val2d[0][1] + val2d[1][2]);
            for (integer j_1 = 0; j_1 < 3; ++j_1)
            begin
                val2d_next[0][j_1] = val[j_1] + 1;
            end
            vector2DThread_PROC_STATE_next = 1; return;    // test_sc_vector1.cpp:122:13;
        end
    endcase
endfunction

// Synchronous register update
always_ff @(posedge clk or negedge rstn) 
begin : vector2DThread_ff
    if ( ~rstn ) begin
        for (integer i = 0; i < 2; ++i)
        begin
            for (integer j = 0; j < 3; ++j)
            begin
                val2d[i][j] <= 0;
            end
        end
        vector2DThread_PROC_STATE <= 0;    // test_sc_vector1.cpp:116:9;
    end
    else begin
        val2d <= val2d_next;
        vector2DThread_PROC_STATE <= vector2DThread_PROC_STATE_next;
    end
end

endmodule

