module up_down_counter_async (
    input  wire       clk,
    input  wire       reset,
    input  wire       up_down,
    output reg  [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else if (up_down)
            count <= count + 1;
        else
            count <= count - 1;
    end
endmodule