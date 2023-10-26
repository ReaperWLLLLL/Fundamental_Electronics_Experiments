module task1_110(
    input clk,
    input reset,
    output reg clk_div
);

reg [7:0] div_reg;

always @ (posedge clk or posedge reset)
    if(reset)
    begin
        div_reg <= 8'b00000000;
        clk_div <= 1'b0;
    end
    else
    begin
        if(div_reg < 8'd250)
            div_reg <= div_reg + 8'b1;
        else
        begin
            div_reg <= 8'b0;
            clk_div <= ~clk_div;
        end
    end
endmodule