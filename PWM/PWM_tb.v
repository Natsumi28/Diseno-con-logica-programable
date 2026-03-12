module PWM_tb();

reg clk;
reg reset;
reg [7:0] SW;
wire PWM;
wire [0:6] HEX0, HEX1, HEX2;

PWM DUT(
	.clk(clk),
	.reset(reset),
	.SW(SW),
	.PWM(PWM),
	.HEX0(HEX0), 
	.HEX1(HEX1), 
	.HEX2(HEX2)
);

always #5 clk= ~clk;

initial begin
	$display("Iniciando simulación");
	clk=0;
	reset=0;
	SW=0;
	
	#10;
	
	$display("Activando reset");
	reset=1;
	#10;
	$display("Desactivando reset");
	reset=0;
	#10;
	
	$display("Cambiando ángulo del servo");
	$display("Ángulo: 180");
	SW=180;
	#10;
	$display("Ángulo: 90");
	SW=90;
	#10;
	$display("Ángulo: 64");
	SW=64;
	#10;
	
	$display("Activando reset");
	reset=1;
	#10;
	$display("Desactivando reset");
	reset=0;
	#10;
	
	$stop;
	$finish;
	end
endmodule
	