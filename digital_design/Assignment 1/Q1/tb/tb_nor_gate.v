`timescale 1ns / 1ps

module tb_nor_gate;
    reg a, b;
    wire y_df, y_st;

    nor_gate_dataflow   u_df (.a(a), .b(b), .y(y_df));
    nor_gate_structural u_st (.a(a), .b(b), .y(y_st));

    initial begin
        $display("Time | a b | Dataflow | Structural");
        $monitor("%0t  | %b %b |    %b     |    %b", $time, a, b, y_df, y_st);
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
endmodule