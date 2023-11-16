`include "MDSD//Extra_credit_sessions//CapStonePract//SSEG_display.v"

`timescale 1ns/1ms

module testbench;
    reg [3:0] data1, data2, data3, data4;
    reg clock;
    wire [3:0] cathodes;
    wire [6:0] sseg;

    SSEG4X7 U1 (data1, data2, data3, data4, clock, cathodes, sseg);

    /*always @ begin
        clk = ~clk; #1;
    end*/

    parameter (PRD) = 4;
    always #(PRD/2)begin
        clock = ~clock;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,testbench);

        data1 = 4'h0;
        data2 = 4'h1;
        data3 = 4'h2;
        data4 = 4'h3;

        #(PRD*4);
        $finish;
    end
//Chip Verify for verilog reference
endmodule

