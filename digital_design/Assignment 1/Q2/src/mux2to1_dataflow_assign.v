module mux2to1_dataflow_assign (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output wire y
);
    assign y = (~sel & i0) | (sel & i1);
endmodule