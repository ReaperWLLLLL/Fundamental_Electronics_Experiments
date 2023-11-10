`define CNT_MAX 32'd25
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
    //这里实现了按键3的下降沿检测，我知道这很蠢，但是我不想改
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
        if(div_reg < 32'd12500000)
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
    if(reset) begin
        cnt <= 32'b0;
    end
    else if(delay_flag) begin
        if(cnt == `CNT_MAX-1)
            cnt <= 32'b0;
        else begin
            cnt <= cnt + 32'b1;
        end
    end
end


reg delay_flag; //还挺好奇三个按键是否得用三个flag
always @(posedge clk or posedge reset) begin
    if(reset) begin
        delay_flag <= 1'b0;
    end
    else if(button1_posedge || button2_posedge || button3_posedge) begin
        delay_flag <= 1'b1;
    end
    else if(cnt == `CNT_MAX-1) begin
        delay_flag <= 1'b0;
    end
end

reg button1_state, button2_state, button3_state;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        button1_state <= 1'b0;
        button2_state <= 1'b0;
        button3_state <= 1'b0;
    end
    else if(cnt == `CNT_MAX-1) begin
        button1_state <= button_io1;
        button2_state <= button_io2;
        button3_state <= button_io3;
    end
    else begin
        button1_state <= 1'b0;
        button2_state <= 1'b0;
        button3_state <= 1'b0;
    end
end

reg led_state1_flag, led_state2_flag, led_state3_flag;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        led_state1_flag <= 1'b0;
        led_state2_flag <= 1'b0;
        led_state3_flag <= 1'b0;
    end
    else if(button1_state) begin
        led_state1_flag <= 1'b1;
        led_state2_flag <= 1'b0;
        led_state3_flag <= 1'b0;
    end     
    else if(button2_state) begin
        led_state1_flag <= 1'b0;
        led_state2_flag <= 1'b1;
        led_state3_flag <= 1'b0;
    end
    else if(stop_flag) begin
        led_state1_flag <= 1'b0;
        led_state2_flag <= 1'b0;
        led_state3_flag <= 1'b0;
    end
    else if(button3_state) begin
        led_state1_flag <= 1'b0;
        led_state2_flag <= 1'b0;
        led_state3_flag <= 1'b1;
    end
end

reg led_cnt;//led计数器
reg stop_flag;//停止标志位
always @(posedge clk_div or posedge reset) begin
    if(reset) begin
        led_io <= 8'b0;
        led_cnt <= 8'b0;
        stop_flag <= 1'b0;
    end
    else if(led_state1_flag) begin
        if(led_io == 8'b10000000 || led_io == 8'b00000000) begin
            led_io <= 8'b00000001;
        end
        else begin
            led_io <= led_io << 1;
        end
    end

    else if(led_state2_flag) begin
        if(led_io == 8'b00000001 || led_io == 8'b00000000) begin
            led_io <= 8'b10000000;
        end
        else begin
            led_io <= led_io >> 1;
        end
    end
    else if(led_state3_flag) begin
        if(led_io != 8'b0) begin
            led_io <= 8'b0;
        end
        else begin
            led_io <= 8'b11111111;
            led_cnt <= led_cnt + 1;
        end
    end

    if(led_cnt == 8'd2 ) begin//这个地方是8'd1为啥过不了？
        stop_flag <= 1'b1;
    end
    else if(led_cnt == 8'd3) begin
        led_cnt <= 0;
    end
    else begin
        stop_flag <= 1'b0;
    end
end

endmodule
