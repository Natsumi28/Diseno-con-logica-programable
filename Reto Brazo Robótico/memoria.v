module memoria(
    input clk,
    input load,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] mem [0:255];

always @(posedge clk)
begin
    if(load)
        mem[addr] <= data_in;

    data_out <= mem[addr];
end

endmodule