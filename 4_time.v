//this function count the time we need that:

`timescale 1ps/1ps

module TIME (
    input clk,
    input counting_sign,
    output reg [5:0]time_end
);
    //initialized the reg output:
    reg [26:0]counter;
    initial begin
        counter = 0;
        time_end = 0;
    end

    //count
    always @(posedge clk) begin
        if (counting_sign) begin
            if (counter == 40000000 - 1) begin
                time_end <= time_end + 1;
                counter <= 0;
            end
            else    counter <= counter + 1;
        end
        else begin
            counter <= 0;
            time_end <= 0; 
        end        
    end
    
endmodule