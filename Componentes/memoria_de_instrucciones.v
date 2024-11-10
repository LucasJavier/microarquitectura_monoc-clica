module IM(
    input [4:0] address, //  Direccion de memoria accedida
    output reg [31:0] inst // Informacion, que puede ser una istruccion o dato
);

reg [31:0] memory [31:0];

always @(*) begin
    inst = memory[address]; 
end

endmodule