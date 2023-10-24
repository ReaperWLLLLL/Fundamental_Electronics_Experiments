module task2_4(X, Y, Z, F);
    input X, Y, Z;
    output F;
    wire YN, XN, ZN, XYN, XYNZ, XNYZN;

    not not_XN(XN, X);
    not not_YN(YN, Y);
    not not_ZN(ZN, Z);

    or or_XYN(XYN, X, YN);
    and and_XYNZ(XYNZ, XYN, Z);
    and and_XNYZN(XNYZN, XN, Y, ZN);

    or or_F(F, XYNZ, XNYZN);
endmodule