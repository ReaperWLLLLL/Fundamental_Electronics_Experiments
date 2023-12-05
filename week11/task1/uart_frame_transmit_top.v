// This module is the top-level module for transmitting UART frames.
// It includes various sub-modules for address generation, data generation, and UART transmission.

`include "addr_tx_en.v" // Include module for address and transmit enable generation.
`include "sin_16_rom.v" // Include module for generating sine wave data.
`include "fre_div.v" // Include module for clock frequency division.
`include "uart_byte_controller.v" // Include module for byte-level UART transmission control.
`include "uart_2byte_controller_withoutHeader.v" // Include module for 2-byte UART transmission control without header.
`include "uart_tx_byte.v" // Include module for UART byte transmission.

module uart_frame_transmit_top (
    input  clk, // Clock input
    input  rst, // Reset input
    output sci_tx // UART transmit output
);

    wire clk_div_addr; // Clock divided address signal
    fre_div #(25'd12500) uut1 ( // Instantiate frequency divider module
        .clk(clk),
        .rst(rst),
        .clk_div_addr(clk_div_addr)
    );

    wire [7:0] addr; // Address signal
    wire send_en; // Transmit enable signal
    wire [15:0] data_out; // Output data signal

    addr_tx_en uut2 ( // Instantiate address and transmit enable module
        .clk_origin(clk),
        .clk(clk_div_addr),
        .rst(rst),
        .addr(addr),
        .data_temp(data_temp),
        .data_out(data_out),
        .tx_en(send_en)
    );

    wire [15:0] data_temp; // Temporary data signal
    sin_16_rom uut3 ( // Instantiate sine wave ROM module
        .address(addr),
        .clock(clk),
        .q(data_temp)
    );

    wire tx_en; // Transmit enable signal
    wire [7:0] tx_d; // Transmit data signal
    wire tx_done; // Transmission completion signal

    uart_2byte_controller_withoutHeader uut4 ( // Instantiate 2-byte UART controller module without header
        .clk(clk),
        .rst(rst),
        .send_en(send_en),
        .tx_en(tx_en),
        .tx_done(tx_done),
        .data(data_out),
        .tx_d(tx_d)
    );

    uart_tx_byte uut5 ( // Instantiate UART byte transmission module
        .clk(clk),
        .rst(rst),
        .tx_en(tx_en),
        .tx_done(tx_done),
        .rx_d(tx_d),
        .sci_tx(sci_tx)
    );

endmodule
