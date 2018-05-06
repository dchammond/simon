// Output:
// input_correct: the input was correct and was indicated as finished
// input_done: input indicated as finished
// Input:
// number_input: Concateated 6-but signal from input switched
// clk
// button: The physical button
// number_desired: The 6-bit number to compare too
module equality_check(input_correct,
                      input_done,
                      number_input,
                      number_desired,
                      button,
                      clk);

    output reg   input_correct, input_done;
    input  [5:0] number_input, number_desired;
    input        button, clk;

    wire equal = (number_input == number_desired);
    
    always@(posedge clk)
    begin
        input_done    <= button;
        input_correct <= (equal & button);
    end

endmodule
