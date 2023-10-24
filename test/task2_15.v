`include "inh.v"
module task2_15(in1, in2, out);
    input in1, in2;
    output out;
    wire inh1, inh2, notinh1,notinh2, notout;

    inh U1(.out(inh1), .in(in1), .invin(in2));
    inh U2(.out(inh2), .in(in2), .invin(in1));
    not U3(notinh2, inh2);
    inh U4(.out(notinh1), .in(notinh2), .invin(inh1));
    not U5(out, notout);
endmodule