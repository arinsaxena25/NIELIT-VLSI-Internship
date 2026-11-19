module seq_detector_10110 (
    input  wire clk,
    input  wire reset,
    input  wire din,
    output reg  detected
);

    localparam S0 = 3'b000,
               S1 = 3'b001,
               S2 = 3'b010,
               S3 = 3'b011,
               S4 = 3'b100,
               S5 = 3'b101;

    reg [2:0] current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: next_state = din ? S4 : S2;
            S4: next_state = din ? S1 : S5;
            S5: next_state = din ? S3 : S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        detected = (current_state == S5) ? 1'b1 : 1'b0;
    end

endmodule