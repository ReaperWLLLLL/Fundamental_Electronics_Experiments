`include "my_key_seg1.v"
`include "my_key_fre_div.v"
`include "button_detection.v"
module task1_2_top(
    input clk,
    input rst,
    input [3:0] vl,
    output [3:0] vl_out,
    output [3:0] hl,
    output [3:0] digit,
    output clk_div_out,
    output clk_div_out1,
    output [7:0] seg
);

my_key_fre_div uut_fre_div(
    .clk(clk),
    .rst(rst),
    .clk_div_out(clk_div_out),
    .clk_div_out1(clk_div_out1)

);

button_detection uut_button_detection(
    .clk(clk),
    .rst(rst),
    .vl(vl),
    .vl_out(vl_out)
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