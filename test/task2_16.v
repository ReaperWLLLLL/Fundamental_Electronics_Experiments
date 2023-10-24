module task2_16(OUT, I0, I1, I2);
    parameter WID = 1;
    input [WID-1:0] I0, I1, I2;
    output [WID-1:0] OUT;

    assign OUT = I0 & I1 | I0 & I2 | I1 & I2;
endmodule