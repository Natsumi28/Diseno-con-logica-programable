module BCD_module(
	input [3:0] bcd_in,
	output reg [0:6] bcd_out);

always @(*)
	begin
		case(bcd_in)
			0: bcd_out=~7'b 1111_110;
			1: bcd_out=~7'b 0110_000;
			2: bcd_out=~7'b 1101_101;
			3: bcd_out=~7'b 1111_001;
			4: bcd_out=~7'b 0110_011;
			5: bcd_out=~7'b 1011_011;
			6: bcd_out=~7'b 1011_111;
			7: bcd_out=~7'b 1110_000;
			8: bcd_out=~7'b 1111_111;
			9: bcd_out=~7'b 1111_011;
			/*
			10: bcd_out=~7'b 1110_111;
			11: bcd_out=~7'b 0011_111;
			12: bcd_out=~7'b 1001_110;
			13: bcd_out=~7'b 0111_101;
			14: bcd_out=~7'b 1001_111;
			15: bcd_out=~7'b 1000_111;
			*/
			default: bcd_out = ~7'b 0000_000;
		endcase
	end
endmodule