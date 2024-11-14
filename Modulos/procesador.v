module rv32i(
    input clk_RV,
    input reset,
    output [31:0] instruccion
);

    wire [2:0] aluControl_RV, type_RV;
    wire aluSrc_RV, regWrite_RV, memWrite_RV, psSrc_RV;
    wire [1:0] resSrc_RV, inmSrc_RV;

    // Instancia primer camino datos para obtener la instruccion
    wire [31:0] inst_RV;
    dataPath caminoDatos(
        // Input
        .clk_DP(clk_RV), 
        .reset_DP(reset),
        .aluSrc_DP(aluSrc_RV), 
        .regWrite_DP(regWrite_RV), 
        .memWrite_DP(memWrite_RV),
        .rscSrc_DP(resSrc_RV), 
        .inmSrc_DP(inmSrc_RV),
        .aluControl_DP(aluControl_RV),
        .type_DP(type_RV),
        .pcSrc_DP(psSrc_RV),
        // Output
        .inst_OUT(inst_RV),
        .zero_OUT(zero_RV)
    );

    assign instruccion = inst_RV;

    // Instancia de la unidad de control
    UC unidadDeControl(
        // Input
        .instr_UC(inst_RV),
        .zero_UC(zero_RV),
        // Output
        .regWrite_UC(regWrite_RV), 
        .memWrite_UC(memWrite_RV), 
        .aluSrc_UC(aluSrc_RV),
        .resSrc_UC(resSrc_RV), 
        .inmSrc_UC(inmSrc_RV),
        .aluControl_UC(aluControl_RV),
        .type_UC(type_RV),
        .pcSrc_UC(psSrc_RV)
    );
                
endmodule