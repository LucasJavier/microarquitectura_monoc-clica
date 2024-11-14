`define generador_dumpfile(nombreArchivo) `"nombreArchivo.vcd`"
`timescale 1ns / 1ps

module rv32i_tb();

    // Señales del testbench
    reg clk;

    // Instancia del procesador rv32i
    rv32i procesador (
        .clk_RV(clk)
    );

    // Generación del reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de reloj de 10 ns
    end

    integer i;

    // Carga de instrucciones en la memoria de instrucciones del procesador
    initial begin
        
        // Inicialización del archivo de salida para la simulación de ondas
        $dumpfile(`generador_dumpfile(`VCD_OUTPUT));
        $dumpvars(0, rv32i_tb);

        // Simulación durante 2000 unidades de tiempo
        #2000;

        $display("Fin de la simulación");
        $finish;
    end

endmodule