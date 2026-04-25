.586
.model flat, stdcall
.stack 2048

ExitProcess PROTO exitCode: DWORD

.data
  
    vector    REAL4 3.0, 4.0
    
    dim_N     DWORD 2               
    resultado REAL4 0.0           

.code
main PROC
 
    MOV ESI, OFFSET vector         
    MOV ECX, dim_N                  


    FLDZ                            

ciclo_norma:
    
    FLD REAL4 PTR [ESI]             ; Sube v[i] a la pila. Ahora ST(0) = v[i], y la suma bajó a ST(1)
    FMUL ST(0), ST(0)               ; Multiplica ST(0) x ST(0) -> Lo eleva al cuadrado
    FADDP ST(1), ST(0)              ; Suma el cuadrado al acumulador: ST(1) = ST(1) + ST(0), y hace POP

    
    ADD ESI, 4                      ; Saltamos 4 bytes al siguiente REAL4
    LOOP ciclo_norma

    
    ; Al salir del ciclo, la suma total de los cuadrados quedó en ST(0)
    FSQRT                           ;  Le saca la raíz cuadrada a ST(0)

  
    FSTP resultado                  ; Guarda la norma final en la variable y limpia la pila

    INVOKE ExitProcess, 0
main ENDP
END main