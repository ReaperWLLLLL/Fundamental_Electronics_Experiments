module task1_18(
    input clk,
    input reset,
    output reg [7:0] q
);

always @ (posedge clk or posedge reset)
    if(reset) q <= 8'b00000000;
    else q <= q + 8'b1;
endmodule