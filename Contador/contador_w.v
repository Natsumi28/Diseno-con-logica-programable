module contador_w(
	input  [9:0] SW,
	input        MAX10_CLK1_50,
	input [1:0] KEY,
	output [0:6] HEX0,
	output [0:6] HEX1,
	output [0:6] HEX2,
	output [0:6] HEX3
);

wire [0:6] D_un, D_de, D_ce, D_mil;

imprimir TOP(
	.clk(MAX10_CLK1_50),
	.rst(~KEY[0]),
	.up_down(SW[0]),
	.load(SW[1]),
	.data_in(SW[8:2]),
	.D_un(D_un),
	.D_de(D_de),
	.D_ce(D_ce),
	.D_mil(D_mil)
);

// concatenación al orden del display físico
assign HEX0 = {1'b1, D_un};
assign HEX1 = {1'b1, D_de};
assign HEX2 = {1'b1, D_ce};
assign HEX3 = {1'b1, D_mil};

endmodule
