/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT93.PRG
 \ Modulo..: Consulta de Departamentos
 \ VersÆo..: 1.1
 \ Data....: 15-05-95
 \ RevisÆo.: 
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Consulta de valores gastos por Departamentos 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

JANELA(01,10,24,15,57,"")
@ 11,28 SAY "Informe a Data e a Hora !"
DO WHILE .T.
   MDATA=DAT_HOJE
   MHORA=SPACE(04)
   SET CURSOR ON
   @ 14,30 GET MDATA  PICT "@D"       VALID(!EMPTY(MDATA))
   @ 14,46 GET MHORA  PICT "@R 99:99" VALID(!EMPTY(MHORA))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      JANELA(02)
      RETURN
   ENDIF
   IF MDATA>DAT_HOJE
      MENS('Data Invalida !!!')
   ELSE
      JANELA(01,10,47,20,60)
      DO WHILE .T.
         NIVEL=1
         SET CURSOR OFF
         KEYBOARD "1"
         SETCOLOR(CORMUNO)
         OPC1=ACHOICE(11,48,19,59,MAT2,,'VERMENU',1)
         IF OPC1=0
            EXIT
         ELSEIF OPC1<=9 .AND. OPC1!=0
            CONSULT(OPC1)
         ENDIF
      ENDDO
      JANELA(02)
   ENDIF
ENDDO
JANELA(02)
RETURN

//FUNCAO CRIA CONSULTA DE DEPARTAMENTO

FUNCTION CONSULT(X)
JANELA(1,11,15,15,66,"Geracao de Consulta")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
MVAL=0
SELE 09
DBGOTOP()
SET FILTER TO ((DATMOV>=MDATA) .AND. (HORAMOV>=MHORA) .AND. (TIPODESP=X))
DBGOTOP()
DO WHILE !EOF()
   IF TCON='N'
      MVAL=MVAL+VALOR
   ELSE
      MVAL=MVAL-VALOR
   ENDIF
   DBSKIP()
ENDDO
DBGOTOP()
JANELA(02)
JANELA(01,03,15,22,61,"Consulta de Departamento - "+MAT2[OPC1])
@ 24,00 SAY PADR("[ESC] Sai",80)
FOR I=16 TO 60
   @ 20,I SAY "-"
NEXT
@ 21,18 SAY "Total - "
@ 21,26 SAY MVAL PICT "@E 999,999,999.99"
IF TIPOMOV!=0
   MDB1={"DATMOV","HORAMOV","MAT1[TIPOMOV]","TCON","VALOR"}
ELSE
   MDB1={"DATMOV","HORAMOV","TIPOMOV","TCON","VALOR"}
ENDIF
MDB2={"","@R 99:99","@!","@!","@R 99,999.99"}
MDB3={"Dt. Mov.","H. Mov.","Tp. Mov","   ","Valor"}
DBEDIT(05,16,19,60,MDB1,,MDB2,MDB3,"Ä","³")
JANELA(02)
DBSETFILTER()
DO BARSTA
RETURN
