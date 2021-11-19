/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT52.PRG
 \ Modulo..: Movimento do Hospede
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 01-02-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Lan‡ar (registrar) o movimento (gasto) de hospedes 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

LOCAL GETLIST:={}

If Select("registro")=0
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
If Select("Precos")=0
   DbfParam=DrvDbf+"Precos"
   UseArq(DbfParam)
EndIf
If Select("Categ")=0
   DbfParam=DrvDbf+"Categ"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=67
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
JANELA(01,12,06,18,75," Movimento do Hospede ")
SETCOLOR(drvcortel)
@ 12,06 Say "±±±±±±±±±±±±±±±±±±±±±±±±± Movimento do Hospede ±±±±±±±±±±±±±±±±±±±±±±±"
@ 14,07 SAY "Ú Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Data ÄÄÄÄÂ Hora ÄÄÄÄ¿"
@ 15,07 SAY "³      ³                                     ³          ³          ³"
@ 16,07 SAY "Ã Tp. Mov. Â Tipo de Despesa ÄÄÄÄÄÄÄÄÄÂ Valor ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´"
@ 17,07 SAY "³          ³                          ³                            ³"
@ 18,07 Say "ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
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
   @ 15,10 GET TAPTO PICT "9999"   VALID (VERIFICA1(@TAPTO,'C'))
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
   /*
      If Registro->movimn='C' .or. Registro->movime='C'
         TTipoDesp=MTipoDesp
         TTipoMov=MTipoMov
         Do VerConjun1
         MTipoDesp=TTipoDesp
         MTipoMov=TTipoMov
      EndIf
   */
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
   SET KEY K_F7 TO DESCMOVIM1  //ATIVA TELA DESCONTO Unitario
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
Set Key K_F7 to PesqHosp
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

//FUNCAO TELA DE DESCONTO DO MOVIMENTO

PROCEDURE DESCMOVIM1

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
   Set Key K_F7 to DescMovim1
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
Set Key K_F7 to DescMovim1
SET KEY K_F8 TO PICKS      //MENU PICK
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo")
JANELA(02)
Set Cursor On
SETCOLOR(drvcortel)
MTipoDesp=XTipo
MTipoMov=XMov
RETURN

//Fun‡„o joga todo valor para o titular caso seja algum conjunto e
//algum individual.

Procedure VerConjun1

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

//FUNCAO VERIFICA APTO ATIVO='R' EM REGISTRO

FUNCTION VERIFICA1(X)

LOCAL ORDEM

AREA=SELECT()
ORDEM=.F.
ACHOU=.F.
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
IF !EMPTY(X)
   SELE Registro
   DBGOTOP()
   LOCATE FOR (APTO=X .And. (Ativo='R' .or. Ativo='S'))
   If !Found()
      TAPTO=0
      ORDEM=.F.
      DBox('Apartamento n„o encontrado !!!',,,0,.T.,,)
   Else
      Sele ConRegis
      IF !Flag
         If Select("&Usuario")!=0
            Close
         EndIF
         Do While .T.
            If !file("&Usuario")
               Arq:={}
               AADD(Arq,{"CodHosp","N",10,0})
               AADD(Arq,{"Nome","C",35,0})
               DbCreAte("&Usuario",Arq)
               Exit
            Else
               FErase("&Usuario")
            EndIf
         EndDo
         Use &Usuario Exclusiv New
         Sele ConRegis
         Set Filter to Codigo=Registro->Codigo .And. Ativo='R'
         DbGoTop()
         Do While !Eof()
            MCodHosp=CodHosp
            Sele Hospedes
            DbGoTop()
            Locate for Codigo=ConRegis->CodHosp
            MNome=Nome
            Sele &Usuario
            Appe Blan
            Repl Nome    With MNome
            Repl CodHosp With MCodHosp
            Sele ConRegis
            DbSkip()
         EndDo
         Sele &Usuario
         MDB3={"Nome"}
         MDb1={"Nome"}
         DBGOTOP()
         Sol_Vdbf(11,11,21,53,Usuario,MDB1,Mdb3,"tApto","CONSULTA DE HOSPEDES")
         If LastKey()!=27 .And. LastKey()=13
            Sele ConRegis
            Set Filter to
            DbGoTop()
            Locate for CodHosp=&Usuario->CodHosp .And. Codigo=Registro->Codigo
            THospede=&Usuario->Nome
            MCodHosp=&Usuario->CodHosp
         EndIf
         Sele &Usuario
         Close
         Sele Hospedes
      Else
         Flag=.F.
         Sele Hospedes
         THospede=Nome
         MCodHosp=Codigo
         Sele ConRegis
         DbGoTop()
         Locate for Codigo=Registro->Codigo .And. CodHosp=Hospedes->Codigo
      EndIf
      ORDEM=.T.
   EndIf
ELSE
   DO MENUAPART1
   If Lastkey()!=27 .And. TApto!=0
      ORDEM=.T.
   EndIF
ENDIF
SELE &AREA
RETURN(ORDEM)

//MENU PICK PARA APTO e Nome do Hospede - Movimento

PROCEDURE MENUAPART1(X)
Local mDela_Atu:=SET(_SET_DELETED,.t.)
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
If Select("&Usuario")!=0
   Close
EndIF
Do While .T.
   If !file("&Usuario")
      Arq:={}
      AADD(Arq,{"Apto","N",4,0})
      AADD(Arq,{"CodHosp","N",10,0})
      AADD(Arq,{"Nome","C",35,0})
      AADD(Arq,{"Codigo","N",10,0})
      DbCreAte("&Usuario",Arq)
      Exit
   Else
      FErase("&Usuario")
   EndIf
EndDo
Use &Usuario Exclusiv New
Sele Conregis
Set Filter to Ativo='R'
DbGoTop()
Do While !Eof()
   Sele Registro
   DbGoTop()
   Locate for Codigo=ConRegis->Codigo
   Sele Hospedes
   DbGoTop()
   Locate for Codigo=ConRegis->CodHosp
   Sele &Usuario
   Appe Blan
   Repl Codigo with Registro->Codigo
   Repl Apto with Registro->Apto
   Repl CodHosp with Hospedes->Codigo
   Repl Nome with Hospedes->Nome
   Sele ConRegis
   DbSkip()
EndDo
SET(_SET_DELETED,mDela_Atu)
MDB3={"Apto","Nome"}
MDB4={"Apto","Nome"}
Sele &Usuario
DBGOTOP()
MDB1={"APTO","Nome"}
MDB2={"999","@!"}
MDB3={"Aptos","Nome"}
DBGOTOP()
Vd=.F.
Sol_Vdbf(12,09,20,55,Usuario,MDB1,Mdb3,"tApto","CONSULTA DE APARTAMENTOS")
Vd=.T.
If LastKey()!=27
   TApto=Apto
   MCodigo=Codigo
   CodiHosp=CodHosp
   Sele Registro
   DbGoTop()
   Locate for Codigo=&Usuario->Codigo
   If Registro->MovimN='C' .And. Registro->MovimE='C'
      Sele ConRegis
      DbGoTop()
      Locate for Codigo=&Usuario->Codigo
      MCodHosp=CodHosp
      MCodigo=ConRegis->Codigo
      Sele Hospedes
      DbGoTop()
      Locate for Codigo=Conregis->CodHosp
      THospede=Nome
      MCodHosp=Codigo
   Else
      Sele ConRegis
      DbGoTop()
      Locate for Codigo=&Usuario->Codigo .And. CodHosp=&Usuario->CodHosp
      MCodigo=ConRegis->Codigo
      Sele Hospedes
      DbGoTop()
      Locate for Codigo=ConRegis->CodHosp
      THospede=Nome
      MCodHosp=Codigo
   EndIf
EndIf
Sele &Usuario
Zap
Close
FErase("&Usuario")
Sele Hospedes
Set Order to 0
Sele ConRegis
SET FILTER TO
SETCURSOR(CUR)
SELE &AREA
RETURN(.T.)
