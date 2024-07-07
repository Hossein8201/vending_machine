//this is the controler of FPGA lcd

`timescale 1ps/1ps

module LCD (
    input clk,
    input reset,
    output reg register,
    output reg read_write,
    output reg enable,
    output reg [3:0] data,
    output reg init_done
);
    // حالت‌های FSM
    typedef enum reg [3:0] {
        INIT,
        SEND_CMD,
        SEND_DATA,
        DONE,
        IDLE
    } state_t;

    reg [3:0]state, next_state;
    reg [31:0]counter;

    // دستورات LCD
    parameter FUNCTION_SET     = 8'h28;  // Function set: 2 lines, 5x8 font
    parameter DISPLAY_CONTROL  = 8'h0C;  // Display ON, Cursor OFF, Blink OFF
    parameter CLEAR_DISPLAY    = 8'h01;  // Clear display
    parameter ENTRY_MODE_SET   = 8'h06;  // Entry mode: Increment, No shift
    parameter RETURN_HOME      = 8'h02;  // Return home

    // دنباله دستورات مقداردهی اولیه
    reg [7:0]init_sequence[0:4];
    reg [3:0]init_index;

    // کاراکترهای جمله "capacity is not enough"
    reg [7:0]message[0:20];
    reg [4:0]message_index;

    initial begin
        init_sequence[0] = 8'h03;       //Wake-up
        init_sequence[1] = 8'h02;       //4-bit mode
        init_sequence[2] = FUNCTION_SET;
        init_sequence[3] = DISPLAY_CONTROL;
        init_sequence[4] = ENTRY_MODE_SET;
        //the message "capacity is not enough"
        message[0] = "c";
        message[1] = "a";
        message[2] = "p";
        message[3] = "a";
        message[4] = "c";
        message[5] = "i";
        message[6] = "t";
        message[7] = "y";
        message[8] = " ";
        message[9] = "i";
        message[10] = "s";
        message[11] = " ";
        message[12] = "n";
        message[13] = "o";
        message[14] = "t";
        message[15] = " ";
        message[16] = "e";
        message[17] = "n";
        message[18] = "o";
        message[19] = "u";
        message[20] = "g";
        message[21] = "h";
    end

    // FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= INIT;
            counter <= 0;
            init_index <= 0;
            message_index <= 0;
            init_done <= 0;
        end else begin
            state <= next_state;
            if (state == INIT || state == SEND_CMD || state == SEND_DATA) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end

    always @* begin
        next_state = state;
        register = 0;
        read_write = 0;
        enable = 0;
        data = 4'b0000;
        case (state)
            INIT: begin
                if (counter == 50000) begin
                    data = init_sequence[init_index][3:0];
                    enable = 1;
                    if (init_index == 4) next_state = SEND_CMD;
                    else next_state = SEND_CMD;
                end
            end
            SEND_CMD: begin
                enable = 0;
                next_state = INIT;
                if (init_index < 4) init_index = init_index + 1;
                else next_state = DONE;
            end
            DONE: begin
                init_done = 1;
                next_state = SEND_DATA;
            end
            SEND_DATA: begin
                if (message_index < 22) begin
                    data = message[message_index][3:0];
                    register = 1; // Register = 1 برای داده
                    enable = 1;
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            IDLE: begin
                enable = 0;
                next_state = SEND_DATA;
                message_index = message_index + 1;
            end
            default: next_state = INIT;
        endcase
    end
endmodule