`timescale 1ns / 1ps

module tb_dff_sync;
    reg  clk;
    reg  reset;
    reg  d;
    wire q;

    dff_sync uut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dff_sync.vcd");
        $dumpvars(0, tb_dff_sync);

        clk = 0;
        reset = 1;
        d = 0;

        #20;
        reset = 0;

        #3  d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 1;
        #10 d = 0;
        #20;

        $finish;
    end

    initial begin
        $display("Time | clk reset d | Q");
        $monitor("%0t  |  %b    %b   %b | %b", $time, clk, reset, d, q);
    end
endmodule