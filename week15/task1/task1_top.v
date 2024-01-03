`include "rom_data_tri.v"
`include "rom_base.v"
`include "rom_harmony.v"
`include "dac_controller_new_1213.v"
`include "mypll2.v"
`include "adc_controller_new_1213.v"
`include "adc_data_ready_tri.v"
`include "uart_NbyteTran_3byteData_controller.v"
`include "uart_tx_byte.v"
`include "uart_rx_byte.v"
`include "uart_rx_Nbyte_controller.v"
`include "uart_1byte_data_reg.v"
`include "mux2.v"
`include "mymult.v"

module task1_top(
    input clk,
    input rst,
    input sdout_adc,
    input sci_rx,
    output lrck_dac,
    output sclk_dac,
    output mclk_dac,
    output sdata_dac,
    output mclk_adc,
    output sclk_adc,
    output lrck_adc,
    output reg  buzz,
    output [23:0] dataL_adc,
    output [23:0] dataR_adc,
    output  send_en,
    output sci_tx
);

initial begin
    buzz = 1'b1;
end

initial begin
    buzz = 1'b1;
end

wire[23:0] data_dac_chL;
wire[23:0] data_dac_chR;
wire[7:0] addr_chL;
wire[7:0] addr_chR;
wire c0;//6553600hz
wire c1;//1.28Mhz

wire tx_done;
wire tx_en;
wire [23:0] data;
wire [7:0] tx_d;
wire send_done;

wire rx_done;
wire [7:0] uart_data;
wire [7:0] rx_data_out;
wire [23:0] mux_data_out;

wire [7:0] byte1,byte2,byte3;

wire [23:0] result1,result2;
rom_data_tri uut1(
    .lr_ch_tri_clk(lrck_dac),
    .rst(rst),
    .addr_chL(addr_chL),
    .addr_chR(addr_chR)
);

rom_base uut2(
    .clock(clk),
    .address(addr_chL),
    .q(data_dac_chL)
);

rom_harmony uut3(
    .clock(clk),
    .address(addr_chR),
    .q(data_dac_chR)
);

dac_controller_new_1213 uut4(
    .clk(c0),
    .rst(rst),
    .data_dac_chL(result1),
    .data_dac_chR(result2),
    .mclk_dac(mclk_dac),
    .sclk_dac(sclk_dac),
    .lrck_dac(lrck_dac),
    .sdata_dac(sdata_dac)
);

adc_controller_new_1213 uut6(
    .clk(c1),
    .rst(rst),
    .sdout_adc(sdout_adc),
    .mclk_adc(mclk_adc),
    .sclk_adc(sclk_adc),
    .lrck_adc(lrck_adc),
    .dataL_adc(dataL_adc),
    .dataR_adc(dataR_adc)
);

mypll2 uut5(
    .inclk0(clk),
    .c0(c0),
    .c1(c1)
);

adc_data_ready_tri uut7(
    .clk(clk),
    .rst(rst),
    .lrck(lrck_adc),
    .send_en(send_en)
);

uart_NbyteTran_3byteData_controller uut8(
    .clk(clk),
    .rst(rst),
    .send_en(send_en),
    .data(mux_data_out),
    .tx_d(tx_d),
    .tx_en(tx_en),
    .tx_done(tx_done)
);

uart_tx_byte uut9(
    .clk(clk),
    .rst(rst),
    .rx_d(tx_d),
    .tx_en(tx_en),
    .tx_done(tx_done),
    .sci_tx(sci_tx)
);

uart_rx_byte uut10(
    .clk(clk),
    .rst(rst),
    .sci_rx(sci_rx),
    .rx_done(rx_done),
    .uart_data(uart_data)
);

mux2 uut12(
    .s(lrck_adc),
    .d1(dataL_adc),
    .d2(dataR_adc),
    .y(mux_data_out)
);

mymult uut13(
    .dataa(data_dac_chL),
    .datab(byte2),
    .result(result1)
);

mymult uut14(
    .dataa(data_dac_chR),
    .datab(byte3),
    .result(result2)
);

uart_rx_Nbyte_controller uut15(
    .clk(clk),
    .rst(rst),
    .rx_done(rx_done),
    .uart_data(uart_data),
    .byte2(byte2),
    .byte3(byte3)
);

endmodule