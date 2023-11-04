//我如果拿16进制当定时器，那想必也是十分合理吧

module task2_3(
    input clk,
    input reset,
    output reg buzz
);

reg [11:0] real_time;//记录当前时间，以秒为单位
reg [15:0] data;//这里的data是一个16位的寄存器，储存数码管的值
reg [3:0] data_temp; //存储当前显示的数码管的值
reg [3:0] digit; //这里的digit是一个4位的寄存器，储存当前显示的数码管的位数
reg [7:0] segment; //这里的segment是一个8位的寄存器，用于驱动数码管

reg buzz_flag;
reg buzz_cnt;
reg stop_flag;
always @(posedge clk, posedge reset) begin
    if(reset) begin
        data[3:0] = 4'd0;
        data[7:4] = 4'd1;
        data[11:8] = 4'd1;
        data[15:12] = 4'd0;
        real_time = 12'd70;//70s
    end
    else if(cnt == 32'd25000000-1) begin
        if(real_time == 12'd0) begin
            buzz_flag = 1'b1;
            if(stop_flag == 1'b0) begin
                buzz_flag = 1'b0;
            end
        end
        else begin
            real_time = real_time - 12'd1;
            data[3:0] = ((real_time)%60)%10;
            data[7:4] = ((real_time)%60)/10;
            data[11:8] = ((real_time)/60)%10;
            data[15:12] = ((real_time)/60)/10;
        end
    end
end

always @(posedge clk, posedge reset) begin
    if(reset) begin
        buzz_flag <= 1'b0;
        buzz_cnt <= 3'd0;
        stop_flag <= 1'b0;
        buzz <= 1'b1;
    end
    else if(cnt == 32'd25000000-1 && buzz_flag == 1'b1) begin
        buzz = ~buzz;
        if(buzz_cnt == 3'd5) begin
            buzz_cnt <= 3'd0;
            stop_flag <= 1'b1;
        end
        else begin
            buzz_cnt <= buzz_cnt + 3'd1;
        end
    end
end

//实现一个1s的定时器
reg [31:0] cnt;
always @ (posedge clk or posedge reset)begin
    if(reset) begin
        cnt <= 32'b0;
    end
    else if(cnt == 32'd25000000-1) begin
        cnt <= 32'b0;
    end
    else begin
        cnt <= cnt + 32'b1;
    end
end

endmodule