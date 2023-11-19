//task1_2 is a part of task1_3, so below is the code of task1_3 
module my_key_seg1(
	input clk,
	input clk1, //for digit
	input rst,
	input [3:0] vl,
	output reg [3:0] hl,
	output reg [3:0] digit,
	output reg[7:0] seg
);

wire [7:0] hl_vl;
reg [15:0] data;
reg [3:0] data_temp;
reg [3:0] current_key;//储存当前按键值
reg key_flag;//按键标志位
reg [1:0] state; 
reg [1:0] state1;

always @(posedge clk1 or posedge rst) begin
	if(rst) begin
		digit = 4'b1111;
		state1 = 2'b00;
		data_temp = 4'b0000;
	end
	else begin
		case (state1)
			2'b00: begin
				data_temp = data[7:4];//???????
				digit = 4'b1110;
				state1 = 2'b01;
			end
			2'b01: begin
                data_temp = data[11:8];
				digit = 4'b1101;
				state1 = 2'b10;
			end
			2'b10: begin
                data_temp = data[15:12];//???????
				digit = 4'b1011;
				state1 = 2'b11;
			end
			2'b11: begin
                data_temp = data[3:0];
				digit = 4'b0111;
				state1 = 2'b00;
			end
			default: begin
				digit = 4'b1111;
				state1 = 2'b00;
                data_temp = 4'b0000;
			end
		endcase
	end
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= 2'b00; 
		hl <= 4'b1111;
    end
    else begin
        case (state)
            2'b00: begin
				hl <= 4'b1110;
                state <= 2'b01;
            end
            2'b01: begin
				hl <= 4'b1101;
                state <= 2'b10;
            end
            2'b10: begin
				hl <= 4'b1011;
                state <= 2'b11;
            end
            2'b11: begin
				hl <= 4'b0111;
                state <= 2'b00;
            end
            default: begin
				hl <= 4'b1111;
                state <= 2'b00;
            end
        endcase
    end
end 
assign hl_vl = {hl,vl};       

//try to use mealy machine to solve the problem
reg [2:0] FSM_state;
parameter FIRST = 3'b001;
parameter SECOND = 3'b010;
parameter RESULT = 3'b100;
reg [4:0] operator;
parameter OR_OPERATOR = 5'b00001;
parameter AND_OPERATOR = 5'b00010;
parameter ADD_OPERATOR = 5'b00100;
parameter SUB_OPERATOR = 5'b01000;
parameter COMPARE_OPERATOR = 5'b10000;

//the first part of the FSM, trying to get state according to input
reg [11:0] first_num;
reg [11:0] second_num;
reg [15:0] result;
always @(posedge clk, posedge rst) begin
	if(rst) begin
		FSM_state <= FIRST;
		operator <= 5'b00000;
		first_num <= 12'b0000_0000_0000;
		second_num <= 12'b0000_0000_0000;
	end
	else begin
		case(FSM_state)
			FIRST: begin
				if(input_type == NUMBER) begin
					first_num <= {first_num[7:0],input_temp[3:0]};
					FSM_state <= FIRST;
				end
				else if(input_type == OPERATOR) begin
					operator <= input_temp;
					FSM_state <= SECOND;
				end
				else begin
					FSM_state <= FIRST;
				end
			end
			SECOND: begin
				if(input_type == NUMBER) begin
					second_num <= {second_num[7:0],input_temp[3:0]};
					FSM_state <= SECOND;
				end
				else if(input_type == EQUAL) begin
					FSM_state <= RESULT;
				end
				else begin
					FSM_state <= SECOND;
				end
			end
			RESULT: begin
				case(operator)
					OR_OPERATOR: begin
						result <= first_num | second_num;
						FSM_state <= RESULT;
					end
					AND_OPERATOR: begin
						result <= first_num & second_num;
						FSM_state <= RESULT;
					end
					ADD_OPERATOR: begin
						result[3:0] <= (first_num[3:0] + second_num[3:0])%10;
						result[7:4] <= (first_num[7:4] + second_num[7:4] + (first_num[3:0] + second_num[3:0])/10)%10;
						result[11:8] <= (first_num[11:8] + second_num[11:8] + (first_num[7:4] + second_num[7:4] + (first_num[3:0] + second_num[3:0])/10)/10)%10;
						result[15:12] <= (first_num[11:8] + second_num[11:8] + (first_num[7:4] + second_num[7:4] + (first_num[3:0] + second_num[3:0])/10)/10)/10;
						FSM_state <= RESULT;
					end
					SUB_OPERATOR: begin
						if(first_num > second_num || first_num == second_num) begin
							result <= {12'b0,first_num[11:8]}*100 + {12'b0,first_num[7:4]}*10 + {12'b0,first_num[3:0]} - {12'b0,second_num[11:8]}*100 - {12'b0,second_num[7:4]}*10 - {12'b0,second_num[3:0]};
						end
						else begin
							result <= 12'b111111111111;
							FSM_state <= RESULT;
						end
					end
					COMPARE_OPERATOR: begin
						if(first_num > second_num) begin
							result <= 12'b1;
						end
						else begin
							result <= 12'b0;
						end
						FSM_state <= RESULT;
					end
					default: begin
						result <= 12'b0;
						FSM_state <= RESULT;
					end
				endcase
			end
			default: begin
				FSM_state <= FIRST;
			end
	endcase
	end
end

//process the origin input to a simple one
reg [2:0] input_type;
parameter NUMBER = 3'b001;
parameter OPERATOR = 3'b010;
parameter EQUAL = 3'b100;

reg [4:0] input_temp;

always @ (posedge clk,posedge rst) begin
	if (rst) begin
		input_type <= 3'b000;
		input_temp <= 5'b00000;
	end
	else begin
		case (hl_vl)
			8'b0111_0111: begin
				//for =  
				input_type <= EQUAL;
				input_temp <= 5'b00000;   
			end
			8'b1011_0111: begin
				//for and   
				input_type <= OPERATOR;
				input_temp <= AND_OPERATOR;
			end
			8'b1101_0111: begin
				//for 0
				input_type <= NUMBER;
				input_temp <= 5'b00000;
			end
			8'b1110_0111: begin
				//for or     
				input_type <= OPERATOR;
				input_temp <= OR_OPERATOR;
			end
			8'b0111_1011: begin
				//for +     
				input_type <= OPERATOR;
				input_temp <= ADD_OPERATOR;
			end
			8'b1011_1011: begin
				//for 3
				input_type <= NUMBER;
				input_temp <= 5'b00011;
			end
			8'b1101_1011: begin
				//for 2
				input_type <= NUMBER;
				input_temp <= 5'b00010;
			end
			8'b1110_1011: begin
				//for 1
				input_type <= NUMBER;
				input_temp <= 5'b00001;
			end
			8'b0111_1101: begin      
				//for -     
				input_type <= OPERATOR;
				input_temp <= SUB_OPERATOR;
			end
			8'b1011_1101: begin
				//for 6
				input_type <= NUMBER;
				input_temp <= 5'b00110;
			end
			8'b1101_1101: begin
				//for 5
				input_type <= NUMBER;
				input_temp <= 5'b00101;
			end
			8'b1110_1101: begin
				//for 4
				input_type <= NUMBER;
				input_temp <= 5'b00100;
			end
			8'b0111_1110: begin      
				//for compare
				input_type <= OPERATOR;
				input_temp <= COMPARE_OPERATOR;
			end
			8'b1011_1110: begin
				//for 9
				input_type <= NUMBER;
				input_temp <= 5'b01001;
			end
			8'b1101_1110: begin
				//for 8
				input_type <= NUMBER;
				input_temp <= 5'b01000;
			end
			8'b1110_1110: begin
				//for 7
				input_type <= NUMBER;
				input_temp <= 5'b00111;
			end
			default: begin
				input_type <= 3'b000;
				input_temp <= 5'b00000;
			end
		endcase
	end
end

//the second part of the FSM, trying to show the result according to the state
always @(posedge clk, posedge rst) begin
	if(rst) begin
		data <= 16'b0000_0000_0000_0000;
	end
	else begin
		case(FSM_state)
			FIRST: begin
				data <= first_num;
			end
			SECOND: begin
				data <= second_num;
			end
			RESULT: begin
				data <= result;
			end
			default: begin
				data <= 16'b0000_0000_0000_0000;
			end
		endcase
	end
end

always @(posedge clk1, posedge rst) begin
	if(rst) begin
		seg = 8'hc0;
	end
	else begin
		case (data_temp)
			0: seg = 8'hc0;
			1: seg = 8'hf9;
			2: seg = 8'ha4;
			3: seg = 8'hb0;
			4: seg = 8'h99;
			5: seg = 8'h92;
			6: seg = 8'h82;
			7: seg = 8'hf8;
			8: seg = 8'h80;
			9: seg = 8'h90;
			10: seg = 8'h88;
			11: seg = 8'h83;
			12: seg = 8'hc6;
			13: seg = 8'ha1;
			14: seg = 8'h86;
			15: seg = 8'h8e;
			default: seg = 8'hc0;
		endcase
	end
end

endmodule

