module score_tracker(current_score,
                     clk,
                     enable,
                     reset);

    output [5:0] current_score;
    input        clk, enable, reset;

    wire   [5:0] new_score;

    n_bit_dffe #(.width(6), .reset_value(0)) score(current_score, new_score, clk, enable, reset);
    
    adder_six adder(new_score, current_score, 6'd1);

endmodule
