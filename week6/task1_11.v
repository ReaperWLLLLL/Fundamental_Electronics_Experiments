module task1_11(N, F);
    input [3:0] N;
    output reg F;
    always @(*) begin
        F = (~N[3] & N[0]) | (~N[3] & ~N[2] & N[1]) | (~N[2] & N[1] & N[0]) | (N[2] &~ N[1] & N[0]);
    end
endmodule