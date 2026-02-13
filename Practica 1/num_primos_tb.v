//num_primos_tb
module num_primos_tb();
	reg [3:0] numero;
	wire led;

num_primos DUT(.numero(numero), .led(led));

initial
	begin
		$display("simulacion iniciada");
		numero=0;
		#10
		numero=1;
		#10
		numero=2;
		#10
		numero=3;
		#10
		numero=4;
		#10
		numero=5;
		#10
		numero=6;
		#10
		numero=7;
		#10
		numero=8;
		#10
		numero=9;
		#10
		numero=10;
		#10
		numero=11;
		#10
		numero=12;
		#10
		numero=13;
		#10
		numero=14;
		#10
		numero=15;
		#10
		$display("simulacion terminada");
		$stop;
		$finish;
	end
endmodule
		
		