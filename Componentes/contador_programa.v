module PC(
    input clk, reset_PC,
    input [31:0] pcNext, // Direccion de la proxima instruccion a realizar
    output reg [31:0] pc // Direccion de la instruccion que se debe ejecutar
);

always @(posedge clk or posedge reset_PC) begin
    if(reset_PC) pc = 32'b0;
    else pc <= pcNext;
end

endmodule