`timescale 1ns / 1ps

module tb_bcd_to_7seg;
    reg  [3:0] bcd;
    wire [6:0] seg;
    integer i;

    bcd_to_7seg uut (
        .bcd(bcd),
        .seg(seg)
    );

    initial begin
        $display("Time | BCD | Segments (Hex)");
        $monitor("%0t  |  %h  |       %h", $time, bcd, seg);

        for (i = 0; i < 16; i = i + 1) begin
            bcd = i;
            #10;
        end

        $finish;
    end
endmodule