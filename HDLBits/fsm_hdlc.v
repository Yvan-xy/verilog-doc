module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter RECV=0, DISC=1, FLAG=3, ERROR=4;
    reg [2:0]state, next_state;
    reg [3:0] i;

    always @(*) begin
        case (state)
            RECV: begin
                if(i < 6) begin
                    if((i==5)&&(~in)) begin
                        next_state <= DISC;
                    end else begin
                        if(~in) begin
                            next_state <= RECV;
                        end
                    end
                end else if(i==6) begin
                    if(in) begin
                        next_state <= ERROR;
                    end else begin
                        next_state <= FLAG;
                    end
                end
            end
            DISC: next_state <= RECV;
            FLAG: next_state <= RECV;
            ERROR: next_state <= in ? ERROR : RECV;
        endcase
    end

    always @(posedge clk) begin
        if(reset) begin
            state <= RECV;
            i <= 0;
        end else begin
            if(state == ERROR) begin
                i <= 0;
            end else if(state == DISC)begin
                i <= 0;
            end else if(state == FLAG)begin
                i <= 0;
            end else if(state == RECV)begin
                i <= in ? (i + 1) : 0;
            end
            state <= next_state;
        end
    end

    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);

endmodule

