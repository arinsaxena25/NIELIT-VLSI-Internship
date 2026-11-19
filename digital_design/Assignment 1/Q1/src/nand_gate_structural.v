module nand_gate_structural (
    input  wire a,
    input  wire b,
    output wire y
);
    nand g1 (y, a, b);
endmodule