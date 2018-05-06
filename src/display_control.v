module display_control(seg,
                       an,
                       number,
                       score,
                       clk);

    output [6:0] seg;
    output [3:0] an;
    input  [5:0] number;
    input  [5:0] score;
    input        clk; // Assume already at 5MHz

    wire clk500; // 500Hz
    clock_divider #(.rate(5000)) divider500(clk500, clk);

    wire clk250; // 250Hz
    clock_divider #(.rate(10000)) divider250(clk250, clk);


    wire [3:0] input_tens;
    wire [3:0] input_ones;
    DecimalDigitDecoder ddd_input( , , , input_tens, input_ones, {10'b0, number});
    
    wire [3:0] score_tens;
    wire [3:0] score_ones;
    DecimalDigitDecoder ddd_score( , , , score_tens, score_ones, {10'b0, score});
    
    wire [3:0] digit_to_draw;
    mux4v #(.width(4)) seg_mux_input(digit_to_draw, input_ones, input_tens, score_ones, score_tens, {clk500, clk250});
    // 00 = input ones
    // 01 = input tens
    // 10 = score ones
    // 11 = score tens
    
    BCDToLED onesBCD(seg, digit_to_draw);
    
    // 0 is enabled, 1 is disabled
    assign an[0] = ~(~clk500 & ~clk250); // Set to 0 if both are 0
    assign an[1] = ~(~clk500 & clk250); // Set to 0 if clk500 is 0 and clk250 is 1
    assign an[2] = ~(clk500 & ~clk250); // Set to 0 if clk500 is 1 and clk250 is 0
    assign an[3] = ~(clk500 & clk250); // Set to 0 if clk500 is 1 and clk250 is 1

endmodule
