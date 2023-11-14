module circuit(A,B,C,F);
    input A,B,C;
    output reg F;

    always@(A,B,C) begin;
        F=A&~B|A&~C|B&C;
    end
    
endmodule