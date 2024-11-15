module BR(
    input clk, // Reloj del sistema
    // Este banco genera el contenido de los registros correspondientes a la entrada de lectura
    // 'a1', 'a2' y 'a3' en las salidad 'rd1' y 'rd2'
    input [4:0] a1, a2, a3, // Entradas que seleccionan los registros 
    input [31:0] wd3, // Informacion a guardar en el registro 'a3'
    input we, reset_BR, // Señal de escritura
    output [31:0] rd1, rd2 // Linea que llevan los datos
);


reg [31:0] registers [31:0];

integer i;

initial begin
    for(i = 0;i<32;i=i+1) begin
        registers[i] <= 32'h00000000;
    end
end

assign rd1 = registers[a1];
assign rd2 = registers[a2];

always @(posedge clk or posedge reset_BR) begin
    if (we)
        registers[a3] <= wd3;
    if(reset_BR) begin
        for(i = 0;i<32;i=i+1) begin
            registers[i] <= 32'h00000000;
        end
    end
end

endmodule