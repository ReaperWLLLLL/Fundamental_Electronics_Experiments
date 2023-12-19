module rom_data_tri (
    input lr_ch_tri_clk,
    input rst,
    output reg [7:0] addr_chL,
    output reg [7:0] addr_chR
);
    always @(posedge lr_ch_tri_clk or posedge rst) begin
        if (rst) begin
            addr_chL <= 8'd0;
        end else begin
            if (addr_chL == 8'd255) begin
                addr_chL <= 8'd0;
            end else begin
                addr_chL <= addr_chL + 1'b1;
            end
        end
    end

    always @(negedge lr_ch_tri_clk or posedge rst) begin
        if (rst) begin
            addr_chR <= 8'd0;
        end else begin
            if (addr_chR >= 8'd255) begin
                addr_chR <= 8'd0;
            end else begin
                addr_chR <= addr_chR + 1'b1;
            end
        end
    end

endmodule
