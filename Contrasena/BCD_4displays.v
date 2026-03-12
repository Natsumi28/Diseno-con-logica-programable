module BCD_4displays(
	input [15:0] bcd_in,
	output [0:6] D_un, D_de, D_ce, D_mil
);

wire [3:0] unidades, decenas, centenas, millares;

assign unidades=bcd_in[3:0];
assign decenas=bcd_in[7:4];
assign centenas=bcd_in[11:8];
assign millares=bcd_in[15:12];

BCD_module Uni(
	.bcd_in(unidades),
	.bcd_out(D_un)
);

BCD_module Dec(
	.bcd_in(decenas),
	.bcd_out(D_de)
);

BCD_module Cen(
	.bcd_in(centenas),
	.bcd_out(D_ce)
);

BCD_module Mil(
	.bcd_in(millares),
	.bcd_out(D_mil)
);

endmodule