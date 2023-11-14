// 4-bit up/down counter
module Count4(clk,rst,enable,upDown, count);
   input clk, rst, enable, upDown;
   output reg [3:0] count;

always @(posedge clk) begin
            casex ({enable,upDown,rst})
                
                3'b0X0: count = count;
                3'bXX1: count = 0;
                3'b110: count = count + 1;
                3'b100: count = count - 1;

            endcase
    end
// insert code here 

endmodule  // Count4
