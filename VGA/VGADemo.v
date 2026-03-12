module VGADemo(
	input MAX10_CLK1_50,
	output reg [2:0] pixel, // pixeles
	output hsync_out, // horizontal
	output vsync_out // vertical
);

wire inDisplayArea;
wire [9:0] CounterX;
wire [9:0] CounterY;

//Clock enable 25MHz
reg pixel_tick = 0;

always@(posedge MAX10_CLK1_50)
	pixel_tick <= ~pixel_tick;
	
hvsync_generator hvsync(
	.clk(MAX10_CLK1_50),
	.pixel_tick(pixel_tick),
	.vga_h_sync(hsync_out),
	.vga_v_sync(vsync_out),
	.CounterX(CounterX),
	.CounterY(CounterY),
	.inDisplayArea(inDisplayArea)
);

always@(posedge MAX10_CLK1_50)
	begin
		if(inDisplayArea)
			begin
			if(CounterX[5] ^ CounterY[5])
					pixel <= 3'b111;
			else
					pixel <= 3'b000;
			end
		else
			pixel <= 3'b000;
	end
	
endmodule