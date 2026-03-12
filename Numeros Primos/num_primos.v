//num_primos
module num_primos(
	input [3:0] numero,
	output reg led
);

always @(*)
	begin
		case(numero)
			2: led=1;
			3: led=1;
			5: led=1;
			7: led=1;
			11: led=1;
			13: led=1;
			default: led= 0;
		endcase
	end
endmodule