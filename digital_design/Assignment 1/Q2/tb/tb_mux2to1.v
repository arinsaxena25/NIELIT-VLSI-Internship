`timescale 1ns / 1ps

module tb_mux2to1;
    reg i0, i1, sel;
    wire y_a, y_b, y_c, y_d, y_e, y_f;

    mux2to1_dataflow_assign  u_a (i0, i1, sel, y_a);
    mux2to1_dataflow_ternary u_b (i0, i1, sel, y_b);
    mux2to1_behavioral_always u_c (i0, i1, sel, y_c);
    mux2to1_behavioral_ifelse u_d (i0, i1, sel, y_d);
    mux2to1_behavioral_case   u_e (i0, i1, sel, y_e);
    mux2to1_gate_level        u_f (i0, i1, sel, y_f);

    initial begin
        $display("Time | sel i1 i0 | a b c d e f");
        $monitor("%0t  |  %b   %b  %b  | %b %b %b %b %b %b", $time, sel, i1, i0, y_a, y_b, y_c, y_d, y_e, y_f);

        sel = 0; i0 = 0; i1 = 0; #10;
        sel = 0; i0 = 1; i1 = 0; #10;
        sel = 0; i0 = 0; i1 = 1; #10;
        sel = 0; i0 = 1; i1 = 1; #10;
        sel = 1; i0 = 0; i1 = 0; #10;
        sel = 1; i0 = 1; i1 = 0; #10;
        sel = 1; i0 = 0; i1 = 1; #10;
        sel = 1; i0 = 1; i1 = 1; #10;
        $finish;
    end
endmodule