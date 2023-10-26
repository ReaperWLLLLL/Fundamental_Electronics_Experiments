module task1_19(
    input clk,
    input reset,
    output clk_div
);

reg [7:0] div_reg;

assign clk_div = div_reg[1];
endmodule