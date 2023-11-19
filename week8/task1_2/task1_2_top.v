`include "my_key_seg1.v"
`include "my_key_fre_div.v"
module task1_2_top(
    input clk,
    input rst,
    input [3:0] vl,
    output [3:0] hl,
    output [3:0] digit,
    output [7:0] seg
);

wire clk_div_out;
wire clk_div_out1;
my_key_fre_div uut_fre_div(
    .clk(clk),
    .rst(rst),
    .clk_div_out(clk_div_out),
    .clk_div_out1(clk_div_out1)

);
my_key_seg1 uut_my_key_seg(
    .clk(clk_div_out),
    .clk1(clk_div_out1),
    .rst(rst),
    .vl(vl),
    .hl(hl),
    .digit(digit),
    .seg(seg)
);


endmodule