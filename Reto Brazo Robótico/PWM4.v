module PWM4(
	input clk,
	input reset,
	input [15:0] servo1,
	input [15:0] servo2,
	input [15:0] servo3,
	input [15:0] servo4,
	output PWM1,
	output PWM2,
	output PWM3,
	output PWM4
);

PWM MOTOR1(
	.clk(clk),
	.reset(reset),
	.angulo(servo1),
	.PWM(PWM1)
);

PWM MOTOR2(
	.clk(clk),
	.reset(reset),
	.angulo(servo2),
	.PWM(PWM2)
);

PWM MOTOR3(
	.clk(clk),
	.reset(reset),
	.angulo(servo3),
	.PWM(PWM3)
);

PWM MOTOR4(
	.clk(clk),
	.reset(reset),
	.angulo(servo4),
	.PWM(PWM4)
);

endmodule