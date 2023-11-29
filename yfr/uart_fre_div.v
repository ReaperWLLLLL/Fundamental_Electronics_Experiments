`define CLK_DIV_ADDR 25'd976//50HZ
module uart_fre_div (
    input clk,
    rst,
    output reg clk_addr  //1Hz  地址递增
);

    reg [24:0] clk_div;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            clk_div <= 25'd0;
            clk_addr <= 1'b0;
        end else begin
            if (clk_div == `CLK_DIV_ADDR - 1) begin
                clk_div <= 25'd0;
                clk_addr = ~clk_addr;
            end else begin
                clk_div <= clk_div + 1'b1;
            end
        end
    end
endmodule
