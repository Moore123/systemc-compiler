/******************************************************************************
* Copyright (c) 2020, Intel Corporation. All rights reserved.
* 
* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception.
* 
*****************************************************************************/

//
// Created by mmoiseev on 06/27/19s.
//

#include <systemc.h>

// Fix me, see #116

// Module with @sc_port to dynamically allocated module object
template<typename T>
struct port_if : public sc_interface {
    virtual void f(T val) = 0;
};

template<typename T>
struct AhbSlave : public sc_module, sc_interface 
{
    sc_in_clk       clk;
    sc_in<bool>     nrst;
    
    sc_signal<T>    s;

    sc_port<port_if<T> >  slave_port;
    
    SC_CTOR(AhbSlave) {
        SC_METHOD(methProc);
        sensitive << s;
    }
    
    void methProc() 
    {
        slave_port->f(s.read());   // Incorrect code: targ_r instead of targ_r[0]
    }
};

struct Dut : public sc_module 
{
    sc_in_clk           clk;
    sc_signal<bool>     nrst;

    using T = sc_uint<4>;

    template<typename T>
    struct Target : public sc_module, port_if<T> 
    {
        sc_signal<T> r;

        SC_HAS_PROCESS(Target);
        
        explicit Target (sc_module_name name) : 
            sc_module(name) 
        {
            SC_METHOD(tarMeth); 
            sensitive << r;
        }
        
        void tarMeth() {
            T a = r.read();       // Incorrect code: targ_r instead of targ_r[0]
        }

        void f(T val) {
            r = val;
        }
    };

    AhbSlave<T>             slave{"slave"};
    sc_vector< Target<T> >  tars{"tars", 2};
    
    SC_HAS_PROCESS(Dut);
    
    explicit Dut (sc_module_name name) : sc_module(name) 
    {
        slave.clk(clk);
        slave.nrst(nrst);
        slave.slave_port(tars[0]);
    }
};


int sc_main(int argc, char **argv) 
{
    Dut dut{"dut"};
    sc_clock clk("clk", 1, SC_NS);
    dut.clk(clk);
    sc_start();
    return 0;
}
