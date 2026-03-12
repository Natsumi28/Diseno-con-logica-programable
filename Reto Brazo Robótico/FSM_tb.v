`timescale 1ns/1ps

module FSM_tb;

reg clk;
reg rst;
reg manual;
reg cargar;
reg reproducir;
reg load;

wire GSENSOR_CS_N;
wire [2:1] GSENSOR_INT;
wire GSENSOR_SCLK;
wire GSENSOR_SDI;
wire GSENSOR_SDO;

wire [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
wire [3:0] PWM1,PWM2,PWM3,PWM4;

FSM DUT(
    .clk(clk),
    .rst(rst),
    .manual(manual),
    .cargar(cargar),
    .reproducir(reproducir),
    .load(load),

    .GSENSOR_CS_N(GSENSOR_CS_N),
    .GSENSOR_INT(GSENSOR_INT),
    .GSENSOR_SCLK(GSENSOR_SCLK),
    .GSENSOR_SDI(GSENSOR_SDI),
    .GSENSOR_SDO(GSENSOR_SDO),

    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5),

    .PWM1(PWM1),
    .PWM2(PWM2),
    .PWM3(PWM3),
    .PWM4(PWM4)
);

initial clk=0;
always #10 clk=~clk;   // 50MHz equivalente

initial
begin
    force DUT.reloj = clk;   // evita esperar al divisor real
end

initial
begin

    rst=1;
    manual=0;
    cargar=0;
    reproducir=0;
    load=0;

    #50
    rst=0;

    // ======================
    // MODO CARGA
    // ======================

    cargar=1;

    // PRIMER ANGULO
    force DUT.servo_x = 10;
    force DUT.servo_y = 20;
    force DUT.servo_z = 30;
	 
	 
	#50;
    load=1;
    #40;
    load=0;
    #100;

    // SEGUNDO ANGULO
    force DUT.servo_x = 40;
    force DUT.servo_y = 50;
    force DUT.servo_z = 60;
	
	#50;
    load=1;
    #40;
    load=0;
    #100;

    // TERCER ANGULO
    force DUT.servo_x = 70;
    force DUT.servo_y = 80;
    force DUT.servo_z = 90;

	 	#50;

    load=1;
    #40;
    load=0;

    #200;

    release DUT.servo_x;
    release DUT.servo_y;
    release DUT.servo_z;

    // ======================
    // MODO REPRODUCIR
    // ======================

    cargar=0;
    reproducir=1;

    #105500;

    $stop;

end

endmodule