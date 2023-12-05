`include "addr_tx_en.v"
`include "sin_16_rom.v"
`include "fre_div.v"
`include "uart_byte_controller.v"
`include "uart_2byte_controller_withoutHeader.v"
`include "uart_tx_byte.v"
module uart_frame_transmit_top (
    input  clk,
    input  rst,
    output sci_tx
);

    wire clk_div_addr;
    fre_div #(25'd12500) uut1 (
        .clk(clk),
        .rst(rst),
        .clk_div_addr(clk_div_addr)
    );

    wire [7:0] addr;
    wire send_en;
    wire [15:0] data_out;  

    addr_tx_en uut2 (
        .clk_origin(clk),
        .clk(clk_div_addr),
        .rst(rst),
        .addr(addr),
        .data_temp(data_temp),
        .data_out(data_out),
        .tx_en(send_en)//this maybe confusing, because i copy the code from last week and do not change the name
    );

    wire [15:0] data_temp;
    sin_16_rom uut3 (
        .address(addr),
        .clock(clk),
        .q(data_temp)
    );

    wire tx_en;
    wire [7:0] tx_d;
    wire tx_done;
    // uart_byte_controller #(12) uut4 (
    //     .clk(clk),
    //     .rst(rst),
    //     .send_en(send_en),
    //     .tx_en(tx_en),
    //     .tx_done(tx_done),
    //.data(data_temp),
    //     .tx_d(tx_d)
    // );

    uart_2byte_controller_withoutHeader uut4 (
        .clk(clk),
        .rst(rst),
        .send_en(send_en),
        .tx_en(tx_en),
        .tx_done(tx_done),
        .data(data_out),
        .tx_d(tx_d)
    );

    uart_tx_byte uut5 (
        .clk(clk),
        .rst(rst),
        .tx_en(tx_en),
        .tx_done(tx_done),
        .rx_d(tx_d),
        .sci_tx(sci_tx)
    );










endmodule
