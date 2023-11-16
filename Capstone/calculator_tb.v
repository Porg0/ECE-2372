`include "MDSD/Capstone/calculator.v"

//Calculator testbench module

module testbench ();
    reg Button1,Button2,Equals,Reset,Operation;
    wire [6:0] S7D1,S7D2,S7D3,S7D4;

    top UUT (Button1,Button2,Equals,Reset,Operation,S7D1,S7D2,S7D3,S7D4);

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
        #(10*10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=1; Equals=0; Reset=0; #(10);
        /*Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        Operation=0; Equals=0; Reset=0; #(10);
        #(10*10);
        Operation=1; Equals=1; Reset=0; #(10);*/
        $finish;
    end

endmodule
