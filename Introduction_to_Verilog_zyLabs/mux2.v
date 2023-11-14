module mux2(a,b,s,y);      
   input a,b,s;   
   output reg y;
   
   always@(a,b,s) begin;
    y= (~s & a)| (s & b);
    
   end //  y = s'a + sb  (not really a register)
   endmodule  
     
// add code here to implement the multiplexer y = s'a + sb
