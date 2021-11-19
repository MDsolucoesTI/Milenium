/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT92.PRG
 \ Modulo..: Consulta de Movimentos
 \ VersÆo..: 2.0
 \ Data....: 17-08-94
 \ RevisÆo.: 05-12-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Consulta de valores gastos por Hospede 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'
#Include 'Milenium.ch'

PRIV TAPTO,OTALP:=0,TOTALN:=0,TOTALL:=0,TOTALE:=0,TOTALPE:=0,TOTALLE:=0,TOTALP:=0
Priv mHosp,mCodH,mQHos

Set Key K_F8 to Picks

JANELA(01,10,20,16,55)
Do While .T.
   @ 14,44 Say "         "
   tApto=0
   mQHos=0
   mSaida=" "
   mHosp=Space(35)
   mCodH=0
   @ 12,22 SAY "Qual o Apartamento  :"
   @ 13,22 Say "Qual dos Hospedes   :"
   @ 14,22 Say "V¡deo ou Impressora :"
   @ 12,43 GET tApto PICT "999" VALID(TesApt(@tApto))
   //@ 13,43 Get mHosp When mQHos>1 Valid(
   @ 14,43 Get mSaida Pict "@!" Valid(nSaida$[VI])
   READ
   IF LASTKEY()=K_ESC
      Exit
   ENDIF
   If (mSaida=[V])
      @ 14,44 Say "ideo"
   Else
      @ 14,44 Say "mpressora"
   EndIf
   SET CURSOR OFF
   If mSaida=[V]
      TEST=GERAL()
      IF TEST
         NOVIDEO()
         SELE 16
         ZAP
         CLOSE
      ENDIF
   Else
      TEST=GERAL()
      IF TEST
         NAIMPRE()
         SELE 16
         ZAP
         CLOSE
      ENDIF
   EndIf
EndDo
Janela(02)
Sele &Usuario
Close All
Ferase(Usuario)
Return

FUNCTION GERAL()

Priv Arq:={}
ORD=.F.

JANELA(01,11,15,15,66,"Geracao de Consulta")
@ 14,17 SAY "Aguarde um Momento - Executando o Processamento"

Use Registro Index Registr1, Registr2, Registr3 shared New
Use Conregis Index Conregi1 Shared New
Use Hospedes Index Hospede1, Hospede2, Hospede3 Shared New
Use Movim Index Movim1 Shared New

Do While .T.
   If !File(Usuario)
      Aadd(Arq,{[DatMov],[D],8,0})
      Aadd(Arq,{[TipoMov],[C],6,0})
      Aadd(Arq,{[CodMov],[C],3,0})
      Aadd(Arq,{[TipoDesp],[C],15,0})
      Aadd(Arq,{[Valor],[N],8,2})
      Aadd(Arq,{[Opera],[C],15,0})
      DbCreate(Usuario,Arq)
      Exit
   Else
      Ferase(Usuario)
   EndIF
EndDo
Use &Usuario Exclu New

SELE Movim

Set Filter To Codigo=ConRegis->Codigo .and. CodHosp=ConRegis->CodHosp
DBGOTOP()
DO WHILE !EOF()
   SELE 13
   DBGOTOP()
   LOCATE FOR NUMOP=MOVIM->OPERADOR
   IF FOUND()
      AUX=NOMEOP
   ELSE
      AUX=""
   ENDI
   SELE 16
   APPE BLANK
   REPL DATMOV WITH MOVIM->DATMOV
   REPL TIPOMOV WITH MAT1[MOVIM->TIPOMOV]
   Do Case
      Case Movim->tCon = 'E'
         Replace tCon With "EST"
      Case Movim->tCon = "D"
         Replace tCon With "DES"
      OtherWise
         Replace tCon With ""
   EndCase
   REPL TIPODESP WITH MAT2[MOVIM->TIPODESP]
   REPL VALOR WITH MOVIM->VALOR
   REPL OPERADOR WITH AUX
   SELE 09
   IF MOVIM->TIPOMOV=1
      IF TCON='N'
         TOTALN=TOTALN+MOVIM->VALOR
      ELSE
         TOTALN=TOTALN-MOVIM->VALOR
      ENDIF
   ELSEIF TIPOMOV=2
      IF TCON='N'
         TOTALE=TOTALE+MOVIM->VALOR
      ELSE
         TOTALE=TOTALE-MOVIM->VALOR
      ENDIF
   ENDIF
   SKIP+1
ENDDO
SET FILTER TO
IF (DBGOTOP(CONTROLE->TAXASER))!=0
   TOTALP=TOTALN * (Controle->TaxaSer/100)
   TOTALL=TOTALN+TOTALP
   TOTALPE=TOTALE * (Controle->TaxaSer/100)
   TOTALLE=(TOTALE+TOTALPE)
ENDIF
JANELA(02)
IF LASTKEY()=K_ESC
   RETURN(ORD)
ENDIF
RETURN(ORD)

FUNCTION NOVIDEO()
SELE 16
DBGOTOP()
@ 24,00 SAY PADR("[ESC] Sai",80)
JANELA(01,06,01,23,77,"Consulta de Movimentos")
FOR I=02 TO 76
   @ 20,I SAY "Ä"
NEXT I
@ 21,02 SAY "Mov. Nor.  "
@ 21,14 SAY TOTALN PICT "@E 99,999.99"
@ 22,02 SAY "Mov. Ext.  "
@ 22,14 SAY TOTALE PICT "@E 99,999.99"
IF CONTROLE->TAXASER!=0
   @ 21,29 SAY "Taxa Ser. Nor. "
   @ 21,45 SAY TOTALP PICT "@E 99,999.99"
   @ 22,29 SAY "Taxa Ser. Ext. "
   @ 22,45 SAY TOTALPE PICT "@E 99,999.99"
ENDIF
@ 21,57 SAY "Total Nor."
@ 21,68 SAY TOTALL PICT "@E 99,999.99"
@ 22,57 SAY "Total Ext."
@ 22,68 SAY TOTALLE PICT "@E 99,999.99"
@ 08,02 SAY "Apto :"
@ 08,15 SAY "Pax :"
@ 08,27 SAY "Hospede :"
@ 08,09 SAY REGISTRO->APTO  PICT "999"
@ 08,21 SAY REGISTRO->PAX   PICT "99"
SELE 04
LOCATE FOR CODIGO=REGISTRO->CODHOSP
@ 08,37 SAY NOME  PICT "@!"
SELE 16
DBGOTOP()
MDB1={"DATMOV","TIPOMOV","TCON","TIPODESP","VALOR","OPERADOR"}
MDB2={"","@!","@!","@!","@R 99,999.99","@!"}
MDB3={"Dt. Mov.","Tp. Mov","   ","Tp. Despesa","Valor","Operador"}
DBEDIT(10,02,19,76,MDB1,,MDB2,MDB3,"Ä","³")
JANELA(2)
RETURN (NIL)

//FUNCAO IMPRIMI

FUNCTION NAIMPRE()
PRIV NUCOP:=1
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
SELE 16
DBGOTOP()
SET DEVI TO PRIN
DO CABMOV
FOR I=1 TO NUCOP
   DBGOTOP()
   DO WHILE ! EOF()
      @PROW()+1,08 SAY DTOC(DATMOV)
      @PROW(),17 SAY TIPOMOV   PICT "@!"
      @PROW(),25 SAY TCON      PICT "@!"
      @PROW(),29 SAY TIPODESP  PICT "@!"
      @PROW(),45 SAY VALOR PICT "@E 99,999.99"
      @PROW(),55 SAY OPERADOR  PICT "@!"
      IF PROW() >= 63
         DO RODAPE
         DO CABECA
      ENDIF
      COPRIN+=1
      DBSKIP()
   ENDDO
   IF PROW() >= 63
      DO RODAPE
      DO CABMOV
   ENDIF
   @PROW()+1,01 SAY REPL("_",79)
   @ PROW()+1,02 SAY "Mov. Nor.  "
   @ PROW(),14 SAY TOTALN PICT "@E 99,999.99"
   IF CONTROLE->TAXASER!=0
      @ PROW(),29 SAY "Taxa Ser. Nor. "
      @ PROW(),45 SAY TOTALP PICT "@E 99,999.99"
   ENDIF
   @ PROW(),57 SAY "Total Nor."
   @ PROW(),68 SAY TOTALL PICT "@E 99,999.99"
   @ PROW()+1,02 SAY "Mov. Ext.  "
   @ PROW(),14 SAY TOTALE PICT "@E 99,999.99"
   IF CONTROLE->TAXASER!=0
      @ PROW(),29 SAY "Taxa Ser. Ext. "
      @ PROW(),45 SAY TOTALPE PICT "@E 99,999.99"
   ENDIF
   @ PROW(),57 SAY "Total Ext."
   @ PROW(),68 SAY TOTALLE PICT "@E 99,999.99"
NEXT I
DO RODAPE
SET DEVICE TO SCREEN
RETURN (NIL)

PROCEDURE CABMOV
SELE 04
LOCATE FOR CODIGO=REGISTRO->CODHOSP
SELE 16
@ 1,30 SAY CONTROLE->NOMHOT PICT "@!"
@ PROW()+1,30 SAY "Consulta de Movimentos"
@ PROW()+2,08 SAY "Data: "+DTOC(DAT_HOJE)
@ PROW()+1,01 SAY 'Apto : '
@ PROW(),PCOL()+1 SAY REGISTRO->APTO  PICT "999"
@ PROW(),PCOL()+3 SAY "Pax :"
@ PROW(),PCOL()+1 SAY REGISTRO->PAX PICT "99"
@ PROW(),PCOL()+3 SAY 'Hospede : '
@ PROW(),PCol()+1 SAY HOSPEDES->NOME PICT "@!"
@ PROW()+1,00 SAY "==============================================================================="
@ PROW()+1,00 SAY "        Dt. Mov  Tp. Mov     Tp. Despesa         Valor Operador"
@ PROW()+1,00 SAY "-------------------------------------------------------------------------------"
RETURN

//FUNCAO VERIFICA APTO ATIVO='S' EM REGISTRO

FUNCTION VERIFI(X)

LOCAL ORDEM

ORDEM=.F.
SELE 05
SET FILTER TO ATIVO='S'
LOCATE FOR APTO=X
IF FOUND()
   SELE 04
   DBGOTOP()
   LOCATE FOR CODIGO=REGISTRO->CODHOSP
   ORDEM=.T.
ELSE
   TAPTO=0
   MENS('Apartamento nao encontrado')
ENDIF
SET FILTER TO
RETURN(ORDEM)

Function TesApto(mNumAp)
Return(.t.)

