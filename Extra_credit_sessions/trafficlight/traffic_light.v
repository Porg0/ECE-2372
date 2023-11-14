module TrafficLight (I,G,Y,R);
    input I;
    output reg G=0,Y=0,R=0;
    reg A=0,B=0; //Registers must be set 0 at the start
    always@(posedge I)begin
        A <= (I & B) | (~I & A);
        B <= (~I & B) | (I & ~A & ~B);
        G <= (I & A) | (~I & ~A & ~B);
        Y <= (~I & B) | (I & ~A & ~B); 
        R <= (I & B) | (~I & A);
    end

endmodule

module testbench;
    reg I=0;
    wire G,Y,R;
    TrafficLight UUT(I,G,Y,R);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,testbench);
        #4;
        I=1; #2; I=0; #2;
        I=1; #2; I=0; #2; 
        I=1; #2; I=0; #2;
        I=1; #2; I=0; #2;
        I=1; #2; I=0; #2;
    end
endmodule