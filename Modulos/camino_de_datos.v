`include "../Componentes/contador_programa.v"
`include "../Componentes/sumador.v"
`include "../Componentes/multiplexor2x1.v"
`include "../Componentes/multiplexor4x1.v"
`include "../Componentes/memoria_de_instrucciones.v"
`include "../Componentes/extension_de_signo.v"
`include "../Componentes/ALU.v"
`include "../Componentes/preparador_datos.v"
`include "../Componentes/memoria_de_datos.v"
`include "../Componentes/banco_de_registros.v"

module dataPath(
    input clk_DP, aluSrc_DP, regWrite_DP, memWrite_DP, reset_DP, pcSrc_DP,
    input [1:0] rscSrc_DP, inmSrc_DP,
    input [2:0] aluControl_DP, type_DP,
    output [31:0] inst_OUT,
    output zero_OUT
);

    // Instancia del 1er multiplexor
    wire [31:0] salMux_DT;
    Mux2x1 multiplexorBranch(
        // Input
        .e1(32'd4), // +4
        .e2(inm_DP), // Inmediato
        .sel(pcSrc_DP), // Selector
        // Output
        .salMux(salMux_DT)
    );

    // Instancia del sumador
    wire [31:0] direccion_pc;
    Adder sumador(
        // Input
        .PC(pcOut_DT), // PC
        .op(salMux_DT), // + valor
        // Output
        .res(direccion_pc) // Direccion
    );

    // Instancia del contador de programa
    wire [31:0] pcOut_DT;
    PC programCounter(
        // Input
        .clk(clk_DP),
        .reset_PC(reset_DP), 
        .pcNext(direccion_pc), 
        // Output
        .pc(pcOut_DT)
    );
    wire [31:0] pc_mas_cuatro = pcOut_DT + 32'd4;

    // Instancia de memoria de instrucciones
    wire [31:0] inst_DP;
    wire [4:0] address_DP = pcOut_DT[6:2];
    IM memoriaInstruciones(
        // Input
        .address(address_DP),
        // Output
        .inst(inst_DP)
    );

    assign inst_OUT = inst_DP;

    // Instancia de extension de signo
    wire [31:0] inm_DP;
    SE extensionSigno(
        // Input
        .inst(inst_OUT),
        .type_SE(type_DP),
        // Output
        .inmExt(inm_DP)
    );

    // Instancia para preparar los datos
    wire [4:0] a1_DP, a2_DP, a3_DP;
    PD preparadorDatos(
        // Input
        .inst(inst_OUT),
        .type_PD(type_DP),
        // Output
        .a1(a1_DP),
        .a2(a2_DP),
        .a3(a3_DP)
    );

    // Instancia multiplexor 4x1
    wire [31:0] wd3_DP;
    Mux4x1 multiplexorWD3(
        // Input
        .e1(res_ALU_DP),
        .e2(wd3_mem_DP),
        .pcNext(pc_mas_cuatro),
        .sel(rscSrc_DP),
        // Output
        .salMux(wd3_DP)
    );

    // Instancia de banco de registros
    wire [31:0] rd1_DP, rd2_DP;
    BR bancoRegistros(
        // Input
        .clk(clk_DP),
        .a1(a1_DP),
        .a2(a2_DP),
        .a3(a3_DP),
        .wd3(wd3_DP),
        .we(regWrite_DP),
        .reset_BR(reset_DP),
        // Output
        .rd1(rd1_DP),
        .rd2(rd2_DP)
    );

    // Instancia del ultimo multiplexor 2x1 para la ALU
    wire [31:0] op2_ALU_DP;
    Mux2x1 multiplexorALU(
        // Input
        .e1(rd2_DP),
        .e2(inm_DP),
        .sel(aluSrc_DP),
        // Output
        .salMux(op2_ALU_DP)
    );

    // Instancia de la ALU
    wire [31:0] res_ALU_DP;
    wire zero_DP;
    ALU alu(
        // Input
        .srcA(rd1_DP),
        .srcB(op2_ALU_DP),
        .ALUControl(aluControl_DP),
        // Output
        .res(res_ALU_DP),
        .zero(zero_DP)
    );

    assign zero_OUT = zero_DP;

    // Instancia de la memoria de datos
    wire [31:0] wd3_mem_DP;
    wire [4:0] address_DP_alu = res_ALU_DP[6:2];
    DM memoriaDatos(
        // Input
        .clk(clk_DP),
        .address(address_DP_alu),
        .wd(rd2_DP),
        .we(memWrite_DP),
        .reset(reset_DP),
        // Output
        .rd(wd3_mem_DP)
    );
    
endmodule