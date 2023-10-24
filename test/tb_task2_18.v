`timescale 1ns / 1ps
`include "task2_18.v"
module tb_task2_18;

    // task2_18 Parameters
    parameter PERIOD = 10;

    // task2_18 Inputs
    reg [7:0] A = 0;
    reg [7:0] B = 0;
    reg [7:0] C = 0;
    reg selA = 0;
    reg selB = 0;
    reg selC = 0;

    // task2_18 Outputs
    wire [7:0] Z;
    task2_18 u_task2_18 (
        .A(A[7:0]),
        .B(B[7:0]),
        .C(C[7:0]),
        .selA(selA),
        .selB(selB),
        .selC(selC),
        .Z(Z[7:0])
    );

    initial begin
        A = 0; B = 0; C = 0; selA = 0; selB = 0; selC = 0;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 0; selB = 0; selC = 1;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 0; selB = 1; selC = 0;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 0; selB = 1; selC = 1;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 1; selB = 0; selC = 0;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 1; selB = 0; selC = 1;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 1; selB = 1; selC = 0;
        #PERIOD;
        A = 0; B = 0; C = 0; selA = 1; selB = 1; selC = 1;
        #PERIOD;
    end

endmodule