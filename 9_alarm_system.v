//this is a module for controling the Buzzer pin in FPGA

`timescale 1ps/1ps

module ALARM_SYSTEM (
    input clk_1_second,
    input start_alarm,
    output reg Buzzer
);
    reg [2:0]counter1;     
    reg alarm_active;       //the status of alarm in the next state
    initial begin
        counter1 = 0;
        alarm_active = 0;
    end
    
    //define the logic of 3 seconds alarm:
    always @(posedge clk_1_second) begin
        if (!start_alarm) begin
            counter1 <= 0;
            Buzzer <= 0;
            alarm_active <= 0;
        end
        else if (start_alarm & !alarm_active) begin
            alarm_active <= 1;
            counter1 <= 0;
        end
        else if (alarm_active) begin
            if (counter1 < 3) begin
                counter1 <= counter1 + 1;
                Buzzer <= 1;        //the Buzzer alarm is on
            end
            else begin
                Buzzer <= 0;        //the Buzzer alarm is off
                alarm_active <= 0;
            end
        end
    end
    
endmodule