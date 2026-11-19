`timescale 1ns / 1ps

module tb_mux2to1;
    reg  a, b, sel;
    wire y;

    mux2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $dumpfile("mux2to1.vcd");
        $dumpvars(0, tb_mux2to1);

        $display("Time | sel a b | Y");
        $monitor("%0t  |  %b  %b %b | %b", $time, sel, a, b, y);

        sel = 0; a = 0; b = 1; #10;
        sel = 0; a = 1; b = 0; #10;
        sel = 1; a = 1; b = 0; #10;
        sel = 1; a = 0; b = 1; #10;

        $finish;
    end
endmodule