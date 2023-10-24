`timescale 1ns/1ps
`include "task2_4.v"
module tb_task2_4;

    // task2_4 Parameters
    parameter PERIOD = 10;

    // task2_4 Inputs
    reg X = 0;
    reg Y = 0;
    reg Z = 0;

    // task2_4 Outputs
    wire F;

    task2_4 u_task2_4 (
        .X(X),
        .Y(Y),
        .Z(Z),
        .F(F)
    );

    initial begin
        $dumpfile("./wave/tb_task2_4.vcd");
        $dumpvars(0, tb_task2_4);
        #PERIOD;
        X = 0; Y = 0; Z = 0;
        #PERIOD;
        X = 0; Y = 0; Z = 1;
        #PERIOD;
        X = 0; Y = 1; Z = 0;
        #PERIOD;
        X = 0; Y = 1; Z = 1;
        #PERIOD;
        X = 1; Y = 0; Z = 0;
        #PERIOD;
        X = 1; Y = 0; Z = 1;
        #PERIOD;
        X = 1; Y = 1; Z = 0;
        #PERIOD;
        X = 1; Y = 1; Z = 1;
        #PERIOD;
    end

endmodule