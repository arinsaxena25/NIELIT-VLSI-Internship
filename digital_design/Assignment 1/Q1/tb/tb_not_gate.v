`timescale 1ns / 1ps

module tb_not_gate;
    reg a;
    wire y_df, y_st;

    not_gate_dataflow   u_df (.a(a), .y(y_df));
    not_gate_structural u_st (.a(a), .y(y_st));

    initial begin
        $display("Time | a | Dataflow | Structural");
        $monitor("%0t  | %b |    %b     |    %b", $time, a, y_df, y_st);
        
        a = 0; #10;
        a = 1; #10;
        $finish;
    end
endmodule