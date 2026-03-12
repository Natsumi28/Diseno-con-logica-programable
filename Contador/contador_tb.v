module contador_tb();

reg clk;
reg rst;
reg up_down;
reg load;
reg [6:0] data_in;
wire [13:0] numero;

contador DUT(
	.clk(clk),
	.rst(rst),
	.up_down(up_down),
	.load(load),
	.data_in(data_in),
	.numero(numero)
);

always #5 clk= ~clk;

initial begin
	clk=0;
	rst=0;
	up_down=0;
	load=0;
	data_in=0;
	
	rst = 1;
	#5;
	rst = 0;
	
	#1100;
	$display("Activando reset");
	rst=1;
	#50;
	$display("Desactivando reset");
	rst=0;
	
	#500;
	
	$display("Activando up down");
	up_down=1;
	#1100;
	$display("Desactivando up down");
	up_down=0;
	#500;
	
	$display("Activando load");
	load=1;
	#50;
	$display("Ingresando 37");
	data_in=37;
	#50;
	$display("Desactivando load");
	load=0;
	#1000;
	
	$display("Activando load");
	load=1;
	#50;
	$display("Ingresando 61");
	data_in=61;
	#50;
	$display("Activando up down");
	up_down=1;
	#50;
	$display("Activando reset");
	rst=1;
	#50;
	$display("Desactivando reset");
	rst=0;
	#50;
	$display("Desactivando load");
	load=0;
	#1000;
	
	$stop;
	$finish;
	end
endmodule
	
	