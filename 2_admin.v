//this function cope with the admin state:

`timescale 1ps/1ps

module ADMIN (
    input clk,
    input reset,
    input goto_admin,
    input [2:0]password,
    input [2:0]position_line,
    input [3:0]position_column,
    input push_up_debounced,
    input push_down_debounced,
    input verify_capacity,
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
    output reg LED_correct_pass,
    output reg signed [4:0]capacity_admin,          //because it may be a negetive number
    output reg correct_pass,
    output reg correct_position   
);
    //password of admin state:
    parameter PASSWORD_ADMIN = 3'b101;
    // the wire parameter for save the capacity
    wire [4:0]capacity_line_admin[0:5][0:7];
    assign
        capacity_line_admin[0][0] = capacity_line00,
        capacity_line_admin[0][1] = capacity_line01,
        capacity_line_admin[0][2] = capacity_line02,
        capacity_line_admin[0][3] = capacity_line03,
        // ************ there are unused lines:
        capacity_line_admin[0][4] = 5'd0,
        capacity_line_admin[0][5] = 5'd0,
        capacity_line_admin[0][6] = 5'd0,
        capacity_line_admin[0][7] = 5'd0,
        // ************ 
        capacity_line_admin[1][0] = capacity_line10,
        capacity_line_admin[1][1] = capacity_line11,
        capacity_line_admin[1][2] = capacity_line12,
        capacity_line_admin[1][3] = capacity_line13,
        capacity_line_admin[1][4] = capacity_line14,
        capacity_line_admin[1][5] = capacity_line15,
        capacity_line_admin[1][6] = capacity_line16,
        capacity_line_admin[1][7] = capacity_line17,
        capacity_line_admin[2][0] = capacity_line20,
        capacity_line_admin[2][1] = capacity_line21,
        capacity_line_admin[2][2] = capacity_line22,
        capacity_line_admin[2][3] = capacity_line23,
        capacity_line_admin[2][4] = capacity_line24,
        capacity_line_admin[2][5] = capacity_line25,
        capacity_line_admin[2][6] = capacity_line26,
        capacity_line_admin[2][7] = capacity_line27,
        capacity_line_admin[3][0] = capacity_line30,
        capacity_line_admin[3][1] = capacity_line31,
        capacity_line_admin[3][2] = capacity_line32,
        capacity_line_admin[3][3] = capacity_line33,
        capacity_line_admin[3][4] = capacity_line34,
        capacity_line_admin[3][5] = capacity_line35,
        capacity_line_admin[3][6] = capacity_line36,
        capacity_line_admin[3][7] = capacity_line37,
        capacity_line_admin[4][0] = capacity_line40,
        capacity_line_admin[4][1] = capacity_line41,
        capacity_line_admin[4][2] = capacity_line42,
        capacity_line_admin[4][3] = capacity_line43,
        capacity_line_admin[4][4] = capacity_line44,
        capacity_line_admin[4][5] = capacity_line45,
        capacity_line_admin[4][6] = capacity_line46,
        capacity_line_admin[4][7] = capacity_line47,
        capacity_line_admin[5][0] = capacity_line50,
        capacity_line_admin[5][1] = capacity_line51,
        capacity_line_admin[5][2] = capacity_line52,
        capacity_line_admin[5][3] = capacity_line53,
        capacity_line_admin[5][4] = capacity_line54,
        capacity_line_admin[5][5] = capacity_line55,
        capacity_line_admin[5][6] = capacity_line56,
        capacity_line_admin[5][7] = capacity_line57;

    //the logic unit of admin mode:
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            LED_correct_pass <= 1'b0; 
            correct_pass <= 1'b0;
            correct_position <= 1'b0; 
            capacity_admin <= 5'd0;   
        end
        else begin
            if (goto_admin) begin
                //check the password:
                if(password == PASSWORD_ADMIN)    correct_pass <= 1'b1;
                else  correct_pass <= 1'b0;         //this means the password isn't true
                //define your line:
                if (correct_pass) begin
                    LED_correct_pass <= 1'b1;
                    if (position_line == 3'b001) begin
                        if (position_column == 4'b0001 || position_column == 4'b0011 || position_column == 4'b0101 || position_column == 4'b0111) begin
                            correct_position <= 1'b1;
                            //for plus or minus the capacity:
                            if (capacity_line_admin[position_line-1][position_column-1] + capacity_admin < 5'd9 && push_up_debounced)    capacity_admin <= capacity_admin + 5'd1;
                            else if (capacity_line_admin[position_line-1][position_column-1] + capacity_admin > 5'd0 && push_down_debounced)     capacity_admin <= capacity_admin - 5'd1;
                            else if (verify_capacity) begin  capacity_admin <= 5'd0;    end  
                        end
                        else begin
                            correct_position <= 0;      //the position of column isn't true
                            capacity_admin <= 5'd0;
                        end
                    end
                    else if (position_line > 3'b000 && position_line < 3'b111) begin
                        if (position_column > 4'b0000 && position_column < 4'b1001) begin
                            correct_position <= 1'b1;
                            //for plus or minus the capacity:
                            if (capacity_line_admin[position_line-1][position_column-1] + capacity_admin < 5'd9 && push_up_debounced)    capacity_admin <= capacity_admin + 5'd1;
                            else if (capacity_line_admin[position_line-1][position_column-1] + capacity_admin > 5'd0 && push_down_debounced)     capacity_admin <= capacity_admin - 5'd1;
                            else if (verify_capacity) begin  capacity_admin <= 5'd0;    end  
                        end
                        else begin
                            correct_position <= 0;      //the position of column isn't true
                            capacity_admin <= 5'd0;
                        end
                    end
                    else begin
                        correct_position <= 0;          //this means the position of line isn't true
                        capacity_admin <= 5'd0;
                    end           
                end
                else begin
                    LED_correct_pass <= 0;
                    correct_position <= 0;
                    capacity_admin <= 5'd0;
                end
            end
            else begin
                LED_correct_pass <= 0;
                correct_pass <= 0;
                correct_position <= 0;
                capacity_admin <= 5'd0;
            end
        end
    end

endmodule