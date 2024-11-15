`define generador_dumpfile(nombreArchivo) `"nombreArchivo.vcd`"
`timescale 1ns / 1ps

module rv32i_tb();

    // Señales del testbench
    reg clk_tb;
    reg reset_tb;
    wire [31:0] instruccion_tb;

    // Instancia del procesador rv32i
    rv32i procesador (
        .clk_RV(clk_tb),
        .reset(reset_tb),
        .instruccion(instruccion_tb)
    );

    // Generación del reloj
    initial begin
        clk_tb = 0;
        forever #1 clk_tb = ~clk_tb; // Periodo de reloj de 10 ns
    end

    integer i;

    // Carga de instrucciones en la memoria de instrucciones del procesador
    initial begin
        
        // Inicialización del archivo de salida para la simulación de ondas
        $dumpfile(`generador_dumpfile(`VCD_OUTPUT));
        $dumpvars(0, rv32i_tb);


        reset_tb = 1;
        #1
        reset_tb = 0;
        // Simulación durante 2000 unidades de tiempo
        #2000;

        $display("Fin de la simulación");
        $finish;
    end

endmodule