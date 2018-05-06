// FSM for Simon
// train_sel and test_sel are 3-bit counters
// 000 = (Train/Test)0
// 100 = (Train/Test)4
// Use training and testing signals to tell apart (Train/Test)0 and not being
// in a training, testing state
module fsm(gen,
           training,
           training_sel,
           testing,
           testing_sel,
           win,
           reset,
           clock_out,
           input_correct,
           input_done,
           advance,
           play_game,
           base_clk);

    output reg [2:0] training_sel, testing_sel;
    output reg       gen, training, testing, win, reset, clock_out;
    input            input_correct, input_done, advance, play_game, base_clk;
    
    wire clk; // 2 Hz
    clock_divider #(.rate(1250000)) divider1(clk, base_clk);
    assign clock_out = clk;

    assign reset = ~play_game; // If switch is low, don't play the game

    // "The main difference between logic dataype and reg/wire is that a logic can be driven by both continuous assignment or blocking/non blocking assignment."
    // http://www.asicguru.com/system-verilog/interview-questions/logic-reg-wire/143/
    typedef enum logic [3:0] {sInitial, sGenerate, sTrain0, sTrain1, sTrain2, sTrain3, sTrain4, sTest0, sTest1, sTest2, sTest3, sTest4, sWin} State;
    State current_state, next_state;

    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            current_state <= sInitial;
        end
        else
        begin
            current_state <= next_state;
        end
    end
    
    always@(*)
    begin
    
        next_state = current_state;
        gen = 1'b0;
        training = 1'b0;
        training_sel = 3'b000;
        testing = 1'b0;
        testing_sel = 3'b000;
        win = 1'b0;

        case(current_state)
            
            sInitial:
            begin
                if(reset)
                begin
                    next_state = sInitial;
                end
                else if(advance)
                begin
                    next_state = sGenerate;
                end
            end
            
            sGenerate:
            begin
                gen = 1'b1;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else
                begin
                    next_state = sTrain0;
                end
            end
            
            sTrain0:
            begin
                training = 1'b1;
                training_sel = 3'b000;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else if(advance)
                begin
                    next_state = sTrain1;
                end
            end
            
            sTrain1:
            begin
                training = 1'b1;
                training_sel = 3'b001;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else if(advance)
                begin
                    next_state = sTrain2;
                end
            end
            
            sTrain2:
            begin
                training = 1'b1;
                training_sel = 3'b010;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else if(advance)
                begin
                    next_state = sTrain3;
                end
            end
            
            sTrain3:
            begin
                training = 1'b1;
                training_sel = 3'b011;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else if(advance)
                begin
                    next_state = sTrain4;
                end
            end
            
            sTrain4:
            begin
                training = 1'b1;
                training_sel = 3'b100;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else if(advance)
                begin
                    next_state = sTest0;
                end
            end

            sTest0:
            begin
                testing = 1'b1;
                testing_sel = 3'b000;
                if(reset || (input_done && !input_correct))
                begin
                    next_state = sInitial;
                end
                else if(input_done && input_correct)
                begin
                    next_state = sTest1;
                end
            end
            
            sTest1:
            begin
                testing = 1'b1;
                testing_sel = 3'b001;
                if(reset || (input_done && !input_correct))
                begin
                    next_state = sInitial;
                end
                else if(input_done && input_correct)
                begin
                    next_state = sTest2;
                end
            end

            sTest2:
            begin
                testing = 1'b1;
                testing_sel = 3'b010;
                if(reset || (input_done && !input_correct))
                begin
                    next_state = sInitial;
                end
                else if(input_done && input_correct)
                begin
                    next_state = sTest3;
                end
            end

            sTest3:
            begin
                testing = 1'b1;
                testing_sel = 3'b011;
                if(reset || (input_done && !input_correct))
                begin
                    next_state = sInitial;
                end
                else if(input_done && input_correct)
                begin
                    next_state = sTest4;
                end
            end
            
            sTest4:
            begin
                testing = 1'b1;
                testing_sel = 3'b100;
                if(reset || (input_done && !input_correct))
                begin
                    next_state = sInitial;
                end
                else if(input_done && input_correct)
                begin
                    next_state = sWin;
                end
            end

            sWin:
            begin
                win = 1'b1;
                if(reset)
                begin
                    next_state = sInitial;
                end
                else
                begin
                    next_state = sGenerate;
                end
            end
        endcase
    end

endmodule
