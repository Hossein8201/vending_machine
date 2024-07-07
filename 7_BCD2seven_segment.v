//this is a transformer BCD to seven segment code:

`timescale 1ps/1ps

module BCD2SEVEN_SEGMENT (
    input [6:0]number,
    output reg [7:0]segment_data
);
    //this shows the number monitor:
    always @(number) begin
        case (number)
            7'd0 :      segment_data <= 8'b00111111;
            7'd1 :      segment_data <= 8'b00000110;
            7'd2 :      segment_data <= 8'b01011011;
            7'd3 :      segment_data <= 8'b01001111;           
            7'd4 :      segment_data <= 8'b01100110;
            7'd5 :      segment_data <= 8'b01101101;
            7'd6 :      segment_data <= 8'b01111101;
            7'd7 :      segment_data <= 8'b00000111;
            7'd8 :      segment_data <= 8'b01111111;
            7'd9 :      segment_data <= 8'b01101111;
            default :   segment_data <= 8'b00000000;  
        endcase
    end

endmodule