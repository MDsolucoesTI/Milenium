/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT261.PRG
 \ Modulo..: Estorno de Movimentos do Hospede
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 01-02-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Desfazer compras (movimento) de valores do Hospede 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

LOCAL GETLIST:={}

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("clientes")=0
   DbfParam=DrvDbf+"clientes"
   UseArq(DbfParam)
EndIf
If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
If Select("Desconto")=0
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam)
EndIf
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
EndIf
If Select("Departa")=0
   DbfParam=DrvDbf+"Departa"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=77
AREAS=SELECT()
REGISTROS=RECNO()
COROLD=SETCOLOR()
CURS=SETCURSOR()
Private DesUni:=.F.
SELE Movim
Barra=SaveScreen(24,00,24,79)
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,12,07,18,76," Estorno de Movimentos ")
SETCOLOR(drvcortel)
@ 12,07 Say "±±±±±±±±±±±±±±±±±±±±±±±±± Estorno de Movimento ±±±±±±±±±±±±±±±±±±±±±±±"
@ 14,08 SAY "Ú Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Data ÄÄÄÄÂ Hora ÄÄÄÄ¿"
@ 15,08 SAY "³      ³                                     ³          ³          ³"
@ 16,08 SAY "Ã Tp. Mov. Â Tipo de Despesa ÄÄÄÄÄÄÄÄÄÂ Valor ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´"
@ 17,08 SAY "³          ³                          ³                            ³"
@ 18,08 Say "ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
JANELA(01,02,01,11,38,[S]," Movimento Normal ",.T.)
JANELA(01,02,41,11,78,[S]," Movimento Extra ",.T.)
@ 02,01 say "±±±±±±±±± Movimento Normal ±±±±±±±±±±±"
@ 02,41 Say "±±±±±±±±± Movimento Extra ±±±±±±±±±±±±"
FOR I=3 TO 08
   @ I,03 SAY "³"
   @ I,12 SAY "³"
   @ I,25 SAY "³"
NEXT
FOR I=3 TO 08
   @ I,43 SAY "³"
   @ I,52 SAY "³"
   @ I,65 SAY "³"
NEXT
FOR I=03 TO 37
   @ 09,I SAY "Ä"
NEXT
@ 10,03 SAY "Total "
FOR I=43 TO 77
   @ 09,I SAY "Ä"
NEXT
@ 10,43 SAY "Total "
DO WHILE .T.
   Sele Movim
   INIC_VAR()
   NORMALT:={}
   NORMALDT:={}
   NORMALTP:={}
   NORMALVL:={}
   EXTRAT:={}
   EXTRATP:={}
   EXTRADT:={}
   EXTRAVL:={}
   CONTE=0        //CONTADOR EXTRA
   CONTN=0        //CONTADOR NORMAL
   TOTALN=0
   TOTALE=0
   THOSPEDE=SPACE(35)
   TTIPOMOV=SPACE(01)
   TTIPODESP=SPACE(01)
   MTCON='N'
   MEstorno='S'
   WTcon='N'
   MOPERADOR=Usuario
   TAPTO=0
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   Set Key K_F8 to Picks
   @ 15,10 GET TAPTO PICT "9999"   VALID (VERIFICA(@TAPTO,'C'))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      EXIT
   ENDI
   Do MudaJan
   MDATMOV=DataC
   MHORAMOV=HORA(TIME())
   MTipoMov=1
   MTipoDesp=0
   MValor=0
   If MTipoMov=1
      @ 17,12 Say 'NORMAL'
   Else
      @ 17,12 Say 'EXTRA '
   EndIf
   @ 15,17 SAY THOSPEDE
   @ 15,55 SAY MDATMOV
   SETCOLOR(drvcorbox)
   InfoSis("Inclui","[F8] Tabela")
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 15,66 GET MHORAMOV      PICT "@R 99:99"         VALID(!EMPTY(MHORAMOV))
   @ 17,10 GET MTIPOMOV      PICT "9"                VALID(VERTMOV(@MTIPOMOV,"C"))   //MENU PICKS
   @ 17,21 GET MTIPODESP     PICT "99"               VALID(VERTDESP(@MTIPODESP)) //MENU PICKS
   READ
   IF LASTKEY()=K_ESC
      DBox('Estorno n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   If Registro->movimn='C' .or. Registro->movime='C'
      TTipoDesp=MTipoDesp
      TTipoMov=MTipoMov
      Do VerConjunto
      MTipoDesp=TTipoDesp
      MTipoMov=TTipoMov
   EndIf
   @ 17,48 GET MVALOR        PICT "@E 999,999.99"    VALID(MValor>0)
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      DBox('Estorno n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   TValor=MValor
   MValor=TValor*(-1)
   mOperador=Usuario
   mTCON = "N"
   MEstorno='S'
   Mdatmov=DataC
   Mhoramov=Hora(Time())
   IF TRAVAREG()
      MCODIGO=REGISTRO->CODIGO
      REPL_VAR()
      UNLOCK
   ENDIF
   TValor=MValor
   MValor=TValor*(-1)
   Sele Desconto
   DbGoTop()
   Locate FOR CODIGO=REGISTRO->CODIGO .And. CodHosp=ConRegis->CodHosp .And. Tipodesp=MTipodesp
   IF FOUND()
      If !Empty(Final)
         MVALOR=Final
      Else
         mValor = (mValor*(Porc/100))
      EndIf
      Sele Movim
      mTCON = "D"
      MEstorno='S'
      IF TRAVAREG()
         MCODIGO=REGISTRO->CODIGO
         REPL_VAR()
         UNLOCK
      ENDIF
   EndIf
   Do MudaJan
   THOSPEDE=SPACE(35)
   MDATMOV=DataC
   MHORAMOV=HORA(TIME())
   MTipoMov=1
   MTipoDesp=0
   MValor=0
   @ 15,17 SAY THOSPEDE
   @ 15,55 SAY MDATMOV
   @ 15,66 say MHORAMOV      PICT "@R 99:99"
   @ 17,10 say MTIPOMOV      PICT "9"
   @ 17,21 say MTIPODESP     PICT "99"
   @ 17,48 say MVALOR        PICT "@E 999,999.99"
   @ 17,24 Say "            "
ENDDO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
JANELA(02)        //FECHA A JANELA DE NORMAL
JANELA(02)        //FECHA A JANELA DE EXTRA
JANELA(02)         //FECHA JANELA PRINCIPAL
SETCURSOR(CURS)
SELE &AREAS
IF REGISTROS#0
   GO REGISTROS
ENDIF
RestScreen(24,00,24,79,Barra)
SETCOLOR(COROLD)
Cod_Sos=Cod_Sos_Ant
RETURN
