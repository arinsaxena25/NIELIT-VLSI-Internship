`timescale 1ns / 1ps

module usr_4bit_tb;
    reg clk;
    reg reset;
    reg [1:0] mode;
    reg [3:0] d_in;
    reg s_in_left;
    reg s_in_right;
    wire [3:0] q;

    usr_4bit uut (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .d_in(d_in),
        .s_in_left(s_in_left),
        .s_in_right(s_in_right),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        mode = 2'b00;
        d_in = 4'b0000;
        s_in_left = 0;
        s_in_right = 0;

        #12 reset = 0;

        #10 mode = 2'b11; d_in = 4'b1010;
        #10 mode = 2'b00;
        #10 mode = 2'b01; s_in_right = 1;
        #10 s_in_right = 0;
        #10 mode = 2'b10; s_in_left = 1;
        #10 s_in_left = 1;

        #20 $finish;
    end
endmodule