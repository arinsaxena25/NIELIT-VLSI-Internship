module not_gate_dataflow (
    input  wire a,
    output wire y
);
    assign y = ~a;
endmodule