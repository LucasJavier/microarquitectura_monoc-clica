module Mux2x1(
    input [31:0] e1, // Registro2 (o mas 4)
    input [31:0] e2, // Inmediato
    input sel, // Selector
    output [31:0] salMux
);

    assign salMux = (sel) ? e2 : e1;

endmodule