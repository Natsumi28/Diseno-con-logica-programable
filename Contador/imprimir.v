module imprimir(
	input clk,
	input rst,
	input up_down,
	input load,
	input [6:0] data_in,
	output [0:6] D_un,
	output [0:6] D_de,
	output [0:6] D_ce,
	output [0:6] D_mil
);

wire reloj;
wire [13:0] numero;

clk_divider DIV(
	.clk(clk),
	.rst(rst),
	.clk_div(reloj)
);

contador CONT(
	.clk(reloj),
	.rst(rst),
	.numero(numero),
	.up_down(up_down),
	.load(load),
	.data_in(data_in)
);

BCD_4displays DISP(
	.bcd_in(numero),
	.D_un(D_un),
	.D_de(D_de),
	.D_ce(D_ce),
	.D_mil(D_mil)
);

endmodule
