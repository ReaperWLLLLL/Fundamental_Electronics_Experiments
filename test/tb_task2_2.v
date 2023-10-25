`timescale 1ns / 1ps
`include "task2_2.v"
module tb_task2_2;

    // task2_2 Parameters
    parameter PERIOD = 10;

    // task2_2 Inputs
    reg A = 0;
    reg B = 0;
    reg C = 0;

    // task2_2 Outputs
    wire X;
    wire Y;

    task2_2 u_task2_2 (
        .A(A),
        .B(B),
        .C(C),
        .X(X),
        .Y(Y)
    );

    initial begin
        $dumpfile("./wave/tb_task2_2.vcd");
        $dumpvars(0, tb_task2_2);
        A = 0; B = 0; C = 0;
        #PERIOD;
        A = 0; B = 0; C = 1;
        #PERIOD;
        A = 0; B = 1; C = 0;
        #PERIOD;
        A = 0; B = 1; C = 1;
        #PERIOD;
        A = 1; B = 0; C = 0;
        #PERIOD;
        A = 1; B = 0; C = 1;
        #PERIOD;
        A = 1; B = 1; C = 0;
        #PERIOD;
        A = 1; B = 1; C = 1;
        #PERIOD;

    end

endmodule