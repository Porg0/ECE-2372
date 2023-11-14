module DisplayComp (
    input lt,gr,eq,clk,
    output reg [6:0] SegmentData
);
    localparam Lessthan = 7'b0001000;
    localparam Greaterthan = 7'b1000000;
    localparam Equals = 7'b1000001;
    
    always @(posedge clk) begin
        
        case({lt,gr,eq})
            3'b100: SegmentData <= Lessthan;
            3'b010: SegmentData <= Greaterthan;
            3'b001: SegmentData <= Equals;
            default: SegmentData <= 7'b1111111;
        endcase
    end
endmodule