 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT45.PRG
 \ Modulo..: Relat¢rio de Departamentos
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 12-05-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: EmissÆo de Relat¢rio de Departamentos 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'
#INCLUDE 'HOTEL.CH'

JANELA(01,10,24,15,57,"")
@ 11,28 SAY "Informe a Data e a Hora !"
DO WHILE .T.
   MDATA=CTOD("  /  /  ")
   MHORA=SPACE(04)
   SET CURSOR ON
   @ 14,30 GET MDATA  PICT "@D"       VALID(!EMPTY(MDATA))
   @ 14,46 GET MHORA  PICT "@R 99:99" VALID(!EMPTY(MHORA))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      JANELA(02)
      CLEAR TYPEAHEAD
      RETURN
   ENDIF
   IF MDATA>DATE()
      MENS('Data Invalida !!!')
   ELSE
      JANELA(01,10,47,20,60)
      DO WHILE .T.
         NIVEL=1
         SET CURSOR OFF
         CLEAR TYPEAHEAD
         KEYBOARD "1"
         SETCOLOR(CORMUNO)
         OPC1=ACHOICE(11,48,19,59,MAT2,,'VERMENU',1)
         IF OPC1=0
            EXIT
         ELSEIF OPC1<=9 .AND. OPC1!=0
            IMPRESSAO(OPC1)
         ENDIF
      ENDDO
      JANELA(02)
   ENDIF
ENDDO
JANELA(02)
RETURN

//FUNCAO IMPRIMIR

FUNCTION IMPRESSAO(X)
NUCOP=1
JANELA(01,09,18,14,63,"Solicitacao de Copias")
@ 12,25 SAY "Informe o Numero de Copias :"
SET CURSOR ON
@ 12,54 GET NUCOP PICT "99" RANGE 1,99
READ
SET CURSOR OFF
JANELA(02)
IF LASTKEY()=K_ESC
   CLEAR TYPEAHEAD
   RETURN
ENDIF
JANELA(01,09,18,14,63,"Verificacao de Impressora")
@ 12,21 SAY "Prepare o Formulario e pressione <ENTER> "
INKEY(0)
IF LASTKEY()=K_ESC
   CLEAR TYPEAHEAD
   JANELA(02)
   RETURN
ENDIF
DO WHILE .T.
   IF !ISPRINTER()
      @ 12,21 SAY "Impressora nao esta Pronta ou sem Papel "
      INKEY(0.5)
      IF LASTKEY()=K_ESC
         JANELA(02)
         CLEAR TYPEAHEAD
         RETURN
      ENDIF
   ELSE
      EXIT
   ENDIF
ENDDO
JANELA(02)
IF LASTKEY()=K_ESC
   CLEAR TYPEAHEAD
   RETURN
ENDIF
JANELA(1,11,15,15,66,"Imprimindo Relatorio de Departamentos")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'

MVAL=0
CORTESIA=0
SALDODIA=0
SELE 09
SET FILTER TO DATMOV>=MDATA .AND. HORAMOV>=MHORA .AND. TIPODESP=X
DBGOTOP()
WHILE !EOF()
   IF TCON='N'
      MVAL=MVAL+VALOR
   ELSEIF TCON='E'
      MVAL=MVAL-VALOR
   ENDIF
   SKIP +1
ENDDO
SALDODIA=MVAL
TAXASER=mVal*0.1
TOTAL=mVal+TAXASER
SET DEVICE TO PRINT
FOR I=1 TO NUCOP
   Sele 09
   DbGoTop()
   DO CAB
   DO WHILE !EOF()
      SELE 05
      DBGOTOP()
      LOCATE FOR CODIGO=MOVIM->CODIGO
      TAPTO=APTO
      SELE 04
      DBGOTOP()
      LOCATE FOR CODIGO=REGISTRO->CODHOSP
      THOSPE=LEFT(NOME,20)
      @ PROW()+1,01 SAY TAPTO    PICT "999"
      @ PROW(),PCOL()+2   SAY THOSPE   PICT "@!"
      SELE 09
      @ PROW(),PCOL()+1   SAY HORAMOV  PICT "@R 99:99"
      @ PROW(),PCOL()+1   SAY VALOR    PICT "@E 999,999.99"
      @ PROW(),PCOL()+1   SAY IIF(TCON='E',"EST","  ")
      @ PROW(),PCOL()+1   SAY MAT1[TIPOMOV]    PICT "@!"
      SELE 13
      DBGOTOP()
      LOCATE FOR NUMOP=MOVIM->OPERADOR
      IF FOUND()
         MOP=LEFT(NOMEOP,10)
         @ PROW(),COL()+1 SAY MOP  PICT "@!"
      ENDIF
      IF PROW()>=63
         DO RODAPE
         DO CAB
      ENDIF
      SELE 09
      DBSKIP()
   ENDDO
   IF PROW()>=49
      DO RODAPE
      DO CAB
   ENDIF
   @ PROW()+1,01 SAY REPL("-",79)
   @ PROW()+1,01 SAY "Sub Total"
   @ PROW(),26   SAY SALDODIA  PICT "@E 99,999,999,999,999.99"
   @ PROW()+1,01 SAY "Taxa Servico"
   @ PROW(),30   SAY TAXASER   PICT "@E 99,999,999,999.99"
   @ PROW()+1,25 SAY "------------------------"
   @ PROW()+1,01 SAY "Total"
   @ PROW(),26 SAY TOTAL   PICT "@E 99,999,999,999,999.99"
   DO RODAPE
NEXT I
SET DEVICE TO SCREEN
SELE 09
DBSETFILTER()
JANELA(02)
RETURN

//CABECALHO DO RELATORIO

PROCEDURE CAB
@ 1,30       SAY "RELACAO DE DEPARTAMENTO - "+MAT2[OPC1]
@ PROW()+2,01 SAY CONTROLE->NOMHOT
@ PROW(),57   SAY "Dia: "
@ PROW(),PCOL()+1   SAY MDATA
@ PROW()+1,01 SAY "==============================================================================="
@ PROW()+2,01 SAY "Apto  Hospede              Hora        Valor   Tp. Mov  Oper."
@ PROW()+1,01 SAY REPL("-",79)
RETURN
