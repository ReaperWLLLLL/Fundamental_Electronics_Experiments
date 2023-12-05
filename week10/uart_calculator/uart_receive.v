module uart_receive #(
    parameter BAUD_RATE = 'd115200,
    parameter CLK_FREQ  = 'd25000000
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

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            baud_cnt <= 13'd0;
        end else if ((baud_cnt == BAUD_CNT_MAX - 1) || (work_en == 1'b0)) begin
            baud_cnt <= 13'd0;
        end else if (work_en) begin
            baud_cnt <= baud_cnt + 1'b1;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            bit_flag <= 1'b0;
        end else if (baud_cnt == BAUD_CNT_MAX / 2 - 1) begin
            bit_flag <= 1'b1;
        end else begin
            bit_flag <= 1'b0;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            bit_cnt <= 4'd0;
        end else if ((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
            bit_cnt <= 4'd0;
        end else if (bit_flag == 1'b1) begin
            bit_cnt <= bit_cnt + 1'b1;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rx_data <= 8'd0;
        end else if ((bit_cnt >= 4'd1) && (bit_cnt <= 4'd8) && (bit_flag == 1'b1)) begin
            rx_data <= {rx_reg3, rx_data[7:1]};
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rx_flag <= 1'b0;
        end else if ((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
            rx_flag <= 1'b1;
        end else begin
            rx_flag <= 1'b0;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            data <= 8'd0;
        end else if (rx_flag) begin
            data <= rx_data;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            ready <= 1'b0;
        end else begin
            ready <= rx_flag;
        end
    end
endmodule
