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
		{A, B, C, D} = 4'b0000; #5;
		`assert(W, 1'b0, "W", "A = 0, B = 0, C = 0, D = 0", "W not 0", "%b");
		`assert(Y, 1'b0, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 0", "%b");
		{A, B, C, D} = 4'b0001; #5;
		`assert(W, 1'b0, "W", "A = 0, B = 0, C = 0, D = 0", "W not 0", "%b");
		`assert(Y, 1'b0, "Y", "A = 0, B = 0, C = 0, D = 0", "Y not 0", "%b");
	end
endmodule