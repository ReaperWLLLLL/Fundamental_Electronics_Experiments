module uart_2byte_controller_withoutHeader(
	input clk,
	input rst,
	input send_en,
	input tx_done,
	input [15:0] data,
	output reg tx_en,
	output reg send_done,
	output reg [7:0] tx_d,	
	output reg [1:0] state,nextstate
	);
	
//	reg [1:0] state,nextstate;

	parameter S0 = 3'b000,S1 = 3'b001,S2 = 3'b010,S3=3'b011,S4=3'b100;

	always @ (posedge clk, posedge rst)
		if (rst) state <= S0;
		else state <= nextstate;
	
	always @ (*)
		case (state)
			S0:begin
				send_done <= 0;
				if (send_en) begin
					tx_d <= data[7:0];
//					tx_en <= 1;
					nextstate <= S1;
				end
				else begin
					tx_d <= tx_d;
					tx_en <= 0;
					nextstate <= S0;
				end
			end
			
			S1:begin				
					tx_en <= 1;
					nextstate <= S2;				
			end
			
			S2:begin
				if (tx_done) begin
					tx_d <= data[15:8];
//					tx_en <= 1;
					nextstate <= S3;
				end
				else begin
					tx_d <= tx_d;
					tx_en <= 0;
					nextstate <= S2;
				end
			end
			
				
			S3:begin				
					tx_en <= 1;
					nextstate <= S4;				
			end
			
			S4:begin
				if (tx_done) begin
					tx_en <= 0;
					send_done <= 1;
					nextstate <= S0;
				end
				else begin
					tx_d <= tx_d;
					tx_en <= 0;
					nextstate <= S4;
				end
			end
			default: ;
		endcase
		
endmodule
