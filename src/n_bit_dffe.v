// n-bit DFFE
module n_bit_dffe(q, d, clk, enable, reset);
   
    parameter
        width = 1,
        reset_value = 0;

    output reg [(width - 1):0] q;
    input      [(width - 1):0]  d;
    input      clk, enable, reset;


    always@(posedge clk or posedge reset)
    begin
        if (reset == 1'b1)
        begin
            q <= reset_value;
        end
        else if (enable == 1'b1)
        begin
            q <= d;
        end
    end
endmodule // dffe
