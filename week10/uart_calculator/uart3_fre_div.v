`define CLK_DIV 25'd12500//50HZ
module uart3_fre_div (
    input clk,
    rst,
    output reg clk_div
);

    reg [24:0] clk_div_cnt;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            clk_div_cnt <= 25'd0;
            clk_div <= 1'b0;
        end else begin
            if (clk_div_cnt == `CLK_DIV - 1) begin
                clk_div_cnt <= 25'd0;
                clk_div = ~clk_div;
            end else begin
                clk_div_cnt <= clk_div_cnt + 1'b1;
            end
        end
    end
endmodule
