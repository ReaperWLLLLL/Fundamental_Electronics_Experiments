module uart_2byte_controller #(
    parameter FRAMENUM = 'd60
) (
    input clk,
    input rst,
    input send_en,
    input tx_done,
    input [15:0] data,
    output reg tx_en,
    output reg send_done,
    output reg [7:0] tx_d,
    output reg [3:0] state,
    nextstate
);


    parameter S0 = 4'b0000,S1 = 4'b0001,S2 = 4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,
	          S7=4'b0111,S8=4'b1000,S9=4'b1001,S10=4'b1010,S11=4'b1011,S12=4'b1100,S13=4'b1101,S14=4'b1110,S15=4'b1111;
    reg [5:0] data_cnt;
    always @(posedge clk, posedge rst)
        if (rst) state <= S0;
        else state <= nextstate;

    //在两个字节前后加帧头0x5353、帧尾0x4545	
    always @(*)
        case (state)
            S0: begin
                send_done <= 0;
                data_cnt  <= 0;
                if (send_en) begin
                    tx_d <= 8'h53;
                    //					tx_en <= 1;
                    nextstate <= S1;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S0;
                end
            end

            S1: begin
                tx_en <= 1;
                nextstate <= S2;
            end

            S2: begin
                if (tx_done) begin
                    tx_d <= 8'h53;
                    //					tx_en <= 1;
                    nextstate <= S3;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S2;
                end
            end

            S3: begin
                tx_en <= 1;
                nextstate <= S4;
            end


            S4: begin
                if (tx_done) begin
                    tx_d <= data[7:0];
                    //					tx_en <= 1;
                    nextstate <= S5;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S4;
                end
            end

            S5: begin
                tx_en <= 1;
                nextstate <= S6;
            end

            S6: begin
                if (tx_done) begin
                    tx_d <= data[15:8];
                    //tx_en <= 1;
                    nextstate <= S7;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S6;
                end
            end

            S7: begin
                data_cnt  <= data_cnt + 1;
                nextstate <= S13;
            end

            S8: begin
                if (tx_done) begin
                    tx_d <= 8'h45;
                    tx_en <= 1;
                    nextstate <= S9;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S8;
                end
            end

            S9: begin
                tx_en <= 1;
                nextstate <= S10;
            end

            S10: begin
                if (tx_done) begin
                    tx_d <= 8'h45;
                    tx_en <= 1;
                    nextstate <= S11;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S10;
                end
            end

            S11: begin
                tx_en <= 1;
                nextstate <= S12;
            end

            S12: begin
                if (tx_done) begin
                    tx_d <= 8'h00;
                    tx_en <= 0;
                    send_done <= 1;
                    nextstate <= S0;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S12;
                end
            end

            S13: begin
                if (data_cnt == `FRAMENUM - 1) begin  // Use double equals for equality comparison
                    tx_en <= 1;
                    nextstate <= S8;
                end else if(send_en) begin
                    nextstate <= S3;
                end else begin
                    tx_d <= tx_d;
                    tx_en <= 0;
                    nextstate <= S13;
                end

            end
            default: ;
        endcase
endmodule
