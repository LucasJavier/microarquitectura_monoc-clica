// Conectar la salida del PC con la entrada de la memoria de instruccion    
// Salida banco de registros conectar a la alu
// Salida de alu a memoria de datos (banco de registros tambien)
// memoria de datos al banco de registros
// extension de signo a banco de regristros
// sumador al PC
// multiplexor reutilziable
// unidad de control contendrá dos módulos: el Decodificador principal y el Decodificador de ALU.
// salida decodificador de alu a alu


/* flujo de módulos/componentes
    1) contador_programa
    2) memoria_de_instrucciones
    3) decodificador_principal
    4) extension_de_signo
    5) decodificador_alu
    6) preparador_datos
    7) banco_de_registros
    8) multiplexor
    9) ALU
    10) memoria_de_datos
*/

/* flujo:

contador_programa --> Entra el reloj y la dirección de la próxima intrucción, nos devuelve la dirección
                      de la instrucción que se debe ejecutar --> memoria_de_instrucciones
memoria_de_instrucciones --> Entra la dirección de la instrucción y nos devuelve la instrucción a
                             ejecutar --> decodificador_principal
decodificador_principal --> Entra los primeros 7 bits de la instruccion recuperada, y nos devuelve una
                            serie de señales, las cuales son:
                                i) branch: (pcSrc) Indica al PC si hacer un salto o no
                                ii) memWrite: Indica a la memoria de datos si habilitar o no la escritura 
                                iii) aluSrc: Indica si el 'op2' de la ALU es de un registro o de un inmediato
                                iv) regWrite: Indica si habilitar o no la escritura en el banco de registros
                                v) resSrc: Indica de donde viene la informacion que se va a guardar (ALU o memoria)
                                vi) inmSrc: Indica al PC si viene un inmediato
                                vii) aluOp: Indica al decodificador de la ALU  que operacion realizar
                                viii) type: Indica el tipo de instrucción
                            --> extension_de_signo
extension_de_signo --> Entra la instrucción y el tipo de instrucción, y nos devuelve el inmediato en 32 bits
                       --> decodificador_alu
decodificador_alu --> Entra parte del 'op', 'f7', 'f3' y el tipo de operación alu 'aluOp', y nos devuelve el
                      tipo de operación que debe hacer la alu --> preparador_datos
preparador_datos --> Entra la instruccion y el tipo de instruccion, para devolvernos en su
                     salida las entradas ya preparadas para banco_de_registros y el selector del multiplexor
                     --> banco_de_registros
banco_de_registros --> Entra la dirección para acceder a los registros, info (o no) a guardar y señal para
                       ver si hacerlo. Nos da en la salida 'rd1' y 'rd2' (registros) --> multiplexor
multiplexor --> Entra el registro 2, el inmediato, y el selectos, para saber que pasarle como 'op2' a la
                ALU --> ALU
ALU --> Entra el registro 1, el registro 2 o el inmeadiato, y la operación a realizar, y nos devuelve el
        resultado --> memoria_de_datos
memoria_de_datos --> Recibe el resultado de la ALU, 'memWrite' para saber si hay que escribir en memoria
*/