/*
    Name: Alejandro Bonilla
    Date: 11/6/23
    Project Name: 4 bit adder/subtractor with 7seg display
    Project Details:
        1) 2 buttons that allow increment input values on 7seg
        2) 1 button to control if its adding or subtracting
        3) 1 button to switch between showing the inputs values and showing the result
        4) 1 button to reset the displays to 0

    Project Status
        The code is running and is able to pass values in the test-bench.
        Issue is that the Feed and Dig wires do not like to properly pass to eachother thus,
        causing incorrect outputs when reseting or pressing equal
*/

module Seg7Decode( //7 segement display
   input [3:0] D4B,
   output reg [6:0] seg7 // LED outputs, active low(meaning 0=on, 1=off) 
);
   always @(D4B)
    begin
       case(D4B) //  bit order in segments ABCDEFG
          
          4'b0000: seg7 = 7'b0000001; // "0"
          4'b0001: seg7 = 7'b1001111; // 1
          4'b0010: seg7 = 7'b0010010; // 2
          4'b0011: seg7 = 7'b0000110; // 3
          4'b0100: seg7 = 7'b1001100; // 4
          4'b0101: seg7 = 7'b0100100; // 5
          4'b0110: seg7 = 7'b0100000; // 6
          4'b0111: seg7 = 7'b0001111; // 7
          4'b1000: seg7 = 7'b0000000; // 8
          4'b1001: seg7 = 7'b0000100; // 9
          4'b1010: seg7 = 7'b1111110; // - for negative numbers

          default: seg7 = 7'b0011100; // Displays a circle on the top of the display to show an error
       endcase
    end   
 
endmodule

module Count4( // 4bit counter
   input up,
   output reg [3:0] count= 4'b0000
);

    always @(posedge up) begin
            count = count + 1; //Increment up 1     
        if (count >= 10) begin
            count <= 0; //When we reach 10 then its time go back to 0
        end
    end
endmodule

module full_adder( //Full adder moodule
	input A, B, C,
	output F, G
);
	assign F = A ^ B ^ C;
	assign G = B & C | A & B | A & C;
endmodule

module full_adder_subtractor( //4-bit rippple-carry-adder-subtractor
	input [3:0] A,B,
	input C,
	output [3:0] S
);
	wire C1, C2, C3, C4;

	full_adder U0 (.A(A[0]), .B(B[0]^C), .C(C), .F(S[0]), .G(C1));			
	full_adder U1 (.A(A[1]), .B(B[1]^C), .C(C1), .F(S[1]), .G(C2));
	full_adder U2 (.A(A[2]), .B(B[2]^C), .C(C2), .F(S[2]), .G(C3));
	full_adder U3 (.A(A[3]), .B(B[3]^C), .C(C3), .F(S[3]), .G(C4));
endmodule

module result_check ( //Checks different result scenarios
    input [3:0] result, 
    input sign,
    output reg [3:0] OutputA=4'b0000, OutputB=4'b0000
);
    always @(result, sign)begin
        case(sign)
            0: begin
                case(result)
                    ({result} > 9): begin
                        OutputA = 0001;
                        OutputB = {result} - 10;
                    end 
                    ({result} <= 9): begin
                        OutputA = 0;
                        OutputB = {result};
                    end
                endcase
            end
            1: begin
                OutputA = 1011;
                OutputB = {result};
            end
        endcase
    end
endmodule

 module equal_button ( //Module for the equal button
    input eq,
    input [3:0] A, B, C, D,
    output reg[3:0] D1=4'b0000,D2=4'b0000,D3=4'b0000,D4=4'b0000
);  
    always @(A, B, C, D, eq)begin
        case(eq)
            0: begin
                D1 <= A;
                D2 <= B;
                D3 <= 0000;
                D4 <= 0000;
            end
            1: begin
                D1 <= 0000;
                D2 <= 0000;
                D3 <= C;
                D4 <= D;
            end
        endcase
    end
endmodule

module reset_button ( // Reset button module 
    input reset,
    input [3:0] A, B,
    output reg [3:0] In1=4'b0000, In2=4'b0000
);
    //If the reset buttton is not pressed then it will not change anything
    always @(negedge reset)begin
        In1 <= A;
        In2 <= B;
    end
    always @(posedge reset)begin //When pressed it will change the values
            In1 <= 0000;
            In2 <= 0000;
        end
endmodule

module pos_neg_val_check ( //Check the operation would result in a negative value
    input [3:0] A, B,
    input op,
    output reg[3:0] Val1=0000, Val2=0000,
    output reg S
);
    always @(posedge op)begin
        case(A)
            (A < B): begin
                Val1 <= B;
                Val2 <= A;
                S <= 1;
            end
            default: begin
                Val1 <=A;
                Val2 <=B;
                S <=0;
            end
        endcase
    end
    always @(negedge op)begin
        Val1 <= A;
        Val2 <= B;
        S <= 0;
    end
endmodule

module top ( 
    input Button1,Button2,Equals,Reset,Operation,
    output [6:0] S7D1, S7D2, S7D3, S7D4
);
    //Two sets of wires, the first set does not seem to be getting used at the moment and I may need to change that
    // wire [3:0] Dig1, Dig2, Dig3, Dig4;
    wire Sign;
    wire [3:0] Feed1, Feed2, Feed3, Feed4, Result;
    
    Count4 C1 (.up(Button1), .count(Feed1)); //Connects count module to button1 
    Count4 C2 (.up(Button2), .count(Feed2)); //Connects count module to button2

    reset_button RB1 (.reset(Reset), .A(Feed1), .B(Feed2), .In1(Feed1), .In2(Feed2)); //Reset button to turn inputs to 0 which turns outputs to 0
    pos_neg_val_check V1 (.A(Feed1), .B(Feed2), .S(Sign), .Val1(Feed1), .Val2(Feed2)); //Check if the operation is going to be pos or neg

    full_adder_subtractor F1 (.A(Feed1), .B(Feed2), .C(Operation), .S(Result)); //Perform the operation with the inputs
    result_check RC1 (.result(Result), .sign(Sign), .OutputA(Feed3), .OutputB(Feed4)); //Check how the result should be displayed

    equal_button EB1 (.eq(Equals), //This is our anode selector???
    .A(Feed1), .B(Feed2), .C(Feed3), .D(Feed4), //Putting feed here instead of 1st wire set solved
    .D1(Feed1), .D2(Feed2), .D3(Feed3), .D4(Feed4)); //Equal Button to see if the inputs or outputs are displayed

    Seg7Decode Digit1 (.D4B(Feed1), .seg7(S7D1)); //Display 1
    Seg7Decode Digit2 (.D4B(Feed2), .seg7(S7D2)); //Display 2
    Seg7Decode Digit3 (.D4B(Feed3), .seg7(S7D3)); //Display 3
    Seg7Decode Digit4 (.D4B(Feed4), .seg7(S7D4)); //Display 4
endmodule

/* reset_button RB1 (.reset(rst), 
    .A(Feed1), .B(Feed2), .C3I(Feed3), .C4I(Feed4), //Putting the feed wires here solved a lot of issues but now its time to debug
    .In1(Dig1), .In2(Dig2), .Out1(Dig3), .Out2(Dig4)); //Reset button to turn all displays to 0
*/

/*

    always @(negedge eq)begin  //Show the input values since the equal button hasnt been pressed
            D1 <= A;
            D2 <= B;
            D3 <= 4'b0000;
            D4 <= 4'b0000;
        end
        always @(posedge eq)begin //When pressed it will show the output
            D1 <= 4'b0000;
            D2 <= 4'b0000;
            D3 <= C;
            D4 <= D;
        end
        
*/