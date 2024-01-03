module mux2(
    input  s,
    input [23:0] d1,
    input [23:0] d2,
    output reg [23:0] y
);

    always @ (s or d1 or d2)
        case (s)
            1'd1: y <= d1;
            1'd0: y <= d2;
            default: y <= 24'd0;
        endcase

        endmodule