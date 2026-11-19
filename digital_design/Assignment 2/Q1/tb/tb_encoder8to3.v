`timescale 1ns / 1ps

module tb_encoder8to3;
    reg  [7:0] d;
    wire [2:0] y;
    integer i;

    encoder8to3 uut (
        .d(d),
        .y(y)
    );

    initial begin
        $display("Time | Input (d) | Output (y)");
        $monitor("%0t  |  %b |    %b", $time, d, y);

        for (i = 0; i < 8; i = i + 1) begin
            d = (1 << i);
            #10;
        end

        $finish;
    end
endmodule