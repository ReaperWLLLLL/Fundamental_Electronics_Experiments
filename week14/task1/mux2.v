module mux2(
    input [7:0] s,
    input [23:0] d1,
    input [23:0] d2,
    output reg [23:0] y
);

    always @ (s or d1 or d2)
        case (s)
            8'd0: y <= d1;
            8'd1: y <= d2;
            default: y <= 24'd0;
        endcase

        endmodule