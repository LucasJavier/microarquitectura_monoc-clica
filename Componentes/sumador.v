module Adder(
    input [31:0] op1, op2, // Operandos (PC y el inmediato)
    input wr // Para ver si escribir con 'a3' en 'rd'
    input [2:0] type
    output [31:0] res // Resultado del calculo
); // calcula direcciones

always @(*) begin
    if(type==3'b100 && wr==1) res = op1 + op2 // Utilizado para calcular direcciones de saltos y datos
    else res = op1 + 3'b100; // res = PC + 4
end

endmodule