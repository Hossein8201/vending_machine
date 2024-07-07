//this is a frequency divider to slow the clock cycle in one second:

`timescale 1ps/1ps

module FREQUENCY_DIVIDER (
    input clk,
    output reg clk_1_second
);
    //this count the number of each cycle:
    reg [25:0]counter;
    initial begin
        clk_1_second = 0;
        counter = 0;
    end

    //define the clock out in a second:
    always @(posedge clk) begin
        if (counter == 20000000 - 1) begin              //because the frequency of clk is 40MHz.
            counter <= 0;
            clk_1_second <= ~clk_1_second;
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule