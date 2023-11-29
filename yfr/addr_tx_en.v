module addr_tx_en (
    input clk,
    input clk_origin,
    input rst,
    input [2:0] switch,
    output reg [9:0] addr,
    output reg tx_en
);
    reg [9:0] addr_count;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            addr_count  <= 0;
        end
        else begin
            if (addr_count == 8'd255) begin
                addr_count  <= 0;
            end
            else begin
                addr_count  <= addr_count + 1;
            end
        end
    end
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            addr <= 10'd0;
        end else begin
            if (switch[0]) begin
                addr <= addr_count;
            end else if (switch[1]) begin
                addr <= addr_count+ 10'd256;
            end else if (switch[2]) begin
                addr <= addr_count+ 10'd512;
            end else begin
                addr <= 10'd0;
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
            tx_en <= 1'b0;
        end
        else begin
            if(clk_posedge) begin
                tx_en <= 1'b1;
            end
            else begin
                tx_en <= 1'b0;
            end
        end
    end


endmodule
