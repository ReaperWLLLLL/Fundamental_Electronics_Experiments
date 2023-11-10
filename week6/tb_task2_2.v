//~ `New testbench
`timescale 1ns/1ps
`include "task2_2.v"
module tb_task2_2;

    // task2_2 Parameters
    parameter PERIOD = 10;

    // task2_2 Inputs
    reg clk = 0;
    reg reset = 0;
    reg button_io = 0;

    // task2_2 Outputs
    wire [3:0] digit;
    wire [7:0] segment;

    task2_2 u_task2_2 (
        .clk (clk),
        .reset (reset),
        .button_io (button_io),
        .digit (digit[3:0]),
        .segment (segment[7:0])
    );

    initial begin
        $dumpfile(".//wave//tb_task2_2.vcd");
        $dumpvars(0, tb_task2_2);
        
        // Initialize Inputs
        clk = 0;
        reset = 0;
        button_io = 0;
        reset = 1;
        #10
        reset = 0;
        #10000;
        $finish;
    end
    always begin
        #0.1 clk = ~clk;
    end
    always begin
        #1 button_io = 1;
        #10 button_io = 0;
    end

endmodule