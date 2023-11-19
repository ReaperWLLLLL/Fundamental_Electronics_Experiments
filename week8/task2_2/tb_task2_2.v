//~ `New testbench
`timescale 1ns / 1ps
`include "task2_2_top.v"
module tb_task2_2;

  // task2_2_top Parameters
  parameter PERIOD = 10;


  // task2_2_top Inputs
  reg        clk = 0;
  reg        rst = 0;

  // task2_2_top Outputs
  wire       clk_div_out;
  wire       clk_div_out1;
  wire [3:0] digit;
  wire [7:0] seg;
  wire [7:0] addr;

  task2_2_top u_task2_2_top (
      .clk(clk),
      .rst(rst),
      .clk_div_out (clk_div_out),
      .clk_div_out1(clk_div_out1),
      .digit       (digit[3:0]),
      .seg         (seg[7:0]),
      .addr        (addr[7:0])

  );

  initial begin
    //$dumpfile(".\\wave\\tb_task2_2_top.vcd");
    //$dumpvars(0, tb_task2_2);
    clk = 0;
    rst = 0;
    #100 rst = 1;
    #100 rst = 0;
    #5000
    $finish;
  end

  always begin
    #1 clk = ~clk;
  end

endmodule
