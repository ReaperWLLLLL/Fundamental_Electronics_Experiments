`define CNT_MAX 32'd25000000
module task2_4(
    input clk,
    input reset,
    input [7:0] switch_io,
    output reg clk_div,
    output reg buzz,
    output reg [3:0] digit, //这里的digit是一个4位的寄存器，储存当前显示的数码管的位数
    output reg [7:0] segment //这里的segment是一个8位的寄存器，用于驱动数码管
);

reg [7:0] real_time;//记录当前时间，以秒为单位
reg [15:0] data;//这里的data是一个16位的寄存器，储存数码管的值
reg [3:0] data_temp; //存储当前显示的数码管的值


reg buzz_flag;
reg buzz_cnt;
reg stop_flag;
always @(posedge clk, posedge reset) begin
    if(reset) begin
        real_time = switch_io;
        data[3:0] = ((real_time)%60)%10;
        data[7:4] = ((real_time)%60)/10;
        data[11:8] = ((real_time)/60)%10;
        data[15:12] = ((real_time)/60)/10;
        buzz_flag <= 1'b0; 
    end
    else if(cnt == `CNT_MAX-1) begin
        if(real_time == 8'd0) begin
            buzz_flag = 1'b1;
            if(stop_flag == 1'b1) begin
                buzz_flag = 1'b0;
            end
        end
        else begin
            real_time = real_time - 8'd1;
            data[3:0] = ((real_time)%60)%10;
            data[7:4] = ((real_time)%60)/10;
            data[11:8] = ((real_time)/60)%10;
            data[15:12] = ((real_time)/60)/10;
        end
    end
end

always @(posedge clk, posedge reset) begin
    if(reset) begin
        buzz_cnt <= 3'd0;
        stop_flag <= 1'b0;
        buzz <= 1'b1;
    end
    else if(cnt == `CNT_MAX-1 && buzz_flag == 1'b1) begin
        buzz = ~buzz;
        if(buzz_cnt == 3'd5) begin
            buzz_cnt <= 3'd0;
            stop_flag <= 1'b1;
        end
        else begin
            buzz_cnt <= buzz_cnt + 3'd1;
        end
    end
    else begin
    end
end

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

//实现一个1s的定时器
reg [31:0] cnt;
always @ (posedge clk or posedge reset)begin
    if(reset) begin
        cnt <= 32'b0;
    end
    else if(cnt == `CNT_MAX-1) begin
        cnt <= 32'b0;
    end
    else begin
        cnt <= cnt + 32'b1;
    end
end

reg [1:0] state; 
always @(posedge clk_div or posedge reset) begin
    if(reset) begin
        data_temp <= 4'b0000;
        digit <= 4'b1111;
        state <= 2'b00; 
    end
    else begin
        case (state)
            2'b00: begin
                data_temp <= data[15:12];
                digit <= 4'b1110;
                state <= 2'b01;
            end
            2'b01: begin
                data_temp <= data[11:8];
                digit <= 4'b1101;
                state <= 2'b10;
            end
            2'b10: begin
                data_temp <= data[7:4];
                digit <= 4'b1011;
                state <= 2'b11;
            end
            2'b11: begin
                data_temp <= data[3:0];
                digit <= 4'b0111;
                state <= 2'b00;
            end
            default: begin
                data_temp <= 4'b0000;
                digit <= 4'b1111;
                state <= 2'b00;
            end
        endcase
    end
end

always @(posedge clk, posedge reset) begin
    if(reset) begin
        segment <= 8'h00;
    end
    else begin
        case (data_temp)
            0: segment <= 8'hc0;
            1: segment <= 8'hf9;
            2: segment <= 8'ha4;
            3: segment <= 8'hb0;
            4: segment <= 8'h99;
            5: segment <= 8'h92;
            6: segment <= 8'h82;
            7: segment <= 8'hf8;
            8: segment <= 8'h80;
            9: segment <= 8'h90;
            10: segment <= 8'h88;
            11: segment <= 8'h83;
            12: segment <= 8'hc6;
            13: segment <= 8'ha1;
            14: segment <= 8'h86;
            15: segment <= 8'h8e;
            default: segment <= 8'h00;
        endcase
    end
end

endmodule