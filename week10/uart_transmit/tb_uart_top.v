//~ `New testbench
`timescale 1ns / 1ps
`include "uart_top.v"
module tb_uart_top;

    // uart_top Parameters
    parameter PERIOD = 10;


    // uart_top Inputs
    reg  clk = 0;
    reg  rst = 0;

    // uart_top Outputs
    wire sci_tx;
    uart_top u_uart_top (
        .clk(clk),
        .rst(rst),
        .sci_tx(sci_tx)
    );

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
        #(25000000); 
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

endmodule
