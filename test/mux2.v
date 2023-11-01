module mux2(
input [2:0] d0,d1,
input s,
output [2:0] y
);
assign y = s ? d1 : d0;
endmodule