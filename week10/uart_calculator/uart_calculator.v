module uart_calculator (
    input clk,
    input rst,
    input ready,
    input [7:0] rx_data,
    output reg [15:0] display_data
);

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

    reg [11:0] first_num;
    reg [11:0] second_num;
    reg [15:0] result;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            FSM_state  <= FIRST;
            operator   <= 5'b00000;
            first_num  <= 12'b0000_0000_0000;
            second_num <= 12'b0000_0000_0000;
        end else begin
            case (FSM_state)
                FIRST: begin
                    if (input_type == NUMBER) begin
                        first_num <= {first_num[7:0], input_temp[3:0]};
                        FSM_state <= FIRST;
                    end else if (input_type == OPERATOR) begin
                        operator  <= input_temp;
                        FSM_state <= SECOND;
                    end else begin
                        FSM_state <= FIRST;
                    end
                end
                SECOND: begin
                    if (input_type == NUMBER) begin
                        second_num <= {second_num[7:0], input_temp[3:0]};
                        FSM_state  <= SECOND;
                    end else if (input_type == EQUAL) begin
                        FSM_state <= RESULT;
                    end else begin
                        FSM_state <= SECOND;
                    end
                end
                RESULT: begin
                    if (input_type == RESET) begin
                        FSM_state  <= FIRST;
                        operator   <= 5'b00000;
                        first_num  <= 12'b0000_0000_0000;
                        second_num <= 12'b0000_0000_0000;
                    end else begin
                        case (operator)
                            OR_OPERATOR: begin
                                result <= first_num | second_num;
                                FSM_state <= RESULT;
                            end
                            AND_OPERATOR: begin
                                result <= first_num & second_num;
                                FSM_state <= RESULT;
                            end
                            ADD_OPERATOR: begin
                                result[3:0] <= (first_num[3:0] + second_num[3:0]) % 10;
                                result[7:4] <= (first_num[7:4] + second_num[7:4] + (first_num[3:0] + second_num[3:0])/10)%10;
                                result[11:8] <= (first_num[11:8] + second_num[11:8] + (first_num[7:4] + second_num[7:4] + (first_num[3:0] + second_num[3:0])/10)/10)%10;
                                result[15:12] <= (first_num[11:8] + second_num[11:8] + (first_num[7:4] + second_num[7:4] + (first_num[3:0] + second_num[3:0])/10)/10)/10;
                                FSM_state <= RESULT;
                            end
                            SUB_OPERATOR: begin
                                if (first_num > second_num || first_num == second_num) begin
                                    result[11:8] <= ({12'b0,first_num[11:8]}*100 + {12'b0,first_num[7:4]}*10 + {12'b0,first_num[3:0]} - {12'b0,second_num[11:8]}*100 - {12'b0,second_num[7:4]}*10 - {12'b0,second_num[3:0]})/100;
                                    result[7:4] <= ({12'b0,first_num[11:8]}*100 + {12'b0,first_num[7:4]}*10 + {12'b0,first_num[3:0]} - {12'b0,second_num[11:8]}*100 - {12'b0,second_num[7:4]}*10 - {12'b0,second_num[3:0]})%100/10;
                                    result[3:0] <= ({12'b0,first_num[11:8]}*100 + {12'b0,first_num[7:4]}*10 + {12'b0,first_num[3:0]} - {12'b0,second_num[11:8]}*100 - {12'b0,second_num[7:4]}*10 - {12'b0,second_num[3:0]})%10;

                                end else begin
                                    result <= 12'b111111111111;
                                    FSM_state <= RESULT;
                                end
                            end
                            COMPARE_OPERATOR: begin
                                if (first_num > second_num) begin
                                    result <= 12'b1;
                                end else begin
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
                end
                default: begin
                    FSM_state <= FIRST;
                end
            endcase
        end
    end

    //process the origin input to a simple one
    reg [3:0] input_type;
    parameter NUMBER = 4'b0001;
    parameter OPERATOR = 4'b0010;
    parameter EQUAL = 4'b0100;
    parameter RESET = 4'b1000;
    reg [4:0] input_temp;
    reg input_flag;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            input_type <= 3'b000;
            input_temp <= 5'b00000;
            input_flag <= 1'b0;
        end else if (ready) begin
            case (rx_data)
                8'd48: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00000;
                end
                8'd49: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00001;
                end
                8'd50: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00010;
                end
                8'd51: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00011;
                end
                8'd52: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00100;
                end
                8'd53: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00101;
                end
                8'd54: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00110;
                end
                8'd55: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b00111;
                end
                8'd56: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b01000;
                end
                8'd57: begin
                    input_type <= NUMBER;
                    input_temp <= 5'b01001;
                end
                8'd43: begin
                    input_type <= OPERATOR;
                    input_temp <= ADD_OPERATOR;
                end
                8'd45: begin
                    input_type <= OPERATOR;
                    input_temp <= SUB_OPERATOR;
                end
                8'd65: begin
                    input_type <= OPERATOR;
                    input_temp <= AND_OPERATOR;
                end
                8'd79: begin
                    input_type <= OPERATOR;
                    input_temp <= OR_OPERATOR;
                end
                8'd67: begin
                    input_type <= OPERATOR;
                    input_temp <= COMPARE_OPERATOR;
                end
                8'd61: begin
                    input_type <= EQUAL;
                    input_temp <= 5'b00000;
                end
                8'd82: begin
                    input_type <= RESET;
                    input_temp <= 5'b00000;
                end
                default: begin
                    input_type <= 3'b000;
                    input_temp <= 5'b00000;
                    input_flag <= 1'b0;
                end
            endcase
        end else begin
            input_type <= 3'b000;
            input_temp <= 5'b00000;
            input_flag <= 1'b0;
        end
    end

    //the second part of the FSM, trying to show the result according to the state
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            display_data <= 16'b0000_0000_0000_0000;
        end else begin
            case (FSM_state)
                FIRST: begin
                    display_data <= first_num;
                end
                SECOND: begin
                    display_data <= second_num;
                end
                RESULT: begin
                    display_data <= result;
                end
                default: begin
                    display_data <= 16'b0000_0000_0000_0000;
                end
            endcase
        end
    end


endmodule
