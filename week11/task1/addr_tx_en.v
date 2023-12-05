// a idiot tried to write a counter in the state machine, and he failed.
// maybe put the counter in this module will work.
module addr_tx_en #(
    parameter FRAMENUM = 60
) (
    input clk,
    input clk_origin,
    input rst,
    input [15:0] data_temp,
    output reg [15:0] data_out,
    output reg [7:0] addr,
    output reg tx_en
);
    reg [5:0] frame_cnt;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            addr <= 8'b00000000;
            frame_cnt <= 6'b000000;
        end else begin
            if (addr == 8'b11111111) begin
                addr <= 8'b00000000;
            end else begin
                if (frame_cnt == FRAMENUM - 1) begin
                    addr <= addr;
                    data_out <= 16'h4545;
                    frame_cnt <= 6'b000000;
                end else if (frame_cnt == 0) begin
                    addr <= addr;
                    data_out <= 16'h5353;
                    frame_cnt <= frame_cnt + 1'b1;
                end else begin
                    addr <= addr + 1'b1;
                    data_out <= data_temp;
                    frame_cnt <= frame_cnt + 1'b1;
                end
            end
        end
    end

    reg pulse1, pulse2, pulse3;
    wire clk_posedge;
    always @(posedge clk_origin, posedge rst) begin
        if (rst) begin
            pulse1 <= 1'b0;
            pulse2 <= 1'b0;
            pulse3 <= 1'b0;
        end else begin
            pulse1 <= clk;
            pulse2 <= pulse1;
            pulse3 <= pulse2;
        end
    end
    assign clk_posedge = pulse2 & ~pulse3;

    always @(posedge clk_origin, posedge rst) begin
        if (rst) begin
            tx_en <= 1'b0;
        end else begin
            if (clk_posedge) begin
                tx_en <= 1'b1;
            end else begin
                tx_en <= 1'b0;
            end
        end
    end


endmodule
