module fre_div 
#(
    parameter CLK_DIV_ADDR = 25'd12500
)(
    input clk,
    rst,
    output reg clk_div_addr 
);

    reg [24:0] clk_div;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            clk_div <= 25'd0;
            clk_div_addr <= 1'b0;
        end else begin
            if (clk_div == CLK_DIV_ADDR - 1) begin
                clk_div <= 25'd0;
                clk_div_addr = ~clk_div_addr;
            end else begin
                clk_div <= clk_div + 1'b1;
            end
        end
    end
endmodule
