`timescale 1ns / 1ps

module tb_up_down_counter_full;
    reg        clk;
    reg        reset;
    reg        up_down;
    wire [3:0] count;

    up_down_counter_async uut (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .count(count)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_up_down_counter_full);

        clk = 0;
        reset = 1;
        up_down = 1;

        #12;
        reset = 0;

        up_down = 1;
        #160;

        up_down = 0;
        #160;

        $finish;
    end

    initial begin
        $display("Time | clk reset up_down | Count");
        $monitor("%0t  |  %b    %b       %b     |   %d", $time, clk, reset, up_down, count);
    end
endmodule