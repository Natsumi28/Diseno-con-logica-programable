module BCD_4displays_tb();
	
	parameter N_in=10;
	parameter N_out=7;
	
	reg [N_in-1:0] bcd_in;
	wire [N_out-1:0] D_un, D_de, D_ce, D_mil;

BCD_4displays DUT(.bcd_in(bcd_in), .D_un(D_un), .D_de(D_de), .D_ce(D_ce), .D_mil(D_mil));

initial
	begin
		bcd_in=13;
		#10;
		bcd_in=1023;
		#10;
		bcd_in=455;
		#10;
	end
endmodule