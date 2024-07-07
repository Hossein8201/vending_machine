//this choose the seven segment to be on:

`timescale 1ps/1ps

module SEVEN_SEGMENT_MUX (
    input clk,
    input [6:0]digit1,
    input [6:0]digit2,
    input [6:0]digit3,
    input [6:0]digit4,
    output reg [4:0]segment_selection,
    output [7:0]segment_data
);
    reg [1:0]current_digit;
    reg [19:0]counter;
    reg [6:0]number;

    always @(posedge clk) begin
        if (counter == 20'd40000) begin             //the 1ms delay
            current_digit <= current_digit + 1;
            counter <= 0;
        end
        else     counter <= counter + 1;  
    end

    always @(current_digit) begin
        case (current_digit)
            2'd0: begin
                segment_selection <= 5'b00001;
                number <= digit1;
            end
            2'd1: begin
                segment_selection <= 5'b00010;
                number <= digit2;
            end
            2'd2: begin
                segment_selection <= 5'b00100;
                number <= digit3;
            end
            2'd3: begin
                segment_selection <= 5'b01000;
                number <= digit4;
            end
        endcase
    end
    //call the function:
    BCD2SEVEN_SEGMENT bcd2seven_segment (number, segment_data);
    
endmodule