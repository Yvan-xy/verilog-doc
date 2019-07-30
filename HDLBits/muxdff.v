module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    wire out1;
    always @(*) begin
        case (L)
            1'b0: begin
                out1 <= q_in;
            end
            1'b1: begin
                out1 <= r_in;
            end
        endcase
    end
    always @(posedge clk) begin
        Q <= out1;
    end
endmodule
