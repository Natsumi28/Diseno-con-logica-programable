module PWM_w(
	input [9:0] SW,
	input MAX10_CLK1_50,
	input [1:0] KEY,
	output [14:0] ARDUINO_IO,
	output [0:6] HEX0, HEX1, HEX2
);

wire reloj;

clk_divider divisor(
	.clk(MAX10_CLK1_50), 
	.rst(~KEY[0]),
	.clk_div(reloj)
);

PWM servo(
	.clk(reloj),
	.reset(~KEY[0]),
	.SW(SW[7:0]),
	.PWM(ARDUINO_IO[0]),
	.HEX0(HEX0), 
	.HEX1(HEX1), 
	.HEX2(HEX2)
);

endmodule