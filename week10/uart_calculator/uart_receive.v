module uart_receive #(
    parameter BAUD_RATE = 'd9600,
    parameter CLK_FREQ  = 25000000
) (
    input clk,
    input rst,
    input rx,
    output reg [7:0] data,
    output reg ready
);

    //localparam define
    localparam BAUD_CNT_MAX = CLK_FREQ / BAUD_RATE;

    //reg define
    reg rx_reg1;
    reg rx_reg2;
    reg rx_reg3;  //for pulse
    reg start_nedge;
    reg work_en;
    reg [12:0] baud_cnt;
    reg bit_flag;
    reg [3:0] bit_cnt;
    reg [7:0] rx_data;
    reg rx_flag;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rx_reg1 <= 1'b1;
            rx_reg2 <= 1'b1;
            rx_reg3 <= 1'b1;
        end else begin
            rx_reg1 <= rx;
            rx_reg2 <= rx_reg1;
            rx_reg3 <= rx_reg2;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            start_nedge <= 1'b0;
        end else if ((~rx_reg2) && rx_reg3) begin
            start_nedge <= 1'b1;
        end else begin
            start_nedge <= 1'b0;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            work_en <= 1'b0;
        end else if (start_nedge) begin
            work_en <= 1'b1;
        end else if ((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
            work_en <= 1'b0;
        end
    end

    






endmodule
