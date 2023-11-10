//这玩意倒是可以完全照抄task1_3，验证这个没问题，1_3应该也没问题
`define CNT_MAX 32'd2500000
module task2_2(
    input clk,
    input reset,
    input button_io,
    output reg clk_div,
    output reg [3:0] digit, //这里的digit是一个4位的寄存器，储存当前显示的数码管的位数
    output reg [7:0] segment //这里的segment是一个8位的寄存器，用于驱动数码管
);
localparam SIMULATION_PARAMETER = 32'd100000; //仿真缩小时间尺度，实机为1

reg [15:0] data;//这里的data是一个16位的寄存器，储存数码管的值
reg [3:0] data_temp; //存储当前显示的数码管的值


reg pulse1, pulse2, pulse3;
always @(posedge clk, posedge reset) begin
    //这里实现了按键的下降沿检测
    if(reset)
    begin 
        pulse1 <= 1'b0;
        pulse2 <= 1'b0;
        pulse3 <= 1'b0;
    end
    else
    begin
        pulse1 <= button_io;
        pulse2 <= pulse1;
        pulse3 <= pulse2;
    end
end
wire button_negedge = ~pulse2 & pulse3;
wire button_posedge = pulse2 & ~pulse3;

reg [31:0] div_reg;
always @ (posedge clk or posedge reset) begin
    //这里实现了一个1Hz的计数器
    if(reset)
    begin
        div_reg <= 32'b0;
        clk_div <= 1'b0;
    end

    else
    begin
        if(div_reg < 32'd12500)
            div_reg <= div_reg + 32'b1;
        else
        begin
            div_reg <= 32'b0;
            clk_div <= ~clk_div;
        end
    end
end
reg [31:0] cnt;
always @ (posedge clk or posedge reset)begin
    //这里实现了按键的延时
    if(reset) begin
        cnt <= 32'b0;
        data <= 16'b0000_0000_0000_0000;
    end
    else if(delay_flag) begin
        if(cnt == `CNT_MAX-1) begin //这里要加个`是真的逆天
            if(button_io == 1'b1) begin
                //感觉不太合规，但是少两个always
                data <= data + 16'b0000_0000_0000_0001;
            end
            cnt <= 32'b0;
        end
        else begin
            cnt <= cnt + 32'b1;
        end
    end
end

reg delay_flag;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        delay_flag <= 1'b0;
    end
    else if(button_posedge) begin
        delay_flag <= 1'b1;
    end
    else if(cnt == `CNT_MAX-1) begin
        delay_flag <= 1'b0;
    end
end

reg [1:0] state; 
always @(posedge clk_div or posedge reset) begin
    //不分频有bug，分频之后就没问题了
    if(reset) begin
        data_temp = 4'b0000;
        digit = 4'b1111;
        state = 2'b00; 
    end
    else begin
        case (state)
            2'b00: begin
                digit = 4'b1110;
                data_temp = data[15:12];
                state = 2'b01;
            end
            2'b01: begin
                digit = 4'b1101;
                data_temp = data[11:8];
                state = 2'b10;
            end
            2'b10: begin
                digit = 4'b1011;
                data_temp = data[7:4];
                state = 2'b11;
            end
            2'b11: begin
                digit = 4'b0111;
                data_temp = data[3:0];
                state = 2'b00;
            end
            default: begin
                digit = 4'b1111;
                data_temp = 4'b0000;
                state = 2'b00;
            end
        endcase
    end
end

always @(posedge clk, posedge reset) begin
    if(reset) begin
        segment = 8'h00;
    end
    else begin
        case (data_temp)
            0: segment = 8'hc0;
            1: segment = 8'hf9;
            2: segment = 8'ha4;
            3: segment = 8'hb0;
            4: segment = 8'h99;
            5: segment = 8'h92;
            6: segment = 8'h82;
            7: segment = 8'hf8;
            8: segment = 8'h80;
            9: segment = 8'h90;
            10: segment = 8'h88;
            11: segment = 8'h83;
            12: segment = 8'hc6;
            13: segment = 8'ha1;
            14: segment = 8'h86;
            15: segment = 8'h8e;
            default: segment = 8'h00;
        endcase
    end
end
endmodule