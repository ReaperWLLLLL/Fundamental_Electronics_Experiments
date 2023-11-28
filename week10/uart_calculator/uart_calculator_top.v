`include "uart_receive.v"
`include "uart_calculator.v"
`include "uart3_fre_div.v"
`include "uart_digit.v"
module uart_calculator_top(
    input clk,
    input rst,
    input rx,
    output [7:0] seg,
    output [3:0] digit
);

wire [7:0] data;
wire ready;
uart_receive uut1(
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .data(data),
    .ready(ready)
);

wire [15:0] display_data;
uart_calculator uut2(
    .clk(clk),
    .rst(rst),
    .ready(ready),
    .rx_data(data),
    .display_data(display_data)
);

wire clk_div;
uart3_fre_div uut3(
    .clk(clk),
    .rst(rst),
    .clk_div(clk_div)
);

uart_digit uut4(
    .clk(clk_div),
    .rst(rst),
    .data(display_data),
    .digit(digit),
    .seg(seg)
);









endmodule