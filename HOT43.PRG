/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT43.PRG
 \ Modulo..: Relat¢rio do H¢spedes
 \ Vers∆o..: 1.1
 \ Data....: 17-08-94
 \ Revis∆o.: 09-01-95
 \ Sistema.: MILENIUM - Automaá∆o Hoteleira
 \ Funcao..: Emiss∆o de Relat¢rio do H¢spedes 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

PRIV NUCOP:=1,COPRIN:=1,SOMA[2],SOMADIA[2]

SOMADIA[1]=0
SOMA[1]=0
SOMADIA[2]=0
SOMA[2]=0
TDIARIA:=TOUTROS:=TPAX:=TAPTO:=0
PRIV MDATA
JANELA(01,11,24,16,58,"")
@ 13,27 SAY "Informe a partir de que Data !"
DO WHILE .T.
   MDATA=CTOD("  /  /  ")
   SET CURSOR ON
   @ 15,37 GET MDATA PICT "@D" VALID(!EMPTY(MDATA))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      JANELA(02)
      RETURN
   ENDIF
   IF (!EMPTY(MDATA) .AND. (MDATA<=DAT_HOJE))
      EXIT
   ELSE
      MENS('Data Invalida !!!')
   ENDIF
ENDDO
JANELA(2)


JANELA(01,09,18,14,63,"Solicitacao de Copias")
@ 12,25 SAY "Informe o Numero de Copias :"
SET CURSOR ON
@ 12,54 GET NUCOP PICT "99" RANGE 1,99
READ
SET CURSOR OFF
JANELA(02)
IF LASTKEY()=K_ESC
   RETURN
ENDIF
JANELA(01,09,18,14,63,"Verificacao de Impressora")
@ 12,21 SAY "Prepare o Formulario e pressione <ENTER>"
INKEY(0)
DO WHILE .T.
   IF !ISPRINTER()
      @ 12,21 SAY "Impressora nao esta Pronta ou sem Papel "
      INKEY(0.5)
      IF LASTKEY()=K_ESC
         JANELA(02)
         RETURN
      ENDIF
   ELSE
      EXIT
   ENDIF
ENDDO
JANELA(02)
IF LASTKEY()=K_ESC
   RETURN
ENDIF
JANELA(1,11,15,15,66,"Imprimindo Relatorio de Hospedes")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
IF LASTKEY()=K_ESC
   RETURN
ENDIF
SELE 05     //SELECIONA AREA DE REGISTRO
SET FILTER TO ((DTENT>=MDATA)  .AND.  (DTSAI<=MDATA))
SET DEVICE TO PRINT
FOR COPRIN=1 TO NUCOP
   SELE 04
   SET ORDER TO 2
   DBGOTOP()
   @ 01,00 SAY CHR(15)
   DO CABECA
   DO WHILE !EOF()
      IF PROW() >=63
         DO RODAPE
         @ 01,00 SAY CHR(15)
         DO CABECA
      ENDIF
      SELE 01
      LOCATE FOR CODIGO=REGISTRO->FIRMAAGE
      SELE 05
      LOCATE FOR CODHOSP=HOSPEDES->CODIGO
      SELE 02
      LOCATE FOR APTO=REGISTRO->APTO
      SELE 09
      SET FILTER TO CODIGO=REGISTRO->CODIGO
      DBGOTOP()
      DO WHILE !EOF()
         IF TIPODESP=1
            SOMADIA[TIPOMOV]=SOMADIA[TIPOMOV]+VALOR
         ENDI
         SOMA[TIPOMOV]=SOMA[TIPOMOV]+VALOR
         SKIP +1
      ENDDO
      SELE 05
      TDIARIA := TDIARIA + SOMADIA[1]
      TOUTROS := TOUTROS + SOMA[1] + SOMA[2]
      TPAX := TPAX + REGISTRO->PAX
      TAPTO+=1
      @ PROW()+1,01 SAY REGISTRO->APTO    PICT "999"
      @ PROW(),10   SAY REGISTRO->PAX     PICT "999"
      @ PROW(),16   SAY SUBSTR(HOSPEDES->NOME,1,20)    PICT "@!"
      @ PROW(),39   SAY SUBSTR(clientes->NOME,1,24)      PICT "@!"
      @ PROW(),67   SAY REGISTRO->DTENT
      @ PROW(),80   SAY REGISTRO->DTSAI
      @ PROW(),94   SAY SOMADIA[1] PICT "@E 999,999.99"
      @ PROW(),108  SAY SOMA[1]    PICT "@E 999,999.99"
      @ PROW(),124  SAY 'Normal'
      IF SOMA[2]>0
         @ PROW()+1,01 SAY REGISTRO->APTO    PICT "999"
         @ PROW(),10   SAY REGISTRO->PAX     PICT "999"
         @ PROW(),16   SAY SUBSTR(HOSPEDES->NOME,1,20)    PICT "@!"
         @ PROW(),39   SAY SUBSTR(clientes->NOME,1,24)      PICT "@!"
         @ PROW(),67   SAY REGISTRO->DTENT
         @ PROW(),80   SAY REGISTRO->DTSAI
         @ PROW(),94   SAY SOMADIA[2] PICT "@E 999,999.99"
         @ PROW(),108  SAY SOMA[2]    PICT "@E 999,999.99"
         @ PROW(),124  SAY 'Extra'
      ENDI
      SKIP +1
      IF EOF()
         @ PROW()+1,01 SAY REPL("-",132)
         @ PROW()+1,01 SAY TAPTO PICT "999"
         @ PROW(),10   SAY TPAX  PICT "999"
         @ PROW(),91   SAY TDIARIA PICT "@E 99,999,999.99"
         @ PROW(),105  SAY TOUTROS PICT "@E 99,999,999.99"
      ENDIF
      SOMADIA[1] := SOMA[1] := 0
      SOMADIA[2] := SOMA[2] := 0
   ENDDO
   DO RODAPE
   SOMADIA[1] := SOMA[1] := 0
   SOMADIA[2] := SOMA[2] := 0
NEXT COPRIN
SET DEVICE TO SCREEN
JANELA(02)
SELE 05
SET FILTER TO
SELE 09
SET FILTER TO
SELE 04
SET ORDER TO 0
RETURN


//FUNCAO CABECALHO DO RELATORIO DE HOSPEDES

PROCEDURE CABECA
@ 01,00 SAY Padc(Controle->NomHot+' - Relacao de Hospedes',80)
@ 02,03 SAY "Dia: "
@ 02,PCOL()+1 SAY DAT_HOJE
@ 02,PCOL()+75 SAY "Dia da Semana: "
SEMANA(MDATA)
@ PROW()+1,01 SAY"==================================================================================================================================="
@ PROW()+2,01 SAY"Apto     Pax   Nomes                  Firma                       Dt. Ent.     Dt. Saida         Diaria        Outros      Tipo    "
@ PROW()+1,01 SAY"-----------------------------------------------------------------------------------------------------------------------------------"
RETURN
