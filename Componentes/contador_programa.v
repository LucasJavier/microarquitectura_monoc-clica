module PC(
    input clk, // Reloj del sistema
    input [31:0] pcNext, // Direccion de la proxima instruccion a realizar
    output reg [31:0] pc // Direccion de la instruccion que se debe ejecutar
);

always @(posedge clk) begin
    pc <= pcNext;
end

endmodule