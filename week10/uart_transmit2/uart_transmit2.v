module uart_transmit2 (
    input clk,
    rst,
    tx_en,
    input [7:0] rx_d,
    output reg sci_tx
);

    reg tx_sel_data, flag;
    reg [3:0] tx_num;

    // 定义参数
    parameter CLK_FREQ = 25000000, BPS_CONS = 115200, BPS_DIV = CLK_FREQ/BPS_CONS, BPS_DIV_HALF = CLK_FREQ/BPS_CONS/2;

    // 状态机
    always @(posedge clk or posedge rst)
        if (rst) flag <= 0;
        else if (tx_en) flag <= 1;
        else if (tx_num == 4'd10) flag <= 0;
        else;

    reg [12:0] cnt;

    // 计数器
    always @(posedge clk or posedge rst)
        if (rst) cnt <= 13'd0;
        else if (flag && cnt < BPS_DIV) cnt <= cnt + 1'b1;
        else cnt <= 13'd0;

    // 发送数据选择信号
    always @(posedge clk or posedge rst)
        if (rst) tx_sel_data <= 1'b0;
        else if (cnt == BPS_DIV_HALF) tx_sel_data <= 1'b1;
        else tx_sel_data <= 1'b0;

    // 发送数据计数器
    always @(posedge clk or posedge rst)
        if (rst) tx_num <= 4'd0;
        else if (tx_sel_data && flag) tx_num <= tx_num + 1'b1;
        else if (tx_num == 4'd10) tx_num <= 1'd0;
        else;

    // 发送数据
    always @(posedge clk or posedge rst)
        if (rst) sci_tx <= 1'b1;
        else if (tx_sel_data)
            case (tx_num)
                0: sci_tx <= 1'b0;
                1: sci_tx <= rx_d[0];
                2: sci_tx <= rx_d[1];
                3: sci_tx <= rx_d[2];
                4: sci_tx <= rx_d[3];
                5: sci_tx <= rx_d[4];
                6: sci_tx <= rx_d[5];
                7: sci_tx <= rx_d[6];
                8: sci_tx <= rx_d[7];
                9: sci_tx <= 1'b1;
                default: sci_tx <= 1'b1;
            endcase
endmodule
