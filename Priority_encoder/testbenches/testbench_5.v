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

reg  [7:0] in  = 0; //inputs
wire [2:0] code;    // outputs   
wire z;
reg [14*8:0] input_string;  //string for printout of inputs in the assert macro

PriorityEncode8 uut (in, code, z);

// try all possible input values   
initial begin
 for (in = 128; in != 0;  in = in + 1) begin  //  in=1xxxxxxx
  #5   
    $sformat(input_string, "in=%b",in);
    `assert(code, 3'b111, "code",input_string,"", "%b")
//   `assert(z, 1'b0, "z",input_string,"", "%b")  //commented out to save printout space
 end 
 
 $finish; 
end 

endmodule