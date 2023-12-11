module dac_controller (
    input clk,
    input c0,
    input c1,
    input rst,
    input [23:0] data_dac_chL,
    input [23:0] data_dac_chR,
    output mclk_dac,
    output sclk_dac,
    output lrck_dac,
    output reg sdata_dac,
    output bz  //蜂鸣器 
);

    reg [7:0] addr_chL, addr_chR;
    reg [4:0] delay_cnt;
    reg delay_flag;
    reg [5:0] dac_cntL, dac_cntR;
    reg dac_flagL, dac_flagR;  //LR两通道计数变量
    reg [8:0] lrck_dac_cnt;  //lrck计数变量
    reg [2:0] sclk_dac_cnt;  //sclk计数变量

    parameter DELAY_NUM = 5'd30;

    assign bz = 1'b1;  //让蜂鸣器不响

    //dac mclk,直接给主时钟
    assign mclk_dac = clk;

    always @(posedge mclk_dac, posedge rst)
        if (rst) begin
            delay_cnt  <= 0;
            delay_flag <= 0;
        end else if (delay_cnt == DELAY_NUM) begin
            delay_cnt  <= 0;
            delay_flag <= 1;
        end else begin
            delay_cnt  <= delay_cnt + 1'b1;
            delay_flag <= delay_flag;
        end

    //产生lrck的计数
    always @(posedge mclk_dac, posedge rst)
        if (rst) lrck_dac_cnt <= 0;
        else lrck_dac_cnt <= lrck_dac_cnt + 1'b1;

    //产生sclk的计数
    always @(posedge mclk_dac, posedge rst)
        if (rst) sclk_dac_cnt <= 0;
        else sclk_dac_cnt <= sclk_dac_cnt + 1'b1;

    assign lrck_dac = (delay_flag && (lrck_dac_cnt < 256)) ? 1 : 0;
    assign sclk_dac = (delay_flag && (sclk_dac_cnt < 4)) ? 0 : 1;

    //将两通道波形数据并串转换，送至dac数据端
    always @(posedge sclk_dac or posedge rst) begin
        if (rst) begin
            dac_cntL  <= 0;
            dac_cntR  <= 0;
            dac_flagL <= 0;
            dac_flagR <= 0;
        end else begin
            if (lrck_dac == 0) begin
                if (dac_cntL == 25) begin
                    dac_cntL  <= 0;
                    dac_flagL <= 1;
                    dac_flagR <= 0;
                end else if ((dac_cntL == 0) && (dac_flagL == 0)) begin
                    sdata_dac <= 0;
                    dac_cntL  <= dac_cntL + 1'b1;
                end else if ((dac_cntL > 0) && (dac_cntL < 25) && (dac_flagL == 0)) begin
                    sdata_dac <= data_dac_chL[24-dac_cntL];
                    dac_cntL  <= dac_cntL + 1'b1;
                end
            end else begin
                if (dac_cntR == 25) begin
                    dac_cntR  <= 0;
                    dac_flagR <= 1;
                    dac_flagL <= 0;
                end else if ((dac_cntR == 0) && (dac_flagR == 0)) begin
                    sdata_dac <= 0;
                    dac_cntR  <= dac_cntR + 1'b1;
                end else if ((dac_cntR > 0) && (dac_cntR < 25) && (dac_flagR == 0)) begin
                    sdata_dac <= data_dac_chR[24-dac_cntR];
                    dac_cntR  <= dac_cntR + 1'b1;
                end
            end
        end

    end

endmodule

