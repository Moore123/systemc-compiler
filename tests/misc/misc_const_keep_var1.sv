//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: B ()
//
module B // "mod"
(
    input logic clk
);

// SystemC signals
logic signed [31:0] a1_s;
logic signed [31:0] a2_s;
logic signed [31:0] a3_s;
logic signed [31:0] a4_s;

// C++ data variables
localparam logic [31:0] a1_BYTE_EN_WIDTH = 'd16;
localparam logic [31:0] a2_BYTE_EN_WIDTH = 'd8;

//------------------------------------------------------------------------------
// Method process: a1_byteEnProc (test_const_keep_var1.cpp:33:5) 

always_comb 
begin : a1_byteEnProc     // test_const_keep_var1.cpp:33:5
    logic [31:0] data;
    logic b;
    data = a1_s;
    for (integer unsigned i = 0; i < a1_BYTE_EN_WIDTH; ++i)
    begin
        b = data[2 * i];
    end
end

//------------------------------------------------------------------------------
// Method process: a2_byteEnProc (test_const_keep_var1.cpp:33:5) 

always_comb 
begin : a2_byteEnProc     // test_const_keep_var1.cpp:33:5
    logic [31:0] data;
    logic b;
    data = a2_s;
    for (integer unsigned i = 0; i < a2_BYTE_EN_WIDTH; ++i)
    begin
        b = data[4 * i];
    end
end

//------------------------------------------------------------------------------
// Method process: a3_byteEnProc (test_const_keep_var1.cpp:33:5) 

always_comb 
begin : a3_byteEnProc     // test_const_keep_var1.cpp:33:5
    logic [31:0] data;
    logic b;
    data = a3_s;
    for (integer unsigned i = 0; i < a2_BYTE_EN_WIDTH; ++i)
    begin
        b = data[4 * i];
    end
end

//------------------------------------------------------------------------------
// Method process: a4_byteEnProc (test_const_keep_var1.cpp:33:5) 

always_comb 
begin : a4_byteEnProc     // test_const_keep_var1.cpp:33:5
    logic [31:0] data;
    logic b;
    data = a4_s;
    for (integer unsigned i = 0; i < a1_BYTE_EN_WIDTH; ++i)
    begin
        b = data[2 * i];
    end
end

endmodule


