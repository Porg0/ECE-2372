`include "MDSD//Extra_credit_sessions//Verilogreview//DisplayComp.v"

module testbench ();
    reg lt=0,gr=0,eq=0;
    wire [6:0] SegmentData;

    DisplayComp UUT (lt,gr,eq,clk,SegmentData);

    //clock module
        always begin
            clk => clk; #1;
        end
    //driver module
    
    initial begin
        $dumpfile("DisplayComp.vcd"); //create the waveform file
        $dumpvars(0, testbench); //0 refers to what levels of variables we call
         lt=1; #4;
         lt=0; gr=1; #4;
         gr=0; eq=1; #4;
         gr=1; #4;

        $finish;
    end
endmodule