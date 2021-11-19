/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT22.PRG
 \ Modulo..: Movimento do Hospede
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 01-02-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Registrar o Movimento do Hospede
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

LOCAL GETLIST:={},Areas_Ant[10],ArAlias[10]

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
   Areas_Ant[1]=.T.
   ArAlias[1]="Registro"
Else
   Sele Registro
   Areas_Ant[1]=.F.
   ArAlias[1]="Registro"
EndIf
If Select("Conregis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
   areas_ant[2]=.T.
   ArAlias[2]="ConRegis"
Else
   Sele ConRegis
   areas_ant[2]=.F.
   ArAlias[2]="ConRegis"
EndIf
If Select("clientes")=0
   DbfParam=DrvDbf+"clientes"
   UseArq(DbfParam)
   areas_ant[3]=.T.
   ArAlias[3]="clientes"
Else
   Sele clientes
   areas_ant[3]=.F.
   ArAlias[3]="clientes"
EndIf
If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
   areas_ant[4]=.T.
   ArAlias[4]="Aptos"
Else
   Sele Aptos
   areas_ant[4]=.F.
   ArAlias[4]="Aptos"
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
   areas_ant[5]=.T.
   ArAlias[5]="Hospedes"
Else
   Sele Hospedes
   areas_ant[5]=.F.
   ArAlias[5]="Hospedes"
EndIf
If Select("Desconto")=0
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam)
   areas_ant[6]=.T.
   ArAlias[6]="Desconto"
Else
   Sele Desconto
   areas_ant[6]=.F.
   ArAlias[6]="Desconto"
EndIf
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
   areas_ant[7]=.T.
   ArAlias[7]="Movim"
Else
   Sele Movim
   areas_ant[7]=.F.
   ArAlias[7]="Movim"
EndIf
If Select("Departa")=0
   DbfParam=DrvDbf+"Departa"
   UseArq(DbfParam)
   areas_ant[8]=.T.
   ArAlias[8]="Departa"
Else
   Sele Departa
   areas_ant[8]=.F.
   ArAlias[8]="Departa"
EndIf
If Select("Precos")=0
   DbfParam=DrvDbf+"Precos"
   UseArq(DbfParam)
   areas_ant[9]=.T.
   ArAlias[9]="Precos"
Else
   Sele Precos
   areas_ant[9]=.F.
   ArAlias[9]="Precos"
EndIf
If Select("Categ")=0
   DbfParam=DrvDbf+"Categ"
   UseArq(DbfParam)
   areas_ant[10]=.T.
   ArAlias[10]="Categ"
Else
   Sele Categ
   areas_ant[10]=.F.
   ArAlias[10]="Categ"
EndIf
Cod_Sos_Ant=Cod_Sos
Cod_Sos=67
SET KEY K_ALT_M TO
Set Key K_F2 to
Set Key K_ALT_H to
AREAS=SELECT()
REGISTROS=RECNO()
COROLD=SETCOLOR()
CURS=SETCURSOR()
Private DesUni:=.F.
Op_Menu=1
mAUTOR='GERENCIA       '
mPORC=0
mFinal=0
mOBS=SPACE(30)
SELE Movim
Barra=SaveScreen(24,00,24,79)
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,12,07,18,76," Movimento do Hospede ")
SETCOLOR(drvcortel)
@ 12,07 Say "±±±±±±±±±±±±±±±±±±±±±±±± Movimento do Hospede ±±±±±±±±±±±±±±±±±±±±±±±±"
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
   MEstorno='N'
   WTcon='N'
   MOPERADOR=Usuario
   TAPTO=0
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   Set Key K_F8 to Picks
   Flag=.F.
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
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 15,66 GET MHORAMOV      PICT "@R 99:99"         VALID(!EMPTY(MHORAMOV))
   @ 17,10 GET MTIPOMOV      PICT "9"                VALID(VERTMOV(@MTIPOMOV,"C"))   //MENU PICKS
   @ 17,21 GET MTIPODESP     PICT "99"               VALID(VERTDESP(@MTIPODESP)) //MENU PICKS
   Read
   IF LASTKEY()=K_ESC
      DBox('Movimento n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   If Registro->movimn='C' .or. Registro->movime='C'
      TTipoDesp=MTipoDesp
      TTipoMov=MTipoMov
      Do VerConjunto
      MTipoDesp=TTipoDesp
      MTipoMov=TTipoMov
   EndIf
   Sele Movim
   DbGoTop()
   MValor=0
   If MTipoDesp=1
      Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp .And. TCon='N' .And. estorno='N' .And. TipoDesp=1
      DbGoBoTTom()
      MValor=Valor
      Set Filter to
      If MValor!=0
         If datmov=DataC
            DBox('J  foi lan‡ado uma Di ria hoje, '+DtoC(DataC)+'|para este Hospede.',,,0,.T.,,)
         EndIf
      Else
         Sele Categ
         DbGoTop()
         Locate for Pax=Registro->Pax
         Sele precos
         DbGoTop()
         Locate for tipo=Aptos->Tipo .And. categ=Categ->Codigo
         If Found()
            MValor=diaria
         Else
            MValor=0
            DBox('N„o foi encontrado nenhuma di ria lan‡ada para|este hospede, e na Tabela de Di rias n„o existe|valor de acordo com este n£mero de Pax.',,,0,.T.,,)
         EndIf
      EndIf
   EndIF
   SET KEY K_F7 TO DESCMOVIM  //ATIVA TELA DESCONTO Unitario
   Set Key K_F4 to Desconto1   // Ativa Tela Desconto Continuo
   SETCOLOR(drvcorbox)
   InfoSis("Inclui","[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo")
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 17,48 GET MVALOR        PICT "@E 999,999.99"     VALID(MVALOR>0)
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      DBox('Movimento n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   Sele Movim
   MTCON='N'
   MEstorno='N'
   WTcon='N'
   mOperador=Usuario
   Do While .T.
      IF TRAVAREG()
         MCODIGO=REGISTRO->CODIGO
         Mdatmov=DataC
         Mhoramov=Hora(Time())
         REPL_VAR()
         UNLOCK
         Exit
      ENDIF
   EndDo
   Sele Desconto
   DbGoTop()
   Locate FOR CODIGO=REGISTRO->CODIGO .And. CodHosp=ConRegis->CodHosp .And. Tipodesp=MTipodesp
   IF FOUND()
      If !Empty(Final)
         MVALOR=Final*(-1)
      Else
         TValor = (mValor*(Porc/100))*(-1)
         MValor=TValor
      EndIf
      Sele Movim
      mTCON = "D"
      MEstorno='N'
      IF TRAVAREG()
         MCODIGO=REGISTRO->CODIGO
         REPL_VAR()
         UNLOCK
      ENDIF
   EndIf
   If DesUni
      If !Empty(mFinal)
         mValor = mFinal*(-1)
      Else
         TValor = mValor*(mPorc/100)*(-1)
         MValor=TValor
      EndIf
      mTCON = "D"
      MEstorno='N'
      DesUni = .F.
      Sele Movim
      IF TRAVAREG()
         MCODIGO=REGISTRO->CODIGO
         REPL_VAR()
         UNLOCK
      ENDIF
   EndIF
   Do MudaJan
   SETCOLOR(drvcortel)
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
   Set Key K_F7 to         // Desativa F7 Tela Desconto Unitario
   SET KEY K_F4  TO        //DESATIVA F4 TELA DE DESCONTO
   SETCOLOR(drvcorbox)
   InfoSis("Inclui","[F8] Tabela")
   SETCOLOR(drvcortel)
ENDDO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
SET KEY K_F4 TO
Set Key K_F7 to
SET KEY K_ALT_M TO HOT22
If Sets
   Set Key K_F2 to MudaOp
   Set Key K_ALT_H to AtuData
EndIf
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
For Int=1 To 10         //Loop para fechamento das areas
   If Areas_Ant[Int]
      XXXXX=ArAlias[Int]
      Sele &XXXXX
      Close
   EndIf
Next
Cod_Sos=Cod_Sos_Ant
RETURN

//FUNCAO TELA DE DESCONTO DO MOVIMENTO

PROCEDURE DESCMOVIM

LOCAL GETLIST:={},Area,Regi

@ 03,02 Clear to 10,37
@ 03,42 Clear to 10,77
JANELA(01,02,01,11,38," Movimento Normal ")
JANELA(01,02,41,11,78," Movimento Extra ")
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
XTipo=MTipoDesp
XMov=MTipoMov
Do MudaJan
AREA=SELECT()
REGI=RECNO()
Set Key K_F7 to  // Desativa F7 Tela Desconto Unitario
SET KEY K_F4  TO        //DESATIVA F4 TELA DE DESCONTO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
RestScreen(24,00,24,79,Barra)
JANELA(01,14,01,18,74," Desconto Unit rio ")
mAUTOR='GERENCIA       '
mPORC=0
mFinal=0
mOBS=SPACE(30)
D=.T.
SETCOLOR(drvcortel)
@ 15,02 SAY " Porc. ÄÂ Valor ÄÄÄÄÂ Observacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Quem Autorizou ÄÄ"
@ 16,02 SAY "     %  ³           ³                                ³                  "
@ 17,02 SAY "ÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
SETCOLOR(drvcorbox)
InfoSis("Inclui","[ESC] Sai")
SET CURSOR ON
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
@ 16,03 GET mPORC       PICT "999"
@ 16,12 GET mFinal      PICT "@E 99,999.99"    WHEN(EMPTY(mPORC))
@ 16,24 GET mOBS
@ 16,57 GET mAUTOR                             VALID(!EMPTY(mAUTOR))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   JANELA(2)
   SELE &AREA
   If Regi!=0
      Go Regi
   EndIf
   SET KEY K_F4 TO Desconto1  //TELA DE DESCONTO - HOTRT
   Set Key K_F7 to DescMovim
   SET KEY K_F8 TO Picks      //MENU PICK
   SETCOLOR(drvcorbox)
   InfoSis("Inclui","[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo")
   Set Cursor On
   SETCOLOR(drvcortel)
   MTipoDesp=XTipo
   MTipoMov=XMov
   RETURN
ENDIF
/*
If !Empty(mFinal)
            XVALOR=mFinal*(-1)
Else
            XValor=(mValor*(Porc/100))*(-1)
EndIf
Sele Movim
mTCON = "D"
MEstorno='N'
MValor=XValor
IF TRAVAREG()
            MCODIGO=REGISTRO->CODIGO
            REPL_VAR()
            UNLOCK
ENDIF
*/
DesUni=.T.
SELE &AREA
If Regi!=0
   GO Regi
EndIf
SET KEY K_F4 TO DESCONTO1   //TELA DE DESCONTO - HOTRT
Set Key K_F7 to DescMovim
SET KEY K_F8 TO PICKS      //MENU PICK
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo")
JANELA(02)
Set Cursor On
SETCOLOR(drvcortel)
MTipoDesp=XTipo
MTipoMov=XMov
RETURN

//Fun‡„o monta janela superior de normal e extra
Procedure MudaJan

Local Area:=Select(),Reg:=Recno()

Sele Movim
Inic_Var()
MCodHosp=ConRegis->CodHosp
MCodigo=Registro->Codigo
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
REGIST=RECNO()
SET FILTER TO CODIGO=REGISTRO->CODIGO .AND. TIPOMOV=1 .And. CodHosp=ConRegis->CodHosp
DBGOTOP()
DO WHILE !EOF()
   AADD(NORMALT,TCON)
   AADD(NORMALDT,DATMOV)
   Sele Departa
   DbGoTop()
   Locate for Codigo=Movim->TipoDesp
   AADD(NORMALTP,TIPODESP)
   Sele Movim
   AADD(NORMALVL,VALOR)
   CONTN++
   TOTALN=TOTALN+VALOR
   DBSKIP()
ENDDO
SET FILTER TO CODIGO=REGISTRO->CODIGO .AND. TIPOMOV=2 .And. CodHosp=ConRegis->CodHosp
DBGOTOP()
DO WHILE !EOF()
   AADD(EXTRAT,TCON)
   AADD(EXTRADT,DATMOV)
   Sele Departa
   DbGoTop()
   Locate for Codigo=Movim->TipoDesp
   AADD(EXTRATP,TIPODESP)
   Sele Movim
   AADD(EXTRAVL,VALOR)
   CONTE++
   TOTALE=TOTALE+VALOR
   DBSKIP()
ENDDO
SET FILTER TO
IF REGIST#0
   GO REGIST
ENDIF
@ 03,02 CLEAR TO 10,37
@ 03,42 CLEAR TO 10,77
SETCOLOR(drvcortel)
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
IF CONTN>5
   X=5
ELSEIF CONTN<=5
   X=CONTN-1
ENDIF
IF CONTN>0
   LIN=03
   FOR I=(CONTN-X) TO CONTN
      @ LIN,02 SAY NORMALT[I]
      @ LIN,04 SAY NORMALDT[I]
      @ LIN,13 SAY NORMALTP[I]
      @ LIN,26 SAY NORMALVL[I] PICT "@E 9,999,999.99"
      LIN++
   NEXT
   @ 10,10 SAY TOTALN PICT "@E 999,999,999.99"
ENDIF
IF CONTE>5
   X=5
ELSE
   X=CONTE-1
ENDIF
IF CONTE>0
   LIN=03
   FOR I=(CONTE-X) TO CONTE
      @ LIN,42 SAY EXTRAT[I]
      @ LIN,44 SAY EXTRADT[I]
      @ LIN,53 SAY EXTRATP[I]
      @ LIN,66 SAY EXTRAVL[I] PICT "@E 9,999,999.99"
      LIN++
   NEXT
   @ 10,51 SAY TOTALE PICT "@E 999,999,999.99"
ENDIF
Sele &Area
If Reg!=0
   Go Reg
EndIF
Return

//Fun‡„o joga todo valor para o titular caso seja algum conjunto e
//algum individual.

Procedure VerConjunto

Local Area:=Select()

Do Case
   Case Registro->movimn='C' .And. Registro->movime='I' .And. MTipoMov=1
      Sele ConRegis
      DbGoTop()
      Locate for Codigo=Registro->Codigo .And. Ativo='S'
      MCodHosp=CodHosp
      MCodigo=Codigo
      Sele Hospedes
      Locate for Codigo=ConRegis->CodHosp
      THospede=Nome
      @ 15,17 SAY THOSPEDE
      Do MudaJan
   Case Registro->movimn='I' .And. Registro->movime='C' .And. MTipoMov=2
      Sele ConRegis
      DbGoTop()
      Locate for Codigo=Registro->Codigo .And. Ativo='S'
      MCodHosp=CodHosp
      MCodigo=Codigo
      Sele Hospedes
      Locate for Codigo=ConRegis->CodHosp
      THospede=Nome
      @ 15,17 SAY THOSPEDE
      Do MudaJan
EndCase
Sele &Area
Return
