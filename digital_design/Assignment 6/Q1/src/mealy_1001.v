module mealy_1001 (
    input  wire clk,
    input  wire reset,
    input  wire din,
    output reg  y
);

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    reg [1:0] current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        y = 1'b0;
        next_state = current_state;

        case (current_state)
            S0: begin
                if (din) next_state = S1;
                else     next_state = S0;
            end

            S1: begin
                if (din) next_state = S1;
                else     next_state = S2;
            end

            S2: begin
                if (din) next_state = S1;
                else     next_state = S3;
            end

            S3: begin
                if (din) begin
                    next_state = S1;
                    y = 1'b1;
                end else begin
                    next_state = S0;
                    y = 1'b0;
                end
            end

            default: next_state = S0;
        endcase
    end
endmodule