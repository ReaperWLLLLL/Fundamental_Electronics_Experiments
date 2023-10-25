`timescale 1ns/1ps
`include "mux2.v"
module mux2_tb;
reg [2:0]d0,d1;
reg s;
wire [2:0] y;
mux2 obj(
.d0(d0),
.d1(d1),
.s(s),
.y(y)
);
initial begin
d0= 2'b00;
d1= 2'b00;
s=0;
#10 d0=2'b01;d1=2'b00;s=0;
#10 d0=2'b10;d1=2'b01;s=0;
#10 d0=2'b11;d1=2'b10;s=1;
#10;

end 
endmodule
