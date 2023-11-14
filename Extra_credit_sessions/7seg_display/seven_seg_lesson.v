module seven_seg_lesson (A, B, C, D, a, b, c, d, e, f, g);
    input A, B, C, D;

    output a, b, c, d, e, f, g;

    assign a = A | C | (B & D) | (~B & ~D);
    assign b = ~B | (~C & ~D) | (C & D);
    assign c = B | ~C | (C & D);
    assign d = A | (B & ~C & D) | (~B & C) | (~B & ~D) | (C & ~D);
    assign e = (~B & ~D) | (C & D);
    assign f = A | (B & ~C) | (B & ~D) | (~C & ~D);
    assign g = A | (B & ~C) | (B & ~D) | (~B & C);

endmodule

`timescale 1ns/ 1ps

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

