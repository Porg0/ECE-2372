`include "MDSD/Capstone/calculator.v"

//Calculator testbench module

module testbench ();
    reg Button1,Button2,Equals,Reset,Operation;
    wire [6:0] Dig1, Dig2;
    wire[3:0] Feed1, Feed2, Feed3, Feed4;

    top UUT (Button1,Button2,Equals,Reset,Operation,Dig1,Dig2);

    //Button Loops

    initial Button1 = 1;
        always begin
            #10 Button1= ~Button1;
        end
    initial Button2 = 1;
        always begin
            #10 Button2 = ~Button2;
        end
    
    //Driver module
    initial begin
        $dumpfile("calculator.vcd");
        $dumpvars(0, testbench);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        #(10*10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=1; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=1; #(10);
        Operation=0; Equals=1; Reset=0; #(10);
        #(10*10);
        Operation=1; Equals=0; Reset=0; #(10);
        $finish;
    end
endmodule
