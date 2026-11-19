`timescale 1ns / 1ps

module tb_comparator4bit;
    reg  [3:0] a, b;
    wire gt, eq, lt;

    comparator4bit uut (
        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)
    );

    initial begin
        $display("Time |  A    B  | A>B  A=B  A<B");
        $monitor("%0t  | %d  %d |  %b    %b    %b", $time, a, b, gt, eq, lt);

        a = 4'd5;  b = 4'd5;  #10;
        a = 4'd12; b = 4'd3;  #10;
        a = 4'd2;  b = 4'd9;  #10;
        a = 4'd15; b = 4'd15; #10;
        a = 4'd0;  b = 4'd1;  #10;
        a = 4'd8;  b = 4'd7;  #10;

        $finish;
    end
endmodule