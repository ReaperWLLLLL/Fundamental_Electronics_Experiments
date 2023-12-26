module adc_controller_new_1213(
    input clk,
    input rst,
	 // Input from CS5343
	 input sdout_adc, 
	 output reg sclk_adc,
	 output reg lrck_adc,
	 output mclk_adc,
	 output reg [23:0] dataL_adc,
	 output reg [23:0] dataR_adc	 
);
	localparam CNT_MAX = 3'd4;

	reg [1:0] sdout_adc_buf;
	reg [23:0] dataL_adc_buf,dataR_adc_buf;

	assign mclk_adc = clk;

	reg [2:0] cnt;
	
	always @ (posedge clk,posedge rst)
		if (rst) cnt <= 3'd0;
		else if (cnt < CNT_MAX - 1) cnt <= cnt + 1'b1;
		else cnt <= 3'd0;
	
	always @ (posedge clk, posedge rst)
		if (rst) sclk_adc <= 1'b0;
		else if (cnt < CNT_MAX/2) sclk_adc <= 1'b0;
		else sclk_adc <= 1'b1;
	
	reg [5:0] bit_cnt;	
	
	always @ (posedge clk, posedge rst)
		if (rst) bit_cnt <= 6'd0;
		else if (cnt == CNT_MAX - 1) bit_cnt <= bit_cnt + 1'b1;
		else;
	
	always @ (posedge clk, posedge rst)
		if (rst) lrck_adc <= 1'b0;
	   else if (bit_cnt < 6'd32) lrck_adc <= 1'b0;
		else lrck_adc <= 1'b1;
	
	always @ (posedge clk, posedge rst)
		if (rst) sdout_adc_buf <= 2'b0;
		else  begin
			sdout_adc_buf[1] <= sdout_adc_buf[0];
			sdout_adc_buf[0] <= sdout_adc;
		end	

always @ (posedge clk, posedge rst)
		if (rst) begin
			dataL_adc_buf <= 24'd0;
			dataR_adc_buf <= 24'd0;
		end
		else if (cnt == CNT_MAX/2) begin
			case (bit_cnt)
				6'd1: dataL_adc_buf[23] <= sdout_adc_buf[1];
				6'd2: dataL_adc_buf[22] <= sdout_adc_buf[1];
				6'd3: dataL_adc_buf[21] <= sdout_adc_buf[1];
				6'd4: dataL_adc_buf[20] <= sdout_adc_buf[1];
				6'd5: dataL_adc_buf[19] <= sdout_adc_buf[1];
				6'd6: dataL_adc_buf[18] <= sdout_adc_buf[1];
				6'd7: dataL_adc_buf[17] <= sdout_adc_buf[1];
				6'd8: dataL_adc_buf[16] <= sdout_adc_buf[1];
				6'd9: dataL_adc_buf[15] <= sdout_adc_buf[1];
				6'd10:dataL_adc_buf[14] <= sdout_adc_buf[1];
				6'd11:dataL_adc_buf[13] <= sdout_adc_buf[1];
				6'd12:dataL_adc_buf[12] <= sdout_adc_buf[1];
				6'd13:dataL_adc_buf[11] <= sdout_adc_buf[1];
				6'd14:dataL_adc_buf[10] <= sdout_adc_buf[1];
				6'd15:dataL_adc_buf[9] <= sdout_adc_buf[1];
				6'd16:dataL_adc_buf[8] <= sdout_adc_buf[1];
				6'd17:dataL_adc_buf[7] <= sdout_adc_buf[1];
				6'd18:dataL_adc_buf[6] <= sdout_adc_buf[1];
				6'd19:dataL_adc_buf[5] <= sdout_adc_buf[1];
				6'd20:dataL_adc_buf[4] <= sdout_adc_buf[1];
				6'd21:dataL_adc_buf[3] <= sdout_adc_buf[1];
				6'd22:dataL_adc_buf[2] <= sdout_adc_buf[1];
				6'd23:dataL_adc_buf[1] <= sdout_adc_buf[1];
				6'd24:dataL_adc_buf[0] <= sdout_adc_buf[1];
				
				6'd33: dataR_adc_buf[23] <= sdout_adc_buf[1];
				6'd34: dataR_adc_buf[22] <= sdout_adc_buf[1];
				6'd35: dataR_adc_buf[21] <= sdout_adc_buf[1];
				6'd36: dataR_adc_buf[20] <= sdout_adc_buf[1];
				6'd37: dataR_adc_buf[19] <= sdout_adc_buf[1];
				6'd38: dataR_adc_buf[18] <= sdout_adc_buf[1];
				6'd39: dataR_adc_buf[17] <= sdout_adc_buf[1];
				6'd40: dataR_adc_buf[16] <= sdout_adc_buf[1];
				6'd41: dataR_adc_buf[15] <= sdout_adc_buf[1];
				6'd42:dataR_adc_buf[14] <= sdout_adc_buf[1];
				6'd43:dataR_adc_buf[13] <= sdout_adc_buf[1];
				6'd44:dataR_adc_buf[12] <= sdout_adc_buf[1];
				6'd45:dataR_adc_buf[11] <= sdout_adc_buf[1];
				6'd46:dataR_adc_buf[10] <= sdout_adc_buf[1];
				6'd47:dataR_adc_buf[9] <= sdout_adc_buf[1];
				6'd48:dataR_adc_buf[8] <= sdout_adc_buf[1];
				6'd49:dataR_adc_buf[7] <= sdout_adc_buf[1];
				6'd50:dataR_adc_buf[6] <= sdout_adc_buf[1];
				6'd51:dataR_adc_buf[5] <= sdout_adc_buf[1];
				6'd52:dataR_adc_buf[4] <= sdout_adc_buf[1];
				6'd53:dataR_adc_buf[3] <= sdout_adc_buf[1];
				6'd54:dataR_adc_buf[2] <= sdout_adc_buf[1];
				6'd55:dataR_adc_buf[1] <= sdout_adc_buf[1];
				6'd56:dataR_adc_buf[0] <= sdout_adc_buf[1];
				
				default:;
			endcase
		end
	
	always @ (posedge clk, posedge rst)
		if (rst) begin
			dataL_adc <= 24'd0;
			dataR_adc <= 24'd0;
		end
		else if ((cnt == CNT_MAX/2) && (bit_cnt == 6'd25))
			dataL_adc <= dataL_adc_buf;
		else if ((cnt == CNT_MAX/2) && (bit_cnt == 6'd57))
			dataR_adc <= dataR_adc_buf;
		else;
		
endmodule
