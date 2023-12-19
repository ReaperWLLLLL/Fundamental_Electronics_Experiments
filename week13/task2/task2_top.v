`include "rom_data_tri.v"
`include "rom_base.v"
`include "rom_harmony.v"
`include "dac_controller_new_1213.v"
`include "mypll2.v"
`include "adc_controller_new_1213.v"

module task2_top(
    input clk,
    input rst,
    input sdout_adc,
    output lrck_dac,
    output sclk_dac,
    output mclk_dac,
    output sdata_dac,
    output mclk_adc,
    output sclk_adc,
    output lrck_adc,
    output reg  buzz,
    output [23:0] dataL_adc,
    output [23:0] dataR_adc
);

initial begin
    buzz = 1'b1;
end

wire[23:0] data_dac_chL;
wire[23:0] data_dac_chR;
wire[7:0] addr_chL;
wire[7:0] addr_chR;
wire c0;//6553600hz
wire c1;//1.28Mhz

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
    .data_dac_chL(data_dac_chL),
    .data_dac_chR(data_dac_chR),
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

endmodule
