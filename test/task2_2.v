module task2_2(A, B, C, X, Y);
    input A, B, C;
    output X, Y;
    wire B_L, A_L, M1_L, M2_L, M3_L, M4_L, M1, M2, M3, M4, M1_LL, M2_LL, M3_LL, M4_LL;

    not U1(A_L, A);
    not U2(B_L, B);
    
    and U3(M1, A, B_L);
    and U4(M2, A_L, B);
    and U5(M3, A_L, C);
    and U6(M4, B, C);

    not U7(M1_L, M1);
    not U8(M2_L, M2);
    not U9(M3_L, M3);
    not U10(M4_L, M4);

    not U11(M1_LL, M1_L);
    not U12(M2_LL, M2_L);
    not U13(M3_LL, M3_L);
    not U14(M4_LL, M4_L);

    or U15(X, M1_LL, M2_LL);
    or U16(Y, M3_LL, M4_LL);
endmodule

