module lfsr_tb;

    reg enable, clock, reset;

    initial begin
        $dumpfile("lfsr.vcd");
        $dumpvars(0, lfsr_tb);
        enable = 0; clock = 0; reset = 1;
        #10;
        clock = ~clock; enable = 1; reset = 0;
        #1;
        clock = ~clock; enable = 0; reset = 0;
        #10;
        clock = ~clock; enable = 1; reset = 0;
        #1;
        $finish;
    end

    wire [29:0] data;
    thirty_bit_lfsr lfsr(data, enable, clock, reset);
endmodule

