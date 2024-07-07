//this module is used to we able to get the pins from 16 keyboard

`timescale 1ps/1ps

module KEYPAD (
    input clk,      
    input reset,            
    input [3:0]column,
    output reg [3:0]row,           
    output reg [3:0]key_value, 
    output reg key_pressed   
);
    //reg parameters:
    reg [20:0]counter;  
    reg [1:0]current_row;      
    reg [3:0]key_map[0:15];         //this is a 16 array and the bit of each that, is 4 bit

    //the value of each key:
    parameter
        key_map[0]  = 4'b0001, // 1
        key_map[1]  = 4'b0010, // 2
        key_map[2]  = 4'b0011, // 3
        key_map[3]  = 4'b0100, // A
        key_map[4]  = 4'b0101, // 4
        key_map[5]  = 4'b0110, // 5
        key_map[6]  = 4'b0111, // 6
        key_map[7]  = 4'b1000, // B
        key_map[8]  = 4'b1001, // 7
        key_map[9]  = 4'b1010, // 8
        key_map[10] = 4'b1011, // 9
        key_map[11] = 4'b1100, // C
        key_map[12] = 4'b1101, // *
        key_map[13] = 4'b1110, // 0
        key_map[14] = 4'b1111, // #
        key_map[15] = 4'b0000; // D
    
    //define the key that is pushed and its value:
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            current_row <= 0;
            row <= 4'b1110;              //start with the first row
            key_pressed <= 0;
            key_val <= 4'b1111;          //# that is a unknown key
        end
        else begin
            counter <= counter + 1;
            if (counter == 50000) begin                 //debounced the buttons:
                counter <= 0;
                current_row <= current_row + 1;
                row <= ~(4'b0001 << current_row);
                if (column != 4'b1111) begin
                    key_pressed <= 1;
                    case ({current_row, column})
                        6'b001110: key_val <= key_map[0];
                        6'b001101: key_val <= key_map[1];
                        6'b001011: key_val <= key_map[2];
                        6'b000111: key_val <= key_map[3];
                        6'b011110: key_val <= key_map[4];
                        6'b011101: key_val <= key_map[5];
                        6'b011011: key_val <= key_map[6];
                        6'b010111: key_val <= key_map[7];
                        6'b101110: key_val <= key_map[8];
                        6'b101101: key_val <= key_map[9];
                        6'b101011: key_val <= key_map[10];
                        6'b100111: key_val <= key_map[11];
                        6'b111110: key_val <= key_map[12];
                        6'b111101: key_val <= key_map[13];
                        6'b111011: key_val <= key_map[14];
                        6'b110111: key_val <= key_map[15];
                        default:   key_val <= 4'b1111;
                    endcase
                end 
                else begin
                    key_pressed <= 0;
                end
            end
        end
    end

endmodule