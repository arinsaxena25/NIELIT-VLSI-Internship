module or_gate_structural (
    input  wire a,
    input  wire b,
    output wire y
);
    or g1 (y, a, b);
endmodule