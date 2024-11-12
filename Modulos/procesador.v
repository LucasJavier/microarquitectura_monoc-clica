module rv32i(
    input clk_RV
);

    wire [2:0] aluControl_RV, type_RV;
    wire branch_RV, aluSrc_RV, regWrite_RV, memWrite_RV;
    wire [1:0] resSrc_RV, inmSrc_RV;

    // Instancia primer camino datos para obtener la instruccion
    wire [31:0] inst_RV;
    dataPath caminoDatos(
        // Input
        .clk_DP(clk_RV), 
        .branch_DP(branch_RV), 
        .aluSrc_DP(aluSrc_RV), 
        .regWrite_DP(regWrite_RV), 
        .memWrite_DP(memWrite_RV),
        .rscSrc_DP(resSrc_RV), 
        .inmSrc_DP(inmSrc_RV),
        .aluControl_DP(aluControl_RV),
        .type_DP(type_RV),
        // Output
        .inst_OUT(inst_RV)
    );

    // Instancia de la unidad de control
    UC unidadDeControl(
        // Input
        .instr_UC(inst_RV),
        // Output
        .branch_UC(branch_RV),
        .regWrite_UC(regWrite_RV), 
        .memWrite_UC(memWrite_RV), 
        .aluSrc_UC(aluSrc_RV),
        .resSrc_UC(resSrc_RV), 
        .inmSrc_UC(inmSrc_RV),
        .aluControl_UC(aluControl_RV),
        .type_UC(type_RV)
    );
                
endmodule