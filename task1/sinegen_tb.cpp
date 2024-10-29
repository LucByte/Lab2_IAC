#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){
    int i;
    int clk;
    int MAXcycle = 1000000;
     
    Verilated::commandArgs(argc, argv);
    Vsinegen* top = new Vsinegen;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("sinegen.vcd");

    //init Vbuddy
    if(vbdOpen() != 1) return(-1);
    vbdHeader("Lab 2: sinegen");

    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1;

    for(int sim_cycle; sim_cycle < MAXcycle; sim_cycle++){
        for( clk=0; clk<2; clk++){  //forces model to evaluate on both edges of clock
            tfp->dump(2*sim_cycle + clk); // unit in pico secs!
            top->clk = !top->clk;
            top->eval();
        }

        top->incr = vbdValue();
        vbdPlot(int(top->dout), 0, 255);
        vbdCycle(sim_cycle);

        if(Verilated::gotFinish() || vbdGetkey()=='q') exit(0);     // exit if finish or 'q' pressed

    }

    vbdClose();
    tfp->close();
    exit(0);


}