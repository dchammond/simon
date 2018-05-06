module full_adder(sum, cout, a, b, cin);
    output sum, cout;
    input  a, b, cin;
    wire   partial_s, partial_c1, partial_c2;

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | ((a ^ b) & cin);

endmodule // full_adder

// 01x - arithmetic, 1xx - logic
module alu1(out, carryout, A, B, carryin);
    output      out, carryout;
    input       A, B, carryin;

    full_adder fa1(out, carryout, A, B, carryin);

endmodule // alu1
