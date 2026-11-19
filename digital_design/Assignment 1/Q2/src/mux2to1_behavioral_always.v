module mux2to1_behavioral_always (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output reg  y
);
    always @(i0, i1, sel)
        y = sel ? i1 : i0;
endmodule