//~ `New testbench
`timescale 1ns/1ps
`include "task2_12.v"

module tb_task2_12;

    // task2_12 Parameters
    parameter PERIOD = 10;

    // task2_12 Inputs
    reg [3:0] d0 = 0;
    reg [3:0] d1 = 0;
    reg s = 0;

    // task2_12 Outputs
    wire [3:0] y;

    task2_12 u_task2_12 (
        .d0(d0[3:0]),
        .d1(d1[3:0]),
        .s(s),
        .y(y[3:0])
    );

    initial begin
        d0 = 0; d1 = 0; s = 0;
        #PERIOD;
        d0 = 0; d1 = 0; s = 1;
        #PERIOD;
        d0 = 0; d1 = 1; s = 0;
        #PERIOD;
        d0 = 0; d1 = 1; s = 1;
        #PERIOD;
        d0 = 1; d1 = 0; s = 0;
        #PERIOD;
        d0 = 1; d1 = 0; s = 1;
        #PERIOD;
        d0 = 1; d1 = 1; s = 0;
        #PERIOD;
        d0 = 1; d1 = 1; s = 1;
        #PERIOD;
    end

endmodule