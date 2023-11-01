`include "task1_112.v"
`include "task1_110.v"
module task1_113(
    input clk,
    input reset,
    output [3:0] led_io
);

wire clk_div;

task1_112 uut1(
    .clk(clk),
    .reset(reset),
    .led_io(led_io)
);

task1_110 uut2(
    .clk(clk),
    .reset(reset),
    .clk_div(clk_div)
);
endmodule
