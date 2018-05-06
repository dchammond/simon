// Retrns 5 sounds in micro-seconds
// 1us = 10^-6sec
// Hz = 1/sec
module sound_generator(sound0,
                       sound1,
                       sound2,
                       sound3,
                       sound4);

    output [12:0] sound0, sound1, sound2, sound3, sound4;

    assign sound0 = 13'd5000; // 5000us = 200Hz
    assign sound1 = 13'd3333; // 3333us = 300Hz
    assign sound2 = 13'd2500; // 2500us = 400HZ
    assign sound3 = 13'd2000; // 2000us = 500Hz
    assign sound4 = 13'd1667; // 1667us = 600Hz

endmodule
