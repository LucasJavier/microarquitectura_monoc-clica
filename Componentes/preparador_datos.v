module PD(
    input [31:0] inst,
    input [2:0] type_PD,
    output reg [4:0] a1, a2, a3
);

initial a1 = 5'b00000;
initial a2 = 5'b00000;
initial a3 = 5'b00000;

always @(*) begin
   case(type_PD)
    3'b000: begin // Tipo-I
      a1 = inst[19:15]; // Registro fuente, se utiliza como operando junto con un inmediato
      a2 = 5'bxxxxx; // No se usa, ya que se usa un inmediato
      a3 = inst[11:7]; // Registro destino que recibe el resultado si 'regWrite' esta activado
    end 
    3'b001: begin // Tipo-S
      a1 = inst[19:15]; // Direccion base, se usa junto a un inmediato
      a2 = inst[24:20]; // Registro que contiene el dato a almacenar
      a3 = 5'bxxxxx; // No se usa, no se escribe en el banco (sino que en memoria)
    end 
    3'b010: begin // Tipo-R
      a1 = inst[19:15]; // Registro fuente 1
      a2 = inst[24:20]; // Registro fuente 2
      a3 = inst[11:7]; // Registro destino que recibe el resultado si 'regWrite' esta activado
    end 
    3'b011: begin // Tipo-B
      a1 = inst[19:15]; // Registro 1 que se compara con..
      a2 = inst[24:20]; // ...Registro 2
      a3 = 5'bxxxxx; // No se usa, ya que no hay escritura en el banco de registros.
    end
    default: begin // Tipo-J
      a1 = 5'bxxxxx; // No se usa
      a2 = 5'bxxxxx; // No se usa
      a3 = inst[11:7]; // Registro destino
    end 
endcase 
end

endmodule