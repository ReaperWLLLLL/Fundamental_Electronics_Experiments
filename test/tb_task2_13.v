//~ `New testbench
`timescale 1ns / 1ps

`include "test\\task2_13.v"
module tb_task2_13;

    // task2_13 Parameters
    parameter PERIOD = 10;

    // task2_13 Inputs
    reg x = 0;
    reg y = 0;

    // task2_13 Outputs
    wire z;

    task2_13 u_task2_13 (
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