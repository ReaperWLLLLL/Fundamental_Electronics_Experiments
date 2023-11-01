module task1_114(
    input clk,
    input reset,
    output reg clk_div
);

reg [11:0] div_reg;

initial begin
    div_reg = 12'b0;
    clk_div = 1'b0;
end

always @ (posedge clk, posedge reset)
    if(reset)
    begin
        div_reg <= 12'b000000000000;
        clk_div <= 1'b0;
    end
    else
    begin
        if(div_reg < 12'd2500)
            div_reg <= div_reg + 12'b1;
        else
        begin
            div_reg <= 12'b0;
            clk_div <= ~clk_div;
        end
    end

endmodule