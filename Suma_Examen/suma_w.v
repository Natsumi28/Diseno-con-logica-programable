module suma_w(
	input MAX10_CLK1_50,
	input [9:0] SW,
	output reg [0:6] HEX0, HEX1, HEX2, HEX4, HEX5
);

wire [6:0] suma;
wire [6:0] h0, h1, h2, h4, h5;

suma sumatop(
	.clk(MAX10_CLK1_50),
	.rst(SW[0]),
	.start(~SW[1]),
	.numero(SW[9:6]),
	.suma(suma)
);

BCD_4displays dispin(
	.bcd_in(SW[9:6]),
	.D_un(h4),
	.D_de(h5)
);

BCD_4displays dispout(
	.bcd_in(suma),
	.D_un(h0),
	.D_de(h1),
	.D_ce(h2)
);


always @(*)
	begin
		HEX0=h0;
		HEX1=h1;
		HEX2=h2;
		HEX4=h4;
		HEX5=h5;
	end
	
endmodule