module uart_digit(
    input clk,
    input rst,
    input [15:0] data,
    output reg [3:0] digit,
    output reg[7:0] seg
);

reg [15:0] data_temp;
reg [1:0] state1;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        digit = 4'b1111;
        state1 = 2'b00;
        data_temp = 4'b0000;
    end
    else begin
        case (state1)
            2'b00: begin
                data_temp = data[7:4];//???????
                digit = 4'b1110;
                state1 = 2'b01;
            end
            2'b01: begin
                data_temp = data[11:8];
                digit = 4'b1101;
                state1 = 2'b10;
            end
            2'b10: begin
                data_temp = data[15:12];//???????
                digit = 4'b1011;
                state1 = 2'b11;
            end
            2'b11: begin
                data_temp = data[3:0];
                digit = 4'b0111;
                state1 = 2'b00;
            end
            default: begin
                digit = 4'b1111;
                state1 = 2'b00;
                data_temp = 4'b0000;
            end
        endcase
    end
end

always @(posedge clk, posedge rst) begin
	if(rst) begin
		seg = 8'hc0;
	end
	else begin
		case (data_temp)
			0: seg = 8'hc0;
			1: seg = 8'hf9;
			2: seg = 8'ha4;
			3: seg = 8'hb0;
			4: seg = 8'h99;
			5: seg = 8'h92;
			6: seg = 8'h82;
			7: seg = 8'hf8;
			8: seg = 8'h80;
			9: seg = 8'h90;
			10: seg = 8'h88;
			11: seg = 8'h83;
			12: seg = 8'hc6;
			13: seg = 8'ha1;
			14: seg = 8'h86;
			15: seg = 8'h8e;
			default: seg = 8'hc0;
		endcase
	end
end




endmodule