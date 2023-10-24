//~ `New testbench
`timescale 1ns / 1ps
`include "test\\task2_15.v"
module tb_task2_15;

    // task2_15 Parameters
    parameter PERIOD = 10;

    // task2_15 Inputs
    reg in1 = 0;
    reg in2 = 0;

    // task2_15 Outputs
    wire out;

    task2_15 u_task2_15 (
        .in1 (in1),
        .in2 (in2),
        .out (out)
    );

    initial begin
        in1 = 0;
        in2 = 0;
        #10 in1 = 0; in2 = 1;
        #10 in1 = 1; in2 = 0;
        #10 in1 = 1; in2 = 1;
        #10;
    end

endmodule