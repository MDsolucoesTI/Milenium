/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT47.PRG
 \ Modulo..: Relaá∆o de data prevista de sa°da
 \ Vers∆o..: 1.1
 \ Data....: 17-08-94
 \ Revis∆o.: 15-05-95
 \ Sistema.: MILENIUM - Automaá∆o Hoteleira
 \ Funcao..: Emiss∆o de Relat¢rio de Previs∆o de Sa°da de hospedes 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'
#INCLUDE 'HOTEL.CH'

PRIV MDATA,TPAX:=0,TVALOR:=0,TAPTO:=0,NUCOP:=1,TOTAL:=0
PRIV SOMADIA[2],SOMA[2],SPAX:=0,SVALORN:=0,SVALORE:=0

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
JANELA(1,11,15,15,66,"Imprimindo Relacao de data prevista de saida")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
SELE 05
SET ORDER TO 02
SET FILTER TO DTSAI>=DAT_HOJE .OR. EMPTY(DTSAI)
FOR I=1 TO NUCOP
   DBGOTOP()
   TPAX=0
   TVALOR=0
   TAPTO=0
   TOTAL=0
   SVALOR=0
   SAPTO=0
   SOTAL=0
   SVALORN=0
   SVALORE=0
   TDATA=DTSAI
   SOMADIA[1]=0      //SOMA DO SUB-TOTAL
   SOMADIA[2]=0
   SOMA[1]=0         //SOMA FINAL
   SOMA[2]=0
   SET DEVICE TO PRINT
   DO CABREL
   @ PROW(),COL()+1 SAY CHR(27)+CHR(69)        //NEGRITO
   @ PROW()+1,01 SAY "Data de Saida: "
   @ PROW(),PCOL()+1 SAY DTSAI
   @ PROW(),COL()+1 SAY CHR(27)+CHR(70)        //RETIRA NEGRITO
   DO WHILE !EOF()
      IF TDATA=DTSAI
         SELE 04
         DBGOTOP()
         LOCATE FOR CODIGO=REGISTRO->CODHOSP
         MNOME=LEFT(NOME,20)
         SELE 01
         DBGOTOP()
         LOCATE FOR CODIGO=REGISTRO->FIRMAAGE
         MFIRMA=LEFT(NOME,20)
         SELE 09
         SET FILTER TO CODIGO=REGISTRO->CODIGO
         DBGOTOP()
         DO WHILE !EOF()
            IF TCON='N'
               SOMADIA[TIPOMOV]=SOMADIA[TIPOMOV]+VALOR
               SOMA[TIPOMOV]=SOMA[TIPOMOV]+VALOR
               SVALORN=SVALORN+VALOR
            ELSE
               SOMADIA[TIPOMOV]=SOMADIA[TIPOMOV]-VALOR
               SOMA[TIPOMOV]=SOMA[TIPOMOV]-VALOR
               SVALORE=SVALORE-VALOR
            ENDIF
            SKIP +1
         ENDDO
         TVALOR=TVALOR+SOMADIA[1]
         TOTAL=TOTAL+SOMADIA[2]
         SELE 05
         TAPTO++
         TPAX=TPAX+PAX
         SPAX=SPAX+PAX
         SAPTO++
         @ PROW()+1,01     SAY APTO       PICT "999"
         @ PROW(),07       SAY MNOME      PICT "@!"
         @ PROW(),30       SAY PAX        PICT "99"
         @ PROW(),35       SAY MFIRMA     PICT "@!"
         @ PROW(),57       SAY SOMADIA[1] PICT "@R 9,999.99"
         @ PROW(),67       SAY SOMADIA[2] PICT "@R 9,999.99"
         DBSKIP()
         IF PROW()>=63
            DO RODAPE
            DO CABREL
         ENDIF
      ELSE
         @ PROW()+1,01 SAY REPL("-",03)
         @ PROW(),30   SAY REPL("-",02)
         @ PROW(),57   SAY REPL("-",08)
         @ PROW(),67   SAY REPL("-",08)
         @ PROW()+1,01 SAY SAPTO    PICT "999"
         @ PROW(),29   SAY SPAX     PICT "999"
         @ PROW(),55   SAY SVALORN  PICT "@R 999,999.99"
         @ PROW(),65   SAY SVALORE  PICT "@R 999,999.99"
         TDATA=DTSAI
         TVALOR=0
         @ PROW()+1,01 SAY REPL("-",79)
         @ PROW(),COL()+1 SAY CHR(27)+CHR(69)        //NEGRITO
         @ PROW()+1,01 SAY "Data de Saida: "
         @ PROW(),PCOL()+1 SAY DTSAI
         @ PROW(),COL()+1 SAY CHR(27)+CHR(70)        //RETIRA NEGRITO
         SVALOR=0
         SAPTO=0
         SOTAL=0
         SPAX=0
         SOMADIA[1]=0
         SOMADIA[2]=0
         SVALORN=0
         SVALORE=0
      ENDIF
   ENDDO
   @ PROW()+1,01 SAY REPL("-",03)
   @ PROW(),30   SAY REPL("-",02)
   @ PROW(),57   SAY REPL("-",08)
   @ PROW(),67   SAY REPL("-",08)
   @ PROW()+1,01 SAY SAPTO   PICT "999"
   @ PROW(),29   SAY SPAX    PICT "999"
   @ PROW(),55   SAY SVALORN PICT "@R 999,999.99"
   @ PROW(),65   SAY SVALORE PICT "@R 999,999.99"
   IF PROW()>=63
      DO RODAPE
      DO CABREL
   ENDIF
   @ PROW()+1,01   SAY REPL("=",80)
   @ PROW()+1,01 SAY TAPTO    PICT "999"
   @ PROW(),29   SAY TPAX     PICT "999"
   @ PROW(),55   SAY SOMA[1]  PICT "@R 999,999.99"
   @ PROW(),65   SAY SOMA[2]  PICT "@R 999,999.99"
   DO RODAPE
NEXT
SET DEVICE TO SCREEN
SELE 05
SET ORDER TO 0
SET FILTER TO
JANELA(02)
RETURN

//FUNCAO CABECALHO DO RELATORIO

PROCEDURE CABREL
@ 01,28  SAY "RELATORIO DE DATA PREVISTA DE SAIDA"
@ PROW()+1,33 SAY "SAN MICHEL PALACE HOTEL"
@ PROW()+1,01 SAY "Data: "
@ PROW(),PCOL()+1 SAY DAT_HOJE
@ PROW()+1,01 SAY REPL("-",79)
@ PROW()+1,01 SAY "APTO  NOME                  PAX   FIRMA                 NORMAL    EXTRA    "
@ PROW()+1,01 SAY REPL("=",79)
RETURN
