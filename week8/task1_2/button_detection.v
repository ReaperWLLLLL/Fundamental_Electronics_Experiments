//按键消抖和检测模块，这玩意理论上一定要写
//this module is to transform the origin button signal to a stable signal
`define CNT_MAX 25000
module button_detection(
    input clk,
    input rst,
    input [3:0] vl,
    output reg [3:0] vl_out
);
reg [3:0] vl_temp1;
reg [3:0] vl_temp2;
reg [3:0] vl_temp3;
always @(posedge clk or posedge rst) begin
    if(rst) begin
        vl_temp1 <= 4'b0000;
        vl_temp2 <= 4'b0000;
        vl_temp3 <= 4'b0000;
    end
    else begin
        vl_temp1 <= vl;
        vl_temp2 <= vl_temp1;
        vl_temp3 <= vl_temp2;
    end
end
wire v1_negedge = (~vl_temp2[0] & vl_temp2[0]) || (~vl_temp2[1] & vl_temp3[1]) || (~vl_temp2[2] & vl_temp3[2]) || (~vl_temp2[3] & vl_temp3[3]); //detect the nwgedge of vl,

reg [31:0] cnt;
always @ (posedge clk or posedge rst)begin
    if(rst) begin
        cnt <= 32'b0;
        vl_out <= 4'b1111;
    end
    else if(delay_flag) begin
        if(cnt == `CNT_MAX-1) begin
            cnt <= 32'b0;
            vl_out <= vl;
        end
        else begin
            cnt <= cnt + 32'b1;
            vl_out <= 4'b1111;
        end
    end
end

reg delay_flag;
always @(posedge clk or posedge rst) begin
    if(rst) begin
        delay_flag <= 1'b0;
    end
    else if(v1_negedge) begin
        delay_flag <= 1'b1;
    end
    else if(cnt == `CNT_MAX-1) begin
        delay_flag <= 1'b0;
    end
end

always @(posedge clk or posedge rst) begin

end
endmodule