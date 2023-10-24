module inh(in, invin, out);
input in, invin;
output out;
wire notinvin;

not U1(notinvin, invin);
and U2(out, in, notinvin);
endmodule