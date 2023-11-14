module TrafflicLightCase (
    input clk,i,
    output reg G=0,
    output reg Y=0,
    output reg R=0
);

    reg[1:0] state=0; //state[1]: S1 || state[0]: S0
    
    always @(posedge clk) begin
        
        case ({i,state}) //{} case likes one object so thats why we turn it into a vector. Turns multiple objects into 1
                        //{i,state}: 3-bit input {i, state[1], state[2]}
        //Following Cases
        /* i, state[0], state[1]
        000
        001
        010
        011 -ignore
        100
        101
        110
        111 -ignore
        */

        3'b000: begin //3'b -3 bits
            state   <= 2'b00;
            {G,Y,R} <= 3'b100;
        end

        3'b001: begin
            state   <= 2'b01;
            {G,Y,R} <= 3'b010;
        end

        3'b010: begin
            state   <= 2'b10;
            {G,Y,R} <= 3'b001;
        end

        3'b100: begin
            state   <= 2'b01;
            {G,Y,R} <= 3'b010;
        end

        3'b101: begin
            state   <= 2'b10;
            {G,Y,R} <= 3'b001;
        end

        3'b110: begin
            state   <= 2'b00;
            {G,Y,R} <= 3'b100;
        end

        default: begin// execute if none match
            state <= 2'b00;
            {G,Y,R} <= 3'b111;
        end
        endcase

    end
    
endmodule

