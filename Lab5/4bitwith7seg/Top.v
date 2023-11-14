`include "MDSD//Lab5//4bitwith7seg//Seg7Decode.v"
`include "MDSD//Lab5//4bitwith7seg//Count4.v"
`include "MDSD//Lab5//4bitwith7seg//ClkDiv.v"

module Top(clk, rst, enable, upDown, count, seg7);
// count[3:0] output included for convenience in debug and testbenches
	input clk, rst, enable, upDown;
	output [3:0] count;
	reg [3:0] count;
	output [6:0] seg7;
	reg [6:0] seg7;
	
    wire clkCounter;  // divided clock for Counter module
	wire [3:0] C;
	wire [6:0] S;
	ClkDiv U0 (clk, clkCounter);
	
	Count4 C0 (clkCounter, rst, enable, upDown, C);

	always @(C) begin
		count = C;
	end

	Seg7Decode S0 (count, S);

	always @(S) begin
		seg7 = S;
	end

	// Add code here to instantiate and connect the three modules together structurally

	
endmodule
