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

        a = 8'hFF; b = 8'h01; opcode = 3'b000; #10;

        a = 8'hAA; b = 8'hAA; opcode = 3'b001; #10;

        a = 8'hF0; b = 8'h0F; opcode = 3'b010; #10;

        a = 8'h55; b = 8'hAA; opcode = 3'b011; #10;

        a = 8'hFF; b = 8'h55; opcode = 3'b100; #10;

        a = 8'h00; b = 8'h00; opcode = 3'b101; #10;

        a = 8'h05; b = 8'h10; opcode = 3'b110; #10;

        a = 8'h20; b = 8'h10; opcode = 3'b110; #10;

        a = 8'h81; b = 8'h00; opcode = 3'b111; #10;

        a = 8'h00; b = 8'hFF; #10;

        $finish;
    end

endmodule