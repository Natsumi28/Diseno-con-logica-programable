module contrasena(
	input clk,
	input [3:0] SW,
	input [1:0] KEY,
	output reg[0:6] HEX0, HEX1, HEX2, HEX3,
	output reg[6:0] LEDR
);

wire clk_div;
wire [6:0] h0, h1, h2, h3;
parameter [15:0] password=16'hABCD;
reg [15:0] numero;

parameter IDLE=0, S1=1, S2=2, S3=3, S4=4, BAD=5, GOOD=6;

reg [2:0] state, next;
wire [3:0] x=SW[3:0];
wire reset= ~KEY[0];
wire confirmar= ~KEY[1];

clk_divider divisor(
	.clk(clk),
	.rst(reset),
	.clk_div(clk_div)
);

always @(posedge clk_div or posedge reset)
begin
	if (reset)
		state<=IDLE;
	else
		state<=next;
end

always @(*) 
begin
    LEDR = 7'b0000000;

    case(state)
        IDLE: LEDR[0] = 1;
        S1:   LEDR[1] = 1;
        S2:   LEDR[2] = 1;
        S3:   LEDR[3] = 1;
        S4:   LEDR[4] = 1;
		  BAD:  LEDR[5] = 1;
        GOOD: LEDR[6] = 1;
        default: LEDR[6:0] = 7'b0000000;
    endcase
end


always @(*)
begin
	case(state)
		IDLE:
			begin
			if(confirmar && x==password[3:0])
				next=S1;
			else if (confirmar)
				next=BAD;
			else
				next=state;
			end
		S1:
			begin
			if(confirmar && x==password[7:4])
				next=S2;
			else if (confirmar)
				next=BAD;
			else
				next=state;
			end
		S2:
			begin
			if(confirmar && x==password[11:8])
				next=S3;
			else if (confirmar)
				next=BAD;
			else
				next=state;
			end
		S3:
			begin
			if(confirmar && x==password[15:12])
				next=S4;
			else if (confirmar)
				next=BAD;
			else
				next=state;
			end
		S4:
			if(confirmar)
				next=GOOD;
			else
				next=S4;
		BAD:
			next=BAD;
		GOOD:
			next=GOOD;
		default:
			next=IDLE;
	endcase
end

always @(posedge clk_div or posedge reset)
begin
	if(reset)
		numero<=0;
	else if(confirmar)
		begin
		case(state)
			IDLE: numero[3:0]<= x;
			S1: numero[7:4]<= x;
			S2: numero[11:8]<= x;
			S3: numero[15:12]<= x;
		endcase
		end
	end


BCD_4displays resultado(
	.bcd_in(numero),
	.D_un(h0), 
	.D_de(h1), 
	.D_ce(h2), 
	.D_mil(h3)
);

always @(*)
begin
	case(state)
		BAD:
			begin
				HEX0=~7'b 0111_101;
				HEX1=~7'b 1110_111;
				HEX2=~7'b 0011_111;
				HEX3=~7'b 0000_000;
			end
		GOOD:
			begin
				HEX0=~7'b 0111_101;
				HEX1=~7'b 1111_110;
				HEX2=~7'b 1111_110;
				HEX3=~7'b 1011_111;
			end
		default:
			begin
				HEX0=h0;
				HEX1=h1;
				HEX2=h2;
				HEX3=h3;
			end
	endcase
end

endmodule