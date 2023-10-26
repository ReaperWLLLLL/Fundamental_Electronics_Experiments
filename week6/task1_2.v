module task1_2(
    input clk,
    input reset,
    output reg [2:0] led,
    output reg [2:0] clk_div
);
reg [31:0] div_reg1, div_reg2, div_reg3;
initial begin
    div_reg1 <= 32'b0;
    div_reg2 <= 32'b0;
    div_reg3 <= 32'b0;
    clk_div <= 3'b0;
    led <= 3'b0;
end
always @ (posedge clk, posedge reset) begin
    if(reset)
    begin
        div_reg1 <= 32'b0;
        div_reg2 <= 32'b0;
        div_reg3 <= 32'b0;
        clk_div <= 4'b0;
    end
    else
    begin
        if(div_reg1 < 32'd50000000)
            div_reg1 <= div_reg1 + 32'b1;
        else
        begin
          div_reg1 <= 32'b0;
          clk_div[0] <= ~clk_div[0];
        end
        if(div_reg2 < 32'd25000000)
            div_reg2 <= div_reg2 + 32'b1;
        else
        begin
          div_reg2 <= 32'b0;
          clk_div[1] <= ~clk_div[1];
        end
        if(div_reg3 < 32'd2500000)
            div_reg3 <= div_reg3 + 32'b1;
        else
        begin
          div_reg3 <= 32'b0;
          clk_div[2] <= ~clk_div[2];
        end
    end
end
always @(posedge clk_div[0]) begin
    led[0] <= ~led[0];
end

always @(posedge clk_div[1]) begin
    led[1] <= ~led[1];
end

always @(posedge clk_div[2]) begin
    led[2] <= ~led[2];
end

endmodule

