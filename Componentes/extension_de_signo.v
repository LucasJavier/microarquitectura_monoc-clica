module SE(
    input [31:0] inst, // Intruccion
    input [2:0] tpye, // Codigo de operacion
    output reg [31:0] inmExt // Inmediato de 32 bits
);

always @(*) begin
    case (type)
        3'b000: inmExt = { {20{inst[31]}}, inst[31:20] }; // I-Type
        3'b001: inmExt = { {20{inst[31]}}, inst[31:25], inst[11:7] }; // S-Type
        3'b011: inmExt = { {20{inst[31]}}, inst[31], inst[30:25], inst[11:8], inst[7] }; // B-Type
        3'b100: inmExt = { {12{inst[31]}}, inst[31], inst[30:21], inst[20], inst[19:12] }; // J-Type
        default: inmExt = 32'b0; // R-type
    endcase
end

endmodule