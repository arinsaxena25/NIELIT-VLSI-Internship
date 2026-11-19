module alu_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] alu_control,
    output reg  [7:0] alu_out,
    output reg        zero_flag
);
    always @(*) begin
        case (alu_control)
            3'b000: alu_out = a + b;
            3'b001: alu_out = a - b;
            3'b010: alu_out = a & b;
            3'b011: alu_out = a | b;
            3'b100: alu_out = a ^ b;
            3'b101: alu_out = a << 1;
            3'b110: alu_out = a >> 1;
            default: alu_out = 8'h00;
        endcase
        zero_flag = (alu_out == 8'h00) ? 1'b1 : 1'b0;
    end
endmodule