module BCD_module(
	input [3:0] bcd_in,
	output reg [0:6] bcd_out);

always @(*)
	begin
		case(bcd_in)
			4'h0: bcd_out=~7'b 1111_110;
			4'h1: bcd_out=~7'b 0110_000;
			4'h2: bcd_out=~7'b 1101_101;
			4'h3: bcd_out=~7'b 1111_001;
			4'h4: bcd_out=~7'b 0110_011;
			4'h5: bcd_out=~7'b 1011_011;
			4'h6: bcd_out=~7'b 1011_111;
			4'h7: bcd_out=~7'b 1110_000;
			4'h8: bcd_out=~7'b 1111_111;
			4'h9: bcd_out=~7'b 1111_011;
			4'hA: bcd_out=~7'b 1110_111;
			4'hB: bcd_out=~7'b 0011_111;
			4'hC: bcd_out=~7'b 1001_110;
			4'hD: bcd_out=~7'b 0111_101;
			4'hE: bcd_out=~7'b 1001_111;
			4'hF: bcd_out=~7'b 1000_111;
			
			default: bcd_out = ~7'b 0000_000;
		endcase
	end
endmodule