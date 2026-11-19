`timescale 1ns / 1ps

module tb_up_down_counter;
    reg        clk;
    reg        reset;
    reg        up_down;
    wire [3:0] count_sync;
    wire [3:0] count_async;

    up_down_counter_sync  u_sync  (clk, reset, up_down, count_sync);
    up_down_counter_async u_async (clk, reset, up_down, count_async);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        up_down = 1;
        #12;

        reset = 0;
        #50;

        up_down = 0;
        #50;

        up_down = 1;
        #20;

        reset = 1;
        #3;
        reset = 0;
        #20;

        $finish;
    end

    initial begin
        $display("Time | clk reset up_down | Sync_Count | Async_Count");
        $monitor("%0t  |  %b    %b       %b     |     %d      |     %d", $time, clk, reset, up_down, count_sync, count_async);
    end
endmodule