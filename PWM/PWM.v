module PWM(
	input clk,
	input reset,
	input [7:0] SW,
	output reg PWM,
	output reg [0:6] HEX0, HEX1, HEX2
);

wire [31:0] valor;
wire [31:0] numero;
wire [6:0] h0, h1, h2;
reg [7:0] limite;

assign valor= ((500*limite)/9) + 2500;

contador cuenta(
	.clk(clk),
	.rst(reset),
	.numero(numero)
);

always @(posedge clk or posedge reset)
	begin
		if(reset)
			limite=0;
		else if(SW>180)
			limite=180;
		else
			limite=SW;
		end

BCD_4displays resultado(
	.bcd_in(limite),
	.D_un(h0), 
	.D_de(h1), 
	.D_ce(h2)
);

always @(posedge clk or posedge reset)
	begin
		if(reset)
			PWM<=0;
		else if(numero<=valor)
			PWM<=1;
		else
			PWM<=0;
	end

always @(*)
	begin
		HEX0=h0;
		HEX1=h1;
		HEX2=h2;
	end

endmodule