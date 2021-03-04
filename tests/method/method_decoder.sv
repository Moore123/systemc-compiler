//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.12
// see more information at https://github.com/intel/systemc-compiler
//
//==============================================================================

//==============================================================================
//
// Module: B_top ()
//
module B_top // "b_mod"
(
);

// SystemC signals
logic enable;
logic [15:0] data_in;
logic [3:0] bdata_in;
logic [3:0] binary_dout;
logic [3:0] binary_case_dout;
logic [3:0] binary_prior_dout;
logic [3:0] binary_prior_assign_dout;
logic [15:0] binary_decoder_case_dout;
logic [15:0] binary_decoder_assign_dout;


//------------------------------------------------------------------------------

A a_mod
(
  .enable(enable),
  .data_in(data_in),
  .bdata_in(bdata_in),
  .binary_dout(binary_dout),
  .binary_case_dout(binary_case_dout),
  .binary_prior_dout(binary_prior_dout),
  .binary_prior_assign_dout(binary_prior_assign_dout),
  .binary_decoder_case_dout(binary_decoder_case_dout),
  .binary_decoder_assign_dout(binary_decoder_assign_dout)
);

endmodule



//==============================================================================
//
// Module: A (test_decoder.cpp:212:5)
//
module A // "b_mod.a_mod"
(
    input logic enable,
    input logic [15:0] data_in,
    input logic [3:0] bdata_in,
    output logic [3:0] binary_dout,
    output logic [3:0] binary_case_dout,
    output logic [3:0] binary_prior_dout,
    output logic [3:0] binary_prior_assign_dout,
    output logic [15:0] binary_decoder_case_dout,
    output logic [15:0] binary_decoder_assign_dout
);

//------------------------------------------------------------------------------
// Method process: encoder_ifelse (test_decoder.cpp:44:5) 

always_comb 
begin : encoder_ifelse     // test_decoder.cpp:44:5
    binary_dout = 0;
    if (enable)
    begin
        if (data_in == 'h2)
        begin
            binary_dout = 1;
        end
        if (data_in == 'h4)
        begin
            binary_dout = 2;
        end
        if (data_in == 'h8)
        begin
            binary_dout = 3;
        end
        if (data_in == 'h10)
        begin
            binary_dout = 4;
        end
        if (data_in == 'h20)
        begin
            binary_dout = 5;
        end
        if (data_in == 'h40)
        begin
            binary_dout = 6;
        end
        if (data_in == 'h80)
        begin
            binary_dout = 7;
        end
        if (data_in == 'h100)
        begin
            binary_dout = 8;
        end
        if (data_in == 'h200)
        begin
            binary_dout = 9;
        end
        if (data_in == 'h400)
        begin
            binary_dout = 10;
        end
        if (data_in == 'h800)
        begin
            binary_dout = 11;
        end
        if (data_in == 'h1000)
        begin
            binary_dout = 12;
        end
        if (data_in == 'h2000)
        begin
            binary_dout = 13;
        end
        if (data_in == 'h4000)
        begin
            binary_dout = 14;
        end
        if (data_in == 'h8000)
        begin
            binary_dout = 15;
        end
    end
end

//------------------------------------------------------------------------------
// Method process: encoder_case (test_decoder.cpp:81:5) 

always_comb 
begin : encoder_case     // test_decoder.cpp:81:5
    binary_case_dout = 0;
    if (enable)
    begin
        case (data_in)
        2 : begin
            binary_case_dout = 1;
        end
        4 : begin
            binary_case_dout = 2;
        end
        8 : begin
            binary_case_dout = 3;
        end
        16 : begin
            binary_case_dout = 4;
        end
        32 : begin
            binary_case_dout = 5;
        end
        64 : begin
            binary_case_dout = 6;
        end
        128 : begin
            binary_case_dout = 7;
        end
        256 : begin
            binary_case_dout = 8;
        end
        512 : begin
            binary_case_dout = 9;
        end
        1024 : begin
            binary_case_dout = 10;
        end
        2048 : begin
            binary_case_dout = 11;
        end
        4096 : begin
            binary_case_dout = 12;
        end
        8192 : begin
            binary_case_dout = 13;
        end
        16384 : begin
            binary_case_dout = 14;
        end
        32768 : begin
            binary_case_dout = 15;
        end
        endcase
    end
end

//------------------------------------------------------------------------------
// Method process: priority_ifelse (test_decoder.cpp:104:5) 

always_comb 
begin : priority_ifelse     // test_decoder.cpp:104:5
    binary_prior_dout = 0;
    if (enable)
    begin
        if (data_in[0] == 1)
        begin
            binary_prior_dout = 0;
        end else begin
            if (data_in[1] == 1)
            begin
                binary_prior_dout = 1;
            end else begin
                if (data_in[2] == 1)
                begin
                    binary_prior_dout = 2;
                end else begin
                    if (data_in[3] == 1)
                    begin
                        binary_prior_dout = 3;
                    end else begin
                        if (data_in[4] == 1)
                        begin
                            binary_prior_dout = 4;
                        end else begin
                            if (data_in[5] == 1)
                            begin
                                binary_prior_dout = 5;
                            end else begin
                                if (data_in[6] == 1)
                                begin
                                    binary_prior_dout = 6;
                                end else begin
                                    if (data_in[7] == 1)
                                    begin
                                        binary_prior_dout = 7;
                                    end else begin
                                        if (data_in[8] == 1)
                                        begin
                                            binary_prior_dout = 8;
                                        end else begin
                                            if (data_in[9] == 1)
                                            begin
                                                binary_prior_dout = 9;
                                            end else begin
                                                if (data_in[10] == 1)
                                                begin
                                                    binary_prior_dout = 10;
                                                end else begin
                                                    if (data_in[11] == 1)
                                                    begin
                                                        binary_prior_dout = 11;
                                                    end else begin
                                                        if (data_in[12] == 1)
                                                        begin
                                                            binary_prior_dout = 12;
                                                        end else begin
                                                            if (data_in[13] == 1)
                                                            begin
                                                                binary_prior_dout = 13;
                                                            end else begin
                                                                if (data_in[14] == 1)
                                                                begin
                                                                    binary_prior_dout = 14;
                                                                end else begin
                                                                    if (data_in[15] == 1)
                                                                    begin
                                                                        binary_prior_dout = 15;
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

//------------------------------------------------------------------------------
// Method process: priority_assign (test_decoder.cpp:143:5) 

always_comb 
begin : priority_assign     // test_decoder.cpp:143:5
    binary_prior_assign_dout = (!enable) ? 0 : (data_in[0] ? 0 : data_in[1] ? 1 : data_in[2] ? 2 : data_in[3] ? 3 : data_in[4] ? 4 : data_in[5] ? 5 : data_in[6] ? 6 : data_in[7] ? 7 : data_in[8] ? 8 : data_in[9] ? 9 : data_in[10] ? 10 : data_in[11] ? 11 : data_in[12] ? 12 : data_in[13] ? 13 : data_in[14] ? 14 : 15);
end

//------------------------------------------------------------------------------
// Method process: decoder_case (test_decoder.cpp:162:5) 

always_comb 
begin : decoder_case     // test_decoder.cpp:162:5
    binary_decoder_case_dout = 0;
    if (enable)
    begin
        case (bdata_in)
        0 : begin
            binary_decoder_case_dout = 1;
        end
        1 : begin
            binary_decoder_case_dout = 'h2;
        end
        2 : begin
            binary_decoder_case_dout = 'h4;
        end
        3 : begin
            binary_decoder_case_dout = 'h8;
        end
        4 : begin
            binary_decoder_case_dout = 'h10;
        end
        5 : begin
            binary_decoder_case_dout = 'h20;
        end
        6 : begin
            binary_decoder_case_dout = 'h40;
        end
        7 : begin
            binary_decoder_case_dout = 'h80;
        end
        8 : begin
            binary_decoder_case_dout = 'h100;
        end
        9 : begin
            binary_decoder_case_dout = 'h200;
        end
        10 : begin
            binary_decoder_case_dout = 'h400;
        end
        11 : begin
            binary_decoder_case_dout = 'h800;
        end
        12 : begin
            binary_decoder_case_dout = 'h1000;
        end
        13 : begin
            binary_decoder_case_dout = 'h2000;
        end
        14 : begin
            binary_decoder_case_dout = 'h4000;
        end
        15 : begin
            binary_decoder_case_dout = 'h8000;
        end
        endcase
    end
end

//------------------------------------------------------------------------------
// Method process: decoder_assign (test_decoder.cpp:185:5) 

always_comb 
begin : decoder_assign     // test_decoder.cpp:185:5
    binary_decoder_assign_dout = enable ? (1 <<< bdata_in) : 'b0;
end

endmodule


