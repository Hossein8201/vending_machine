//this debounced the push buttons in board FPGA:

`timescale 1ps/1ps

module DEBOUNCER (
    input clk,       
    input push, 
    output reg debounced_push 
);
    //reg variables:
    reg [19:0]counter; 
    initial begin
        counter = 0;
    end

    // Debounce logic
    always @(posedge clk) begin
        if (push == 0) begin
            if (counter <= 800000) begin         // 20 milliseconds debounce time
                counter <= counter + 1;
            end
        end 
        else begin
            counter <= 0;                       // Reset counter
        end
        // Change the output after debounce time
        if (counter == 800000) begin
            debounced_push <= 1'b1;
        end
        else begin
            debounced_push <= 1'b0;
        end
    end

endmodule