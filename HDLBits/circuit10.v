module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    always @(posedge clk) begin
        q <= a;
        state <= a|b;
    end
endmodule

