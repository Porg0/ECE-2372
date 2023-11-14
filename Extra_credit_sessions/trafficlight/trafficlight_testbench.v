`include "MDSD//Extra_credit_sessions//trafficlight//trafficlightcases.v"

module testbench ();
    reg clk =0, i = 0;
    wire G,Y,R;

    TrafflicLightCase UUT (clk,i,G,Y,R); //UUT = Unit Under Test

    //clock driver

    always begin
        #5; clk = ~clk;
    end

    //driver module
    
    initial begin
        $dumpfile("trafficlight.vcd");
        $dumpvars(0, testbench); //0 refers to what levels of variables we call
        //time = 0, i=0
        //color should be green

        #(10*10);

        i=1; #(10);
        i=0; #(10);

        i=1; #(10);
        i=0; #(10);

        i=1; #(10);
        i=0; #(10);

        i=1; #(10);
        i=0; #(10);

        i = 1;
        #100;

        $finish;
    end

endmodule