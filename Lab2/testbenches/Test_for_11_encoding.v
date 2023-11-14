`define assert(actual, expected, outputName, inputs, description, type) \
    $write("\nTIME: "); $write($realtime); \
    if (actual == expected) \
        $display("   PASSED:   "); \
    else begin \
        $display(" ** FAILED:   "); \
        if (description) $display("TEST: %s", description); \
    end \
    $write("%s = ", outputName, type, actual); \
    $write(", EXPECTED: ", type, expected); \
    if (inputs) $display(" WITH: %s", inputs);
// End of `assert macro.

`timescale 1 ns / 1 ns
module testbench;
	reg A, B, C, D;
	wire W, Y;
	PriorityEncoder UUT(A, B, C, D, W, Y);
	initial begin
		{A, B, C, D} = 4'b1000; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1001; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1010; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1011; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1100; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1101; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1110; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");

		{A, B, C, D} = 4'b1111; #5;
		`assert(W, 1'b1, "W", "A = 0, B = 0, C = 0, D = 0", "W not 1", "%b");
		`assert(Y, 1'b1, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 1", "%b");
	end
endmodule