module Adder(
    input [31:0] op1, op2, // Operandos
    output [31:0] res // Resultado del calculo
); // calcula direcciones

assign res = op1 + op2; // Utilizado para calcular direcciones de saltos y datos

endmodule