//this module cope with the user state:

`timescale 1ps/1ps

module USER (
    input clk,
    input reset,
    input goto_user,
    input [1:0]user_id,
    input [2:0]position_line,
    input [3:0]position_column,
    input push_confirm_buy_debounced,
    input [4:0]capacity_line00,
    input [4:0]capacity_line01,
    input [4:0]capacity_line02,
    input [4:0]capacity_line03, 
    input [4:0]capacity_line10,
    input [4:0]capacity_line11,
    input [4:0]capacity_line12,
    input [4:0]capacity_line13,
    input [4:0]capacity_line14,
    input [4:0]capacity_line15,
    input [4:0]capacity_line16,
    input [4:0]capacity_line17,
    input [4:0]capacity_line20,
    input [4:0]capacity_line21,
    input [4:0]capacity_line22,
    input [4:0]capacity_line23,
    input [4:0]capacity_line24,
    input [4:0]capacity_line25,
    input [4:0]capacity_line26,
    input [4:0]capacity_line27,
    input [4:0]capacity_line30,
    input [4:0]capacity_line31,
    input [4:0]capacity_line32,
    input [4:0]capacity_line33,
    input [4:0]capacity_line34,
    input [4:0]capacity_line35,
    input [4:0]capacity_line36,
    input [4:0]capacity_line37,
    input [4:0]capacity_line40,
    input [4:0]capacity_line41,
    input [4:0]capacity_line42,
    input [4:0]capacity_line43,
    input [4:0]capacity_line44,
    input [4:0]capacity_line45,
    input [4:0]capacity_line46,
    input [4:0]capacity_line47,
    input [4:0]capacity_line50,
    input [4:0]capacity_line51,
    input [4:0]capacity_line52,
    input [4:0]capacity_line53,
    input [4:0]capacity_line54,
    input [4:0]capacity_line55,
    input [4:0]capacity_line56,
    input [4:0]capacity_line57,
    output reg LED_costumer1,
    output reg LED_costumer2,
    output reg LED_costumer3,
    output reg LED_capacity_choses,
    output reg LED_correct_id,
    output reg signed [4:0]capacity_user,
    output reg [6:0]costumer_cash,
    output reg correct_id
);
    // the reg costumer cash for save the changes and the condition of ending the process:
    reg [6:0]costumer_cash1, costumer_cash2, costumer_cash3;
    reg end_process_condition;
    //define the static variables:
    parameter
        USER1 = 2'b00,
        USER2 = 2'b01,
        USER3 = 2'b10;
    //the wire parameter for price of each line:
    wire [6:0]price_line[0:5]; 
    assign
        price_line[0] = 7'd85,       //8500
        price_line[1] = 7'd60,       //6000
        price_line[2] = 7'd45,       //4500
        price_line[3] = 7'd30,       //3000
        price_line[4] = 7'd20,       //2000
        price_line[5] = 7'd20;       //2000
    // the wire parameter for save the capacity
    wire [4:0]capacity_line_user[0:5][0:7];
    assign
        capacity_line_user[0][0] = capacity_line00,
        capacity_line_user[0][1] = capacity_line01,
        capacity_line_user[0][2] = capacity_line02,
        capacity_line_user[0][3] = capacity_line03,
        // ************ there are unused lines:
        capacity_line_user[0][4] = 5'd0,
        capacity_line_user[0][5] = 5'd0,
        capacity_line_user[0][6] = 5'd0,
        capacity_line_user[0][7] = 5'd0,
        // ************ 
        capacity_line_user[1][0] = capacity_line10,
        capacity_line_user[1][1] = capacity_line11,
        capacity_line_user[1][2] = capacity_line12,
        capacity_line_user[1][3] = capacity_line13,
        capacity_line_user[1][4] = capacity_line14,
        capacity_line_user[1][5] = capacity_line15,
        capacity_line_user[1][6] = capacity_line16,
        capacity_line_user[1][7] = capacity_line17,
        capacity_line_user[2][0] = capacity_line20,
        capacity_line_user[2][1] = capacity_line21,
        capacity_line_user[2][2] = capacity_line22,
        capacity_line_user[2][3] = capacity_line23,
        capacity_line_user[2][4] = capacity_line24,
        capacity_line_user[2][5] = capacity_line25,
        capacity_line_user[2][6] = capacity_line26,
        capacity_line_user[2][7] = capacity_line27,
        capacity_line_user[3][0] = capacity_line30,
        capacity_line_user[3][1] = capacity_line31,
        capacity_line_user[3][2] = capacity_line32,
        capacity_line_user[3][3] = capacity_line33,
        capacity_line_user[3][4] = capacity_line34,
        capacity_line_user[3][5] = capacity_line35,
        capacity_line_user[3][6] = capacity_line36,
        capacity_line_user[3][7] = capacity_line37,
        capacity_line_user[4][0] = capacity_line40,
        capacity_line_user[4][1] = capacity_line41,
        capacity_line_user[4][2] = capacity_line42,
        capacity_line_user[4][3] = capacity_line43,
        capacity_line_user[4][4] = capacity_line44,
        capacity_line_user[4][5] = capacity_line45,
        capacity_line_user[4][6] = capacity_line46,
        capacity_line_user[4][7] = capacity_line47,
        capacity_line_user[5][0] = capacity_line50,
        capacity_line_user[5][1] = capacity_line51,
        capacity_line_user[5][2] = capacity_line52,
        capacity_line_user[5][3] = capacity_line53,
        capacity_line_user[5][4] = capacity_line54,
        capacity_line_user[5][5] = capacity_line55,
        capacity_line_user[5][6] = capacity_line56,
        capacity_line_user[5][7] = capacity_line57;
    
    //calculate the logic of module:
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            LED_costumer1 <= 1'b0;
            LED_costumer2 <= 1'b0;
            LED_costumer3 <= 1'b0;
            LED_capacity_choses <= 1'b0;
            LED_correct_id <= 1'b0;
            capacity_user <= 5'b0; 
            costumer_cash <= 7'd0;    
            costumer_cash1 <= 7'd70;        //7000
            costumer_cash2 <= 7'd50;        //5000  
            costumer_cash3 <= 7'd30;        //3000
            correct_id <= 1'b0;
            end_process_condition <= 1'b0;
        end
        else begin
            if (goto_user) begin
                //check the id of user is correct or not
                case (user_id)
                    USER1 :  begin  correct_id <= 1'b1;   LED_correct_id <= 1;   end 
                    USER2 :  begin  correct_id <= 1'b1;   LED_correct_id <= 1;   end 
                    USER3 :  begin  correct_id <= 1'b1;   LED_correct_id <= 1;   end 
                    default: begin  correct_id <= 1'b0;   LED_correct_id <= 0;   end 
                endcase
                //check the user password and begin buying process
                case (user_id)
                    USER1 : begin 
                        costumer_cash <= costumer_cash1;
                        if (costumer_cash1 > 7'd0) begin                //the condition for beginning of buying process
                            LED_costumer1 <= 1'b1;
                            LED_costumer2 <= 1'b0;
                            LED_costumer3 <= 1'b0; 
                            if (position_line == 3'b001) begin
                                if (position_column == 4'b0001 || position_column == 4'b0011 || position_column == 4'b0101 || position_column == 4'b0111) begin
                                    if (capacity_line_user[position_line-1][position_column-1] == 5'd0) begin
                                        LED_capacity_choses <= 0;
                                        end_process_condition <= 1;
                                    end
                                    else begin
                                        LED_capacity_choses <= 1;
                                        end_process_condition <= 0;
                                        if (push_confirm_buy_debounced && costumer_cash1 >= price_line[position_line-1]) begin    //buy success
                                            costumer_cash1 <= costumer_cash1 - price_line[position_line-1];
                                            capacity_user <= capacity_user - 5'd1;
                                            costumer_cash <= costumer_cash1;
                                        end
                                        else   costumer_cash <= costumer_cash1;     //the buying process denied
                                    end
                                end
                                else begin                                 //the position column isn't true
                                    capacity_user <= 5'd0;
                                    LED_capacity_choses <= 0; 
                                    end_process_condition <= 0;
                                end             
                            end
                            else if (position_line > 3'b000 && position_line < 3'b111) begin
                                if (position_column > 4'b0000 && position_column < 4'b1001) begin
                                    if (capacity_line_user[position_line-1][position_column-1] == 5'd0) begin
                                        LED_capacity_choses <= 0;
                                        end_process_condition <= 1;
                                    end
                                    else begin
                                        LED_capacity_choses <= 1;
                                        end_process_condition <= 0;
                                        if (push_confirm_buy_debounced && costumer_cash1 >= price_line[position_line-1]) begin    //buy success
                                            costumer_cash1 <= costumer_cash1 - price_line[position_line-1];
                                            capacity_user <= capacity_user - 5'd1;
                                            costumer_cash <= costumer_cash1;
                                        end
                                        else  costumer_cash <= costumer_cash1;        //the buying process denied
                                    end
                                end
                                else begin                                  //the position column isn't true
                                    capacity_user <= 5'd0;
                                    LED_capacity_choses <= 0;
                                    end_process_condition <= 0; 
                                end       
                            end
                            else begin                                      //the position line isn't true
                                capacity_user <= 5'd0;
                                LED_capacity_choses <= 0; 
                                end_process_condition <= 0;
                            end          
                        end
                        else begin                                         //the beginning of buying process was denied
                            capacity_user <= 5'd0;
                            LED_capacity_choses <= 0;
                            end_process_condition <= 0;
                        end      
                    end
                    USER2 : begin
                        costumer_cash <= costumer_cash2; 
                        if (costumer_cash2 > 7'd0) begin                  //the condition for beginning of buying process
                            LED_costumer1 <= 1'b0;
                            LED_costumer2 <= 1'b1;
                            LED_costumer3 <= 1'b0; 
                            if (position_line == 3'b001) begin
                                if (position_column == 4'b0001 || position_column == 4'b0011 || position_column == 4'b0101 || position_column == 4'b0111) begin
                                    if (capacity_line_user[position_line-1][position_column-1] == 5'd0) begin
                                        LED_capacity_choses <= 0;
                                        end_process_condition <= 1;
                                    end
                                    else begin
                                        LED_capacity_choses <= 1;
                                        end_process_condition <= 0;
                                        if (push_confirm_buy_debounced && costumer_cash2 >= price_line[position_line-1]) begin    //buy success
                                            costumer_cash2 <= costumer_cash2 - price_line[position_line-1];
                                            capacity_user <= capacity_user - 5'd1;
                                            costumer_cash <= costumer_cash2;
                                        end
                                        else  costumer_cash <= costumer_cash2;     //the buying process denied
                                    end
                                end
                                else begin                                //the position column isn't true
                                    capacity_user <= 5'd0;
                                    LED_capacity_choses <= 0; 
                                    end_process_condition <= 0;
                                end             
                            end
                            else if (position_line > 3'b000 && position_line < 3'b111) begin
                                if (position_column > 4'b0000 && position_column < 4'b1001) begin
                                    if (capacity_line_user[position_line-1][position_column-1] == 5'd0) begin
                                        LED_capacity_choses <= 0;
                                        end_process_condition <= 1;
                                    end
                                    else begin
                                        LED_capacity_choses <= 1;
                                        end_process_condition <= 0;
                                        if (push_confirm_buy_debounced && costumer_cash2 >= price_line[position_line-1]) begin    //buy success
                                            costumer_cash2 <= costumer_cash2 - price_line[position_line-1];
                                            capacity_user <= capacity_user - 5'd1;
                                            costumer_cash <= costumer_cash2;
                                        end
                                        else  costumer_cash <= costumer_cash2;        //the buying process denied
                                    end
                                end
                                else begin                                  //the position column isn't true
                                    capacity_user <= 5'd0;
                                    LED_capacity_choses <= 0;
                                    end_process_condition <= 0; 
                                end       
                            end
                            else begin                                      //the position line isn't true
                                capacity_user <= 5'd0;
                                LED_capacity_choses <= 0;
                                end_process_condition <= 0; 
                            end          
                        end
                        else begin                                         //the beginning of buying process was denied
                            capacity_user <= 5'd0;
                            LED_capacity_choses <= 0;
                            end_process_condition <= 0;
                        end      
                    end
                    USER3 : begin
                        costumer_cash <= costumer_cash3;
                        if (costumer_cash3 > 7'd0) begin                  //the condition for beginning of buying process
                            LED_costumer1 <= 1'b0;
                            LED_costumer2 <= 1'b0;
                            LED_costumer3 <= 1'b1;
                            if (position_line == 3'b001) begin
                                if (position_column == 4'b0001 || position_column == 4'b0011 || position_column == 4'b0101 || position_column == 4'b0111) begin
                                    if (capacity_line_user[position_line-1][position_column-1] == 5'd0) begin
                                        LED_capacity_choses <= 0;
                                        end_process_condition <= 1;
                                    end
                                    else begin
                                        LED_capacity_choses <= 1;
                                        end_process_condition <= 0;
                                        if (push_confirm_buy_debounced && costumer_cash3 >= price_line[position_line-1]) begin    //buy success
                                            costumer_cash3 <= costumer_cash3 - price_line[position_line-1];
                                            capacity_user <= capacity_user - 5'd1;
                                            costumer_cash <= costumer_cash3;
                                        end
                                        else  costumer_cash <= costumer_cash3;   //the buying process denied
                                    end
                                end
                                else begin                              //the position column isn't true
                                    capacity_user <= 5'd0;
                                    LED_capacity_choses <= 0; 
                                    end_process_condition <= 0;
                                end             
                            end
                            else if (position_line > 3'b000 && position_line < 3'b111) begin
                                if (position_column > 4'b0000 && position_column < 4'b1001) begin
                                    if (capacity_line_user[position_line-1][position_column-1] == 5'd0) begin
                                        LED_capacity_choses <= 0;
                                        end_process_condition <= 1;
                                    end
                                    else begin
                                        LED_capacity_choses <= 1;
                                        end_process_condition <= 0;
                                        if (push_confirm_buy_debounced && costumer_cash3 >= price_line[position_line-1]) begin    //buy success
                                            costumer_cash3 <= costumer_cash3 - price_line[position_line-1];
                                            capacity_user <= capacity_user - 5'd1;
                                            costumer_cash <= costumer_cash3;
                                        end
                                        else  costumer_cash <= costumer_cash3;        //the buying process denied
                                    end
                                end
                                else begin                                  //the position column isn't true
                                    capacity_user <= 5'd0;
                                    LED_capacity_choses <= 0;
                                    end_process_condition <= 0; 
                                end       
                            end
                            else begin                                      //the position line isn't true
                                capacity_user <= 5'd0;
                                LED_capacity_choses <= 0;
                                end_process_condition <= 0; 
                            end          
                        end
                        else begin                                         //the beginning of buying process was denied
                            capacity_user <= 5'd0;
                            LED_capacity_choses <= 0;
                            end_process_condition <= 0;
                        end      
                    end
                    default : begin                                        //buzzer code for alarm in 3 seconds
                        LED_costumer1 <= 0;
                        LED_costumer2 <= 0;
                        LED_costumer3 <= 0;
                        LED_capacity_choses <= 0;
                        end_process_condition <= 0;
                        capacity_user <= 5'd0;
                        costumer_cash <= 7'd0;
                    end   
                endcase
            end
            else begin
                correct_id <= 0;
                LED_correct_id <= 0;
                LED_costumer1 <= 0;
                LED_costumer2 <= 0;
                LED_costumer3 <= 0;
                LED_capacity_choses <= 0;
                end_process_condition <= 0;
                capacity_user <= 5'd0;
                costumer_cash <= 7'd0;
            end
        end
    end
 
endmodule