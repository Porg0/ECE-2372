module Seg7Decode( // convert active-high 4-bit BCD to 7-segment display code, active low outputs
   input [3:0] bin, // binary input
   output reg [6:0] seg7 // LED outputs, active low, assumes common anode LEDs. Not actually registers. 
    );
   always @(bin)
    begin
       case(bin)
       //  bit order is segments ABCDEFG
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
          4'b1010: seg7 = 7'b0001000; // A
          4'b1011: seg7 = 7'b1100000; // b
          4'b1100: seg7 = 7'b0110001; // C
          4'b1101: seg7 = 7'b1000010; // d
          4'b1110: seg7 = 7'b0110000; // E
          4'b1111: seg7 = 7'b0111000; // F
      //////////// insert code here for input patterns 4'b001 through 4'b1111 
     
          default: seg7 = 7'b1101010; // "n" ("n" for none, but this will never happen)
       endcase
    end   
 // insert code here
 
endmodule