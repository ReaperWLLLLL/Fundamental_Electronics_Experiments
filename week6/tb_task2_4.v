//~ `New testbench
`timescale 1ns/1ps
`include "task2_4.v"

module tb_task2_4;

    // task2_4 Parameters
    parameter PERIOD = 10;

    // task2_4 Inputs
    reg clk = 0;
    reg reset = 0;
    reg [7:0] switch_io = 0;

    // task2_4 Outputs
    wire clk_div;
    wire buzz;
    wire [3:0] digit;
    wire [7:0] segment;

    task2_4 u_task2_4 (
        .clk(clk),
        .reset(reset),
        .switch_io(switch_io[7:0]),
        .clk_div(clk_div),
        .buzz(buzz),
        .digit(digit[3:0]),
        .segment(segment[7:0])
    );

    initial begin
        $dumpfile("./wave/tb_task2_4.vcd");
        $dumpvars(0, tb_task2_4);
        clk = 0;
        reset = 1;
        switch_io = 8'b00000111;
        #10
        reset = 0;
        #10000
        switch_io = 8'b10000111;
        reset = 1;
        #10
        reset = 0;
        $finish;
    end

    always begin
        #0.1 clk = ~clk;
    end

endmodule