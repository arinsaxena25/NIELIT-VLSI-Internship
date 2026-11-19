`timescale 1ns / 1ps

module tb_sequence_detector;
    reg  clk;
    reg  reset;
    reg  din;
    wire y_mealy;
    wire y_moore;

    mealy_1001 u_mealy (.clk(clk), .reset(reset), .din(din), .y(y_mealy));
    moore_1001 u_moore (.clk(clk), .reset(reset), .din(din), .y(y_moore));

    always #5 clk = ~clk; //using 10ns clock

    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars(0, tb_sequence_detector);

        clk = 0;
        reset = 1;
        din = 0;

        #12;
        reset = 0;

        #10 din = 1;
        #10 din = 0;
        #10 din = 0;
        #10 din = 1;
        #10 din = 0;
        #10 din = 0;
        #10 din = 1;

        #20;
        $finish;
    end

    initial begin
        $display("Time | clk reset din | Mealy_Y | Moore_Y");
        $monitor("%0t |  %b    %b    %b  |    %b    |    %b", $time, clk, reset, din, y_mealy, y_moore);
    end
endmodule