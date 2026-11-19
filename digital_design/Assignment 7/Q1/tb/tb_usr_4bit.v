`timescale 1ns / 1ps

module tb_usr_4bit;
    reg        clk;
    reg        reset;
    reg  [1:0] select;
    reg  [3:0] d;
    reg        s_in_left;
    reg        s_in_right;
    wire [3:0] q;

    usr_4bit uut (
        .clk(clk),
        .reset(reset),
        .select(select),
        .d(d),
        .s_in_left(s_in_left),
        .s_in_right(s_in_right),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("../VCD/usr_4bit.vcd");
        $dumpvars(0, tb_usr_4bit);

        clk = 0; reset = 1; select = 2'b00; d = 4'b0000; s_in_left = 0; s_in_right = 0;
        #12 reset = 0;

        select = 2'b11; d = 4'b1010; #10;

        select = 2'b00; #10;

        select = 2'b01; s_in_right = 1; #10;
        s_in_right = 0; #10;

        select = 2'b10; s_in_left = 1; #10;
        s_in_left = 0; #10;

        $finish;
    end

    initial begin
        $display("Time | clk reset sel | D | Q");
        $monitor("%0t |  %b    %b   %b  | %b | %b", $time, clk, reset, select, d, q);
    end
endmodule