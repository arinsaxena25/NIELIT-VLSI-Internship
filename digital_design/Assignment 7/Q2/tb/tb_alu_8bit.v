`timescale 1ns / 1ps

module tb_alu_8bit;
    reg  [7:0] a, b;
    reg  [2:0] alu_control;
    wire [7:0] alu_out;
    wire       zero_flag;

    alu_8bit uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .alu_out(alu_out),
        .zero_flag(zero_flag)
    );

    initial begin
        $dumpfile("../VCD/alu_8bit.vcd");
        $dumpvars(0, tb_alu_8bit);

        a = 8'h0F; b = 8'h03;

        alu_control = 3'b000; #10; // Addition (0F + 03 = 12)
        alu_control = 3'b001; #10; // Subtraction (0F - 03 = 0C)
        alu_control = 3'b010; #10; // AND (0F & 03 = 03)
        alu_control = 3'b011; #10; // OR (0F | 03 = 0F)
        alu_control = 3'b100; #10; // XOR (0F ^ 03 = 0C)
        alu_control = 3'b101; #10; // Shift Left (0F << 1 = 1E)
        alu_control = 3'b110; #10; // Shift Right (0F >> 1 = 07)

        $finish;
    end

    initial begin
        $display("Time | A | B | Ctrl | ALU_Out | Zero");
        $monitor("%0t | %h | %h |  %b |    %h   |  %b", $time, a, b, alu_control, alu_out, zero_flag);
    end
endmodule