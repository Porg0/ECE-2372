

module Count4(clk,rst,enable,upDown, count);
   
   input clk, rst, enable, upDown;
   output reg [3:0] count;

always @(posedge clk) begin
    if (rst) begin
        count <= 4'b0000;
    end
    else begin
        if (enable) begin
            if (upDown) begin
                if (count == 4'b1111) begin
                    count <= 4'b0000;
                end
                else begin
                    count <= count + 1;
                end
            end
            else begin
                if (count == 4'b0000) begin
                    count <= 4'b1111;
                end
                else begin
                    count <= count - 1;
                end
            end
        end
    end
end

endmodule