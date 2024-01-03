module adc_data_ready_tri(
    input clk,
    input rst,
    input lrck,
    output reg send_en
);

    reg pulse1, pulse2, pulse3;
    wire clk_edge;
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            pulse1 <= 1'b0;
            pulse2 <= 1'b0;
            pulse3 <= 1'b0;
        end
        else begin
            pulse1 <= lrck;
            pulse2 <= pulse1;
            pulse3 <= pulse2;
        end
    end
    assign clk_edge = (pulse2 & ~pulse3) | (~pulse2 & pulse3);


    always @(posedge clk, posedge rst) begin
        if (rst) begin
            send_en <= 1'b0;
        end
        else begin
            if(clk_edge) begin
                send_en <= 1'b1;
            end
            else begin
                send_en <= 1'b0;
            end
        end
    end


endmodule