module brazo_robot_w(
	input MAX10_CLK1_50,
	input [1:0] KEY,
	input [2:0] SW,
	
	output GSENSOR_CS_N,
   input [2:1] GSENSOR_INT,
   output GSENSOR_SCLK,
   inout GSENSOR_SDI,
   inout GSENSOR_SDO,
	
	output [3:0] ARDUINO_IO,
	output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	
	output VGA_HS,
   output VGA_VS,
	
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
);

wire [2:0] vga_rgb;

assign VGA_R = {4{vga_rgb[2]}};
assign VGA_G = {4{vga_rgb[1]}};
assign VGA_B = {4{vga_rgb[0]}};

FSM brazo(
	.clk(MAX10_CLK1_50),
	.rst(~KEY[0]),
	.manual(SW[0]),
	.cargar(SW[1]),
	.reproducir(SW[2]),
	.load(~KEY[1]),
	
	.GSENSOR_CS_N(GSENSOR_CS_N),
   .GSENSOR_INT(GSENSOR_INT),
   .GSENSOR_SCLK(GSENSOR_SCLK),
   .GSENSOR_SDI(GSENSOR_SDI),
   .GSENSOR_SDO(GSENSOR_SDO),

	.HEX0(HEX0),
	.HEX1(HEX1),
	.HEX2(HEX2),
	.HEX3(HEX3),
	.HEX4(HEX4),
	.HEX5(HEX5),
	
   .PWM1(ARDUINO_IO[0]),
   .PWM2(ARDUINO_IO[1]),
   .PWM3(ARDUINO_IO[2]),
   .PWM4(ARDUINO_IO[3]),
	
	.hsync_out(VGA_HS),
   .vsync_out(VGA_VS),

   .vga_rgb(vga_rgb)
);

endmodule	