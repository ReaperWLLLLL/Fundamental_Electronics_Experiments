module task2_3(A0, A1, EN, Y);
    input A0, A1, EN;
    output [3:0] Y;
    wire A0_L, A1_L;
    
    not not_A0_L(A0_L, A0);
    not not_A1_L(A1_L, A1);

    and and_0(Y[0], A0_L, A1_L, EN);
    and and_1(Y[1], A0, A1_L, EN);
    and and_2(Y[2], A0_L, A1, EN);
    and and_3(Y[3], A0, A1, EN);
endmodule
