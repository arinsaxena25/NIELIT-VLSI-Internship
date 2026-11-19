module xnor_gate_structural (
    input  wire a,
    input  wire b,
    output wire y
);
    xnor g1 (y, a, b);
endmodule