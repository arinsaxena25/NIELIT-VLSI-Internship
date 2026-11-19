module bcd_to_excess3 (
    input  wire [3:0] bcd,
    output wire [3:0] excess3
);
    assign excess3 = bcd + 4'b0011;
endmodule