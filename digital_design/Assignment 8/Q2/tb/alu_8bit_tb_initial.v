`timescale 1ns/1ps

module alu_8bit_tb;

    reg [7:0] a, b;
    reg [2:0] opcode;
    wire [7:0] result;
    wire carry_out, zero_flag;

    alu_8bitnew uut (
        .a(a), .b(b), .opcode(opcode),
        .result(result), .carry_out(carry_out), .zero_flag(zero_flag)
    );

    initial begin
        $dumpfile("../VCD/alu_8bit.vcd");
        $dumpvars(0, alu_8bit_tb);

        a = 8'h05; b = 8'h03;
        
        opcode = 3'b000; #10; // ADD
        opcode = 3'b010; #10; // AND
        opcode = 3'b011; #10; // OR

        $finish;
    end

endmodule