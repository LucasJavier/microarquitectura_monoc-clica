module ALU(
    input [31:0] srcA, srcB, // Operandos (registro y registro/inmediato)
    input [2:0] ALUControl, // Operacion a realizar
    output reg [31:0] res, // Resultado
    output zero
);

always @(*) begin
    case (ALUControl)
        3'b000: res = srcA + srcB; // Suma
        3'b001: res = srcA - srcB; // Resta
        3'b010: res = srcA && srcB; // AND
        3'b011: res = srcA || srcB; // OR
        3'b101: res = (srcA < srcB) ? 1 : 0; // SLT
        default: res = 32'b0;
    endcase
end

assign zero = (res == 32'b0); // zero es 1 cuando res es 0

endmodule