//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.3.7
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
logic a;
logic b;
logic c;


//------------------------------------------------------------------------------

A a_mod
(
  .a(a),
  .b(b),
  .c(c)
);

endmodule



//==============================================================================
//
// Module: A (test_if.cpp:356:5)
//
module A // "b_mod.a_mod"
(
    input logic a,
    output logic b,
    output logic c
);

// SystemC signals
logic s1;
logic s2;

//------------------------------------------------------------------------------
// Method process: if_const_and_signal (test_if.cpp:57:5) 

always_comb 
begin : if_const_and_signal     // test_if.cpp:57:5
end

//------------------------------------------------------------------------------
// Method process: if_empty1 (test_if.cpp:76:5) 

// Process-local variables
logic signed [31:0] n;

always_comb 
begin : if_empty1     // test_if.cpp:76:5
    integer i;
    if (n > 0)
    begin
        i = 3;
    end
    i = 5;
end

//------------------------------------------------------------------------------
// Method process: if_empty2 (test_if.cpp:87:5) 

// Process-local variables
logic signed [31:0] n;

always_comb 
begin : if_empty2     // test_if.cpp:87:5
    integer i;
    if (n > 0)
    begin
    end else begin
        i = 3;
    end
    i = 5;
end

//------------------------------------------------------------------------------
// Method process: if_empty3 (test_if.cpp:98:5) 

// Process-local variables
logic signed [31:0] n;

always_comb 
begin : if_empty3     // test_if.cpp:98:5
    b = 1;
end

//------------------------------------------------------------------------------
// Method process: if_empty4 (test_if.cpp:107:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] n;

always_comb 
begin : if_empty4     // test_if.cpp:107:5
    if (n > 0)
    begin
        if (n > 1)
        begin
            m = 1;
        end
    end
    if (n > 2)
    begin
    end else begin
        m = 2;
    end
    m = 3;
end

//------------------------------------------------------------------------------
// Method process: if_stmt1 (test_if.cpp:125:5) 

always_comb 
begin : if_stmt1     // test_if.cpp:125:5
    integer i;
    integer j_1;
    j_1 = a;
    if (j_1 > 0)
    begin
        i = 1;
    end else begin
        i = 2;
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_stmt2 (test_if.cpp:138:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] n;

always_comb 
begin : if_stmt2     // test_if.cpp:138:5
    integer i;
    if (m > 0)
    begin
        i = 1;
        if (n > 0)
        begin
            i = 3;
        end
        i = 5;
    end else begin
        i = 2;
        if (n > 1)
        begin
            i = 4;
        end
    end
    i = 0;
end

//------------------------------------------------------------------------------
// Method process: if_stmt2a (test_if.cpp:157:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] n;

always_comb 
begin : if_stmt2a     // test_if.cpp:157:5
    integer k_1;
    k_1 = 0;
    if (m > 0)
    begin
        k_1 = 1;
        if (n > 0)
        begin
            k_1 = 2;
        end else begin
            k_1 = 3;
        end
    end else begin
        if (n > 1)
        begin
            k_1 = 4;
        end
    end
    k_1 = 6;
end

//------------------------------------------------------------------------------
// Method process: if_stmt3 (test_if.cpp:180:5) 

// Process-local variables
logic signed [31:0] n;
logic signed [31:0] k;

always_comb 
begin : if_stmt3     // test_if.cpp:180:5
    integer i;
    if (a)
    begin
        i = 1;
        if (n > a)
        begin
            if (k == a)
            begin
                i++;
            end else begin
                i--;
            end
            i = 3;
        end
        i = 5;
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_stmt4 (test_if.cpp:199:5) 

always_comb 
begin : if_stmt4     // test_if.cpp:199:5
    integer i;
    if (a)
    begin
        if (b)
        begin
            i = 1;
        end
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_stmt5 (test_if.cpp:211:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] k;
logic signed [31:0] n;

always_comb 
begin : if_stmt5     // test_if.cpp:211:5
    integer i;
    if (m > 0)
    begin
        i = 1;
        i = 2;
    end
    if (k < 0)
    begin
        i = 3;
        if (n > 0)
        begin
            i = 4;
        end
    end
    i = 5;
    if (k == 0)
    begin
        i = 6;
    end
end

//------------------------------------------------------------------------------
// Method process: if_compl_cond1 (test_if.cpp:231:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] k;

always_comb 
begin : if_compl_cond1     // test_if.cpp:231:5
    integer i;
    if (m == 1 || k == 1)
    begin
        i = 1;
    end else begin
        i = 2;
    end
    if (m > 1 || k < 1)
    begin
        i = 1;
    end
    if (m != k || k != 1)
    begin
    end else begin
        i = 2;
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_compl_cond2 (test_if.cpp:253:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] k;

always_comb 
begin : if_compl_cond2     // test_if.cpp:253:5
    integer i;
    if (m == 1 && k == 1)
    begin
        i = 1;
    end else begin
        i = 2;
    end
    if (m > 1 && k < 1)
    begin
        i = 1;
    end
    if (m != k && k != 1)
    begin
    end else begin
        i = 2;
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_compl_cond3 (test_if.cpp:275:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] k;

always_comb 
begin : if_compl_cond3     // test_if.cpp:275:5
    integer i;
    if (m == 1 && k == 2 || k < m)
    begin
        i = 1;
    end else begin
        i = 2;
    end
    if (m == 1 || k == 2 && k < m)
    begin
        i = 1;
    end
    if (m == 1 && k == 1 || m == 2 && k == 2)
    begin
    end else begin
        i = 2;
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_compl_cond4 (test_if.cpp:297:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] k;

always_comb 
begin : if_compl_cond4     // test_if.cpp:297:5
    integer i;
    if (m == 1 && (k == 2 || k < m))
    begin
        i = 1;
    end else begin
        i = 2;
    end
    if ((m == 1 || k == 2) && k < m)
    begin
        i = 1;
    end
    if (m == 1 && (k == 1 || m == 2) && k == 2)
    begin
    end else begin
        i = 2;
    end
    b = |i;
end

//------------------------------------------------------------------------------
// Method process: if_const (test_if.cpp:319:5) 

// Process-local variables
logic signed [31:0] m;
logic signed [31:0] k;

always_comb 
begin : if_const     // test_if.cpp:319:5
    integer i;
    if (0)
    begin
    end else begin
        i = m;
    end
    if (1)
    begin
        i = m;
    end
    if (0)
    begin
    end else begin
        i = k;
    end
    if (1)
    begin
        i = m;
    end
end

endmodule

