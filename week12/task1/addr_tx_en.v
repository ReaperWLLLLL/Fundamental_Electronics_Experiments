module addr_tx_en (
    input clk,
    input clk_origin,
    input rst,
    output reg [7:0] addr,
    output reg send_en
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            addr  <= 8'b00000000;
        end
        else begin
            if (addr == 8'b11111111) begin
                addr  <= 8'b00000000;
            end
            else begin
                addr  <= addr + 1'b1;
            end
        end
    end

    reg pulse1, pulse2, pulse3;
    wire clk_posedge;
    always @(posedge clk_origin, posedge rst) begin
        if(rst) begin
            pulse1 <= 1'b0;
            pulse2 <= 1'b0;
            pulse3 <= 1'b0;
        end
        else begin
            pulse1 <= clk;
            pulse2 <= pulse1;
            pulse3 <= pulse2;
        end
    end
    assign clk_posedge = pulse2 & ~pulse3;

    always @(posedge clk_origin, posedge rst) begin
        if (rst) begin
            send_en <= 1'b0;
        end
        else begin
            if(clk_posedge) begin
                send_en <= 1'b1;
            end
            else begin
                send_en <= 1'b0;
            end
        end
    end


endmodule
