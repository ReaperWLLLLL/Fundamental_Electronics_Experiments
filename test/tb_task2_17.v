// New testbench
`timescale 1ns / 1ps
`include "task2_17.v"
module tb_task2_17;

    // task2_17 Parameters
    parameter PERIOD = 10;

    // task2_17 Inputs
    reg [3:0] N = 0;

    // task2_17 Outputs
    wire F;

    task2_17 u_task2_17 (
        .N(N[3:0]),
        .F(F)
    );

    initial begin
        N = 0;
        #PERIOD;
        N = 1;
        #PERIOD;
        N = 2;
        #PERIOD;
        N = 3;
        #PERIOD;
        N = 4;
        #PERIOD;
        N = 5;
        #PERIOD;
        N = 6;
        #PERIOD;
        N = 7;
        #PERIOD;
        N = 8;
        #PERIOD;
        N = 9;
        #PERIOD;
        N = 10;
        #PERIOD;
        N = 11;
        #PERIOD;
        N = 12;
        #PERIOD;
        N = 13;
        #PERIOD;
        N = 14;
        #PERIOD;
        N = 15;
        #PERIOD;
    end

endmodule