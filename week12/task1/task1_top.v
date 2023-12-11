`include "fre_div.v"
`include "addr_tx_en.v"
`include "sin_24_rom.v"
`include "uart_NbyteTran_3byteData_controller.v"
`include "uart_tx_byte.v"
module task1_top(
    input clk,
    input rst,
    output sci_tx
);

wire clk_div_addr;
fre_div uut1(
    .clk(clk),
    .rst(rst),
    .clk_div_addr(clk_div_addr)
);

wire [7:0] addr;
wire send_en;
addr_tx_en uut2(
    .clk_origin(clk),
    .rst(rst),
    .clk(clk_div_addr),
    .addr(addr),
    .send_en(send_en)
);

wire tx_done;
wire tx_en;
wire [23:0] data;
wire [7:0] tx_d;
wire send_done;
uart_NbyteTran_3byteData_controller uut3(
    .clk(clk),
    .rst(rst),
    .send_en(send_en),
    .tx_done(tx_done),
    .tx_en(tx_en),
    .data(data),
    .tx_d(tx_d),
    .send_done(send_done)
);

sin_24_rom uut4(
    .address(addr),
    .clock(clk),
    .q(data)
);

uart_tx_byte uut5(
    .clk(clk),
    .rst(rst),
    .tx_en(tx_en),
    .rx_d(tx_d),
    .sci_tx(sci_tx),
    .tx_done(tx_done)
);  



endmodule