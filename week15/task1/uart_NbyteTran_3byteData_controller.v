module uart_NbyteTran_3byteData_controller(
	input clk,
	input rst,
	input send_en,
	input tx_done,
	input [23:0] data,
	output reg tx_en,	
	output reg send_done,
	output reg [7:0] tx_d,
	output reg [4:0] state,nextstate
	);	

	parameter FRAME_NUM = 12'd1000;//数据包长度

	parameter  S0 = 5'b00000,S1 = 5'b00001, S2 = 5'b00010, S3 = 5'b00011, S4 = 5'b00100, S5 = 5'b00101, S6 = 5'b00110,
	           S7 = 5'b00111,S8 = 5'b01000, S9 = 5'b01001,S10 = 5'b01010,S11 = 5'b01011,S12 = 5'b01100,S13 = 5'b01101,
				 S14 = 5'b01110,S15= 5'b01111,S16 = 5'b10000;
	
	always @ (posedge clk, posedge rst)
		if (rst) state <= S0;
		else state <= nextstate;
	
//在开头加帧尾0x4545、帧头0x5353，数据包
	
	reg [10:0] frame_cnt;
	wire send_flag;
	
	always @ (posedge clk,posedge rst)
		if (rst) frame_cnt <= 0;
		else begin
			if (send_en) begin					
				if (frame_cnt < (FRAME_NUM - 1)) begin frame_cnt <= frame_cnt + 1'b1;end
				else begin frame_cnt <= 0;end
			end
			else ;
		end
		
	always @ (*)
		case (state)
			S0:begin
				send_done <= 0;
				if (send_en) begin
					if (frame_cnt == 0) begin
						tx_d <= 8'h45;
						tx_en <= 1;
						nextstate <= S1;
					end
					else begin
						tx_d <= data[7:0];
						tx_en <= 1;
						nextstate <= S2;
					end
				end
				else begin
					tx_d <= tx_d;
					tx_en <= 0;
					nextstate <= S0;
				end
			end
			S1:begin
				if (tx_done) begin
					tx_d <=  8'h45;
					tx_en <= 0;
					nextstate <= S3;
				end				
				else begin
					tx_d <=  8'h45;
					tx_en <= 0;
					nextstate <= S1;
				end
			end
			
			S2:begin
				if (tx_done) begin
					tx_d <= data[7:0];
					tx_en <= 0;
					nextstate <= S11;
				end				
				else begin
					tx_d <= data[7:0];
					tx_en <= 0;
					nextstate <= S2;
				end
			end
			
			//发送第二个0x45
			S3:begin
				tx_d <= 8'h45;
				tx_en <= 1;
				nextstate <= S4;
			end
			
			S4:begin
				if (tx_done) begin
					tx_d <= 8'h45;	
					tx_en <= 0;
					nextstate <= S5;
				end
				else begin
					tx_d <= 8'h45;
					tx_en <= 0;
					nextstate <= S4;
				end
			end
			//发送第一个0x53
			S5:begin
				tx_d <= 8'h53;
				tx_en <= 1;
				nextstate <= S6;
			end
			
			S6:begin
				if (tx_done) begin
					tx_d <= 8'h53;	
					tx_en <= 0;
					nextstate <= S7;
				end
				else begin
					tx_d <= 8'h53;
					tx_en <= 0;
					nextstate <= S6;
				end
			end
			//发送第二个0x53
			S7:begin
				tx_d <= 8'h53;
				tx_en <= 1;
				nextstate <= S8;
			end
			
			S8:begin
				if (tx_done) begin
					tx_d <= 8'h53;	
					tx_en <= 0;
					nextstate <= S9;
				end
				else begin
					tx_d <= 8'h53;
					tx_en <= 0;
					nextstate <= S8;
				end
			end
			//发送低8位
			S9:begin
				tx_d <= data[7:0];
				tx_en <= 1;
				nextstate <= S10;
			end
			
			S10:begin
				if (tx_done) begin
					tx_d <= data[7:0];
					tx_en <= 0;
					nextstate <= S11;
				end
				else begin
					tx_d <= data[7:0];
					tx_en <= 0;
					nextstate <= S10;
				end
			end
			//发送中8位
			S11:begin
					tx_d <= data[15:8];
					tx_en <= 1;
					nextstate <= S12;
			end
			
			S12:begin
				if (tx_done) begin
					tx_d <= data[15:8];	
					tx_en <= 0;
					nextstate <= S13;
				end
				else begin
					tx_d <= data[15:8];
					tx_en <= 0;
					nextstate <= S12;
				end
			end
			//发送高8位
			S13:begin
					tx_d <= data[23:16];
					tx_en <= 1;
					nextstate <= S14;
			end
			
			S14:begin
				if (tx_done) begin
					tx_d <= data[23:16];	
					tx_en <= 0;
					nextstate <= S15;
				end
				else begin
					tx_d <= data[23:16];
					tx_en <= 0;
					nextstate <= S14;
				end
			end
			//发送高高8位
			S15:begin
					tx_d <= 8'h00;
					tx_en <= 1;
					nextstate <= S16;
			end
			
			S16:begin
				if (tx_done) begin
					tx_d <= 8'h00;	
					tx_en <= 0;
					nextstate <= S0;
				end
				else begin
					tx_d <= 8'h00;
					tx_en <= 0;
					nextstate <= S16;
				end
			end
			default: nextstate <= S0;
		endcase	

endmodule
