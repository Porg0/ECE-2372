`include "MDSD/Capstone/calculator.v"

//Calculator testbench module

module testbench ();
    reg B1,B2,Equals,rst,op;
    wire[3:0] Output1,Output2,result;
    wire [6:0] S7D1,S7D2,S7D3,S7D4;

    top UUT (B1,B2,Equals,rst,op,Output1,Output2,result,S7D1,S7D2,S7D3,S7D4);

    //driver module
        initial B1=0;
        always begin
           #10 B1 = ~B1;
        end 

    initial begin
        $dumpfile("calculator.vcd");
        $dumpvars(0, testbench);

        B2=0; op=0; Equals=0; rst=0; #(10);
        B2=1; op=0; Equals=0; rst=0; #(10);
        B2=0; op=0; Equals=0; rst=0; #(10);
        B2=1; op=0; Equals=0; rst=0; #(10);
        B2=0; op=0; Equals=0; rst=0; #(10);
        B2=1; op=0; Equals=0; rst=0; #(10);
        #(10*10);

        $finish;
    end

endmodule
