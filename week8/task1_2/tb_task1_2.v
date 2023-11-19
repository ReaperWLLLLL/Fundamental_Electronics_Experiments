//~ `New testbench
`timescale 1ns/1ps
`include "task1_2_top.v"

module tb_task1_2_top;

    // task1_2_top Parameters
    parameter PERIOD = 10;

    // task1_2_top Inputs
    reg [3:0] vl = 0;
    reg clk = 0;
    reg rst = 0;

    // task1_2_top Outputs
    wire [3:0] hl;
    wire [3:0] digit;
    wire [7:0] seg;

    task1_2_top u_task1_2_top (
        .clk(clk),
        .rst(rst),
        .vl(vl[3:0]),
        .hl(hl[3:0]),
        .digit(digit[3:0]),
        .seg(seg[7:0])
    );

    initial begin
        $dumpfile(".\\wave\\tb_task1_2_top.vcd");
        $dumpvars(0, tb_task1_2_top);
        clk = 0;
        rst = 0;
        vl = 4'b1111;
        rst = 1;
        #10
        rst = 0;
        #500
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

    always begin
        #100
        vl = 4'b1110;
        #100
        vl = 4'b1101;
        #100
        vl = 4'b1011;
        #100
        vl = 4'b0111;
    end

endmodule