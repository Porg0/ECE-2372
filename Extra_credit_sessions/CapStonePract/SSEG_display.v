module SSEG4X7(
    input clock,
    input [3:0] data1, data2, data3, data4,
    output [6:0] sseg,
    output [3:0] cathodes,
);


endmodule

module ssegDecode( //7 segement display
   input [3:0] data,
   output reg [6:0] sseg = 7'h0x00 // LED outputs, active low(meaning 0=on, 1=off) 
);
   always @(data)
    begin
       case(data) //  bit order in segments ABCDEFG
          
          0: sseg = 7'h0x3F; // "0"
          1: sseg = 7'h0x06; // 1
          2: sseg = 7'h0x5B; // 2
          3: sseg = 7'h0x4F; // 3
          4: sseg = 7'h0x66; // 4
          5: sseg = 7'h0x6D; // 5
          6: sseg = 7'h0x6F; // 6
          7: sseg = 7'h; // 7
          8: sseg = 7'h; // 8
          9: sseg = 7'h; // 9
          10: sseg = 7'h0x40;
          11: sseg = 7'h;

          default: sseg = 7'b0011100; // Displays a circle on the top of the display to show an error
       endcase
    end   
endmodule

module Count4( // 4bit counter
   input clock,
   output reg [1:0] data= 0
);
    always @(posedge clock) begin
        //out[1] <= out[1] ^ out[0];
        //out[0] <= ~out[0];

        data = data + 1;

    end
endmodule

module MUX(
    input [6:0] data1, data2, data3, data4,
    input [1:0] control,
    output reg [6:0] sseg
);      
    always @(data1,data2,data3,data4,control)begin
        case(control)
            0: sseg = data1;
            1: sseg = data2;
            2: sseg = data3;
            3: sseg = data4;
        endcase
    end
endmodule  

module CathodeDecoder(
    input [2:0] control,
    output reg [3:0] out,
);
    always @(control)begin
        case(control)
            0: out = 4'b0001;
            1: out = 4'b0010;
            2: out = 4'b0100;
            3: out = 4'b1000;
        endcase

        // << -bitwise shift left 
        out = 4'b0001 << control;
    end
endmodule