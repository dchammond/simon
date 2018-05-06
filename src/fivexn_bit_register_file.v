module fivexn_bit_register_file(out0,
                                out1,
                                out2,
                                out3,
                                out4,
                                in0,
                                in1,
                                in2,
                                in3,
                                in4,
                                write_enable,
                                clk,
                                reset);

    parameter
        width = 32,
        reset_value = 0;

    output [(width - 1):0] out0, out1, out2, out3, out4;
    input  [(width - 1):0] in0, in1, in2, in3, in4;
    input                  write_enable, clk, reset;

    n_bit_dffe #(.width(width), .reset_value(reset_value)) dffe0(out0, in0, clk, write_enable, reset);
    n_bit_dffe #(.width(width), .reset_value(reset_value)) dffe1(out1, in1, clk, write_enable, reset);
    n_bit_dffe #(.width(width), .reset_value(reset_value)) dffe2(out2, in2, clk, write_enable, reset);
    n_bit_dffe #(.width(width), .reset_value(reset_value)) dffe3(out3, in3, clk, write_enable, reset);
    n_bit_dffe #(.width(width), .reset_value(reset_value)) dffe4(out4, in4, clk, write_enable, reset);

endmodule
