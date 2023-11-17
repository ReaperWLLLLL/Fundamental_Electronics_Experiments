module addrgen(
    input clk,
    input rst,
    output reg [7:0] addr
);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        addr <= 8'b00000000;
    end
    else begin
        addr <= addr + 1;
    end
end
endmodule