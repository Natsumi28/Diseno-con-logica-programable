module addr_counter(
    input clk,
    input reset,
    input load,
    output reg [7:0] addr
);

always @(posedge clk or posedge reset)
begin
    if(reset)
        addr <= 0;
    else if(load)
		begin
			if (addr < 255)
				addr <= addr + 1;
			else
				addr <= 0;
		end
end

endmodule