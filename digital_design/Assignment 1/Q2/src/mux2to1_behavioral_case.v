module mux2to1_behavioral_case (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output reg  y
);
    always @(i0, i1, sel) begin
        case (sel)
            1'b0: y = i0;
            1'b1: y = i1;
        endcase
    end
endmodule