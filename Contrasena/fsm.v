module fsm(
	input MAX10_CLK1_50,
	input [0:0] SW,
	input [0:0] KEY,
	output reg [3:0] LEDR
);

reg [25:0] counter;
reg clk_d;

always @(posedge MAX10_CLK1_50)
	begin
		counter<=counter+1;
		clk_d=counter[25];
	end

parameter S0=0, S1=1, S2=2, S3=3;

reg [1:0] state, next;
wire x=SW[0];
wire reset= ~KEY[0];

//Current state

always @(posedge clk_d or posedge reset)
begin
	if (reset)
		state<=S0;
	else
		state<=next;
end

always @(*)
begin
	case(state)
		S0:
			if(x==1)
				next=S1;
			else
				next=S0;
		S1:
			if(x==0)
				next=S2;
			else
				next=S1;
		S2:
			if(x==1)
				next=S3;
			else
				next=S0;
		S3:
			if(x==1)
				next=S1;
			else
				next=S2;
		default:
			next=S0;
	endcase
end

//Output logic
always @(*)
begin
	LEDR=4'b0000;
	
	case(state)
		S0: LEDR[0]=1;
		S1: LEDR[1]=1;
		S2: LEDR[2]=1;
		S3: LEDR[3]=1;
	endcase
end

endmodule