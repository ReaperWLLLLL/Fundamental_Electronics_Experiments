`timescale  1ns / 1ps
`include "task3.v"
module tb_task3;

// task3 Parameters
parameter PERIOD  = 10;


// task3 Inputs
reg   a                                    = 0 ;
reg   b                                    = 0 ;
reg   c                                    = 0 ;

// task3 Outputs
wire  d                                    ;

task3  u_task3 (
    .a                       ( a   ),
    .b                       ( b   ),
    .c                       ( c   ),

    .d                       ( d   )
);

initial
begin
    #PERIOD;
    a = 0; b = 0; c = 0;
    #PERIOD;
    a = 0; b = 0; c = 1;
    #PERIOD;
    a = 0; b = 1; c = 0;
    #PERIOD;
    a = 0; b = 1; c = 1;
    #PERIOD;
    a = 1; b = 0; c = 0;
    #PERIOD;
    a = 1; b = 0; c = 1;
    #PERIOD;
    a = 1; b = 1; c = 0;
    #PERIOD;
    a = 1; b = 1; c = 1;
    #PERIOD;
end

endmodule