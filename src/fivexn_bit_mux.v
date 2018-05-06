// Select between 5, n-bit values
module fivexn_bit_mux(out,
                      in0,
                      in1,
                      in2,
                      in3,
                      in4,
                      sel);

    parameter
        width = 1;

    output [(width - 1):0] out;
    input  [(width - 1):0] in0, in1, in2, in3, in4;
    input  [2:0]           sel;

    wire   [(width - 1):0] intermediate;

    mux4v #(.width(width)) first_four(intermediate, in0, in1, in2, in3, sel[1:0]);
    mux2v  #(.width(width)) final_val(out, intermediate, in4, sel[2]);

endmodule
