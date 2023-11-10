`timescale 1ns / 1ps
`include "task1_2.v"
module tb_task1_2;

    // task1_2 Parameters
    parameter PERIOD = 10;

    // task1_2 Inputs
    reg clk = 0;
    reg reset = 0;

    // task1_2 Outputs
    wire [2:0] led;
    wire [2:0] clk_div;

    task1_2 u_task1_2 (
        .clk(clk),
        .reset(reset),
        .led(led[2:0]),
        .clk_div(clk_div[2:0])
    );

    initial begin
        $dumpfile("./wave/tb_task1_2.vcd");
        $dumpvars(0, tb_task1_2);
        clk = 0;
        reset = 1;
        #10 
        reset = 0;
    end

    always begin
        # clk = ~clk;
        if( $time > 1000 ) $finish;
    end

endmodule