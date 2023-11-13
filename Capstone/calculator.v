/*
    Name: Alejandro Bonilla
    Date: 11/6/23
    Project Name: 4 bit adder/subtractor with 7seg display
    Project Details:
        1) 2 buttons that allow increment input values on 7seg
        2) 1 button to control if its adding or subtracting
        3) 1 button to switch between showing the inputs values and showing the result
        4) 1 button to reset the displays to 0
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
        if(up == 1)begin
            count <= count + 1; //Increment up 1
        end        
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
    output reg [3:0] OutputA=4'b0000, OutputB=4'b0000
);
    always @(result)begin
        if (result > 9) begin //Result is double digit
            OutputA <= 0001;
            OutputB <= result-10;
        end else if (result < 0)begin //Result is negative
            OutputA <= 1010;
            OutputB <= result;
        end else begin //Result is single digit
            OutputA <= 0000;
            OutputB <= result;
        end
    end
endmodule

 module equal_button ( //Module for the equal button
    input eq,
    input [3:0] D1I, D2I, D3I, D4I,
    output reg[3:0] D1=4'b0000,D2=4'b0000,D3=4'b0000,D4=4'b0000
);  
    always @(negedge eq) begin //Assign the Input values for if the button is not yet pressed
        D1 <= D1I;
        D2 <= D2I;
        D3 <= 4'b0000;
        D4 <= 4'b0000;
    end
    always @(posedge eq)begin //When pressed it will show the output
            D1 <= 4'b0000;
            D2 <= 4'b0000;
            D3 <= D3I;
            D4 <= D4I;
        end
endmodule

module reset_button ( // Reset button module
    input reset,
    input [3:0] C1I, C2I, C3I, C4I,
    output reg [3:0] In1=4'b0000, In2=4'b0000, Out1=4'b0000, Out2=4'b0000
);
    //If the reset buttton is not pressed then it will not change anything
    always @(negedge reset)begin
        In1 <= C1I;
        In2 <= C2I;
        Out1 <= C3I;
        Out2 <= C4I;
    end
    always @(posedge reset)begin //When pressed it will change the values
            In1 <= 0000;
            In2 <= 0000;
            Out1 <= 0000;
            Out2 <= 0000;
        end
endmodule

module top ( 
    input Button1,Button2,Equals,rst,Operation,
    output [6:0] S7D1, S7D2, S7D3, S7D4
);
    //Two sets of wires, the first set does not seem to be getting used at the moment and I may need to change that
    wire [3:0] Dig1, Dig2, Dig3, Dig4, result;
    wire [3:0] Feed1, Feed2, Feed3, Feed4;

    Count4 C1 (.up(Button1), .count(Dig1)); //Connects count module to button1 
    Count4 C2 (.up(Button2), .count(Feed2)); //Connects count module to button2

    full_adder_subtractor F1 (.A(Dig1), .B(Feed2), .C(Operation), .S(result)); //Perform the operation with the inputs
    result_check RC1 (.result(result), .OutputA(Feed3), .OutputB(Feed4)); //Check how the result should be displayed

    equal_button EB1(.eq(Equals), //This is our anode selector???
    .D1I(Dig1), .D2I(Feed2), .D3I(Feed3), .D4I(Feed4), //Putting feed here instead of 1st wire set solved
    .D1(Feed1), .D2(Dig2), .D3(Dig3), .D4(Dig4)); //Equal Button to see if the inputs or outputs are displayed

    reset_button RB1 (.reset(rst), 
    .C1I(Dig1), .C2I(Feed2), .C3I(Feed3), .C4I(Feed4), //Putting the feed wires here solved a lot of issues but now its time to debug
    .In1(Feed1), .In2(Dig2), .Out1(Dig3), .Out2(Dig4)); //Reset button to turn all displays to 0

    Seg7Decode Digit1 (.D4B(Dig1), .seg7(S7D1)); //Display 1
    Seg7Decode Digit2 (.D4B(Feed2), .seg7(S7D2)); //Display 2
    Seg7Decode Digit3 (.D4B(Feed3), .seg7(S7D3)); //Display 3
    Seg7Decode Digit4 (.D4B(Feed4), .seg7(S7D4)); //Display 4
endmodule