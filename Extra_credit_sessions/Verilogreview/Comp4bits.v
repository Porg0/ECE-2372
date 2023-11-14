module Comp4bits(
    input [3:0] A,B,
    output reg lt,gr,eq
);
 always@(A,B) begin
    if (A>B) begin //greater than case
        gr = 1;
        lt = 0;
        eq = 0;
    end
    else if (A<B) begin //less than case
        gr = 0;
        lt = 1;
        eq = 0;
    end
    else begin //equal to case
        gr = 0;
        lt = 0;
        eq = 1;
    end
end
endmodule