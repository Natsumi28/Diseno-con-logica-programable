//5Mhz
module clk_divider #(parameter FREQ=5_000_000)(
	input clk, rst,
	output reg clk_div
);

reg [31:0] count;
localparam CLK_FREQ=50_000_000;
localparam ConstantNumber=CLK_FREQ/(2*FREQ);

always @(posedge clk or posedge rst)
	begin
		if(rst==1)
			count<=0;
		else if (count==ConstantNumber-1)
			count<=0;
		else
			count<=count+1;
	end

always @(posedge clk or posedge rst)
	begin
	if(rst==1)
		clk_div<=0;
	else if (count==ConstantNumber-1)
		clk_div<=~clk_div;
	else
		clk_div<=clk_div;
	end

	endmodule