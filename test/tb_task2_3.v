`timescale 1ns / 1ps
`include "task2_3.v"
module tb_task2_3;

    // task2_3 Parameters
    parameter PERIOD = 10;

    // task2_3 Inputs
    reg A0 = 0;
    reg A1 = 0;
    reg EN = 0;

    // task2_3 Outputs
    wire [3:0] Y;
    task2_3 u_task2_3 (
        .A0(A0),
        .A1(A1),
        .EN(EN),
        .Y(Y[3:0])
    );

    initial begin
        A0 = 0; A1 = 0; EN = 0;
        #PERIOD;
        A0 = 0; A1 = 0; EN = 1;
        #PERIOD;
        A0 = 0; A1 = 1; EN = 0;
        #PERIOD;
        A0 = 0; A1 = 1; EN = 1;
        #PERIOD;
        A0 = 1; A1 = 0; EN = 0;
        #PERIOD;
        A0 = 1; A1 = 0; EN = 1;
        #PERIOD;
        A0 = 1; A1 = 1; EN = 0;
        #PERIOD;
        A0 = 1; A1 = 1; EN = 1;
        #PERIOD;
    end

endmodule