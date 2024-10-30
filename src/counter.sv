module counter(
 input logic clk,
 input logic reset,
 input logic areset,
 output logic signal
);
logic [5:0]count;

always_ff@(posedge clk )begin
    if(areset || (reset && count<19))
        begin
            count = 0;
            signal =  0;
         end
    else if (~reset && count <19) begin
        count++;
        signal = 0;
     end else if(~reset && count >=19) begin
        count = 0;
        signal = 1;
     end else
        signal = 1;
end
endmodule