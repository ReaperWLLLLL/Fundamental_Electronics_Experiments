//~ `New testbench
`timescale 1ns/1ps
`include "task2_3.v"
module tb_task2_3;

    // task2_3 Parameters
    parameter PERIOD = 10;

    // task2_3 Inputs
    reg clk = 0;
    reg reset = 0;

    // task2_3 Outputs
    wire clk_div;
    wire buzz;
    wire [3:0] digit;
    wire [7:0] segment;

    task2_3 u_task2_3 (
        .clk(clk),
        .reset(reset),
        .clk_div(clk_div),
        .buzz(buzz),
        .digit(digit[3:0]),
        .segment(segment[7:0])
    );

    initial begin
        $dumpfile("./wave/tb_task2_3.vcd");
        $dumpvars(0, tb_task2_3);
        clk = 0;
        reset = 1;
        #10
        reset = 0;
        #10000
        $finish;
    end

    always begin
        #0.1 clk = ~clk;
    end

endmodule