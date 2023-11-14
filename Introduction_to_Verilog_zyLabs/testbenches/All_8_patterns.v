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
module testbench;
      reg a,b,s;
      wire y;
      mux2 dut(a,b,s,y);
 
   initial begin
       a = 0; b = 0; s = 0;
       #5 `assert(y, 1'b0, "y", "a = 0; b = 0; s = 0;", "y not 0", "%b")
       
       a = 0; b = 1; s = 0;
       #5 `assert(y, 1'b0, "y", "a = 0; b = 1; s = 0;", "y not 0", "%b")
       
       a = 1; b = 0; s = 0;
       #5 `assert(y, 1'b1, "y", "a = 1; b = 0; s = 0;", "y not 1", "%b")
       
       a = 1; b = 1; s = 0;
       #5 `assert(y, 1'b1, "y", "a = 1; b = 1; s = 0;", "y not 1", "%b")
       
       // change select line s to 1 to select input b:

       a = 0; b = 0; s = 1;
       #5 `assert(y, 1'b0, "y", "a = 0; b = 0; s = 1;", "y not 0", "%b")
       
       a = 0; b = 1; s = 1;
       #5 `assert(y, 1'b1, "y", "a = 0; b = 1; s = 1;", "y not 1", "%b")
       
       a = 1; b = 0; s = 1;
       #5 `assert(y, 1'b0, "y", "a = 1; b = 0; s = 1;", "y not 0", "%b")
       
       a = 1; b = 1; s = 1;
       #5 `assert(y, 1'b1, "y", "a = 1; b = 1; s = 1;", "y not 1", "%b")
       
      $finish;
   end
endmodule