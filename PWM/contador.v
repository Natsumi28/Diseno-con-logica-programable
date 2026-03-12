module contador #(parameter CMAX=99_999)(
	input clk,
	input rst,
	output reg [31:0] numero
);

always @(posedge clk or posedge rst)
	begin
		if(rst==1)
			numero <= 0;
		else if(numero == CMAX)
			numero <= 0;
		else
			numero <= numero + 1;
	end

endmodule

