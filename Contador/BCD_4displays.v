module BCD_4displays #(parameter N_in=10, N_out=7)(
	input [N_in-1:0] bcd_in,
	output [0:N_out-1] D_un, D_de, D_ce, D_mil
);

wire [3:0] unidades, decenas, centenas, millares;

assign unidades=bcd_in%10;
assign decenas=(bcd_in/10)%10;
assign centenas=(bcd_in/100)%10;
assign millares=(bcd_in/1000)%10;

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