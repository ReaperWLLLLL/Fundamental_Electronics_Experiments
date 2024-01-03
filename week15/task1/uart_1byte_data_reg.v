module uart_1byte_data_reg (
    input clk,
    input rst,
    input rx_done,
    input [7:0] rx_data,
    output reg [7:0] rx_data_out
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rx_data_out <= 8'd0;
        end else if (rx_done) begin
            rx_data_out <= rx_data;
        end else;
    end


endmodule
