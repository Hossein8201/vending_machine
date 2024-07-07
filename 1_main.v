//this is the main module in vending machine:

`timescale 1ps/1ps

module MAIN (
    input clk,
    input reset,
    input status_5_second,
    input dip_switch_status,
    input [2:0]password,
    input [2:0]position_line,
    input [3:0]position_column,
    input push_up,
    input push_down,
    input verify_capacity,
    input [1:0]user_id,
    input push_confirm_buy,
    input push_buy_end,
    output reg LED_admin,
    output reg LED_user,
    output reg LED_unknown_state,
    output LED_correct_pass,
    output LED_correct_id,
    output LED_costumer1,
    output LED_costumer2,
    output LED_costumer3,
    output LED_capacity_choses,
    //to show and use the seven segment:
    output [4:0]segment_selection,
    output [7:0]segment_data,
    //output reg [6:0]ones, tens, hundreds, thousands,
    output Buzzer
);
    //reg and wire variables:
    reg goto_admin, goto_user, goto_unknown_state;
    reg [13:0]present_state, next_state;
    reg [4:0]capacity_line[0:5][0:7]; 
    reg [6:0]ones, tens, hundreds, thousands;
    reg condition2;
    reg [6:0]counter;                      
    wire clk_1_second;
    wire push_up_debounced, push_down_debounced, push_confirm_buy_debounced, push_buy_end_debounced;
    wire correct_pass, correct_id, correct_position;
    wire [5:0]time_5_second, time_60_second;      
    wire signed [4:0]capacity_admin, capacity_user;             //because it may be a negetive number
    wire [6:0]costumer_cash;
    wire condition1, condition3, condition4;
	//the wire parameter for price of each line:
    wire [6:0]price_line[0:5]; 
    assign
        price_line[0] = 7'd85,       //8500
        price_line[1] = 7'd60,       //6000
        price_line[2] = 7'd45,       //4500
        price_line[3] = 7'd30,       //3000
        price_line[4] = 7'd20,       //2000
        price_line[5] = 7'd20;       //2000

    // Instantiate debouncer for each button
    DEBOUNCER debouncer1 (clk, push_up, push_up_debounced);
    DEBOUNCER debouncer2 (clk, push_down, push_down_debounced);
    DEBOUNCER debouncer3 (clk, push_confirm_buy, push_confirm_buy_debounced);
    DEBOUNCER debouncer4 (clk, push_buy_end, push_buy_end_debounced);
    //this generate the clock in cycle one second
    FREQUENCY_DIVIDER divide_1_second (clk, clk_1_second);
    //this count five second
    assign condition4 = (status_5_second == 1 && dip_switch_status == 1) ? 1 : 0;
    TIME count_5_second (clk, condition4, time_5_second);   
    //this count one minute
    assign condition1 = (present_state == next_state && goto_admin == 1) ? 1 : 0;
    TIME count_1_minute (clk, condition1, time_60_second); 
    
    //check the states that is on:
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            goto_admin <= 1'b0;
            goto_user <= 1'b1;
            goto_unknown_state <= 1'b0;       //the state we don't do anything
            LED_admin <= 1'b0;
            LED_user <= 1'b1;
            LED_unknown_state <= 1'b0;
            present_state <= 14'd0;
            next_state <= 14'd0;
            condition2 <= 1'b0;
            //the numbers are invalid
            ones <= 7'd10;      
            tens <= 7'd10;
            hundreds <= 7'd10;
            thousands <= 7'd10;
            //define the capacity of line and column:
            capacity_line[0][0] <= 5'd0;
            capacity_line[0][1] <= 5'd0;
            capacity_line[0][2] <= 5'd0;
            capacity_line[0][3] <= 5'd0;
            // ************ there are unused lines:
            capacity_line[0][4] <= 5'd0;
            capacity_line[0][5] <= 5'd0;
            capacity_line[0][6] <= 5'd0;
            capacity_line[0][7] <= 5'd0;
            // ************
            capacity_line[1][0] <= 5'd0;
            capacity_line[1][1] <= 5'd0;
            capacity_line[1][2] <= 5'd0;
            capacity_line[1][3] <= 5'd0;
            capacity_line[1][4] <= 5'd0;
            capacity_line[1][5] <= 5'd0;
            capacity_line[1][6] <= 5'd0;
            capacity_line[1][7] <= 5'd0;
            capacity_line[2][0] <= 5'd0;
            capacity_line[2][1] <= 5'd0;
            capacity_line[2][2] <= 5'd0;
            capacity_line[2][3] <= 5'd0;
            capacity_line[2][4] <= 5'd0;
            capacity_line[2][5] <= 5'd0;
            capacity_line[2][6] <= 5'd0;
            capacity_line[2][7] <= 5'd0;
            capacity_line[3][0] <= 5'd0;
            capacity_line[3][1] <= 5'd0;
            capacity_line[3][2] <= 5'd0;
            capacity_line[3][3] <= 5'd0;
            capacity_line[3][4] <= 5'd0;
            capacity_line[3][5] <= 5'd0;
            capacity_line[3][6] <= 5'd0;
            capacity_line[3][7] <= 5'd0;
            capacity_line[4][0] <= 5'd0;
            capacity_line[4][1] <= 5'd0;
            capacity_line[4][2] <= 5'd0;
            capacity_line[4][3] <= 5'd0;
            capacity_line[4][4] <= 5'd0;
            capacity_line[4][5] <= 5'd0;
            capacity_line[4][6] <= 5'd0;
            capacity_line[4][7] <= 5'd0;
            capacity_line[5][0] <= 5'd0;
            capacity_line[5][1] <= 5'd0;
            capacity_line[5][2] <= 5'd0;
            capacity_line[5][3] <= 5'd0;
            capacity_line[5][4] <= 5'd0;
            capacity_line[5][5] <= 5'd0;
            capacity_line[5][6] <= 5'd0;
            capacity_line[5][7] <= 5'd0;
        end
        else begin
            //count again for any changes in state admin:
            present_state <= {goto_admin,password,position_line,position_column,push_up_debounced,push_down_debounced,verify_capacity};
            if (present_state != next_state) begin
                next_state <= present_state;
            end

            //check the conditions to goto state admin:
            if (dip_switch_status == 1) begin 
                condition2 <= 1'b0;                                        //the condition to prepare goto user
                if (time_60_second == 6'd60 && goto_admin == 1) begin      //passed 60 second without any change in state admin:
                    LED_admin <= 1'b0;                                     //it goes to unknown state:
                    LED_user <= 1'b0;  
                    LED_unknown_state <= 1'b1;            
                    goto_admin <= 1'b0;
                    goto_user <= 1'b0;
                    goto_unknown_state <= 1'b1;
                end    
                else if (time_5_second == 6'd5 || goto_admin == 1) begin   //passed 5 second and push the button or stay in admin:
                    LED_admin <= 1'b1;
                    LED_user <= 1'b0;
                    LED_unknown_state <= 1'b0;
                    goto_admin <= 1'b1;
                    goto_user <= 1'b0;
                    goto_unknown_state <= 1'b0;
                end
                else begin                                        //it goes to unknown state:
                    LED_admin <= 1'b0;                 
                    LED_user <= 1'b0;  
                    LED_unknown_state <= 1'b1;           
                    goto_admin <= 1'b0;
                    goto_user <= 1'b0;
                    goto_unknown_state <= 1'b1;
                end
            end
            else if (push_buy_end_debounced == 1) begin          //it goes to unknown state:
                condition2 <= 1'b1;                              //the event happen
                LED_admin <= 1'b0;                 
                LED_user <= 1'b0;   
                LED_unknown_state <= 1'b1;            
                goto_admin <= 1'b0;
                goto_user <= 1'b0;
                goto_unknown_state <= 1'b1;
            end
            else if (condition2 == 1) begin    
                LED_admin <= 1'b0;                 
                LED_user <= 1'b0;  
                LED_unknown_state <= 1'b1;            
                goto_admin <= 1'b0;
                goto_user <= 1'b0;
                goto_unknown_state <= 1'b1;
            end
            else begin                                          //it keeps the state in user:
                LED_admin <= 1'b0;
                LED_user <= 1'b1;
                LED_unknown_state <= 1'b0;
                goto_admin <= 1'b0;
                goto_user <= 1'b1;
                goto_unknown_state <= 1'b0;
            end

            //this save the changes in capacitys:
            if (goto_admin && verify_capacity) begin                                  //check the verifaying and save changes:
                capacity_line[position_line-1][position_column-1] <= capacity_line[position_line-1][position_column-1] + capacity_admin;
            end
            else if (goto_user && push_confirm_buy_debounced && costumer_cash >= price_line[position_line-1]) begin                   //check the confirming and save changes:
                capacity_line[position_line-1][position_column-1] <= capacity_line[position_line-1][position_column-1] + capacity_user;     
            end

            //this choose the segment that is on:
            if (goto_admin && correct_pass && correct_position) begin
                ones <= {2'b00,capacity_line[position_line-1][position_column-1] + capacity_admin};
                tens <= 7'd10;                                                        //the number of tens is invalid
                hundreds <= {3'b000,position_column};         
                thousands <= {4'b0000,position_line};
            end
            else if (goto_user && correct_id) begin
                ones <= 0;
                tens <= 0;
                // *********** calculate devide and remain 10:
                case (costumer_cash)
                    7'd75 : begin
                        thousands <= 7'd7;
                        hundreds <= 7'd5;
                    end
                    7'd70 : begin
                        thousands <= 7'd7;
                        hundreds <= 7'd0;
                    end
                    7'd65 : begin
                        thousands <= 7'd6;
                        hundreds <= 7'd5;
                    end
                    7'd60 : begin
                        thousands <= 7'd6;
                        hundreds <= 7'd0;
                    end
                    7'd55 : begin
                        thousands <= 7'd5;
                        hundreds <= 7'd5;
                    end
                    7'd50 : begin
                        thousands <= 7'd5;
                        hundreds <= 7'd0;
                    end
                    7'd45 : begin
                        thousands <= 7'd4;
                        hundreds <= 7'd5;
                    end
                    7'd40 : begin
                        thousands <= 7'd4;
                        hundreds <= 7'd0;
                    end
                    7'd35 : begin
                        thousands <= 7'd3;
                        hundreds <= 7'd5; 
                    end
                    7'd30 : begin
                        thousands <= 7'd3;
                        hundreds <= 7'd0; 
                    end
                    7'd25 : begin
                        thousands <= 7'd2;
                        hundreds <= 7'd5; 
                    end
                    7'd20 : begin
                        thousands <= 7'd2;
                        hundreds <= 7'd0;
                    end
                    7'd15 : begin
                        thousands <= 7'd1;
                        hundreds <= 7'd5;
                    end
                    7'd10 : begin
                        thousands <= 7'd1;
                        hundreds <= 7'd0;
                    end
                    7'd5 : begin
                        thousands <= 7'd0;
                        hundreds <= 7'd5;
                    end
                    7'd0 : begin
                        thousands <= 7'd0;
                        hundreds <= 7'd0;
                    end 
                    default : begin
                        thousands <= 7'd0;
                        hundreds <= 7'd0;
                    end
                endcase
                // ***********
            end
            else begin              //the seven segment turned off
                ones <= 7'd10;
                tens <= 7'd10;
                hundreds <= 7'd10;
                thousands <= 7'd10;
            end
        end
    end

    //call the functions: 
    ADMIN admin (
        clk, reset, goto_admin, password, position_line, position_column, push_up_debounced, push_down_debounced, verify_capacity,
        capacity_line[0][0], capacity_line[0][1], capacity_line[0][2], capacity_line[0][3], 
        capacity_line[1][0], capacity_line[1][1], capacity_line[1][2], capacity_line[1][3], capacity_line[1][4], capacity_line[1][5], capacity_line[1][6], capacity_line[1][7], 
        capacity_line[2][0], capacity_line[2][1], capacity_line[2][2], capacity_line[2][3], capacity_line[2][4], capacity_line[2][5], capacity_line[2][6], capacity_line[2][7],
        capacity_line[3][0], capacity_line[3][1], capacity_line[3][2], capacity_line[3][3], capacity_line[3][4], capacity_line[3][5], capacity_line[3][6], capacity_line[3][7],
        capacity_line[4][0], capacity_line[4][1], capacity_line[4][2], capacity_line[4][3], capacity_line[4][4], capacity_line[4][5], capacity_line[4][6], capacity_line[4][7],
        capacity_line[5][0], capacity_line[5][1], capacity_line[5][2], capacity_line[5][3], capacity_line[5][4], capacity_line[5][5], capacity_line[5][6], capacity_line[5][7],
        LED_correct_pass, capacity_admin, correct_pass, correct_position
    );
    USER user (
        clk, reset, goto_user, user_id, position_line, position_column, push_confirm_buy_debounced,
        capacity_line[0][0], capacity_line[0][1], capacity_line[0][2], capacity_line[0][3], 
        capacity_line[1][0], capacity_line[1][1], capacity_line[1][2], capacity_line[1][3], capacity_line[1][4], capacity_line[1][5], capacity_line[1][6], capacity_line[1][7], 
        capacity_line[2][0], capacity_line[2][1], capacity_line[2][2], capacity_line[2][3], capacity_line[2][4], capacity_line[2][5], capacity_line[2][6], capacity_line[2][7],
        capacity_line[3][0], capacity_line[3][1], capacity_line[3][2], capacity_line[3][3], capacity_line[3][4], capacity_line[3][5], capacity_line[3][6], capacity_line[3][7],
        capacity_line[4][0], capacity_line[4][1], capacity_line[4][2], capacity_line[4][3], capacity_line[4][4], capacity_line[4][5], capacity_line[4][6], capacity_line[4][7],
        capacity_line[5][0], capacity_line[5][1], capacity_line[5][2], capacity_line[5][3], capacity_line[5][4], capacity_line[5][5], capacity_line[5][6], capacity_line[5][7],
        LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses, LED_correct_id,
        capacity_user, costumer_cash, correct_id
    );
    //this code on/off Buzzer LED in FPGA
    assign condition3 = (goto_user == correct_id) ? 0 : (goto_user) ? 1 : 0 ;
    ALARM_SYSTEM Buzzer_alarm (clk_1_second, condition3, Buzzer); 
    //the seven segmenet controler unit:
    SEVEN_SEGMENT_MUX seven_segment_mux (clk, ones, tens, hundreds, thousands, segment_selection, segment_data);
    
endmodule