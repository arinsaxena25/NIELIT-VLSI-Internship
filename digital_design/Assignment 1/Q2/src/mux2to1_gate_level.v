module mux2to1_gate_level (
    input wire i0,
    input wire i1,
    input wire sel,
    output wire y
);
    wire sel_n, w1, w2;
    not g1 (sel_n, sel);
    and g2 (w1, i0, sel_n);
    and g3 (w2, i1, sel);
    or g4 (y, w1, w2);
endmodule