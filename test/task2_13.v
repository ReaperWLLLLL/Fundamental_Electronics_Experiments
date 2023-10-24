module task2_13(x,y,z);
    input x,y;
    output z;
    assign z = x&~y;
endmodule