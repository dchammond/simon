module adder_six(out, A, B);
    output [5:0] out;
    input  [5:0] A, B;
    wire [5:0] cout_chain;

    alu1 al0(out[0], cout_chain[0], A[0], B[0], 1'b0);
    alu1 al1(out[1], cout_chain[1], A[1], B[1], cout_chain[0]);
    alu1 al2(out[2], cout_chain[2], A[2], B[2], cout_chain[1]);
    alu1 al3(out[3], cout_chain[3], A[3], B[3], cout_chain[2]);
    alu1 al4(out[4], cout_chain[4], A[4], B[4], cout_chain[3]);
    alu1 al5(out[5], cout_chain[5], A[5], B[5], cout_chain[4]);

endmodule
