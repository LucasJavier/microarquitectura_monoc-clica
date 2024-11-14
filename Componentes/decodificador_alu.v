module aluDeco(
    input op, f7,
    input [2:0] f3,
    input [1:0] aluOp,
    output reg [2:0] aluControl // a la ALU
);

wire OP_F7 = {op,f7};

initial aluControl = 3'b000;

always @(*) begin
    case (aluOp)
        2'b00: aluControl = 3'b000; // Suma
        2'b01: aluControl = 3'b001; // Resta
        2'b10: begin
            case (f3)
                3'b000: begin
                    if(OP_F7==2'b00 || OP_F7==2'b01 || OP_F7==2'b10) begin
                        aluControl = 3'b000; // Suma
                    end
                    else aluControl = 3'b001; // Resta
                end
                3'b010: aluControl = 3'b101; // SLT
                3'b110: aluControl = 3'b011; // OR
                3'b111: aluControl = 3'b010; // AND
                default: aluControl = 3'b000; // Suma
            endcase
        end
        default: aluControl = 3'b000; // Suma
    endcase
end

endmodule