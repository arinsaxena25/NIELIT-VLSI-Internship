`timescale 1ns / 1ps

module tb_bin2gray_3bit;
    reg  [2:0] b;
    wire [2:0] g;
    integer i;

    bin2gray_3bit uut (
        .b(b),
        .g(g)
    );

    initial begin
        $display("Time | Binary (b) | Gray (g)");
        $monitor("%0t  |    %b     |   %b", $time, b, g);

        for (i = 0; i < 8; i = i + 1) begin
            b = i;
            #10;
        end

        $finish;
    end
endmodule