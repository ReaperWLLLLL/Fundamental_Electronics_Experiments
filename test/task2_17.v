module task2_17(N, F);
    input [3:0] N;
    output F;
    assign F = (~N[3] & N[0]) | (~N[3] & ~N[2] & N[1]) | (~N[2] & N[1] & N[0]) | (N[2] &~ N[1] & N[0]);
endmodule