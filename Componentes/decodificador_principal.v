module mainDeco(
    input [6:0] op,
    output reg branch, // (pcSrc) Indica al PC si hacer un salto o no
    output reg memWrite, // Indica a la memoria de datos si habilitar o no la escritura 
    output reg aluSrc, // Indica si el 'op2' de la ALU es de un registro o de un inmediato
    output reg regWrite, // Indica si hay que habilitar o no la escritura en el banco de registros
    output reg resSrc, // Indica de donde viene la informacion que se va a guardar (ALU o memoria)
    output reg [1:0] inmSrc, // Indica al PC si viene un inmediato
    output reg [1:0] aluOp // Indica al decodificador de la ALU  que operacion realizar
    output reg [2:0] type // Indica el tipo de instrucción
);

always @(*) begin
    case (op)
        7'b0000011: begin // lw --> I-type
            regWrite = 1;
            inmSrc = 2'b00;
            aluSrc = 1;
            memWrite = 0;
            resSrc = 1;
            branch = 0;
            aluOp = 2'b00;
            type = 3'b000
        end
        7'b0100011: begin // sw --> S-type
            regWrite = 0;
            inmSrc = 2'b01;
            aluSrc = 1;
            memWrite = 1;
            resSrc = x;
            branch = 0;
            aluOp = 2'b00;
            type = 3'b001
        end
        7'b0110011: begin // R-type --> Operacion con la ALU
            regWrite = 1;
            inmSrc = 2'bxx;
            aluSrc = 0;
            memWrite = 0;
            resSrc = 0;
            branch = 0;
            aluOp = 2'b10;
            type = 3'b010

        end
        7'b1100011: begin // beq --> B-type
            regWrite = 0;
            inmSrc = 2'b10;
            aluSrc = 0;
            memWrite = 0;
            resSrc = x;
            branch = 1;
            aluOp = 2'b01;
            type = 3'b011
        end
        default: begin // J-type
            regWrite = 1; // (se escribe el valor de retorno del salto en el registro de destino).
            inmSrc = 2'b10; // (indica que el inmediato es un desplazamiento de 20 bits, que se utiliza
                            // para calcular la nueva dirección del salto).
            aluSrc = 0; // (no se realiza ninguna operación aritmética).
            memWrite = 0; // (no se escribe en memoria).
            resSrc = 1; // (el resultado de la instrucción es la dirección de retorno del salto, 
                        // que se guarda en el registro).
            branch = 0; // (no es una instrucción de salto condicional).
            aluOp = 2'b00; //  (no se utiliza la ALU).
            type = 3'b100
        end
    endcase
end

endmodule