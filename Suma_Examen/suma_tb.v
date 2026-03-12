 module suma_tb();

reg clk, rst, start;
reg [3:0] numero;
wire [6:0] suma;

suma DUT(
    .clk(clk),
    .rst(rst),
    .start(start),
    .numero(numero),
    .suma(suma)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    start = 0;
    numero = 0;

    #20;
    rst = 0;

    // prueba 1
    numero = 13;
    #10;
    start = 1;
    #10;
    start = 0;

    #200;

    // prueba 2
    numero = 15;
    #10;
    start = 1;
    #10;
    start = 0;

    #200;

    $stop;
end

endmodule