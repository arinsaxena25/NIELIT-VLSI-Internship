module mux2to1_behavioral_ifelse (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output reg  y
);
    always @(i0, i1, sel) begin
        if (sel)
            y = i1;
        else
            y = i0;
    end
endmodule