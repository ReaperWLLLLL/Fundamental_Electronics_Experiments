//~ `New testbench
`timescale 1ns/1ps
`include "task2_11.v"

module tb_task2_11;
    parameter PERIOD = 10;

    // task2_11 Inputs
    reg x = 0;
    reg y = 0;

    // task2_11 Outputs
    wire z;

    task2_11 u_task2_11(
        .x(x),
        .y(y),
        .z(z)
    );

    initial begin
        x = 0;
        y = 0;
        #10 x = 0; y = 1;
        #10 x = 1; y = 0;
        #10 x = 1; y = 1;
        #10;
    end
endmodule