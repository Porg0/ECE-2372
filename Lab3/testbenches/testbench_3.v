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

// It looks like this testbench contains a "$finish" system task.
// Be aware that some simulation programs (e.g. Modelsim) will immediately close once the "$finish" system task is executed.
// If you find that your simulation program is closing unexpectedly, try removing any "$finish" system tasks in this file.

`timescale 1 ns/ 1 ns

module testbench();
	reg 	[3:0] 	A = 0, B = 0;
	reg						C;
	wire 	[3:0] 	S;
	reg [14*8:0] input_string;

	top uut(A, B, C, S);

	initial begin
		A = 15;
		B = 15;
		C = 0;
		#5;
		$sformat(input_string, "A=%d, B=%d, C=%b", A, B, C);
      `assert(S, 4'b1110, "S", input_string,"", "%b")
	   $finish;
	end

endmodule