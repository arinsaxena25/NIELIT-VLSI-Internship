module xor_gate_structural (
    input  wire a,
    input  wire b,
    output wire y
);
    xor g1 (y, a, b);
endmodule