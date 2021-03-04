//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: Dut ()
//
module Dut // "dut"
(
    input logic clk
);

// SystemC signals
logic nrst;
logic [3:0] s;
logic [3:0] ptar_s2;
logic slave_clk;
logic slave_nrst;

assign slave_clk = clk;
assign slave_nrst = nrst;

//------------------------------------------------------------------------------
// Method process: slave_methProc (test_sc_port_dyn.cpp:40:5) 

// Process-local variables
logic [3:0] ptar_l1;

always_comb 
begin : slave_methProc     // test_sc_port_dyn.cpp:40:5
    logic [3:0] val;
    val = 0;
    // Call g() begin
    ptar_l1 = val;
    ptar_s2 = ptar_l1 + 1;
    // Call g() end
end

//------------------------------------------------------------------------------
// Clocked THREAD: slave_threadProc (test_sc_port_dyn.cpp:45:5) 

// Thread-local variables
logic [3:0] s_next;
logic [3:0] a;
logic [3:0] a_next;

// Next-state combinational logic
always_comb begin : slave_threadProc_comb     // test_sc_port_dyn.cpp:45:5
    slave_threadProc_func;
end
function void slave_threadProc_func;
    logic [3:0] TMP_0;
    logic [3:0] val;
    logic [3:0] TMP_1;
    a_next = a;
    s_next = s;
    val = a_next;
    // Call f() begin
    s_next = val;
    TMP_1 = val + 1;
    // Call f() end
    a_next = TMP_1;
endfunction

// Syncrhonous register update
always_ff @(posedge slave_clk or negedge slave_nrst) 
begin : slave_threadProc_ff
    if ( ~slave_nrst ) begin
        logic [3:0] TMP_0;
        logic [3:0] val;
        a <= 0;
        val = 0;
        // Call f() begin
        s <= val;
        TMP_0 = val + 1;
        // Call f() end
    end
    else begin
        s <= s_next;
        a <= a_next;
    end
end

//------------------------------------------------------------------------------
// Method process: methProc (test_sc_port_dyn.cpp:116:5) 

// Process-local variables
logic [3:0] ptar_l2;

always_comb 
begin : methProc     // test_sc_port_dyn.cpp:116:5
    logic [3:0] TMP_0;
    logic [3:0] a;
    // Call h() begin
    TMP_0 = ptar_l2 + ptar_s2;
    // Call h() end
    a = TMP_0;
end

endmodule


