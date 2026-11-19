module usr_4bit (
    input  wire       clk,
    input  wire       reset,
    input  wire [1:0] mode,
    input  wire [3:0] d_in,
    input  wire       s_in_left,
    input  wire       s_in_right,
    output reg  [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0000;
        else begin
            case (mode)
                2'b00: q <= q;
                2'b01: q <= {s_in_right, q[3:1]};
                2'b10: q <= {q[2:0], s_in_left};
                2'b11: q <= d_in;
                default: q <= q;
            endcase
        end
    end

endmodule