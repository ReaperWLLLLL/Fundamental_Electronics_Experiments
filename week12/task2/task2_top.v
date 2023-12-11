`include "rom_data_tri.v"
`include "rom_array_sync.v"
`include "dac_controller.v"
`include "fre_div.v"
module task2_top(
    input clk,
    input rst,
    output lrck_dac,
    output sclk_dac,
    output mclk_dac,
    output sdata_dac
);

wire[23:0] data_dac_chL;
wire[23:0] data_dac_chR;
wire[7:0] addr_chL;
wire[7:0] addr_chR;
wire c0;//6553600hz
wire c1;//13107200hz

rom_data_tri uut1(
    .lr_ch_tri_clk(lrck_dac),
    .rst(rst),
    .addr_chL(addr_chL),
    .addr_chR(addr_chR)
);

rom_array_sync uut2(
    .clock(clk),
    .address(addr_chL),
    .q(data_dac_chL)
);

rom_array_sync uut3(
    .clock(clk),
    .address(addr_chR),
    .q(data_dac_chR)
);

dac_controller uut4(
    .clk(c0),
    .rst(rst),
    .data_dac_chL(data_dac_chL),
    .data_dac_chR(data_dac_chR),
    .mclk_dac(mclk_dac),
    .sclk_dac(sclk_dac),
    .lrck_dac(lrck_dac),
    .sdata_dac(sdata_dac)
);

fre_div uut5(
    .inclk0(clk),
    .c0(c0),
    .c1(c1)
);

endmodule