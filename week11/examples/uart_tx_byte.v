module uart_tx_byte(
					input clk,rst,tx_en,					
					input [7:0]rx_d,
					output reg sci_tx,
					output reg tx_done
					);
	
	
	reg tx_flag;
	reg [3:0] tx_num;
	reg [12:0] div_cnt;
	
	parameter CLK_FREQ = 25000000,
				 BPS_CONS = 115200,
			    BPS_DIV = CLK_FREQ/BPS_CONS;
//				 BPS_DIV_HALF = CLK_FREQ/BPS_CONS/2;

	always @(posedge clk or posedge rst)
		if (rst) tx_flag <= 0;
		else if (tx_en) tx_flag <= 1;
		else if ((tx_num == 4'd9) && (div_cnt == (BPS_DIV - 1))) tx_flag <= 0;
		else;
	
	always @ (posedge clk, posedge rst)
	if (rst) begin
		div_cnt <= 0;
		tx_num <= 0;
	end
	else if (tx_flag) begin
		if (div_cnt < BPS_DIV - 1) begin
			div_cnt <= div_cnt + 1'b1;
			
		end
		else begin
			div_cnt <= 0;
			tx_num <= tx_num + 1'b1;
		end
	end
	else begin
		div_cnt <= 0;
		tx_num <= 0;
	end
		
	always @ (posedge clk or posedge rst)
		if (rst)
			sci_tx <= 1'b1;
		else if (tx_flag)
			case (tx_num)
				0: sci_tx <= 1'b0;
				1: sci_tx <= rx_d[0];
				2: sci_tx <= rx_d[1];
				3: sci_tx <= rx_d[2];
				4: sci_tx <= rx_d[3];
				5: sci_tx <= rx_d[4];
				6: sci_tx <= rx_d[5];
				7: sci_tx <= rx_d[6];
				8: sci_tx <= rx_d[7];
				9: sci_tx <= 1'b1;
				default: sci_tx <= 1'b1;
			endcase
			
	always @ (posedge clk, posedge rst)
	if (rst) tx_done <= 1'b0;
	else if ((tx_num == 4'd9) && (div_cnt == (BPS_DIV - 1))) tx_done <= 1'b1;
	else tx_done <= 1'b0;
	
endmodule
