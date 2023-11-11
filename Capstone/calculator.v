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

module Seg7Decode( // convert active-high 4-bit BCD to 7-segment display code, active low outputs
   input [3:0] D4B, // binary input
   output reg [6:0] seg7=0000000 // LED outputs, active low, assumes common anode LEDs. Not actually registers. 
    );
   always @(D4B)
    begin
       case(D4B) //  bit order is segments ABCDEFG
          
          4'b0000: seg7 = 7'b1111110; // "0"
          4'b0001: seg7 = 7'b1001111; // 1
          4'b0010: seg7 = 7'b0010010; // 2
          4'b0011: seg7 = 7'b0000110; // 3
          4'b0100: seg7 = 7'b1001100; // 4
          4'b0101: seg7 = 7'b0100100; // 5
          4'b0110: seg7 = 7'b0100000; // 6
          4'b0111: seg7 = 7'b0001111; // 7
          4'b1000: seg7 = 7'b0000000; // 8
          4'b1001: seg7 = 7'b0000100; // 9
          4'b1010: seg7 = 7'b0000001; // - for negative numbers

          default: seg7 = 7'b1100011; // Displays a circle on the top of the display to show an error
       endcase
    end   
 
endmodule

module Count4( up, count); // 4-bit up/down counter
   
   input up;
   output reg [3:0] count= 4'b0000;

    always @(up) begin
        if(up == 1)begin
            count <= count + 1; //Increment up 1
        end        
        if (count >= 10) begin
            count <= 0; //If we reach 10 then its time go back to 0
        end
    end
endmodule  // Count4

module full_adder(A, B, C, F, G); //Half adder moodule
	
	input A, B, C;
	output F, G;
	assign F = A ^ B ^ C;
	assign G = B & C | A & B | A & C;

endmodule

module full_adder_subtractor(A, B, C, S); //Full rippple-carry-adder-subtractor

	input [3:0] A,B;
	input C;
	output [3:0] S;
	wire C1, C2, C3, C4;

	full_adder U0 (.A(A[0]), .B(B[0]^C), .C(C), .F(S[0]), .G(C1));			
	full_adder U1 (.A(A[1]), .B(B[1]^C), .C(C1), .F(S[1]), .G(C2));
	full_adder U2 (.A(A[2]), .B(B[2]^C), .C(C2), .F(S[2]), .G(C3));
	full_adder U3 (.A(A[3]), .B(B[3]^C), .C(C3), .F(S[3]), .G(C4));
	
endmodule

module result_check ( //Checks different result scenarios
    input [3:0] result, 
    output reg [3:0] Output1=0000, Output2=0000
);
    always@(result)begin
        if (result > 9) begin //Result is double digit
            Output1 <= 0001;
            Output2 <= result-10;
        end else if (result < 0)begin //Result is negative
            Output1 <= 1010;
            Output2 <= result;
        end else begin //Result is single digit
            Output1 <= 0000;
            Output2 <= result;
        end
    end
endmodule

 module equal_button ( //Module for the equal button
    input eq,
    output reg[3:0] D1=0000,D2=0000,D3=0000,D4=0000
);
    always@(eq)begin
        if (eq == 1)begin //When pressed it will show the output
            D1 = 4'b0000;
            D2 = 4'b0000;
            D3 = D3;
            D4 = D4;
        end else begin //Else only show the inputs
            D1 = D1;
            D2 = D2;
            D3 = 4'b0000;
            D4 = 4'b0000;
        end
    end
endmodule

module reset_button (
    input reset,
    output reg [3:0] In1=0000, In2=0000, Out1=0000, Out2=0000
);
    always @(reset)begin
        if (reset == 1)begin
            In1 <= 0000;
            In2 <= 0000;
            Out1 <= 0000;
            Out2 <= 0000;
        end else begin
            In1 <= In1;
            In2 <= In2;
            Out1 <= Out1;
            Out2 <= Out2;
        end
    end
endmodule

module top ( 
    input B1,B2,Equals,rst,op,
    output [3:0] Output1,Output2, result,
    output [6:0] S7D1, S7D2, S7D3, S7D4
);

    wire [3:0] Input1, Input2;

    Count4 C1 (.up(B1), .count(Input1)); //Connects count module to button1 
    Count4 C2 (.up(B2), .count(Input2)); //Connects count module to button2

    full_adder_subtractor F1 (.A(Input1), .B(Input2), .C(op), .S(result)); //Perform the operation with the inputs
    result_check R1 (.result(result), .Output1(Output1), .Output2(Output2)); //Check how the result should be displayed

    equal_button E1(.eq(Equals), .D1(Input1), .D2(Input2), .D3(Output1), .D4(Output2)); //Equal Button to see if the inputs or outputs are displayed
    reset_button R0 (.reset(rst), .In1(Input1), .In2(Input2), .Out1(Output1), .Out2(Output2)); //Reset button to turn all displays to 0

    Seg7Decode I1 (.D4B(Input1), .seg7(S7D1)); //Display 1
    Seg7Decode I2 (.D4B(Input2), .seg7(S7D2)); //Display 2
    Seg7Decode O1 (.D4B(Output1), .seg7(S7D3)); //Display 3
    Seg7Decode O2 (.D4B(Output2), .seg7(S7D4)); //Display 4

endmodule

/* 
always@(Equals) begin
        if (~Equals) begin //Eq switch hasnt been pressed yet
            Input1 = {Input1A};
            Input2 = {Input2A};
            Output1 = {4'b0000};
            Output2 = {4'b0000};
        end 
        else begin //Equal switch was pressed
            Input1 = {4'b0000};
            Input2 = {4'b0000};
            Output1 = {Output1A};
            Output2 = {Output2A};
        end
    end */