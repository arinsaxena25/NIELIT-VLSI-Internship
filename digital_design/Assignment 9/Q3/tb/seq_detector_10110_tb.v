`timescale 1ns / 1ps

module seq_detector_10110_tb;
    reg clk;
    reg reset;
    reg din;
    wire detected;

    seq_detector_10110 uut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .detected(detected)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        din = 0;
        #12 reset = 0;

        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;

        #20 $finish;
    end
endmodule