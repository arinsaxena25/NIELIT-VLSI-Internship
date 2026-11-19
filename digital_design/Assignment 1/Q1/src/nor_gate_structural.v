module nor_gate_structural (
    input  wire a,
    input  wire b,
    output wire y
);
    nor g1 (y, a, b);
endmodule