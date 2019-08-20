module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter idle=2'd0, one=2'd1, two=2'd2, three=2'd3;
    reg	[1:0]	state, next_state;
    
    always@(*) begin
        case({state, x})
            {idle, 1'b0}:	next_state = idle;
            {idle, 1'b1}:	next_state = one;
            {one, 1'b0}:	next_state = two;
            {one, 1'b1}:	next_state = one;
            {two, 1'b0}:	next_state = idle;
            {two, 1'b1}:	next_state = three;
            {three, 1'b0}:	next_state = two;
            {three, 1'b1}:	next_state = one;
        endcase
    end
    
    always@(posedge clk or negedge aresetn) begin
        if(~aresetn)
            state <= idle;
        else
            state <= next_state;
    end
    
    assign	z = (state == two && x == 1'b1);
    
endmodule





/*
module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    reg [1:0] status,next_status;
    parameter READY=0, FIRST=1, SECOND=2;
    always @(*) begin
        case (status)
            READY: begin
                next_status = x ? FIRST : READY;
                z = 0;
            end
            FIRST: begin
                next_status = ~x ? SECOND : FIRST;
                z = 0;
            end
            SECOND: begin
                next_status = x ? FIRST : READY;
                z = x;
            end
        endcase
    end

    always @(posedge clk) begin
        if(~aresetn) begin
            status <= SECOND;
        end
        else begin
            status <= next_status;
        end
    end

endmodule
*/
