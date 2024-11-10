module DM(
    input clk, // Reloj del sistema
    input [31:0] address, // La direccion de memoria accedida (salida de la ALU)
    input [31:0] wd, // Los datos que se escriben (registro 2, 'rd2')
    input we, // Señal para escritura
    output [31:0] rd // Guardamos la información que debe ir al banco de registros ('wd3')
);

reg [31:0] data_memory [31:0];

always @(posedge clk) begin
    if (we)
        data_memory[address] <= wd;
end

assign rd = data_memory[address];

endmodule