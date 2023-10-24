module task2_18(A, B, C, selA, selB, selC, Z);
    input [7:0] A, B, C;
    input selA, selB, selC;
    output [7:0] Z;
    assign Z = selA ? A : (selB ? B : (selC ? C : 8'b0));
endmodule
