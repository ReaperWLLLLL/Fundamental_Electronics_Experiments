// a idiot tried to write a counter in the state machine, and he failed.
// maybe put the counter in this module will work.

module addr_tx_en #(
    parameter FRAMENUM = 60
) (
    input clk,  // Clock input
    input clk_origin,  // Original clock input
    input rst,  // Reset input
    input [15:0] data_temp,  // Temporary data input
    output reg [15:0] data_out,  // Output data
    output reg [7:0] addr,  // Address output
    output reg tx_en  // Transmit enable output
);

    reg [5:0] frame_cnt;  // Frame counter

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            addr <= 8'b00000000;  // Reset address
            frame_cnt <= 6'b000000;  // Reset frame counter
        end else begin
            if (addr == 8'b11111111) begin  // Check if address is at maximum value
                addr <= 8'b00000000;  // Reset address
            end else begin
                if (frame_cnt == FRAMENUM - 1) begin  // Check if frame counter is at maximum value
                    addr <= addr;  // Keep current address
                    data_out <= 16'h4545;  // Set output data
                    frame_cnt <= 6'b000000;  // Reset frame counter
                end else if (frame_cnt == 0) begin  // Check if frame counter is at minimum value
                    addr <= addr;  // Keep current address
                    data_out <= 16'h5353;  // Set output data
                    frame_cnt <= frame_cnt + 1'b1;  // Increment frame counter
                end else begin
                    addr <= addr + 1'b1;  // Increment address
                    data_out <= data_temp;  // Set output data
                    frame_cnt <= frame_cnt + 1'b1;  // Increment frame counter
                end
            end
        end
    end

    reg pulse1, pulse2, pulse3;  // Clock pulse signals
    wire clk_posedge;  // Positive edge clock signal

    always @(posedge clk_origin, posedge rst) begin
        if (rst) begin
            pulse1 <= 1'b0;  // Reset pulse1
            pulse2 <= 1'b0;  // Reset pulse2
            pulse3 <= 1'b0;  // Reset pulse3
        end else begin
            pulse1 <= clk;  // Assign pulse1 with clock input
            pulse2 <= pulse1;  // Assign pulse2 with pulse1
            pulse3 <= pulse2;  // Assign pulse3 with pulse2
        end
    end

    assign clk_posedge = pulse2 & ~pulse3;  // Calculate positive edge clock signal

    always @(posedge clk_origin, posedge rst) begin
        if (rst) begin
            tx_en <= 1'b0;  // Reset transmit enable
        end else begin
            if (clk_posedge) begin  // Check if positive edge clock signal is high
                tx_en <= 1'b1;  // Set transmit enable
            end else begin
                tx_en <= 1'b0;  // Reset transmit enable
            end
        end
    end

endmodule
