module adc_controller(
    input clk,
    input rst,
	 // Input from CS5343
	 input sdout_adc, 
	 output sclk_adc,
	 output lrck_adc,
	 output mclk_adc,
	 output reg [23:0] dataL_adc,
	 output reg [23:0] dataR_adc	 
);

reg [7:0] lrck_adc_cnt;//lrck计数变量
reg [1:0] sclk_adc_cnt;//sclk计数变量
reg [4:0] cntL_adc,cntR_adc;//LR两通道计数变量
reg flagL_adc,flagR_adc;//LR两通道标志变量
reg [24:0] dataL_adcBuf,dataR_adcBuf;//LR两通道数据缓冲

assign mclk_adc = clk;

//产生lrck的计数
always @ (posedge clk, posedge rst)
    if (rst) lrck_adc_cnt <= 0;
    else  lrck_adc_cnt <= lrck_adc_cnt + 1'b1;	

//产生sclk的计数
always @ (posedge clk, posedge rst)
    if (rst) sclk_adc_cnt <= 0;
    else sclk_adc_cnt <= sclk_adc_cnt + 1'b1;	
  
assign lrck_adc = (lrck_adc_cnt < 128) ? 1 :0;
assign sclk_adc = (sclk_adc_cnt < 2) ? 0 :1;

always @ (posedge sclk_adc, posedge rst)
   if (rst) begin
      cntL_adc <= 0 ;
		cntR_adc <= 0;
		flagL_adc <= 0;
		flagR_adc <= 0;
   end
   else begin
		if (lrck_adc == 0) begin						
			if (cntL_adc == 25) begin
				cntL_adc <= 0;
				flagL_adc <= 1;
				flagR_adc <= 0;
			end
			else if ((cntL_adc < 25) && (flagL_adc == 0)) begin
				dataL_adcBuf[24 - cntL_adc] <= sdout_adc ;
				cntL_adc <= cntL_adc + 1 ;
			end
			end
		   else begin
				if (cntR_adc == 25) begin
					cntR_adc <= 0;
					flagR_adc <= 1;
					flagL_adc <= 0;
					dataL_adc <= dataL_adcBuf[23:0];
					dataR_adc <= dataR_adcBuf[23:0];
				end
				else if ((cntR_adc < 25) && (flagR_adc == 0)) begin
					dataR_adcBuf[24 - cntR_adc] <= sdout_adc ;
					cntR_adc <= cntR_adc + 1'b1 ;
				end
			end
	end
endmodule
