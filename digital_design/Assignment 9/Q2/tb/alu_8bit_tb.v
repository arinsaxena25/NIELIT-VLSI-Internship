`timescale 1ns / 1ps

module alu_8bit_tb;
    reg [7:0] a, b;
    reg [2:0] opcode;
    wire [7:0] result;
    wire carry_out, zero_flag;

    alu_8bit uut (
        .a(a), .b(b), .opcode(opcode),
        .result(result), .carry_out(carry_out), .zero_flag(zero_flag)
    );

    initial begin
        a = 8'h0A; b = 8'h05; opcode = 3'b000; #10;
        opcode = 3'b001; #10;
        opcode = 3'b010; #10;
        opcode = 3'b011; #10;
        opcode = 3'b100; #10;
        opcode = 3'b101; #10;
        opcode = 3'b110; #10;
        opcode = 3'b111; #10;
        $finish;
    end
endmodule