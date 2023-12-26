module uart_rx_Nbyte_controller
(
					input clk,rst,					
					input rx_done,
					input [7:0] uart_data,
					output [7:0] byte1,byte2,byte3
					);
	
	localparam BYTE_NUM = 3'd3;
	reg [1:0] rx_done_buf;
	wire rx_done_posedge;
	reg [2:0] rx_byte_cnt;
	reg [7:0] byte_data[BYTE_NUM - 1:0];
	integer j;
	
	assign byte1 = byte_data[0];
	assign byte2 = byte_data[1];
	assign byte3 = byte_data[2];
	
	assign rx_done_posedge = ~rx_done_buf[1] && rx_done_buf[0];
	
	always @ (posedge clk, posedge rst)
		if (rst) rx_done_buf <= 2'b00;
		else begin
			rx_done_buf[1] <= rx_done_buf[0];
			rx_done_buf[0] <= rx_done;
		end
		
	always @ (posedge clk, posedge rst)
		if (rst) begin
			rx_byte_cnt <= 3'd0;
		end
		else if (rx_done_posedge) begin
			if (rx_byte_cnt < BYTE_NUM - 1) begin
				for (j = 0; j < BYTE_NUM; j = j + 1) begin
					if (j == rx_byte_cnt) byte_data[rx_byte_cnt] = uart_data;
					else;
				end
				rx_byte_cnt <= rx_byte_cnt + 1'b1;				
			end			
			else begin
				for (j = 0; j < BYTE_NUM; j = j + 1) begin
					if (j == rx_byte_cnt) byte_data[rx_byte_cnt] = uart_data;
					else;
				end
				rx_byte_cnt <= 3'd0;
			end
			end		
		else;
		
endmodule

		