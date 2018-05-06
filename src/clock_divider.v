module clock_divider(
    output clkout,
    input clkin
    );
    parameter
        rate = 1;
    reg [31:0] counter = 1;
    reg temp_clk = 0;
    always @(posedge(clkin))
    begin
        if(counter == rate)
        begin
            counter <= 1;
            temp_clk <= ~temp_clk;
        end
        else
        begin
            counter <= counter + 1;
        end
    end
    assign clkout = temp_clk;
endmodule
