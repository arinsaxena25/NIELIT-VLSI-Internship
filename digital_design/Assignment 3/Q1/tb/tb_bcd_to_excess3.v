`timescale 1ns / 1ps

module tb_bcd_to_excess3;
    reg  [3:0] bcd;
    wire [3:0] excess3;
    integer i;

    bcd_to_excess3 uut (
        .bcd(bcd),
        .excess3(excess3)
    );

    initial begin
        $display("Time | BCD Input | Excess-3 Output");
        $monitor("%0t  |   %b (%d)  |    %b (%d)", $time, bcd, bcd, excess3, excess3);

        for (i = 0; i < 10; i = i + 1) begin
            bcd = i;
            #10;
        end

        $finish;
    end
endmodule