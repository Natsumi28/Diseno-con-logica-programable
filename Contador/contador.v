module contador #(parameter CMAX=100)(
	input clk,
	input rst,
	input up_down,
	input load,
	input [6:0] data_in,
	output reg [13:0] numero
);

always @(posedge clk or posedge rst)
	begin
		if(rst==1)
			numero <= 0;
		else if(load==1)
			begin
				if(data_in>CMAX)
					numero<=CMAX;
				else
					numero<=data_in;
			end
		else if (up_down==1)
			begin
				if(numero==0)
					numero<=CMAX;
				else
					numero<=numero-1;
			end
		else if(numero == CMAX)
			numero <= 0;
		else
			numero <= numero + 1;
	end

endmodule

