// Dillon Hammond
module BCDToLED(
    output [6:0] seg, // segments
    input  [3:0] in   // binary input
    );
    
    wire z = in[0];
    wire y = in[1];
    wire x = in[2];
    wire w = in[3];

    // A->G = 0->6
    assign seg[0] = (x & ~y & ~z) | (~w & ~x & ~y & z);
    assign seg[1] = (x & ~y & z) | (x & y & ~z);
    assign seg[2] = (~x & y & ~z);
    assign seg[3] = (x & ~y & ~z) | (~w & ~x & ~y & z) | (x & y & z);
    assign seg[4] = (x & ~y) | (z);
    assign seg[5] = (~x & y) | (y & z) | (~w & ~x & z);
    assign seg[6] = (~w & ~x & ~y) | (x & y & z);
endmodule
