`include "MDSD//Extra_credit_sessions//Verilogreview//Comp4bits.v"

module testbench ();
    reg [3:0] A,B;
    wire lt,gr,eq;

     Comp4bits UUT (A,B,lt,gr,eq);

    //driver module
    
    initial begin
        $dumpfile("Comp4bits.vcd"); //create the waveform file
        $dumpvars(0, testbench); //0 refers to what levels of variables we call
        A=5; B=7; #4;
        A=10; B=7; #4;
        A=10; B=10; #4;
        $finish;
    end
endmodule
