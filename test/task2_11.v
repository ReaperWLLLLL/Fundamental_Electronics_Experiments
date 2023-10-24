module task2_11(x,y,z);
input x,y;
output z;

assign z = x & ~y;
endmodule