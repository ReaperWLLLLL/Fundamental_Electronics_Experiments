module key_fre_div(
					input clk,
					input rst,
					output reg clk_div_out
);


reg [18:0] div_cnt;

always @ (posedge clk,posedge rst) begin
		if (rst)
			div_cnt <= 0;
		else if (div_cnt == 19'd499_999)	begin
				clk_div_out <= ~clk_div_out;//clk = 25MH, 25Hz
				div_cnt <= 0;
			end
		else
			div_cnt <= div_cnt + 1'b1;
	end
endmodule