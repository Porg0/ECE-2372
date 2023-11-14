/*
addersubtractor.v
Developed By: Derek Johnston @ Texas Tech University

Implement an 4-bit Ripple-Carry Adder/Subtractor

Inputs: A (4-bit), B (4-bit), C (1-bit)
Output: S (4-bit) = A + B (C = 0), A - B (C = 1)
*/

module full_adder(A, B, C, F, G);
	
	input A, B, C;
	output F, G;

	assign F = A ^ B ^ C;
	assign G = B & C | A & B | A & C;

endmodule

module top(A, B, C, S);

	input [3:0] A,B;
	input C;
	output [3:0] S;

	wire C1, C2, C3, C4;

	full_adder U0 (.A(A[0]), .B(B[0]^C), .C(C), .F(S[0]), .G(C1));			
	full_adder U1 (.A(A[1]), .B(B[1]^C), .C(C1), .F(S[1]), .G(C2));
	full_adder U2 (.A(A[2]), .B(B[2]^C), .C(C2), .F(S[2]), .G(C3));
	full_adder U3 (.A(A[3]), .B(B[3]^C), .C(C3), .F(S[3]), .G(C4));

	
endmodule

/*
module full_adder(A, B, C, F, G);
	
	input A,B;
	input G;
	output F;
	output C;

	wire W0, W1, W2, W3;
	xor (W0, A, B);
	xor (F, C0, G);

	and (W1, A, B);
	and (W2, A, G);
	and (W3, B, G);
	or (C, W1, W2, W3);

endmodule

module top(A, B, C, S);
	
	input [3:0]A,B;
	input C;
	output [3:0]S;

	wire [3:0] Y;
	wire C0, C1, C2, C3;

	xor (Y[0], B[0], C);
	xor (Y[1], B[1], C);
	xor (Y[2], B[2], C);
	xor (Y[3], B[3], C);

	xor (C, C3, G);
	xor (C3, C4);

	full_adder U0 (S[0], C0, A[0], B[0], C);
	full_adder U1 (S[1], C1, A[1], B[1], C1);
	full_adder U2 (S[2], C2, A[2], B[2], C2);
	full_adder U3 (S[3], C3, A[3], B[3], C3);	
	
endmodule */
