`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2018 03:04:16 PM
// Design Name: 
// Module Name: top_level
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_level(correct_led,
                 state_leds,
                 seg,
                 an,
                 amp_audio_out,
                 amp_gain,
                 amp_not_shutdown,
                 input_swt,
                 play_swt,
                 submit_button, // Center
                 advance_button, // Right
                 clk);
    
    output [6:0] seg;
    output [3:0] an;
    output  [5:1] state_leds;
    output       correct_led, amp_audio_out, amp_gain, amp_not_shutdown;
    input  [5:0] input_swt;
    input        play_swt, submit_button, advance_button, clk;
    
// ---------------- Start Base Clock -------------------
    wire base_clock; // 5 MHz
    clk_wiz divider_base(clk, base_clock);
// ---------------- End Base Clock ---------------------
    
// ---------------- Start FSM --------------------------
    wire gen;
    wire training;
    wire [2:0] training_sel;
    wire testing;
    wire [2:0] testing_sel;
    wire win;
    wire reset_game;
    wire game_clock;
    wire input_correct;
    wire input_done;
    wire advance = advance_button;
    fsm state_machine(gen, training, training_sel, testing, testing_sel, win, reset_game, game_clock, input_correct, input_done, advance, play_swt, base_clock);
    
    assign state_leds[1] = gen;
    assign state_leds[2] = training;
    assign state_leds[3] = testing;
    assign state_leds[4] = win;
    assign state_leds[5] = reset_game;
// ---------------- End FSM ----------------------------

// ---------------- Start Score Tracker ----------------
    wire [5:0] score;
    score_tracker score_track(score, game_clock, win, reset_game);
// ---------------- End Score Tracker ------------------

// ---------------- Start LFSR -------------------------
    wire [29:0] random_number;
    thirty_bit_lfsr lfsr(random_number, gen, base_clock, reset_game); // Only updates on "gen"
// ---------------- End LFSR ---------------------------

// ---------------- Start Number Generator -------------
    wire [5:0] rand_num0, rand_num1, rand_num2, rand_num3, rand_num4;
    number_generator num_gen(rand_num0, rand_num1, rand_num2, rand_num3, rand_num4, random_number); // Only updates on "gen" because lfsr
// ---------------- End Number Generator ---------------

// ---------------- Start Number Selector --------------
    wire [5:0] chosen_number;
    fivexn_bit_mux #(.width(6)) num_sel(chosen_number, rand_num0, rand_num1, rand_num2, rand_num3, rand_num4, training_sel | testing_sel); // Only one is ever non-zero
// ---------------- End Number Selector ----------------

// ---------------- Start Sound Generator --------------
    wire [12:0] sound0, sound1, sound2, sound3, sound4;
    sound_generator sound_gen(sound0, sound1, sound2, sound3, sound4);
// ---------------- End Sound Generator ----------------

// ---------------- Start Sound Selector ---------------
    wire [12:0] chosen_sound;
    fivexn_bit_mux #(.width(13)) sound_sel(chosen_sound, sound0, sound1, sound2, sound3, sound4, training_sel | testing_sel); // Only one is ever non-zero
// ---------------- End Sound Selector -----------------

// ---------------- Start Equality Check ---------------
    assign correct_led = input_correct & input_done & testing;
    equality_check eq_check(input_correct, input_done, input_swt, chosen_number, submit_button, game_clock);
// ---------------- End Equality Check -----------------

// ---------------- Start AMP Control ------------------
    amp_control amp(amp_audio_out, amp_gain, amp_not_shutdown, chosen_sound, training | testing, reset, base_clock);
// ---------------- End AMP Control --------------------

// ---------------- Start Display Control --------------
    wire [5:0] display_num;
    mux2v #(.width(6)) display_mux(display_num, input_swt, chosen_number, training);
    display_control display(seg, an, display_num, score, base_clock);
// ---------------- End Display Control ----------------

endmodule
