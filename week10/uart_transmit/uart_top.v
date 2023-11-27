`include "uart_transmit.v"
`include "uart_fre_div.v"
`include "addr_tx_en.v"
`include "sin_rom.v"

module uart_top(
    input clk,
    input rst,
    output  sci_tx
);

wire clk_div_addr;
uart_fre_fiv uut1(
    .clk(clk),
    .rst(rst),
    .clk_div_addr(clk_div_addr)
);

wire [7:0] addr;
wire tx_en;
addr_tx_en uut2(
    .clk_origin(clk),
    .clk(clk_div_addr),
    .rst(rst),
    .addr(addr),
    .tx_en(tx_en)
);

wire [7:0]data_temp;
sin_rom uut3(
    .address(addr),
    .clock(clk),
    .q(data_temp)
);

uart_transmit uut4(
    .clk(clk),
    .rst(rst),
    .tx_en(tx_en),
    .rx_d(data_temp),
    .sci_tx(sci_tx)
);

endmodule