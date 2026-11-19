module usr_4bit (
    input  wire       clk,
    input  wire       reset,
    input  wire [1:0] select,
    input  wire [3:0] d,
    input  wire       s_in_left,  // Serial input for Shift Left
    input  wire       s_in_right, // Serial input for Shift Right
    output reg  [3:0] q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0000;
        else begin
            case (select)
                2'b00: q <= q;                       // Hold
                2'b01: q <= {s_in_right, q[3:1]};   // Shift Right
                2'b10: q <= {q[2:0], s_in_left};    // Shift Left (2'b10)
                2'b11: q <= d;                       // Parallel Load
                default: q <= q;
            endcase
        end
    end
endmodule