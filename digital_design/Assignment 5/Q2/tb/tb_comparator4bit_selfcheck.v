`timescale 1ns / 1ps

module tb_comparator4bit_selfcheck;
    reg  [3:0] a, b;
    wire gt, eq, lt;

    reg exp_gt, exp_eq, exp_lt;
    integer i, j;
    integer pass_count = 0;
    integer fail_count = 0;

    comparator4bit uut (
        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)
    );

    initial begin
        $dumpfile("comparator.vcd");
        $dumpvars(0, tb_comparator4bit_selfcheck);

        $display("Time | A  B | GT EQ LT | Status");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;
                #10;

                exp_gt = (a > b);
                exp_eq = (a == b);
                exp_lt = (a < b);

                if ((gt == exp_gt) && (eq == exp_eq) && (lt == exp_lt)) begin
                    pass_count = pass_count + 1;
                end else begin
                    $display("%0t  | %d %d | %b  %b  %b  | FAIL", $time, a, b, gt, eq, lt);
                    fail_count = fail_count + 1;
                end
            end
        end

        $display("\n--- SIMULATION RESULT ---");
        $display("TOTAL PASSED: %d / 256", pass_count);
        $display("TOTAL FAILED: %d / 256", fail_count);
        $finish;
    end
endmodule