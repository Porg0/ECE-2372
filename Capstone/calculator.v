/*
    Name: Alejandro Bonilla
    Date: 11/6/23
    Project Name: 4 bit adder/subtractor with 7seg display
    Project Details:
        1) 2 buttons that allow increment input values on 7seg
        2) 1 button to control if its adding or subtracting
        3) 1 button to switch between showing the inputs values and showing the result
        4) 1 button to reset the displays to 0
        5) 2 7 segment displays to show our values

    Project Status
        The code is running and is able to pass values in the test-bench.
        Issue is that the Feed and Dig wires do not like to properly pass to eachother thus,
        causing incorrect outputs when reseting or pressing equal
    
    11/17
        The module count has been lowered, and most work together
        When the equal button is instated the verilog no longer functions
            -By this I mean that it is preventing the result wire from passing value somehow

    11/20
        The code is now working properly
        Took out 2 displays since we only need to have two digits at a time
*/

module Count4( // 4bit counter
   input up, r,
   output reg [3:0] count=4'b0000
    );
    always @(posedge r, posedge up) begin //Trigger on the button press
        case({r,up})
            2'b1X: count = 4'b0000;
            2'b01: count = count +1;
        endcase
        case(count)
            4'b1010: count = 4'b0000; //When we reach 10 then its time go back to 0
        endcase
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
	output [4:0] S
    );
	wire C1, C2, C3, C4;
	full_adder U0 (.A(A[0]), .B(B[0]^C), .C(C), .F(S[0]), .G(C1));			
	full_adder U1 (.A(A[1]), .B(B[1]^C), .C(C1), .F(S[1]), .G(C2));
	full_adder U2 (.A(A[2]), .B(B[2]^C), .C(C2), .F(S[2]), .G(C3));
	full_adder U3 (.A(A[3]), .B(B[3]^C), .C(C3), .F(S[3]), .G(S[4]));
endmodule

module output_setter ( //Determines our output
    input [4:0] result,
    input [3:0] A,B,
    input op, eq,
    output reg [3:0] OutputC, OutputD
    );

  always@(eq, result, op) begin
    case(eq)
        0: begin //Equal button not pressed so its just the inputs
            OutputC = A;
            OutputD = B;
        end
        1: begin //Equal button was pressed so now determine what the displays must output
            case({result[4], op})
                2'b00: begin
                    OutputC = 4'b0000;
                    OutputD = result;
                end 
                2'b01: begin
                    OutputC = 4'b0000;
                    OutputD = result;
                end 
                2'b10: begin
                    OutputC = 4'b0001;
                    OutputD = result - 4'b1010;
                end 
                2'b11: begin
                    OutputC = 4'b1011;
                    OutputD = result - 5'b10000;
                end
            endcase
        end
    endcase
    end
endmodule

module Seg7Decode( //7 segement display
   input [3:0] Data,
   output reg [6:0] seg7=7'b0000000 // LED outputs, active low(meaning 0=on, 1=off) 
    );
   always @(Data)begin
       case(Data) //  bit order in segments ABCDEFG
          4'b0000: seg7 <= 7'b0000001; // "0"
          4'b0001: seg7 <= 7'b1001111; // 1
          4'b0010: seg7 <= 7'b0010010; // 2
          4'b0011: seg7 <= 7'b0000110; // 3
          4'b0100: seg7 <= 7'b1001100; // 4
          4'b0101: seg7 <= 7'b0100100; // 5
          4'b0110: seg7 <= 7'b0100000; // 6
          4'b0111: seg7 <= 7'b0001111; // 7
          4'b1000: seg7 <= 7'b0000000; // 8
          4'b1001: seg7 <= 7'b0000100; // 9
          4'b1010: seg7 <= 7'b1111110; // - for negative numbers
          default: seg7 <= 7'b0011100; // Diglays a circle on the top of the display to show an error
       endcase
    end   
endmodule

module top ( //Module Instances
    input Button1,Button2,Equals,Reset,Operation, 
    output [6:0] Dig1, Dig2
    );
    wire [3:0] Number1, Number2, Disp1, Disp2;
    wire [4:0] Result; // 5 bit value since we have to go up to 18

    Count4 C1 (.up(Button1), .r(Reset), .count({Number1})); //Connects count module to button1 
    Count4 C2 (.up(Button2), .r(Reset), .count({Number2})); //Connects count module to button2

    full_adder_subtractor F1 (.A({Number1}), .B({Number2}), .C(Operation), .S({Result})); 
        //^ Performs chosen operation with the outputs of count module

    output_setter OS1 (.result({Result}), .A({Number1}), .B({Number2}), .op(Operation), .eq(Equals), .OutputC({Disp1}), .OutputD({Disp2})); 
        //^ Result checker and assigns display input values

    Seg7Decode Digit1 (.Data({Disp1}), .seg7({Dig1})); //Display 1
    Seg7Decode Digit2 (.Data({Disp2}), .seg7({Dig2})); //Display 2
endmodule