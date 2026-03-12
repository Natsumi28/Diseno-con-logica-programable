module suma(
    input clk,
    input rst,
    input start,
    input [3:0] numero,
    
    output reg [6:0] suma
);

reg [3:0] contador;
reg [6:0] acumulador;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        suma <= 0;
        acumulador <= 0;
        contador <= 0;
    end

    else if(start && contador==0)
    begin
        contador <= numero;
        acumulador <= 0;
    end

    else if(contador > 0)
    begin
        acumulador <= acumulador + contador;
        contador <= contador - 1;
    end

    else if(contador == 0)
        suma <= acumulador;
end

endmodule