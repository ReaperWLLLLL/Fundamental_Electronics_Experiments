module my_key_seg(
					input clk,
					input rst,
					input [3:0] vl,
					output reg [3:0] hl,
					output reg seg_sel,
					output reg[7:0] seg
);

wire [7:0] hl_vl;
reg [1:0] state,nextstate;

parameter S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;

always @ (posedge clk, posedge rst)
    if (rst) state <= S0;
    else state <= nextstate;

always @ (*)
    case (state)
        S0: begin
            hl = 4'b1110;
            nextstate = S1;
        end	
		  S1: begin
            hl = 4'b1101;
            nextstate = S2;
        end	
		  S2: begin
            hl = 4'b1011;
            nextstate = S3;
        end	
		  S3: begin
            hl = 4'b0111;
            nextstate = S0;
        end	
		  default: nextstate = S0;
   endcase
		  
assign hl_vl = {hl,vl};		  

always @ (posedge clk,posedge rst) begin
		if (rst)	begin
				seg <= 8'b0;
				seg_sel <= 1;
			end
		else
			case (hl_vl)
				8'b0111_0111: begin
						seg <= 8'hc0;//0      
						seg_sel <= 1;
					end
				8'b1011_0111: begin
						seg <= 8'hf9;//1      
						seg_sel <= 1;
					end
				8'b1101_0111: begin
						seg <= 8'hc0;//0      
						seg_sel <= 1;
					end
				8'b1110_0111: begin
						
						seg <= 8'h92;//5     
						seg_sel <= 1;
					end
				8'b0111_1011: begin
						seg <= 8'h99;//4     
						seg_sel <= 1;
					end
				8'b1011_1011: begin
						
						seg <= 8'hb0;//3      
						seg_sel <= 1;
					end
				8'b1101_1011: begin
						
						seg <= 8'ha4;//2      
						seg_sel <= 1;
					end
				8'b1110_1011: begin
						
						seg <= 8'hf9;//1     
						seg_sel <= 1;
					end
				8'b0111_1101: begin
						seg <= 8'h80;//8     
						seg_sel <= 1;
					end
				8'b1011_1101: begin
						
						seg <= 8'h82;//6      
						seg_sel <= 1;
					end
				8'b1101_1101: begin
						seg <= 8'h88;//A
						seg <= 8'h92;//5      
						seg_sel <= 1;
					end
				8'b1110_1101: begin
						seg <= 8'h83;//B
						seg <= 8'h99;//4      
						seg_sel <= 1;
					end
				8'b0111_1110: begin
						seg <= 8'hc6;//C      
						seg_sel <= 1;
					end
				8'b1011_1110: begin
						seg <= 8'ha1;//D
						seg <= 8'h90;//9      
						seg_sel<= 1;
					end
				8'b1101_1110: begin
						seg <= 8'h86;//E
						seg <= 8'h80;//8      
						seg_sel <= 1;
					end
				8'b1110_1110: begin
						seg <= 8'h8E;//F
						seg <= 8'hf8;//7      
						seg_sel <= 1;
					end
				default: seg_sel <= 0;
			endcase
	end
endmodule


