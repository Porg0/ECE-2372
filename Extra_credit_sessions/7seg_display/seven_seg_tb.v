`timescale 1ns/ 1ps
`include "seven_seg_lesson.v"

module seven_seg_lesson_tb ();

    reg A, B, C, D;
    wire a, b, c, d, e, f, g;

    seven_seg_lesson uut(A, B, C, D, a, b, c, d, e, f, g);

    initial begin
        
        $dumpfile("seven_seg_lesson.vcd");
        $dumpvars(0, seven_seg_lesson_tb);

        for (integer i=0; i < 16; i = i + 1)begin
            {A,B,C,D} = i[3:0]; #5;
        end

        $finish;

    end


endmodule