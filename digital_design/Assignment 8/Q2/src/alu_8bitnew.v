module alu_8bitnew (
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [2:0] opcode,
    output reg [7:0] result,
    output reg carry_out,
    output reg zero_flag
);

    always @(*) begin
        carry_out = 1'b0;
        case (opcode)
            3'b000: {carry_out, result} = a + b;         // ADD with carry
            3'b001: result = a - b;                      // SUB
            3'b010: result = a & b;                      // AND
            3'b011: result = a | b;                      // OR
            3'b100: result = a ^ b;                      // XOR
            3'b101: result = ~(a | b);                   // NOR
            3'b110: result = (a < b) ? 8'b1 : 8'b0;        // SLT (Set Less Than)
            3'b111: result = a << 1;                     // Shift Left
            default: result = 8'h00;
        endcase
        
        zero_flag = (result == 8'h00) ? 1'b1 : 1'b0;
    end

endmodule