module task1_12(
    input panic ,enable, exiting, window, door, garage, 
    output reg alarm
    );
    always @(panic, enable, exiting, window, door, garage) begin:Ablk
        reg secure;
        secure = window & door & garage;
        alarm = panic | (enable & ~exiting & ~secure);
    end
endmodule
