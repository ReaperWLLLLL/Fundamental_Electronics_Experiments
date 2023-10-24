module and_or1 (
    input x1,
    input x2,
    output and2,
    output or2
    
);
    assign and2 = x1 & x2;
    assign or2 = x1 | x2;
    
endmodule