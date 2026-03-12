module PWM(
	input clk,
	input reset,
	input [15:0] angulo,
	output reg PWM
);

wire [31:0] valor;
wire [31:0] numero;
wire [6:0] h0, h1, h2;
reg [15:0] limite;

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
		else if(angulo>180)
			limite=180;
		else if(angulo<0)
			limite=0;
		else
			limite=angulo;
		end

always @(posedge clk or posedge reset)
	begin
		if(reset)
			PWM<=0;
		else if(numero<=valor)
			PWM<=1;
		else
			PWM<=0;
	end

endmodule