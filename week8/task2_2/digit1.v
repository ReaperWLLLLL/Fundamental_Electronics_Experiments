module digit1(
    input clk,
    input rst,
    input [7:0] data,
    output reg [3:0] digit,
    output reg [7:0] seg
);

reg [3:0] state;
reg [3:0] data_temp;
always @(posedge clk, posedge rst) begin
    if(rst) begin
        state <= 4'b0001;
        digit <= 4'b1111;
    end
    else begin
        case(state)
            4'b0001: begin
                state <= 4'b0010;
                digit <= 4'b1110;
                data_temp <= data[3:0];
            end
            4'b0010: begin
                state <= 4'b0100;
                digit <= 4'b1101;
                data_temp <= data[7:4];
            end
            4'b0100: begin
                state <= 4'b1000;
                digit <= 4'b1011;
                data_temp <= 4'b0000;
            end
            4'b1000: begin
                state <= 4'b0001;
                digit <= 4'b0111;
                data_temp <= 4'b0000;
            end
            default: begin
                state <= 4'b0001;
                digit <= 4'b1111;
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