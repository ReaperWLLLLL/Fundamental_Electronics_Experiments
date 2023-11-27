// Purpose: Top level module for UART transmit.
`include "addr_tx_en2.v"
`include "uart_transmit2.v"
`include "uart2_fre_div.v"
`include "three_waves_rom.v"
module uart2_top(
    input clk,
    input rst,
    input [2:0] switch,
    output  sci_tx
);

wire clk_div_addr;
uart2_fre_fiv uut1(
    .clk(clk),
    .rst(rst),
    .clk_div_addr(clk_div_addr)
);

wire [9:0] addr;
wire tx_en;
addr_tx_en2 uut2(
    .clk_origin(clk),
    .clk(clk_div_addr),
    .rst(rst),
    .switch(switch),
    .addr(addr),
    .tx_en(tx_en)
);

wire [9:0]data_temp;
three_waves_rom uut3(
    .address(addr),
    .clock(clk),
    .q(data_temp)
);

uart_transmit2 uut4(
    .clk(clk),
    .rst(rst),
    .tx_en(tx_en),
    .rx_d(data_temp),
    .sci_tx(sci_tx)
);



endmodule