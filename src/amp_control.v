module amp_control(audio,
                   gain,
                   not_shutdown,
                   sound,
                   play,
                   reset,
                   clk);
    output reg    audio;
    output        gain, not_shutdown;
    input  [12:0] sound;
    input         play, reset, clk;

    wire micro_clk; // 1MHz -> 1us freq
    clock_divider #(.rate(5)) div5M(micro_clk, clk);

    assign gain = 1'b1; // high = 6db gain, low = 12db gain, more gain -> louder
    assign not_shutdown = play;

    reg [13:0] counter = 1;
    always@(posedge micro_clk)
    begin
        if(counter >= sound)
        begin
            counter <= 1;
            audio <= (~audio & play);
        end
        else
        begin
            counter <= counter + 1;
        end
    end

endmodule
