`include "myrom.v"
`include "addrgen.v"
`include "fre_div2_2.v"
`include "digit1.v"

module task2_2_top(
    input clk,
    input rst,
    output clk_div_out,
    output clk_div_out1,
    output [3:0] digit,
    output [7:0] seg
);

wire [7:0] addr;
myrom uut1(
    .clock(clk_div_out1),
    .address(addr),
    .q(data_temp)
);

wire [7:0] data_temp;
addrgen uut2(
    .clk(clk_div_out),
    .rst(rst),
    .addr(addr)
);

fre_div2_2 uut3(
    .clk(clk),
    .rst(rst),
    .clk_div_out(clk_div_out),
    .clk_div_out1(clk_div_out1)
);

digit1 uut4(
    .clk(clk_div_out1),
    .data(data_temp),
    .rst(rst),
    .digit(digit),
    .seg(seg)
);



endmodule