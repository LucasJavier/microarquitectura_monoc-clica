module rv32i(
    input clk_RV,
    input reset_RV,
    input [1:0] type,
    output [31:0] result_RV
);

wire [31:0] pcNext_RV, pcOut_RV;
wire [6:0] op_RV;
wire [2:0] f3_RV;
wire f7_RV, zero_RV;

// Instancia de dataPath
dataPath dp(
    .clk(clk_RV),
    .reset(reset_RV), 
    .pcNext(pcNext_RV), 
    .pcOut(pcOut_RV),
    .op(op_RV), 
    .f3(f3_RV), 
    .f7(f7_RV), 
    .zero(zero_RV), 
    .result(result_RV)
);

// Instancia de controlUnit
UC cu( // Los demas hay que sacarlos del mainDeco
    .op(op_RV),
    .f3(f3_RV), 
    .f7(f7_RV), 
    .regWrite(regWrite), 
    .aluSrc(aluSrc),
    .memWrite(memWrite), 
    .ALUControl(ALUControl), 
    .resSrc(resSrc), 
    .inmSrc(inmSrc)
);
                
endmodule