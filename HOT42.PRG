/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT42.PRG
 \ Modulo..: Relat¢rio do Caixa e Controle de Pagamento
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 15-05-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: EmissÆo de Relat¢rio do Caixa e Controle de Pagamento
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

//     Declaracao de variaveis locais

PRIV DENT:=CTOD(""),DSAI:=CTOD(""),HENTR:=SPACE(04),HSAID:=SPACE(04)
PRIV TTG:=0,TTS:=0,TMDIN:=0,TMCHE:=0,TMCRE:=0,TMRDA:=0,TMCOB:=0,TDESC:=0,TTROC:=0
PUBLIC WCODIGO:=0,NREC:=0,WVALOR:=0,MTROCO:=0,TCARTAO:=0,TCHEQUE:=0

JANELA(01,10,22,16,60," Relatorio de Caixa ")
@13,22 SAY " Data Ent. ÄÄÄÄÄÂÄ Data Sai. ÄÄÄÄÄÄÄ"
@14,22 SAY "                ³                   "
@15,22 SAY " Hora Ent. ÄÄÄÄÄÅÄ Hora Sai. ÄÄÄÄÄÄÄ"
@16,22 SAY "                ³                   "
@17,22 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
SELE 12
DBGOTOP()
DENT=Paramet->DTCAIXA
HENTR=Paramet->HCAIXA
SET CURSOR ON
@13,25 GET DENT   PICT "@D"  VALID(!EMPTY(DENT) .AND. DENT<=DAT_HOJE)
@15,25 GET HENTR  PICT "@R 99:99"  VALID(!EMPTY(HENTR))
@13,43 GET DSAI   PICT "@D"  VALID(!EMPTY(DSAI) .AND. DSAI<=DAT_HOJE .AND. DSAI>=DENT)
@15,43 GET HSAID  PICT "@R 99:99"  VALID(!EMPTY(HSAID))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   JANELA(02)
   RETURN
ENDIF
JANELA(2)

PRIV NUCOP:=1,COPRIN:=1
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
@ 12,21 SAY "Prepare o Formulario e pressione <ENTER> "
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
JANELA(1,11,15,15,66,"Imprimindo Relatorio de Caixa")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
DO WHILE COPRIN<=NUCOP
   SELE 05                      //SELECIONA AREA REGISTRO
   SET FILTER TO (((DTSAI>=DENT .AND. DTSAI<=DSAI).AND.(HSAI>=HENTR .AND. HSAI<=HSAID)).and.(Ativo="N"))
   DBGOTOP()
   SELE 04                     //SELECIONA AREA DE CADASTRO DE HOSPEDE
   SET FILTER TO CODIGO=REGISTRO->CODHOSP
   GO TOP
   SET DEVI TO PRINT
   @ 01,01 SAY CHR(15)
   DO CABCAIXA WITH 1
   SELE 05
   DBGOTOP()
   DO WHILE !EOF()
      IF PROW()>=60
         DO RODA
         @ 01,01 SAY CHR(15)
         DO CABCAIXA WITH 1
      ENDIF
      IF VLEXTRA>0
         TG=0
         TS=0
         TG=VLNORMAL+VLEXTRA
         TS=SERNOR+SEREXT
      ELSE
         TG=VLNORMAL
         TS=SERNOR
      ENDIF
      MDIN=0
      MCHE=0
      MCRE=0
      MRDA=0
      MCOB=0
      MTROCO=0
      TTG+=TG
      TTS+=TS
      HOSPEDES->(DBSEEK(REGISTRO->CODHOSP))
      @ PROW()+1,00 SAY REGISTRO->APTO   PICT "999"
      @ PROW(),08   SAY REGISTRO->RD PICT "99999"
      @ PROW(),15   SAY SUBSTR(HOSPEDES->NOME,1,20)  PICT "@!"
      @ PROW(),38   SAY TG  PICT "@E 999,999.99"
      @ PROW(),52   SAY TS  PICT "@E 9,999.99"
      FORMAS(REGISTRO->CODHOSP)                    //FUNCAO SOMA VALORES EXTRAS E NORMAIS
  //CALCULO DO TROCO
      MTROCO=(MDIN+MCHE+MCRE+MRDA+MCOB)-(TG+TS)
      TMDIN+=MDIN
      TMCHE+=MCHE
      TMCRE+=MCRE
      TMRDA+=MRDA
      TMCOB+=MCOB
      @ PROW(),64   SAY MDIN-MTROCO PICT "@E@) 9,999.99"
      @ PROW(),76   SAY MCHE PICT "@E 9,999.99"
      @ PROW(),88   SAY MCRE PICT "@E 9,999.99"
      @ PROW(),101  SAY MRDA PICT "@E 9,999.99"
      @ PROW(),112  SAY MCOB PICT "@E 9,999.99"
      DESCONT=DESCON(REGISTRO->CODIGO)  //FUNCAO VERIFICA DESCONTO
      @ PROW(),124  SAY  DESCONT  PICT "@E 9,999.99"
      TDESC+=DESCONT
      SELE 05
      SKIP +1
   ENDDO
   IF PROW() >=60
      DO RODA
      @ 01,01 SAY CHR(15)
      DO CABCAIXA WITH 1
   ENDIF
   @PROW()+1,01 SAY REPL('=',131)
   @PROW()+1,38 SAY TTG  PICT "@E 999,999.99"
   @PROW(),52 SAY TTS    PICT "@E 9,999.99"
   @PROW(),64 SAY TMDIN-TTROC  PICT "@E@) 9,999.99"
   @PROW(),76 SAY TMCHE  PICT "@E 9,999.99"
   @PROW(),88 SAY TMCRE  PICT "@E 9,999.99"
   @PROW(),101 SAY TMRDA PICT "@E 9,999.99"
   @PROW(),112 SAY TMCOB PICT "@E 9,999.99"
   @PROW(),124 SAY TDESC PICT "@E 9,999.99"
   DO RODA
   COPRIN+=1
   SET DEVI TO SCREEN
   DO PAGAMENTO
   SELE 10
   SET FILTER TO
   SELE 05
   SET FILTER TO
   SELE 04
   SET FILTER TO
ENDD
JANELA(02)
SELE 12
DO WHILE .T.
   IF RLOCK()
      DBGOTOP()
      REPL DTCAIXA WITH DSAI
      REPL HCAIXA  WITH HSAID
      UNLOCK
      EXIT
   ELSE
      MENS('Arquivo sendo utilizado !!!')
   ENDIF
ENDDO
RETURN

//FUNCAO RODAPE DO RELATORIO CAIXA

PROCEDURE RODA
@ 60,01 SAY "------------------------------------------------------------------------------------------------------------------------------------"
@ 61,01 SAY "Observacao: Quaisquer moedas estrangeiras entram como dinheiro (valor autorizado)."
RETURN

//FUNCAO VERIFICA QUAL FORMA DE PAGAMENTO DEVE SER IMPRESSO

PROCEDURE FORMAS(X)
SELE 10
SET FILTER TO CODIGO=X
GO TOP
DO WHILE !EOF()
   DO CASE
      CASE FORMAPAG=1
         MDIN=MDIN+VALOR
      CASE FORMAPAG=2
         MCHE=MCHE+VALOR
      CASE FORMAPAG=3
         MCRE=MCRE+VALOR
      CASE FORMAPAG=4
         MRDA=MRDA+VALOR
      CASE FORMAPAG=5
         MCOB=MCOB+VALOR
   ENDCASE
   SKIP +1
ENDDO
SELE 07
SET ORDER TO 0
SET FILTER TO CODIGO=REGISTRO->CODIGO
DBGOTOP()
DO WHILE !EOF()
   MCHE=MCHE+VALOR
   DBSKIP()
ENDDO
RETURN

//FUNCAO VALOR DO DESCONTO

FUNCTION DESCON(X)
SELE 06
DES=0
VALOR=0
LOCATE FOR CODIGO=X
IF FOUND()
   DES=VALOR
ENDIF
RETURN(VALOR)

PROCEDURE PAGAMENTO
JANELA(1,11,15,15,66,"Imprimindo Controle de Pagamento")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
SELE 05
SET FILTER TO (((DTSAI>=DENT .AND. DTSAI<=DSAI).AND.(HSAI>=HENTR .AND. HSAI<=HSAID)).and.(Ativo="N"))
DBGOTOP()
SET DEVICE TO PRINT
SELE 10
SET FILTER TO FORMAPAG=2 .OR. FORMAPAG=3
DBGOTOP()
REGISTRO->(DBGOTOP())
IF LASTREC()<>0
   @ 01,00 SAY CHR(15)
   DO CABCAIXA WITH 2
ENDIF
DO WHILE ! REGISTRO->(EOF())
   WCODIGO := 0
   WCODIGO := REGISTRO->CODIGO
   IF WCODIGO = 0
      REGISTRO->(DBSKIP())
      LOOP
   ENDIF
   SELE 10
   DBSEEK(WCODIGO)
   DBEVAL({|| WVALOR := WVALOR + VALOR },,{|| CODIGO=WCODIGO})
   DBSEEK(WCODIGO)
   DBEVAL({|| RELAT(1) },,{|| CODIGO=WCODIGO})
   SELE 07
   LOCATE FOR CODIGO=WCODIGO
   IF FOUND()
      DBEVAL({|| RELAT(2) },,{|| CODIGO=WCODIGO})
   ENDIF
   SELE 10
   REGISTRO->(DBSKIP())
ENDDO
IF PROW() >=60
   DO RODAPE
   @ 01,00 SAY CHR(15)
   DO CABCAIXA WITH 2
ENDIF
@PROW()+1,1 SAY REPL("=",131)
@PROW()+1,1 SAY " Total  "
@PROW(),PCOL()+40 SAY " Cheque : "
@PROW(),PCOL()+2 SAY TCHEQUE PICT "@E 99,999.99"
@PROW(),PCOL()+40 SAY " Cartao : "
@PROW(),PCOL()+2 SAY TCARTAO PICT "@E 99,999.99"
DO RODAPE
SET DEVICE TO SCREEN
SELE 05
DBSETFILTER()
JANELA(02)
RETURN


FUNCTION RELAT(X)
IF X=1
   HOSPEDES->(DBSEEK(REGISTRO->CODHOSP))
   SELE 13
   LOCATE FOR NUMOP=REGISTRO->OPSAI
   SELE 10
   @PROW()+1,01  SAY SENHA->NOMEOP
   @PROW(),15  SAY HOSPEDES->NOME
   @PROW(),41  SAY MAT3[FORMAPAG]
   @PROW(),54 SAY VALOR
   IF FORMAPAG=2
      TCHEQUE+=VALOR
   ELSEIF FORMAPAG=3
      TCARTAO+=VALOR
   ENDIF
   IF FORMAPAG=3
      @PROW(),67  SAY NUMERO
      @PROW(),116 SAY "-"
   ENDIF
   @PROW(),91  SAY BANCO
   @PROW(),102 SAY AGENCIA
   IF FORMAPAG=2
      @PROW(),69  SAY "-"
      @PROW(),114 SAY NUMERO
   ENDIF
   IF PROW() >=60
      DO RODAPE
      @ 01,00 SAY CHR(15)
      DO CABCAIXA WITH 2
   ENDIF
ELSE
   HOSPEDES->(DBSEEK(REGISTRO->CODHOSP))
   SELE 13
   LOCATE FOR NUMOP=REGISTRO->OPSAI
   SELE 07
   @PROW()+1,01  SAY SENHA->NOMEOP
   @PROW(),15  SAY HOSPEDES->NOME
   @PROW(),41  SAY "CHEQUE PRE"
   @PROW(),54 SAY VALOR
   TCHEQUE+=VALOR
   @PROW(),91  SAY BANCO   PICT "9999"
   @PROW(),106 SAY "-"
   @PROW(),114 SAY NCHEQUE PICT "@!"
   IF PROW() >=60
      DO RODAPE
      @ 01,00 SAY CHR(15)
      DO CABCAIXA WITH 2
   ENDIF
ENDIF
RETURN NIL

PROCEDURE CABCAIXA
PARAMETERS WHAT
IF WHAT=1
   @ 01,00 SAY Padc(Paramet->NomHot,80)
   @ 03,15 SAY "C A I X A"
   @ 03,94 SAY "Data: "+DTOC(DAT_HOJE)
   @ 03,45 SAY "Data Ent.: "+DTOC(DENT)+" Data Sai.: "+DTOC(DSAI)
   @ 04,45 SAY "Hora Ent.: "
   @ 04,PCOL() SAY HENTR PICT "@R 99:99"
   @ 04,PCOL()+2 SAY " Hora Sai.: "
   @ 04,PCOL() SAY HSAID PICT "@R 99:99"
   @ 05,00 SAY "===================================================================================================================================="
   @ 07,00 SAY "Apto   RD     Nomes                    T. Geral    Tx Serv.    Dinheiro     Cheques    C/Credito      R.D.A.   Cobrancas  Cort-Desc "
   @ 08,00 SAY "------------------------------------------------------------------------------------------------------------------------------------"
ELSE
   @ 01,00 SAY Padc(Paramet->NomHot,80)
   @ 02,54 SAY "Controle de Pagamentos"
   @ 03,03 SAY "Dia: "
   @ 03,PCOL()+1 SAY DAT_HOJE
   @ 04,45 SAY "Data Ent.: "+DTOC(DENT)+" Data Sai.: "+DTOC(DSAI)
   @ 05,45 SAY "Hora Ent.: "
   @ 05,PCOL() SAY HENTR PICT "@R 99:99"
   @ 05,PCOL()+2 SAY " Hora Sai.: "
   @ 05,PCOL() SAY HSAID PICT "@R 99:99"
   @ PROW()+1,01 SAY"==================================================================================================================================="
   @ PROW()+2,01 SAY"Operador      Emitente                  TipoMov         Valor     Cartao N§               Banco      Agencia     Cheque N§"
   @ PROW()+1,01 SAY"-----------------------------------------------------------------------------------------------------------------------------------"
ENDIF
RETURN
