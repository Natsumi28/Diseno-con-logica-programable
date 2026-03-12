module UART_Rx_w #(parameter BAUD_RATE = 9600, parameter CLOCK_FREQ = 50000000,BITS = 8)(
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [15:0] ARDUINO_IO,
    output [0:6] HEX0, HEX1, HEX2,
    output [9:0] LEDR
);

wire [BITS-1:0] num;

UART_Rx #(
    .BAUD_RATE(BAUD_RATE),
    .CLOCK_FREQ(CLOCK_FREQ),
	 .BITS(BITS)
) UART_RX (
    .clk(MAX10_CLK1_50),
    .rst(~KEY[0]),
    .rx_in(ARDUINO_IO[0]),
    .data_out(num),
	 .data_ready(LEDR[0])
);


BCD_4displays #(
	.N_in(8),
	.N_out(7)
) BCD (
	.bcd_in(num),
	.D_un(HEX0),
	.D_de(HEX1),
	.D_ce(HEX2)
);


endmodule