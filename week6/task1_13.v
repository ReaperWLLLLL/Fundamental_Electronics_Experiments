module task1_13(N, F);
    input [3:0] N;
    output reg F;
    parameter OneIsPrime = 1;

    always @(*)
        if(N==1) F = OneIsPrime;
        else if((N % 2) == 0)
            begin if(N == 2) F = 1; else F = 0; end
        else if(N <= 7) F = 1;
        else if((N == 11) || (N == 13)) F = 1;
        else F = 0;
endmodule
