`include "../Componentes/decodificador_alu.v"
`include "../Componentes/decodificador_principal.v"
`include "../Componentes/descomponer_instruccion.v"

module UC(
    input [6:0] op_UC,
    input [2:0] f3_UC,
    input f7_UC,
    input zero,
    output reg [9:0] salUC
);

    wire pcSrc_UC; // Nos indica de que fuente viene el contador del programa (PC)
    wire [1:0] resSrc_UC;
    wire memWrite_UC;
    wire [1:0] aluOP_UC;
    wire aluSrc_UC;
    wire [1:0] inmSrc_UC;
    wire regWrite_UC;
    wire [2:0] aluControl_UC;

    mainDeco mainDecoder(
        .op(op_UC), 
        .branch(pcSrc_UC),
        .resSrc(resSrc_UC), 
        .memWrite(memWrite_UC),
        .aluSrc(aluSrc_UC), 
        .inmSrc(inmSrc_UC), 
        .regWrite(regWrite_UC), 
        .aluOp(aluOp_UC)
    );

    // Instancia del Decodificador de ALU
    aluDeco aluDecoder(
        .op(op_UC), 
        .f3(f3_UC), 
        .f7(f7_UC), 
        .aluOp(aluOp_UC), 
        .aluControl(aluControl_UC)
    );

    // Lógica combinacional para generar señales de control
    always @(*) begin
        // Lógica para establecer valores de las señales de control en función de op, f3, y f7
        // (por ejemplo, en función del tipo de instrucción se configuran los flags de control)
        // Agregar lógica aquí según el diagrama de control del RISC-V.
    end
endmodule