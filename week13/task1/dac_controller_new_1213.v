module dac_controller_new_1213(
	input clk,
	input rst,	
	input [23:0] data_dac_chL,
	input [23:0] data_dac_chR,	
	output mclk_dac,
	output sclk_dac,
	output lrck_dac,
	output reg sdata_dac
);

	reg [7:0] delay_cnt;
	reg delay_flag;

	reg sclk_dac_buf;
	reg lrck_dac_buf;

	localparam DELAY_NUM = 5'd200;
	localparam CNT_MAX = 4'd8;

	//dac mclk,直接给主时钟
	assign mclk_dac = clk;

	always @ (posedge clk, posedge rst)
		if (rst) begin
			delay_cnt <= 0;
			delay_flag <= 0;
		end
		else if (delay_cnt == DELAY_NUM) begin   
			delay_cnt <= 0;
			delay_flag <= 1;
		end
		else begin
			delay_cnt <= delay_cnt + 1'b1;
			delay_flag <= delay_flag;
		end	
 
	reg [3:0] cnt;
	
	always @ (posedge clk,posedge rst)
		if (rst) cnt <= 4'd0;
		else if (cnt < CNT_MAX - 1) cnt <= cnt + 1'b1;
		else cnt <= 4'd0;
	
	always @ (posedge clk, posedge rst)
		if (rst) sclk_dac_buf <= 1'b0;
		else if (cnt < CNT_MAX/2) sclk_dac_buf <= 1'b0;
		else sclk_dac_buf <= 1'b1;
	
	reg [2:0] sclk_dac_buf_reg;
	
	always @ (posedge clk, posedge rst)
		if (rst) sclk_dac_buf_reg <= 3'b0;
		else begin
			sclk_dac_buf_reg[2] <= sclk_dac_buf_reg[1];
			sclk_dac_buf_reg[1] <= sclk_dac_buf_reg[0];
			sclk_dac_buf_reg[0] <= sclk_dac_buf;
		end
	
	reg [5:0] bit_cnt;	
	
	always @ (posedge clk, posedge rst)
		if (rst) bit_cnt <= 6'd0;
		else if (cnt == CNT_MAX - 1) bit_cnt <= bit_cnt + 1'b1;
		else;
	
	always @ (posedge clk, posedge rst)
		if (rst) lrck_dac_buf <= 1'b0;
	   else if (bit_cnt < 6'd32) lrck_dac_buf <= 1'b0;
		else lrck_dac_buf <= 1'b1;
 
	assign lrck_dac = delay_flag && lrck_dac_buf;
   assign sclk_dac = delay_flag && sclk_dac_buf_reg[2];

////将两通道波形数据并串转换，送至dac数据端
	always @ (posedge clk, posedge rst)
		if (rst) sdata_dac <= 1'b0;
		else if (cnt == CNT_MAX/2) begin
			case (bit_cnt)
				6'd1: sdata_dac <= data_dac_chL[23];
				6'd2: sdata_dac <= data_dac_chL[22];
				6'd3: sdata_dac <= data_dac_chL[21];
				6'd4: sdata_dac <= data_dac_chL[20];
				6'd5: sdata_dac <= data_dac_chL[19];
				6'd6: sdata_dac <= data_dac_chL[18];
				6'd7: sdata_dac <= data_dac_chL[17];
				6'd8: sdata_dac <= data_dac_chL[16];
				6'd9: sdata_dac <= data_dac_chL[15];
				6'd10:sdata_dac <= data_dac_chL[14];
				6'd11:sdata_dac <= data_dac_chL[13];
				6'd12:sdata_dac <= data_dac_chL[12];
				6'd13:sdata_dac <= data_dac_chL[11];
				6'd14:sdata_dac <= data_dac_chL[10];
				6'd15:sdata_dac <= data_dac_chL[9];
				6'd16:sdata_dac <= data_dac_chL[8];
				6'd17:sdata_dac <= data_dac_chL[7];
				6'd18:sdata_dac <= data_dac_chL[6];
				6'd19:sdata_dac <= data_dac_chL[5];
				6'd20:sdata_dac <= data_dac_chL[4];
				6'd21:sdata_dac <= data_dac_chL[3];
				6'd22:sdata_dac <= data_dac_chL[2];
				6'd23:sdata_dac <= data_dac_chL[1];
				6'd24:sdata_dac <= data_dac_chL[0];
				
				6'd33: sdata_dac <= data_dac_chR[23];
				6'd34: sdata_dac <= data_dac_chR[22];
				6'd35: sdata_dac <= data_dac_chR[21];
				6'd36: sdata_dac <= data_dac_chR[20];
				6'd37: sdata_dac <= data_dac_chR[19];
				6'd38: sdata_dac <= data_dac_chR[18];
				6'd39: sdata_dac <= data_dac_chR[17];
				6'd40: sdata_dac <= data_dac_chR[16];
				6'd41: sdata_dac <= data_dac_chR[15];
				6'd42:sdata_dac <= data_dac_chR[14];
				6'd43:sdata_dac <= data_dac_chR[13];
				6'd44:sdata_dac <= data_dac_chR[12];
				6'd45:sdata_dac <= data_dac_chR[11];
				6'd46:sdata_dac <= data_dac_chR[10];
				6'd47:sdata_dac <= data_dac_chR[9];
				6'd48:sdata_dac <= data_dac_chR[8];
				6'd49:sdata_dac <= data_dac_chR[7];
				6'd50:sdata_dac <= data_dac_chR[6];
				6'd51:sdata_dac <= data_dac_chR[5];
				6'd52:sdata_dac <= data_dac_chR[4];
				6'd53:sdata_dac <= data_dac_chR[3];
				6'd54:sdata_dac <= data_dac_chR[2];
				6'd55:sdata_dac <= data_dac_chR[1];
				6'd56:sdata_dac <= data_dac_chR[0];
				
				default:;
			endcase
		end

endmodule

	