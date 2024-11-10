`include "../Componentes/contador_programa.v"
`include "../Componentes/banco_de_registros.v"
`include "../Componentes/extension_de_signo.v"
`include "../Componentes/ALU.v"
`include "../Componentes/sumador.v"
`include "../Componentes/multiplexor.v"
`include "../Componentes/memoria_de_datos.v"
`include "../Componentes/memoria_de_instruccioens.v"
`include "../Componentes/unidad_control.v"

module dataPath(
    input clk_DP, // para el contador del programa
    input reset, // a valor por defecto al PC
    output [31:0] result
);

    wire [31:0] pcOut, pcNext_DP;
    // Instancia del contador de programa
    PC programCounter(
        .clk(clk_DP), 
        .pcNext(pcNext_DP), 
        .pc(pcOut)
    );

    wire [31:0] pc_mas_cuatro;
    Adder sumador_pc(
        .op1(pcOut),
        .op2(32'd4),
        .res(pc_mas_cuatro)
    );

    wire [31:0] inst_DP;
    IM memoriaInstruciones(
        .address(pcOut),
        .inst(inst_DP)
    );

    // Decodificar la instruccion
    wire [4:0] rs1_DT, rs2_DT, rd_DT;
    wire [6:0] op_DT;
    wire [2:0] funct3_DT;
    DI descomponerInstruccion(
        .inst_DI(inst_DP),
        .src(),
        .rs1(rs1_DT),
        .rs2(rs2_DT),
        .rd(rd_DT),
        .opcode(op_DT),
        .funct3(funct3_DT)
    );

    // Instancia de la extensión de signo
    wire [31:0] inmExt_DP;
    SE extensorSigno( // ¿De donde salen los valores?
        .inst(inst_DP),
        .src(), 
        .inmExt(inmExt_DP)
    );
    
    // Instancia del banco de registros
    wire [31:0] rd1_DP, rd2_DP;
    BR bancoRegistro( // ver bien como obtener los demas valores
        .clk(clk_DP),
        .a1(a1), 
        .a2(a2), 
        .a3(a3), 
        .wd3(wd3), 
        .we(we), 
        .rd1(rd1_DP), 
        .rd2(rd2_DP)
    );
    
    // Instancia de la ALU
    wire [31:0] aluRes;
    ALU alu( // ¿De donde salen los valores?
        .srcA(rd1),
        .srcB(inmExt),
        .ALUControl(ALUControl),
        .res(aluRes)
    );
    
endmodule