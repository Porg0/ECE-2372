module PriorityEncoder(a,b,c,d,w,y);
	   input a,b,c,d;          //Inputs
   output reg w,y;              // Outputs            
always @(a,b,c,d) begin
    w=(a|b);
    y=(a|(~b&c));
  end
endmodule

