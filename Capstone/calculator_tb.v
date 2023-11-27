`include "MDSD/Capstone/calculator.v"

//Calculator testbench module

module testbench ();
    reg Button1,Button2,Equals,Reset,Operation;
    wire [6:0] Dig1, Dig2;
    wire[3:0] Feed1, Feed2, Feed3, Feed4;

    top UUT (Button1,Button2,Equals,Reset,Operation,Dig1,Dig2);
    
    //Driver module
    initial begin
        $dumpfile("calculator.vcd");
        $dumpvars(0, testbench);
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //1 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //2 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //3 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //4 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //5 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //6 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //7 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //8 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //9 on both
        Button1=0; Button2=0; Operation=0; Equals=1; Reset=0; #(10); //Displays 18
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //Hits 10 so returns to 0

        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //1 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //2 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //3 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //4 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //5 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //6 on both
        Button1=0; Button2=0; Operation=0; Equals=1; Reset=0; #(10); //Display output of 6 + 6 which is 12
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=1; #(10); //Reset it all to 0

        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //1 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //2 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //3 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //4 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //5 on both
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=1; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //6 on both
        Button1=0; Button2=0; Operation=1; Equals=1; Reset=0; #(10); //Display output of 6-6 which is 0
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=1; #(10); //Set all to 0 

        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //1 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //2 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //3 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //4 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //5 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //6 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //7 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //8 on 2nd
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=0; #(10);
        Button1=0; Button2=1; Operation=0; Equals=0; Reset=0; #(10); //9 on 2nd
        Button1=0; Button2=0; Operation=1; Equals=1; Reset=0; #(10); //Displays -9
        Button1=0; Button2=0; Operation=0; Equals=0; Reset=1; #(10); //Set all to 0        

        $finish;
    end
endmodule

