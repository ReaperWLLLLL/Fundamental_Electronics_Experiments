`include "key_fre_div.v"
`include "key_seg.v"
`include "my_key_seg.v"
module key_seg_top(
						input clk,
						input rst,
						input [3:0] vl,
						output [3:0] hl,
						output seg_sel,
						output [7:0] seg,
						output clk_div_out,
						output bz
);

//wire clk_key;
assign bz = 1;

key_fre_div uut_fre_div(
					.clk(clk),
					.rst(rst),
					.clk_div_out(clk_div_out)
);

my_key_seg uut_my_key_seg(
					.clk(clk_div_out),
					.rst(rst),
					.vl(vl),
					.hl(hl),
					.seg_sel(seg_sel),
					.seg(seg)
);

endmodule
