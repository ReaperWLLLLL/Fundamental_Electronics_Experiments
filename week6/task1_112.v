module task1_112(
    input clk,
    input reset,
    output reg [3:0] led_io
);

reg [1:0] state, nextstate;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

always @ (posedge clk, posedge reset)
    if(reset) state <= S0;
    else state <= nextstate;

always @ (*)
    case(state)
        S0: begin
            nextstate = S1;
            led_io = 4'b0001;
        end
        S1: begin
            nextstate = S2;
            led_io = 4'b0010;
        end
        S2: begin
            nextstate = S3;
            led_io = 4'b0100;
        end
        S3: begin
            nextstate = S0;
            led_io = 4'b1000;
        end
        default: nextstate = S0;
    endcase
endmodule