module Mux4x1(
    input [31:0] e1, // ALU
    input [31:0] e2, // RD - Memoria datos
    input [31:0] pcNext, // PC
    input [1:0] sel, // Selector
    output reg [31:0] salMux
);

always @(*) begin
    if(sel==2'b00) salMux = e1;
    else if(sel==2'b01) salMux = e2;
    else if(sel==2'b10) salMux = pcNext;
    else salMux = 32'b0;
end
    
endmodule