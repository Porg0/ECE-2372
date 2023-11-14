`include "MDSD//Extra_credit_sessions//Verilogreview//DisplayComp.v"
`include "MDSD//Extra_credit_sessions//Verilogreview//Comp4bits.v"

module top(
    input [3:0]A,B,
    input clk,
    output [6:0] SegmentData
);
    wire LT,GR,EQ;
    Comp4bits Unit1(.A(A),.B(B),.lt(LT),.gr(GR),.eq(EQ));
    DisplayComp Unit2(.lt(LT),.gr(GR),.eq(EQ),.clk(clk),.SegmentData(SegmentData));
endmodule