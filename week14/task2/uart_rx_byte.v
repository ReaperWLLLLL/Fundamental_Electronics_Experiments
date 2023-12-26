module uart_rx_byte
#(parameter CLK_FREQ = 25_000_000, parameter BPS_CONS = 1000_000)
(
					input clk,rst,					
					input sci_rx,
					output reg [7:0] uart_data,
					output reg rx_done
					);
	
	
	reg rx_flag;
	reg [3:0] rx_num;
	reg [12:0] div_cnt;
	reg [7:0] rx_data;
	
	localparam BPS_DIV = CLK_FREQ/BPS_CONS;

	reg [1:0] sci_rx_buf;
	wire rx_negedge;
	assign rx_negedge = sci_rx_buf[1] && ~sci_rx_buf[0];
	
	always @ (posedge clk, posedge rst)
		if (rst) sci_rx_buf <= 2'b00;
		else begin
			sci_rx_buf[1] <= sci_rx_buf[0];
			sci_rx_buf[0] <= sci_rx;
		end
	
	
	always @(posedge clk or posedge rst)
		if (rst) rx_flag <= 0;
		else if (rx_negedge) rx_flag <= 1;
		else if ((rx_num == 4'd9) && (div_cnt == (BPS_DIV - 1))) rx_flag <= 0;
		else;
	
	always @ (posedge clk, posedge rst)
	if (rst) begin
		div_cnt <= 0;
		rx_num <= 0;
	end
	else if (rx_flag) begin
		if (div_cnt < BPS_DIV - 1) begin
			div_cnt <= div_cnt + 1'b1;			
		end
		else begin
			div_cnt <= 0;
			rx_num <= rx_num + 1'b1;
		end
	end
	else begin
		div_cnt <= 0;
		rx_num <= 0;
	end
		
	always @ (posedge clk or posedge rst)
		if (rst)
			rx_data <= 8'd0;
		else if (rx_flag)
			if (div_cnt == BPS_DIV/2) begin
				case (rx_num)			
					4'd1: rx_data[0] <= sci_rx_buf[1];
					4'd2: rx_data[1] <= sci_rx_buf[1];
					4'd3: rx_data[2] <= sci_rx_buf[1];
					4'd4: rx_data[3] <= sci_rx_buf[1];
					4'd5: rx_data[4] <= sci_rx_buf[1];
					4'd6: rx_data[5] <= sci_rx_buf[1];
					4'd7: rx_data[6] <= sci_rx_buf[1];
					4'd8: rx_data[7] <= sci_rx_buf[1];				
					default: ;
				endcase
			end
			
	always @ (posedge clk, posedge rst)
	if (rst) begin
		rx_done <= 1'b0;
		uart_data <= 8'd0;
	end
	else if (rx_num == 4'd9) begin
		rx_done <= 1'b1;
		uart_data <= rx_data;
	end
	else begin
		rx_done <= 1'b0;
		uart_data <= 8'd0;
	end
	
endmodule
