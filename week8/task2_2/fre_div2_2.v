`define CNT_MAX 25
`define CNT_MAX1 25

module fre_div2_2(
	input clk,
	input rst,
	output reg clk_div_out,
	output reg clk_div_out1
);

reg [31:0] div_cnt;

always @ (posedge clk,posedge rst) begin
	if (rst) begin
	  	div_cnt <= 0;
		clk_div_out <= 0;
	end
	else if (div_cnt == `CNT_MAX-1) begin
		clk_div_out <= ~clk_div_out;
		div_cnt <= 0;
	end
	else
		div_cnt <= div_cnt + 1'b1;
end

reg [31:0] div_cnt1;
always @ (posedge clk,posedge rst) begin
	if (rst) begin
	  	div_cnt1 <= 0;
		clk_div_out1 <= 0;
	end
	else if (div_cnt1 == `CNT_MAX1-1) begin
		clk_div_out1 <= ~clk_div_out1;
		div_cnt1 <= 0;
	end
	else
		div_cnt1 <= div_cnt1 + 1'b1;
end


endmodule