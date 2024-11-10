`include "../Componentes/memoria_de_datos.v"
`include "../Componentes/memoria_de_instruccioens.v"

module memory(
    input clk_M,
    input [31:0] address_M,
    input [31:0] wd_M,
    input we_M,
    output [31:0] inst_M,
    output [31:0] rd_M
);

// Instancia de Memoria de Instrucciones
IM intrucionesMemoria(
    .address(address_M),
    .inst(inst_M)
);

// Instancia de Memoria de Datos
DM datosMemoria(
    .clk(clk_M), 
    .address(address_M), 
    .wd(wd_M), 
    .we(we_M), 
    .rd(rd_M)
);

endmodule