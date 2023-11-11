module Count4( up, count); // 4-bit up/down counter
   
   input up;
   output reg [3:0] count= 4'b0000;

    always @(up) begin
        if(up == 1)begin
            count <= count + 1; //Increment up 1
        end        
        if (count >= 10) begin
            count <= 0; //If we reach 10 then its time go back to 0
        end
    end
endmodule  // Count4

module full_adder(A, B, C, F, G); //Half adder moodule
	
	input A, B, C;
	output F, G;
	assign F = A ^ B ^ C;
	assign G = B & C | A & B | A & C;

endmodule

module full_adder_subtractor(A, B, C, S); //Full rippple-carry-adder-subtractor

	input [3:0] A,B;
	input C;
	output [3:0] S;
	wire C1, C2, C3, C4;

	full_adder U0 (.A(A[0]), .B(B[0]^C), .C(C), .F(S[0]), .G(C1));			
	full_adder U1 (.A(A[1]), .B(B[1]^C), .C(C1), .F(S[1]), .G(C2));
	full_adder U2 (.A(A[2]), .B(B[2]^C), .C(C2), .F(S[2]), .G(C3));
	full_adder U3 (.A(A[3]), .B(B[3]^C), .C(C3), .F(S[3]), .G(C4));
	
endmodule

module result_check ( //Checks different result scenarios
    input [3:0] result, 
    output reg [3:0] Output1=0000, Output2=0000
);
    always@(result)begin
        if (result > 9) begin //Result is double digit
            Output1 <= 0001;
            Output2 <= result-10;
        end else if (result < 0)begin //Result is negative
            Output1 <= 1010;
            Output2 <= result;
        end else begin //Result is single digit
            Output1 <= 0000;
            Output2 <= result;
        end
    end
endmodule

module equal_button ( //Module for the equal button
    input eq,
    input [3:0] In1, In2, In3, In4,
    output reg[3:0] D1=0000,D2=0000,D3=0000,D4=0000
);
    always@(eq)begin
        if (eq == 1)begin //When pressed it will show the output
            D1 = 0000;
            D2 = 0000;
            D3 = {In3};
            D4 = {In4};
        end else begin //Else only show the inputs
            D1 = {In1};
            D2 = {In2};
            D3 = 0000;
            D4 = 0000;
        end
    end
endmodule

module top (
    input B1,B2,Equals,rst,op,
    output [6:0] S7D1, S7D2, S7D3, S7D4
);

    wire [3:0] Input1, Input2,result, Output1, Output2;

    Count4 C1 (.up(B1), .count(Input1)); //Connects count module to button1 
    Count4 C2 (.up(B2), .count(Input2)); //Connects count module to button2

    full_adder_subtractor F1 (.A(Input1), .B(Input2), .C(op), .S(result)); //Perform the operation with the inputs
    result_check R1 (.result(result), .Output1(Output1), .Output2(Output2)); //Check how the result should be displayed

   equal_button E1(.eq(Equals), .In1(Input1), .In2(Input2), .In3(Output1), .In4(Output2), .D1(Input1), .D2(Input2), .D3(Output1), .D4(Output2)); //Equal Button to see if the inputs or outputs are displayed 
endmodule

module testbench;

    reg B1,B2,Equals,rst,op;
    wire [6:0] S7D1, S7D2, S7D3, S7D4;

    top UUT (B1,B2,Equals,rst,op,S7D1,S7D2,S7D3,S7D4);

    initial B1 = 1;
        always begin
            #10 B1= ~B1;
        end
    initial B2 = 0;
        always begin
            #10 B2 = ~B2;
        end

    initial begin
        $dumpfile("modtest.vcd");
        $dumpvars(0, testbench);

        op=0; Equals=0;#(10);
        op=0; Equals=0;#(10);
        op=0; Equals=0;#(10);
        op=0; Equals=0;#(10);
        op=0; Equals=0;#(10);
        op=0; Equals=1;#(10);
        op=0; Equals=0;#(10);
        #(10*10);

        $finish;
    end

endmodule