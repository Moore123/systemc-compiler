//==============================================================================
//
// The code is generated by Intel Compiler for SystemC, version 1.4.16
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

// Variables generated for SystemC signals
logic a;
logic b;
logic c;


//------------------------------------------------------------------------------
// Child module instances

A a_mod
(
  .a(a),
  .b(b),
  .c(c)
);

endmodule



//==============================================================================
//
// Module: A (test_cond_oper.cpp:320:5)
//
module A // "b_mod.a_mod"
(
    input logic a,
    output logic b,
    output logic c
);

// Variables generated for SystemC signals
logic s;
logic s1;
logic s2;

//------------------------------------------------------------------------------
// Method process: dead_cond_error (test_cond_oper.cpp:58:5) 
// Empty process, no code generated 

//------------------------------------------------------------------------------
// Method process: cond_oper_for_channels (test_cond_oper.cpp:68:5) 

always_comb 
begin : cond_oper_for_channels     // test_cond_oper.cpp:68:5
    logic b_1;
    integer m_1;
    integer k_1;
    m_1 = s;
    k_1 = s;
    b_1 = |k_1 ? s1 : s2;
    b_1 = |k_1 ? s1 : s2;
end

//------------------------------------------------------------------------------
// Method process: logic_expr1 (test_cond_oper.cpp:79:5) 

always_comb 
begin : logic_expr1     // test_cond_oper.cpp:79:5
    integer m_1;
    integer k_1;
    logic l0;
    logic l1;
    logic l2;
    logic l3;
    logic l4;
    m_1 = s;
    k_1 = s;
    l0 = !(m_1 == k_1);
    l1 = m_1 == 1 || k_1 == 1;
    l2 = (m_1 > 1 || k_1 < 1);
    l3 = m_1 != k_1 || k_1 != 1;
    l4 = (m_1 > 1 || !(k_1 > 1) || k_1 > m_1 || k_1 < m_1);
end

//------------------------------------------------------------------------------
// Method process: logic_expr2 (test_cond_oper.cpp:90:5) 

always_comb 
begin : logic_expr2     // test_cond_oper.cpp:90:5
    integer m_1;
    integer k_1;
    logic l1;
    logic l2;
    logic l3;
    logic l4;
    m_1 = s;
    k_1 = s;
    l1 = m_1 == 1 && k_1 == 1;
    l2 = (m_1 > 1 && k_1 < 1);
    l3 = m_1 != k_1 && k_1 != 1;
    l4 = (m_1 > 1 && k_1 > 1 && k_1 > m_1 && !(m_1 == k_1));
end

//------------------------------------------------------------------------------
// Method process: logic_expr3 (test_cond_oper.cpp:100:5) 

always_comb 
begin : logic_expr3     // test_cond_oper.cpp:100:5
    integer m_1;
    integer k_1;
    logic l1;
    logic l2;
    logic l3;
    logic l4;
    m_1 = s;
    k_1 = s;
    l1 = m_1 == 1 && k_1 == 1 || k_1 < m_1;
    l2 = m_1 > 1 || k_1 < 1 && k_1 != 1;
    l3 = m_1 != k_1 && k_1 != 1 || !(m_1 < k_1) && k_1 < 1;
    l4 = m_1 != k_1 || !(k_1 == m_1) && m_1 < k_1 || k_1 < 1;
end

//------------------------------------------------------------------------------
// Method process: logic_expr4 (test_cond_oper.cpp:110:5) 

always_comb 
begin : logic_expr4     // test_cond_oper.cpp:110:5
    integer m_1;
    integer k_1;
    logic l1;
    logic l2;
    logic l3;
    logic l4;
    m_1 = s;
    k_1 = s;
    l1 = m_1 == 1 && (k_1 == 1 || (k_1 < m_1));
    l2 = (m_1 > 1 || k_1 < 1) && k_1 != 1;
    l3 = m_1 != k_1 && ((k_1 != 1 || !(m_1 < k_1)) && k_1 < 1);
    l4 = m_1 != k_1 || !(k_1 == m_1) && (m_1 < k_1 || k_1 < 1);
end

//------------------------------------------------------------------------------
// Method process: cond_oper_compl (test_cond_oper.cpp:120:5) 

always_comb 
begin : cond_oper_compl     // test_cond_oper.cpp:120:5
    integer i;
    integer m_1;
    integer k_1;
    m_1 = s;
    k_1 = s;
    i = |(m_1 + 1) ? m_1 + 1 : m_1 + 2;
    i = (m_1 + 1 > k_1 - 1) ? 1 : 2;
end

//------------------------------------------------------------------------------
// Method process: cond_oper1 (test_cond_oper.cpp:129:5) 

always_comb 
begin : cond_oper1     // test_cond_oper.cpp:129:5
    integer i;
    integer m_1;
    integer k_1;
    m_1 = s;
    k_1 = s;
    i = (m_1 == 1) ? 1 : 2;
    i = (m_1 > k_1) ? m_1 + 1 : k_1 + 1;
    i = (m_1 < k_1 || m_1 == 1) ? m_1++ : ++k_1;
    i = (m_1 < k_1 && !(m_1 == 1)) ? ((++i) + m_1) : (m_1 * k_1);
    i = (m_1 == k_1) ? m_1 : ((m_1 == 1) ? 1 : 2);
    i = (m_1 != k_1) ? ((m_1 == 1) ? m_1++ : --k_1) : (m_1 - k_1);
end

//------------------------------------------------------------------------------
// Method process: cond_oper2 (test_cond_oper.cpp:142:5) 

always_comb 
begin : cond_oper2     // test_cond_oper.cpp:142:5
    integer i;
    integer m_1;
    integer k_1;
    m_1 = s;
    k_1 = s;
    if (m_1 > 1)
    begin
        i = (m_1 == 1) ? m_1 : k_1;
    end else begin
        i = (m_1 == 2) ? k_1 : m_1;
    end
    if (m_1 > 1)
    begin
    end else begin
        i = (m_1 == 2) ? k_1 : m_1;
    end
    if (m_1 > 1)
    begin
        i = (m_1 == 1) ? m_1 : k_1;
    end
    i = (m_1 == 1) ? m_1 : k_1;
end

//------------------------------------------------------------------------------
// Method process: cond_oper_const (test_cond_oper.cpp:286:5) 

always_comb 
begin : cond_oper_const     // test_cond_oper.cpp:286:5
    integer i;
    integer m_1;
    integer k_1;
    m_1 = s;
    k_1 = s;
    i = k_1;
    i = m_1;
    i = (0 || k_1 == m_1) ? m_1 : k_1;
    i = (1 && k_1 == m_1) ? m_1 : k_1;
    i = k_1;
    i = m_1;
end

//------------------------------------------------------------------------------
// Method process: cond_oper_fcall (test_cond_oper.cpp:303:5) 

always_comb 
begin : cond_oper_fcall     // test_cond_oper.cpp:303:5
    integer i;
    i = 1;
    i = 3;
    i = 3;
    i = 7;
end

endmodule

