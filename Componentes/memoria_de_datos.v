module DM(
    input clk, // Reloj del sistema
    input [31:0] address, // La direccion de memoria accedida
    input [31:0] wd, // Los datos que se escriben (salida de la ALU)
    input we, // Señal para escritura
    output [31:0] rd // La informacion que hay en esa direccion
);

reg [31:0] data_memory [31:0];

always @(posedge clk) begin
    if (we)
        data_memory[address] <= wd;
end

assign rd = data_memory[address];

endmodule