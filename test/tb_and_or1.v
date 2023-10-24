//~ `New testbench
`timescale  1ns / 1ps
`include "test\\and_or1.v"
module tb_and_or1;

// and_or1 Parameters
parameter PERIOD  = 10;


// and_or1 Inputs
reg   x1                                   = 0 ;
reg   x2                                   = 0 ;

// and_or1 Outputs
wire  and2                                 ;
wire  or2                                  ;

and_or1  u_and_or1 (
    .x1                      ( x1     ),
    .x2                      ( x2     ),

    .and2                    ( and2   ),
    .or2                     ( or2    )
);

initial
begin
    x1 = 0;
    x2 = 0;
    #10 x2 =0;x1 =1;
    #10 x2 =1;x1 =0;
    #10 x2 =1;x1 =1;
    #10;
end

endmodule