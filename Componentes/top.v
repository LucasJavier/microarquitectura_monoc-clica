/* flujo de módulos/componentes
    1) multiplexor2x1
    2) sumador
    3) contador_programa
    4) memoria_de_instrucciones
    5) decodificador_principal
    6) extension_de_signo
    7) decodificador_alu
    8) preparador_datos
    9) multiplexor4x1
    10) banco_de_registros
    11) multiplexor2x1
    12) ALU
    13) memoria_de_datos
*/

/* flujo:

multiplexor2x1 (para saber si PCnext +4 o PC + inmediato) --> Entra la señal de 'branch' para saber que sumarle
                                        al PC --> sumador
sumador --> Entra el PC, el inmediato, 'branch' para saber su sumarle al PC, y nos devuelve la direccion
            de la proxima instruccion --> contador_programa
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
decodificador_alu --> Entra el 5to bits de'op' y 'f7', los 3 bits de 'f3' y el tipo de operación alu 'aluOp',
                      y nos devuelve el tipo de operación que debe hacer la alu --> preparador_datos

preparador_datos --> Entra la instruccion y el tipo de instruccion, para devolvernos en su
                     salida las entradas ya preparadas para banco_de_registros --> multiplexor4x1
multiplexor4x1 (para saber de donde llega el dato de 'wd3' - entrada del banco_de_registros -) --> Entra:
                i) La salida de la ALU
                ii) La salida de la memoria_de_datos
                iii) El inmediato
                iv) El PC
                --> banco_de_registros
banco_de_registros --> Entra la dirección para acceder a los registros, info (o no) a guardar y señal para
                       ver si hacerlo. Nos da en la salida 'rd1' y 'rd2' (registros) --> multiplexor2x1
multiplexor2x1 --> Entra el registro 2, el inmediato, y el aluSrc, para saber que pasarle como 'op2' a la
                ALU --> ALU
ALU --> Entra el registro 1, el registro 2 o el inmeadiato, y la operación a realizar, y nos devuelve el
        resultado --> memoria_de_datos
memoria_de_datos --> Recibe el resultado de la ALU (a 'address'), 'memWrite' para saber si hay que escribir en 
                     memoria, el reloj, y el dato a escribir (de ser necesario, en 'wd') en 'address'.
*/