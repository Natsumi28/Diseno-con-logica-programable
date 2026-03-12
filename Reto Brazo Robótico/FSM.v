module FSM(
	input clk,
	input rst,
	input manual,
	input cargar,
	input reproducir,
	input load,
	
	output GSENSOR_CS_N,
   input [2:1] GSENSOR_INT,
   output GSENSOR_SCLK,
   inout GSENSOR_SDI,
   inout GSENSOR_SDO,

	output [7:0] HEX0,
   output [7:0] HEX1,
   output [7:0] HEX2,
   output [7:0] HEX3,
   output [7:0] HEX4,
   output [7:0] HEX5,

   output [3:0] PWM1, PWM2, PWM3, PWM4,
	
	output hsync_out,
   output vsync_out,
   output reg [2:0] vga_rgb
);

reg [1:0] state, next;
parameter IDLE=0, MANUAL=1, CARGA=2, REPRODUCIR=3;

reg signed [7:0] servo_x;
reg signed [7:0] servo_y;
reg signed [7:0] servo_z;

wire signed [15:0] accel_x;
wire signed [15:0] accel_y;
wire signed [15:0] accel_z;

wire [7:0] mem_x_out;
wire [7:0] mem_y_out;
wire [7:0] mem_z_out;

wire [7:0] addr;
wire write_enable;
wire write_enable2;

assign write_enable = load && (state == CARGA);
assign write_enable2 =(state == REPRODUCIR);

wire addr_enable;
assign addr_enable = write_enable || write_enable2;

accel accel_inst(

    .MAX10_CLK1_50(clk),
    .KEY({1'b1,~rst}),

    .GSENSOR_CS_N(GSENSOR_CS_N),
    .GSENSOR_INT(GSENSOR_INT),
    .GSENSOR_SCLK(GSENSOR_SCLK),
    .GSENSOR_SDI(GSENSOR_SDI),
    .GSENSOR_SDO(GSENSOR_SDO),

    .accel_x(accel_x),
    .accel_y(accel_y),
    .accel_z(accel_z),
	 
	 .HEX0(HEX0),
	 .HEX1(HEX1),
	 .HEX2(HEX2),
	 .HEX3(HEX3),
	 .HEX4(HEX4),
	 .HEX5(HEX5)
);

wire reloj;

wire reloj2;

clk_divider #(.FREQ(50)) divisor(
	.clk(clk), 
	.rst(rst),
	.clk_div(reloj)
);

clk_divider divisor2(
	.clk(clk), 
	.rst(rst),
	.clk_div(reloj2)
);


always @(posedge clk or posedge rst)
	begin
		if(rst)
			state<=IDLE;
		else
			state<=next;
	end

always @(*)
	begin
		case(state)
			IDLE:
				begin
					if(manual && !cargar && !reproducir)
						next=MANUAL;
					else if(cargar && !manual && !reproducir)
						next=CARGA;
					else if(reproducir && !manual && !cargar)
						next=REPRODUCIR;
					else
						next=IDLE;
				end
			MANUAL:
				begin
					if(cargar && !manual && !reproducir)
						next=CARGA;
					else if(reproducir && !manual && !cargar)
						next=REPRODUCIR;
					else if(!reproducir && !manual && !cargar)
						next=IDLE;
					else
						next=MANUAL;
					end
			CARGA:
				begin
					if(!cargar && manual && !reproducir)
						next=MANUAL;
					else if(reproducir && !manual && !cargar)
						next=REPRODUCIR;
					else if(!reproducir && !manual && !cargar)
						next=IDLE;
					else
						next=CARGA;
					end
			REPRODUCIR:
				begin
					if(!cargar && manual && !reproducir)
						next=MANUAL;
					else if(!reproducir && !manual && cargar)
						next=CARGA;
					else if(!reproducir && !manual && !cargar)
						next=IDLE;
					else
						next=REPRODUCIR;
					end
			default:
				next=IDLE;
		endcase
	end

always @(*)
begin
	if(rst)
	begin
		servo_x=0;
		servo_y=0;
		servo_z=0;
	end
	else
		begin
		case(state)
			IDLE:
				begin
					servo_x=0;
					servo_y=0;
					servo_z=0;
					
				end
			
			MANUAL:
				begin
					servo_x = ((accel_x + 256) * 45)/128;
					servo_y = ((accel_y + 256) * 45)/128;
					servo_z = ((accel_z + 256) * 45)/128;
				end
			CARGA:
				begin
					servo_x = ((accel_x + 256) * 45)/128;
					servo_y = ((accel_y + 256) * 45)/128;
					servo_z = ((accel_z + 256) * 45)/128;
				end
			REPRODUCIR:
				begin
					servo_x = mem_x_out;
					servo_y = mem_y_out;
					servo_z = mem_z_out;
				end
		endcase
		end
	end	

memoria memx(
    .clk(reloj),
    .load(write_enable),
    .addr(addr),
    .data_in(servo_x),
    .data_out(mem_x_out)
);

memoria memy(
    .clk(reloj),
    .load(write_enable),
    .addr(addr),
    .data_in(servo_y),
    .data_out(mem_y_out)
);

memoria memz(
    .clk(reloj),
    .load(write_enable),
    .addr(addr),
    .data_in(servo_z),
    .data_out(mem_z_out)
);

addr_counter contador(
    .clk(reloj),
    .reset(rst),
    .load(addr_enable),
    .addr(addr)
);

PWM4 pwm_inst(

   .clk(reloj2),
   .reset(rst),

   .servo1(servo_x),
   .servo2(servo_y),
   .servo3(servo_y),
   .servo4(servo_z),

   .PWM1(PWM1),
	.PWM2(PWM2),
	.PWM3(PWM3),
	.PWM4(PWM4)
);

//VGA

reg reloj_vga = 0;
always @(posedge clk) begin
    reloj_vga <= ~reloj_vga;
end

wire [9:0] CounterX, CounterY;
wire inDisplayArea;
reg [7:0] ascii;
wire [7:0] servo_x_abs = (servo_x < 0) ? -servo_x : servo_x;
wire [7:0] servo_y_abs = (servo_y < 0) ? -servo_y : servo_y;
wire [7:0] servo_z_abs = (servo_z < 0) ? -servo_z : servo_z;

hvsync_generator hvsync(
    .clk(reloj_vga),
    .pixel_tick(1'b1),
    .vga_h_sync(hsync_out),
    .vga_v_sync(vsync_out),
    .inDisplayArea(inDisplayArea),
    .CounterX(CounterX),
    .CounterY(CounterY)
);

wire [6:0] char_col = CounterX[9:3];
wire [5:0] char_row = CounterY[9:4];

always @(*) begin
    ascii = 8'h20;
    
    if (char_row == 2) begin
        case (char_col)
            10: ascii = "X";
            11: ascii = ":";
            12: ascii = 8'h30 + (servo_x_abs / 100);
            13: ascii = 8'h30 + ((servo_x_abs / 10) % 10);
            14: ascii = 8'h30 + (servo_x_abs % 10);
        endcase
    end
    
    else if (char_row == 3) begin
        case (char_col)
            10: ascii = "Y";
            11: ascii = ":";
            12: ascii = 8'h30 + (servo_y_abs / 100);
            13: ascii = 8'h30 + ((servo_y_abs / 10) % 10);
            14: ascii = 8'h30 + (servo_y_abs % 10);
        endcase
    end

    else if (char_row == 4) begin
        case (char_col)
            10: ascii = "Z";
            11: ascii = ":";
            12: ascii = 8'h30 + (servo_z_abs / 100);
            13: ascii = 8'h30 + ((servo_z_abs / 10) % 10);
            14: ascii = 8'h30 + (servo_z_abs % 10);
        endcase
    end

    else if (char_row == 6) begin
        if (char_col >= 10 && char_col <= 20) begin
            case (state)
                IDLE: begin
                    case(char_col)
                        10: ascii="I"; 11: ascii="D"; 12: ascii="L"; 13: ascii="E";
                    endcase
                end
                MANUAL: begin
                    case(char_col)
                        10: ascii="M"; 11: ascii="A"; 12: ascii="N"; 13: ascii="U"; 14: ascii="A"; 15: ascii="L";
                    endcase
                end
                CARGA: begin
                    case(char_col)
                        10: ascii="C"; 11: ascii="A"; 12: ascii="R"; 13: ascii="G"; 14: ascii="A";
                    endcase
                end
                REPRODUCIR: begin
                    case(char_col)
                        10: ascii="R"; 11: ascii="E"; 12: ascii="P"; 13: ascii="R"; 14: ascii="O"; 15: ascii="D"; 16: ascii="U"; 17: ascii="C"; 18: ascii="I"; 19: ascii="R";
                    endcase
                end
            endcase
        end
    end
end

wire [3:0] row_addr = CounterY[3:0];
wire [2:0] col_addr = CounterX[2:0];
wire [10:0] rom_addr = {ascii[6:0], row_addr};
wire [7:0] font_data;

font_rom rom_inst(
    .addr(rom_addr),
    .data(font_data)
);

wire pixel_on = font_data[7 - col_addr];

always @(posedge clk) begin
    if (reloj_vga) begin
        if (inDisplayArea && pixel_on)
            vga_rgb <= 3'b111;
        else
            vga_rgb <= 3'b000;
    end
end

endmodule
		