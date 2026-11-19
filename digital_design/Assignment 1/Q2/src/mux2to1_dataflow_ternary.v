module mux2to1_dataflow_ternary (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output wire y
);
    assign y = sel ? i1 : i0;
endmodule