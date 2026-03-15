module BCD_4displays_w(
	input [9:0] SW,
	output [0:6] HEX0, HEX1, HEX2, HEX3
);

BCD_4displays mostrar(
	.bcd_in(SW[9:0]),
	.D_un(HEX0),
	.D_de(HEX1),
	.D_ce(HEX2),
	.D_mil(HEX3)
);

endmodule