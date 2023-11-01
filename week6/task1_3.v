module task1_3(
    input clk,
    input reset,
    input [2:0] button_io,
    output reg clk_div,
    output reg [7:0] led_io
);

reg [31:0] div_reg;

always @ (posedge clk or posedge reset)
    if(reset)
    begin
        div_reg <= 32'b0;
        clk_div <= 1'b0;
    end

    else
    begin
        if(div_reg < 32'd25000000)
            div_reg <= div_reg + 32'b1;
        else
        begin
            div_reg <= 32'b0;
            clk_div <= ~clk_div;
        end
    end

endmodule

