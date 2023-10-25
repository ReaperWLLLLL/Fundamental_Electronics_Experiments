//~ `New testbench
`timescale 1ns/1ps
`include "task2_14.v"
module tb_task2_14;

    // task2_14 Parameters
    parameter PERIOD = 10;

    // task2_14 Inputs
    reg panic = 0;
    reg enable = 0;
    reg exiting = 0;
    reg window = 0;
    reg door = 0;
    reg garage = 0;

    // task2_14 Outputs
    wire alarm;

    task2_14 u_task2_14 (
        .panic(panic),
        .enable(enable),
        .exiting(exiting),
        .window(window),
        .door(door),
        .garage(garage),
        .alarm(alarm)
    );

    initial begin
        
        // Test 1
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 0; door = 0; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 0; door = 0; garage = 1;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 0; door = 1; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 0; door = 1; garage = 1;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 1; door = 0; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 1; door = 0; garage = 1;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 1; door = 1; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 0; window = 1; door = 1; garage = 1;
        #PERIOD;

        // Test 2
        panic = 0; enable = 0; exiting = 1; window = 0; door = 0; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 0; door = 0; garage = 1;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 0; door = 1; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 0; door = 1; garage = 1;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 1; door = 0; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 1; door = 0; garage = 1;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 1; door = 1; garage = 0;
        #PERIOD;
        panic = 0; enable = 0; exiting = 1; window = 1; door = 1; garage = 1;
        #PERIOD;

        //...


    end

endmodule