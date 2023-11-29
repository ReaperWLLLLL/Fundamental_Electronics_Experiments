`include "uart_transmit.v"
`include "uart_fre_div.v"
`include "addr_tx_en.v"
`include "myrom.v"

module uart_top(
    input clk,
    input rst,
    input [2:0] switch,
    output  sci_tx
);

wire clk_div_addr;
uart_fre_div uut1(
    .clk(clk),
    .rst(rst),
    .clk_addr(clk_div_addr)
);

wire [9:0] addr;
wire tx_en;
addr_tx_en uut2(
    .switch(switch),
    .clk_origin(clk),
    .clk(clk_div_addr),
    .rst(rst),
    .addr(addr),
    .tx_en(tx_en)
);

wire [7:0]data_send;
myrom uut3(
    .address(addr),
    .clock(clk),
    .q(data_send)
);

uart_transmit uut4(
    .clk(clk),
    .rst(rst),
    .tx_en(tx_en),
    .rx_d(data_send),
    .sci_tx(sci_tx)
);

endmodule