module PriorityEncode8(in, code,z);    // 8-bit priority encoder
   input [7:0] in;          // 8-bit inputs 
   output reg [2:0] code;   // indicates the index of the most significant bit that is a 1
   output reg z;            // indicates that all input bits are 0
     // outputs are not really registered, but Verilog syntax requires reg for an "if" assignment 
    always@(in)begin;
      if (in==8'b00000000) begin
          z=1'b1;
          code=3'b000;
        end else begin
          z=1'b0;
          if(in[7]==1)    code=3'b111;
        else if(in[6]==1) code=3'b110;
        else if(in[5]==1) code=3'b101;
        else if(in[4]==1) code=3'b100;
        else if(in[3]==1) code=3'b011;
        else if(in[2]==1) code=3'b010;
        else if(in[1]==1) code=3'b001;
        else
        code=3'b000;
      end

    end
     // insert code here        
endmodule

abcd=wy
0010=01 
0011=01
0100=10
0101=10
0110=10
0111=10
1000=11
1001=11
1010=11
1011=11
1100=11
1101=11
1110=11
1111=11

//d does not appear to have any impact