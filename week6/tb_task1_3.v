//~ `New testbench
`timescale 1ns / 1ps
`include "task1_3.v"
module tb_task1_3;

    // task1_3 Parameters
    parameter PERIOD = 10;

    // task1_3 Inputs
    reg clk = 0;
    reg reset = 0;
    reg button_io1 = 0;
    reg button_io2 = 0;
    reg button_io3 = 0;


    // task1_3 Outputs
    wire clk_div;
    wire [7:0] led_io;
    
    task1_3 u_task1_3 (
        .clk        (clk),
        .reset      (reset),
        .button_io1 (button_io1),
        .button_io2 (button_io2),
        .button_io3 (button_io3),
        .clk_div    (clk_div),
        .led_io     (led_io[7:0])
    );

    initial begin
        $dumpfile("./wave/tb_task1_3.vcd");
        $dumpvars(0, tb_task1_3);
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

    always begin
        button_io1 = 1;
        #10 button_io1 = 0;
        #1 button_io1 = 0;
        button_io2 = 1;
        #10 button_io2 = 0;
        #1 button_io2 = 0;
        button_io3 = 1;
        #10 button_io3 = 0;
        #1 button_io3 = 0;
    end

endmodule