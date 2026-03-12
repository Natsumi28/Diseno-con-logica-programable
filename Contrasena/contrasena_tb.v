module contrasena_tb;

    reg clk;
    reg [3:0] SW;
    reg [1:0] KEY;

    wire [0:6] HEX0, HEX1, HEX2, HEX3;
    wire [6:0] LEDR;

    contrasena DUT (
        .clk(clk),
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .LEDR(LEDR)
    );

    defparam DUT.divisor.FREQ = 25_000_00;

    always #10 clk = ~clk;

	 //Tiempo de simulación= 2*clk*(50MHz/divisor.FREQ)
	 task pulsar_confirmar;
        begin
            $display("  -> Pulsando CONFIRMAR");
            KEY[1] = 0;
            #400;
            KEY[1] = 1;
            #400;
        end
    endtask
	 
	 task pulsar_reset;
        begin
			$display("Aplicando RESET");
        KEY[0] = 0;
        #400;
        KEY[0] = 1;
        $display("RESET liberado");
        #400;
		  end
		endtask

    initial begin
        $display("SIMULACION INICIADA");

        clk = 0;
        SW  = 0;
        KEY = 2'b11;
		  #20;

        pulsar_reset();
        SW = 4'hD;
        $display("Enviando caracter: D");
        pulsar_confirmar();

        SW = 4'hC;
        $display("Enviando caracter: C");
        pulsar_confirmar();
		  
		  SW = 4'h5;
        $display("Enviando caracter erroneo: 5");
        pulsar_confirmar();
		  
		  pulsar_reset();
		  
		  SW = 4'hD;
        $display("Enviando caracter: D");
        pulsar_confirmar();

        SW = 4'hC;
        $display("Enviando caracter: C");
        pulsar_confirmar();

        SW = 4'hB;
        $display("Enviando caracter: B");
        pulsar_confirmar();

        SW = 4'hA;
        $display("Enviando caracter: A");
        pulsar_confirmar();

        $display("Confirmacion final");
        pulsar_confirmar();

        #400;

        if (LEDR[6])
            $display("GOOD");
        else
            $display("ERROR: LEDR %b ", LEDR);

        $display("FIN DE SIMULACION");
        $finish;
    end

endmodule