`timescale 1ns / 1ps
`include "task2_16.v"
module tb_task2_16;

    // task2_16 Parameters
    parameter PERIOD = 10;
    parameter WID = 5;

    // task2_16 Inputs
    reg [WID-1:0] I0 = 0;
    reg [WID-1:0] I1 = 0;
    reg [WID-1:0] I2 = 0;

    // task2_16 Outputs
    wire [WID-1:0] OUT;

    task2_16 #(
        .WID(WID)
    ) u_task2_16 (
        .I0(I0[WID-1:0]),
        .I1(I1[WID-1:0]),
        .I2(I2[WID-1:0]),
        .OUT(OUT[WID-1:0])
    );

    initial begin
        I0 = 0; I1 = 0; I2 = 0;
        #PERIOD;
        I0 = 0; I1 = 0; I2 = 1;
        #PERIOD;
        I0 = 0; I1 = 1; I2 = 0;
        #PERIOD;
        I0 = 0; I1 = 1; I2 = 1;
        #PERIOD;
        I0 = 1; I1 = 0; I2 = 0;
        #PERIOD;
        I0 = 1; I1 = 0; I2 = 1;
        #PERIOD;
        I0 = 1; I1 = 1; I2 = 0;
        #PERIOD;
        I0 = 1; I1 = 1; I2 = 1;
        #PERIOD;
    end

endmodule