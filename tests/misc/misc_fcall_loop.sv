//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.4.4
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
    input logic rst
);

// Variables generated for SystemC signals
logic [47:0] st_slt_dims[2];

// Local parameters generated for C++ constants
localparam logic [31:0] TileDimWidth = 12;
localparam logic [31:0] TileDimsNum = 4;
localparam logic [31:0] EdmaStoreSlots = 2;

//------------------------------------------------------------------------------
// Method process: methProc1 (test_fcall_loop.cpp:49:5) 

always_comb 
begin : methProc1     // test_fcall_loop.cpp:49:5
    integer i_1;
    integer l;
    for (integer i = 0; i < 2; ++i)
    begin
        i_1 = i;
        // Call f() begin
        l = i_1;
        // Call f() end
    end
    i_1 = 0;
    // Call f() begin
    l = i_1;
    // Call f() end
end

//------------------------------------------------------------------------------
// Method process: methProc2 (test_fcall_loop.cpp:57:5) 

always_comb 
begin : methProc2     // test_fcall_loop.cpp:57:5
    integer i;
    integer l;
    i = 0;
    // Call f() begin
    l = i;
    // Call f() end
    for (integer i_1 = 0; i_1 < 2; ++i_1)
    begin
        i = i_1;
        // Call f() begin
        l = i;
        // Call f() end
    end
end

//------------------------------------------------------------------------------
// Method process: methProc3 (test_fcall_loop.cpp:65:5) 

always_comb 
begin : methProc3     // test_fcall_loop.cpp:65:5
    integer i_1;
    integer l;
    for (integer i = 0; i < 2; ++i)
    begin
        i_1 = i;
        // Call f() begin
        l = i_1;
        // Call f() end
    end
    for (integer i_2 = 0; i_2 < 2; ++i_2)
    begin
        i_1 = i_2 + 1;
        // Call f() begin
        l = i_1;
        // Call f() end
    end
end

//------------------------------------------------------------------------------
// Method process: methProc4 (test_fcall_loop.cpp:75:5) 

always_comb 
begin : methProc4     // test_fcall_loop.cpp:75:5
    integer i;
    integer l;
    i = 0;
    // Call f() begin
    l = i;
    // Call f() end
    for (integer i_1 = 0; i_1 < 2; ++i_1)
    begin
        i = i_1;
        // Call f() begin
        l = i;
        // Call f() end
    end
    for (integer i_2 = 0; i_2 < 2; ++i_2)
    begin
        i = i_2 + 1;
        // Call f() begin
        l = i;
        // Call f() end
    end
end

//------------------------------------------------------------------------------
// Method process: methProc5 (test_fcall_loop.cpp:86:5) 

always_comb 
begin : methProc5     // test_fcall_loop.cpp:86:5
    integer i_1;
    integer l;
    for (integer i = 0; i < 2; ++i)
    begin
        i_1 = i;
        // Call f() begin
        l = i_1;
        // Call f() end
    end
    i_1 = 0;
    // Call f() begin
    l = i_1;
    // Call f() end
    for (integer i_2 = 0; i_2 < 2; ++i_2)
    begin
        i_1 = i_2 + 1;
        // Call f() begin
        l = i_1;
        // Call f() end
    end
end

//------------------------------------------------------------------------------
// Method process: methProc6 (test_fcall_loop.cpp:97:5) 

always_comb 
begin : methProc6     // test_fcall_loop.cpp:97:5
    integer i_1;
    integer l;
    for (integer i = 0; i < 2; ++i)
    begin
        i_1 = i;
        // Call f() begin
        l = i_1;
        // Call f() end
        for (integer i_2 = 0; i_2 < 3; ++i_2)
        begin
            i_1 = i_2 + 1;
            // Call f() begin
            l = i_1;
            // Call f() end
        end
    end
end

//------------------------------------------------------------------------------
// Method process: methProc7 (test_fcall_loop.cpp:107:5) 

always_comb 
begin : methProc7     // test_fcall_loop.cpp:107:5
    integer i_2;
    integer l;
    for (integer i = 0; i < 2; ++i)
    begin
        for (integer i_1 = 0; i_1 < 3; ++i_1)
        begin
            i_2 = i_1 + 1;
            // Call f() begin
            l = i_2;
            // Call f() end
        end
        i_2 = i;
        // Call f() begin
        l = i_2;
        // Call f() end
    end
end

//------------------------------------------------------------------------------
// Method process: methProc8 (test_fcall_loop.cpp:118:5) 

always_comb 
begin : methProc8     // test_fcall_loop.cpp:118:5
    integer k;
    for (integer i = 0; i < 2; ++i)
    begin
        for (integer i_1 = 0; i_1 < 3; ++i_1)
        begin
            k = i_1 + i;
        end
    end
end

//------------------------------------------------------------------------------
// Clocked THREAD: threadProc (test_fcall_loop.cpp:144:5) 

// Thread-local variables
logic [31:0] slot;
logic [31:0] slot_next;
logic xtc;
logic xtc_next;
logic [47:0] xes;
logic [47:0] xes_next;
logic [1:0] threadProc_PROC_STATE;
logic [1:0] threadProc_PROC_STATE_next;

// Next-state combinational logic
always_comb begin : threadProc_comb     // test_fcall_loop.cpp:144:5
    threadProc_func;
end
function void threadProc_func;
    logic [11:0] TMP_0;
    logic [47:0] dims;
    integer unsigned i;
    logic [19:0] ax0;
    logic TMP_2;
    logic [47:0] dims_1;
    logic [11:0] xes_nxt[4];
    logic [11:0] TMP_3;
    logic [11:0] TMP_4;
    logic TMP_6;
    logic [11:0] TMP_7;
    logic [11:0] TMP_8;
    logic TMP_10;
    logic [11:0] TMP_11;
    slot_next = slot;
    xes_next = xes;
    xtc_next = xtc;
    threadProc_PROC_STATE_next = threadProc_PROC_STATE;
    
    case (threadProc_PROC_STATE)
        0: begin
            xes_next = 0;
            xtc_next = 0;
            dims = xes_next; i = 0;
            // Call getDim() begin
            TMP_0 = dims[i * TileDimWidth +: 12];
            // Call getDim() end
            ax0 = TMP_0;
            dims_1 = st_slt_dims[slot_next];
            // Call incElIdx() begin
            xes_nxt[0] = 0; xes_nxt[1] = 0; xes_nxt[2] = 0; xes_nxt[3] = 0;
            for (integer unsigned i_1 = 0; i_1 < TileDimsNum; ++i_1)
            begin
                dims = xes_next; i = i_1;
                // Call getDim() begin
                TMP_3 = dims[i * TileDimWidth +: 12];
                // Call getDim() end
                xes_nxt[i_1] = TMP_3;
            end
            TMP_2 = |xes_nxt[0];
            // Call incElIdx() end
            xtc_next = TMP_2;
            threadProc_PROC_STATE_next = 1; return;    // test_fcall_loop.cpp:158:17;
        end
        1: begin
            if (1)
            begin
                dims = xes_next; i = 0;
                // Call getDim() begin
                TMP_4 = dims[i * TileDimWidth +: 12];
                // Call getDim() end
                ax0 = TMP_4;
                dims_1 = st_slt_dims[slot_next];
                // Call incElIdx() begin
                xes_nxt[0] = 0; xes_nxt[1] = 0; xes_nxt[2] = 0; xes_nxt[3] = 0;
                for (integer unsigned i_1 = 0; i_1 < TileDimsNum; ++i_1)
                begin
                    dims = xes_next; i = i_1;
                    // Call getDim() begin
                    TMP_7 = dims[i * TileDimWidth +: 12];
                    // Call getDim() end
                    xes_nxt[i_1] = TMP_7;
                end
                TMP_6 = |xes_nxt[0];
                // Call incElIdx() end
                xtc_next = TMP_6;
                threadProc_PROC_STATE_next = 1; return;    // test_fcall_loop.cpp:158:17;
            end
            slot_next = (slot_next == EdmaStoreSlots - 1) ? 0 : slot_next + 1;
            threadProc_PROC_STATE_next = 2; return;    // test_fcall_loop.cpp:162:13;
        end
        2: begin
            xes_next = 0;
            xtc_next = 0;
            dims = xes_next; i = 0;
            // Call getDim() begin
            TMP_8 = dims[i * TileDimWidth +: 12];
            // Call getDim() end
            ax0 = TMP_8;
            dims_1 = st_slt_dims[slot_next];
            // Call incElIdx() begin
            xes_nxt[0] = 0; xes_nxt[1] = 0; xes_nxt[2] = 0; xes_nxt[3] = 0;
            for (integer unsigned i_1 = 0; i_1 < TileDimsNum; ++i_1)
            begin
                dims = xes_next; i = i_1;
                // Call getDim() begin
                TMP_11 = dims[i * TileDimWidth +: 12];
                // Call getDim() end
                xes_nxt[i_1] = TMP_11;
            end
            TMP_10 = |xes_nxt[0];
            // Call incElIdx() end
            xtc_next = TMP_10;
            threadProc_PROC_STATE_next = 1; return;    // test_fcall_loop.cpp:158:17;
        end
    endcase
endfunction

// Syncrhonous register update
always_ff @(posedge clk or negedge rst) 
begin : threadProc_ff
    if ( ~rst ) begin
        slot <= 0;
        threadProc_PROC_STATE <= 0;    // test_fcall_loop.cpp:147:9;
    end
    else begin
        slot <= slot_next;
        xtc <= xtc_next;
        xes <= xes_next;
        threadProc_PROC_STATE <= threadProc_PROC_STATE_next;
    end
end

endmodule

