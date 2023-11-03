module task1_3(
    input clk,
    input reset,
    input button_io1,
    input button_io2,
    input button_io3,
    output reg clk_div,
    output reg [7:0] led_io
);

reg pulse1_1, pulse1_2, pulse1_3;
always @(posedge clk or posedge reset) begin
    //这里实现了按键1的下降沿检测
    if(reset)
    begin 
        pulse1_1 <= 1'b0;
        pulse1_2 <= 1'b0;
        pulse1_3 <= 1'b0;
    end
    else
    begin
        pulse1_1 <= button_io1;
        pulse1_2 <= pulse1_1;
        pulse1_3 <= pulse1_2;
    end
end
wire button1_negedge = ~pulse1_2 & pulse1_3;
wire button1_posedge = pulse1_2 & ~pulse1_3;

reg pulse2_1, pulse2_2, pulse2_3;
always @(posedge clk or posedge reset) begin
    //这里实现了按键2的下降沿检测
    if(reset)
    begin 
        pulse2_1 <= 1'b0;
        pulse2_2 <= 1'b0;
        pulse2_3 <= 1'b0;
    end
    else
    begin
        pulse2_1 <= button_io2;
        pulse2_2 <= pulse2_1;
        pulse2_3 <= pulse2_2;
    end
end
wire button2_negedge = ~pulse2_2 & pulse2_3;
wire button2_posedge = pulse2_2 & ~pulse2_3;

reg pulse3_1, pulse3_2, pulse3_3;
always @(posedge clk or posedge reset) begin
    //这里实现了按键3的下降沿检测
    if(reset)
    begin 
        pulse3_1 <= 1'b0;
        pulse3_2 <= 1'b0;
        pulse3_3 <= 1'b0;
    end
    else
    begin
        pulse3_1 <= button_io3;
        pulse3_2 <= pulse3_1;
        pulse3_3 <= pulse3_2;
    end
end
wire button3_negedge = ~pulse3_2 & pulse3_3;
wire button3_posedge = pulse3_2 & ~pulse3_3;

reg [31:0] div_reg;
always @ (posedge clk or posedge reset)
    //这里实现了一个1s的计数器
    if(reset)
    begin
        div_reg <= 32'b0;
        clk_div <= 1'b0;
    end

    else
    begin
        if(div_reg < 32'd25000000)
            div_reg <= div_reg + 32'b1;
        else
        begin
            div_reg <= 32'b0;
            clk_div <= ~clk_div;
        end
    end

reg [31:0] cnt;
always @ (posedge clk or posedge reset)begin
    //这里实现了按键的延时
    if(reset)
        cnt <= 32'b0;
    else if(button1_negedge || button2_negedge || button3_negedge)
        cnt <= 32'b0;
    else if(button1_posedge || button2_posedge || button3_posedge)
        cnt <= cnt + 32'b0;
    else if(cnt == 32'd25000000)
        cnt <= 32'b0;
    else
        cnt <= cnt + 32'b1;
end


endmodule

