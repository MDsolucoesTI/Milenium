/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT32.PRG
 \ Modulo..: Consulta de Movimentos
 \ VersÆo..: 2.0
 \ Data....: 17-08-94
 \ RevisÆo.: 05-12-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: EmissÆo de Consulta de Movimentos
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

PRIV TAPTO,OTALP:=0,TOTALN:=0,TOTALL:=0,TOTALE:=0,TOTALPE:=0,TOTALE:=0,TOTALLE:=0,TOTALP:=0
Priv tHospede

Set Key K_F8 to Picks

Use Aptos Index Aptos1 Shared New
Use Departa Index Departa1 New
Use Registro Index Registr1, Registr2, Registr3 shared New
Use Conregis Index Conregi1 Shared New
Use Hospedes Index Hospede1, Hospede2, Hospede3 Shared New
Use Movim Index Movim1 Shared New
Use Paramet Shared New

Arquivo=(Substr(Usuario,1,5)+"PAN")
Do While .t.
   If !File(Arquivo)
      mArq:={}
      Aadd(mArq,{[DatMov],[D],8,0})
      Aadd(mArq,{[HoraMov],[C],4,0})
      Aadd(mArq,{[TipMov],[C],6,0})
      Aadd(mArq,{[TipLan],[C],3,0})
      Aadd(mArq,{[EstLan],[C],3,0})
      Aadd(mArq,{[TipDes],[C],12,0})
      Aadd(mArq,{[Valor],[N],8,2})
      Aadd(mArq,{[Opera],[C],15,0})
      DbCreate(Arquivo,mArq)
      Exit
   Else
      Ferase(Arquivo)
   EndIf
EndDo

Use &Arquivo Exclu New

SETCOLOR(drvcorbox)
JANELA(01,10,20,16,55,,.T.)
Do While .T.
   @ 14,44 Say "         "
   tApto=0
   mQHos=0
   mSaida="V"
   mHosp=Space(35)
   mCodH=0
   @ 12,22 SAY "Qual o Apartamento  :"
   @ 13,22 Say "Nome do Hospede     :"
   @ 14,22 Say "V¡deo ou Impressora :"
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 12,43 GET tApto PICT "9999" VALID(Verifica(@tApto))
   Read
   SETCOLOR(drvcorbox)
   @ 13,43 Say  tHospede
   If LastKey()=K_ESC
      Exit
   EndIf
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   SETCOLOR(drvcorbox)
   @ 14,43 Get mSaida Pict "@!" Valid(mSaida$[VI])
   READ
   SETCOLOR(drvcorbox)
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
      GERAL()
      NOVIDEO()
   Else
      GERAL()
      NAIMPRE()
   EndIf
   Janela(02)
   Sele &Arquivo
   Close
   FErase(Arquivo)
EndDo
RETURN


FUNCTION GERAL()

Priv ConMov:=0

SETCOLOR(drvcorbox)
JANELA(01,11,15,15,66," Geracao de Consulta ",.T.)
@ 14,17 SAY "Aguarde um Momento - Executando o Processamento"

For ConMov=1 To 2
   SELE Movim
   SET FILTER TO (Codigo=Registro->Codigo .And. TipoMov=ConMov .And. CodHosp=Hospedes->Codigo)
   DBGOTOP()
   DO WHILE !EOF()
      SELE &Arquivo
      APPE BLANK
      REPL DatMov WITH Movim->DatMov
      Repl HoraMov With Movim->HoraMov
      REPL TIPMOV WITH IIf(Movim->TipoMov=1,[Normal],[Extra ])
      If Movim->tCon = "D"
         Replace TipLan With "Des"
      Else
         Replace TipLan With ""
      EndIf
      If Movim->Estorno=[S]
         Repl EstLan With [Est]
      Else
         Repl EstLan With []
      EndIf
      Ptab(Movim->TipoDesp,'Departa',1,.T.)
      REPL TipDes WITH Departa->TipoDesp
      REPL Valor WITH Movim->Valor
      REPL Opera WITH Usuario
      SELE Movim
      IF TIPOMOV=1
         IF TCON='N'
            If Estorno=[S]
               TOTALN=TOTALN-VALOR
            Else
               TOTALN=TOTALN+VALOR
            EndIf
         ELSE
            If Estorno=[S]
               TOTALN=TOTALN+VALOR
            Else
               TOTALN=TOTALN-VALOR
            EndIf
         ENDIF
      ELSEIF TIPOMOV=2
         If TCon=[N]
            If Estorno=[S]
               TOTALE=TOTALE-VALOR
            Else
               TOTALE=TOTALE+VALOR
            EndIf
         ELSE
            If Estorno=[S]
               TOTALE=TOTALE+VALOR
            Else
               TOTALE=TOTALE-VALOR
            EndIf
         ENDIF
      EndIf
      DbSkip()
   ENDDO
   SET FILTER TO
Next
IF (Paramet->TxSer)!=0
   TOTALP=TOTALN * (Paramet->TxSer/100)
   TOTALL=TOTALN+TOTALP
   TOTALPE=TOTALE * (Paramet->TxSer/100)
   TOTALLE=(TOTALE+TOTALPE)
ENDIF
JANELA(02)
RETURN Nil

// Imprimi no video

FUNCTION NOVIDEO()

SELE &Arquivo
DBGOTOP()

SETCOLOR(drvcorbox)
JANELA(01,04,01,23,77," Consulta de Movimentos ",.T.)

@ 06,02 SAY "Apto :"
@ 06,15 SAY "Pax :"
@ 06,27 SAY "Hospede :"
@ 06,09 SAY REGISTRO->APTO  PICT "999"
@ 06,21 SAY REGISTRO->PAX   PICT "99"
@ 06,37 SAY tHospede  PICT "@!"
@ 08,04 Say [Movimento Normal :]
@ 08,36 Say [Movimento Extra :]
@ 08,23 Say If(Registro->MovimN=[C],[Conjunto],[Individual])
@ 08,54 Say If(Registro->MovimE=[C],[Conjunto],[Individual])
For I=02 To 76
   @ 09,I Say [Í]
Next
FOR I=02 TO 76
   @ 18,I SAY [Í]
NEXT I
FOR I=02 TO 76
   @ 22,I SAY [Í]
NEXT I
@ 19,02 SAY "Mov. Nor.  "
@ 19,14 SAY TOTALN PICT "@E 99,999.99"
@ 20,02 SAY "Mov. Ext.  "
@ 20,14 SAY TOTALE PICT "@E 99,999.99"
IF Paramet->TxSer!=0
   @ 19,29 SAY "Taxa Ser. Nor. "
   @ 19,45 SAY TOTALP PICT "@E 99,999.99"
   @ 20,29 SAY "Taxa Ser. Ext. "
   @ 20,45 SAY TOTALPE PICT "@E 99,999.99"
ENDIF
@ 19,57 SAY "Total Nor."
@ 19,68 SAY TOTALL PICT "@E 99,999.99"
@ 20,57 SAY "Total Ext."
@ 20,68 SAY TOTALLE PICT "@E 99,999.99"
@ 24,00 SAY PADR("[ESC] Sai",80)
MDB1={[DatMov],[HoraMov],[TipMov],[TipLan],[EstLan],[TipDes],[Valor],[Opera]}
MDB2={[],[@r 99:99],[@!],[@!],[@!],[@!],[@r 99,999.99],[@!]}
MDB3={[Dt. Mov.],[Hora ],[Tp. Mov],[   ],[   ],[Tp. Despesa],[Valor],[Operador]}
DBEDIT(10,02,19,76,MDB1,,MDB2,MDB3,"Ä","³")
JANELA(02)
RETURN (NIL)

//FUNCAO IMPRIMI

FUNCTION NAIMPRE()

PRIV NUCOP:=1

SETCOLOR(drvcorbox)
JANELA(01,09,18,14,63," Solicitacao de Copias ",.T.)
@ 12,25 SAY "Informe o Numero de Copias :"
SET CURSOR ON
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
@ 12,54 GET NUCOP PICT "99" RANGE 1,99
READ
SETCOLOR(drvcorbox)
SET CURSOR OFF
JANELA(02)
IF LASTKEY()=K_ESC
   RETURN (Nil)
ENDIF
SETCOLOR(drvcorbox)
JANELA(01,09,18,14,63," Verificacao de Impressora ",.T.)
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
SELE &Arquivo
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
//         DO RODAPE
//         DO CABECA
      ENDIF
      COPRIN+=1
      DBSKIP()
   ENDDO
   IF PROW() >= 63
//      DO RODAPE
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
//DO RODAPE
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
   DBox('Apartamento n„o encontrado !!!',,,0,.T.,,)
ENDIF
SET FILTER TO
RETURN(ORDEM)
