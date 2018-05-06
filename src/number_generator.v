// Simple module to split a 30-bit number into 6x5-bit numbers
// num0 = rand[5:0], etc...
module number_generator(num0,
                        num1,
                        num2,
                        num3,
                        num4,
                        rand_num);
    
    output [5:0]  num0, num1, num2, num3, num4;
    input  [29:0] rand_num;

    assign num0 = rand_num[5:0];
    assign num1 = rand_num[11:6];
    assign num2 = rand_num[17:12];
    assign num3 = rand_num[23:18];
    assign num4 = rand_num[29:24];

endmodule
