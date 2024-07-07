// this is a testbench for my project:

`timescale 1ms/1ps

module TESTBENCH;
    reg clk;
    reg reset;
    reg status_5_second;
    reg dip_switch_status;
    reg [2:0]password;
    reg [2:0]position_line;
    reg [3:0]position_column;
    reg push_up;
    reg push_down;
    reg verify_capacity;
    reg [1:0]user_id;
    reg push_confirm_buy;
    reg push_buy_end;
    wire LED_admin;
    wire LED_user;
    wire LED_unknown_state;
    wire LED_correct_pass;
    wire LED_correct_id;
    wire LED_costumer1;
    wire LED_costumer2;
    wire LED_costumer3;
    wire LED_capacity_choses;
    //to show and use the seven segment:
    wire [4:0]segment_selection;
    wire [7:0]segment_data;
    wire [6:0]ones;
    wire [6:0]tens;
    wire [6:0]hundreds;
    wire [6:0]thousands;
    wire Buzzer;
    // wire [5:0]time_5_second;
    // wire [5:0]time_60_second;
    // wire clk_1_second;

    // Instantiate the design
    MAIN main (
        .clk(clk),
        .reset(reset),
        .status_5_second(status_5_second),
        .dip_switch_status(dip_switch_status),
        .password(password),
        .position_line(position_line),
        .position_column(position_column),
        .push_up(push_up),
        .push_down(push_down),
        .verify_capacity(verify_capacity),
        .user_id(user_id),
        .push_confirm_buy(push_confirm_buy),
        .push_buy_end(push_buy_end),
        .LED_admin(LED_admin),
        .LED_user(LED_user),
        .LED_unknown_state(LED_unknown_state),
        .LED_correct_pass(LED_correct_pass),
        .LED_correct_id(LED_correct_id),
        .LED_costumer1(LED_costumer1),
        .LED_costumer2(LED_costumer2),
        .LED_costumer3(LED_costumer3),
        .LED_capacity_choses(LED_capacity_choses),
        .segment_selection(segment_selection),
        .segment_data(segment_data),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands),
        .Buzzer(Buzzer)
        // .time_5_second(time_5_second),
        // .time_60_second(time_60_second),
        // .clk_1_second(clk_1_second)
    );

    initial begin
        clk = 0;
        forever begin
            #0.0000125  clk = ~clk;        // the time scale that clk changes (40MHz)
        end
    end

    initial begin
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);
        
        // Apply test vectors:
        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 01;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 1;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 1;
        dip_switch_status = 1;
        password = 0;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 01;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #15
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 01;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 1;
        dip_switch_status = 1;
        password = 0;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #6
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 110;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1    
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 01;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1       
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 0;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 0;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 0;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 101;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 1;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 11;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 10;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 10;
        push_confirm_buy = 0;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 10;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 2;
        push_confirm_buy = 1;
        push_buy_end = 0;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 2;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 1;
        password = 0;
        position_line = 0;
        position_column = 0;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);

        reset = 0;
        status_5_second = 0;
        dip_switch_status = 0;
        password = 0;
        position_line = 101;
        position_column = 0110;
        push_up = 1;
        push_down = 1;
        verify_capacity = 0;
        user_id = 0;
        push_confirm_buy = 1;
        push_buy_end = 1;
        #1
        $display("admin:%b, user:%b, unknown:%b, pass:%b, id:%b ,costumer1:%b, costumer2:%b, costumer3:%b, capacity:%b,  cash:%d%d%d%d\n",
        LED_admin, LED_user, LED_unknown_state, LED_correct_pass, LED_correct_id,LED_costumer1, LED_costumer2, LED_costumer3, LED_capacity_choses,thousands,hundreds,tens,ones);
        // $display("time 5 second:%d     time 60 second:%d       clk 1 second:%b\n",time_5_second,time_60_second,clk_1_second);      
        //finish the simulation
        $finish;
    end
    
endmodule