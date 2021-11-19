/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT29.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Efetuar Desconto Cont¡nuo
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

LOCAL GETLIST:={}

/*
   Nivelop = Nivel de acesso do usuario (1=operacao, 2=manutencao e
   3=gerencia)
*/
IF nivelop < 1          // se usuario nao tem
   ALERTA()               // permissao, avisa
   DBOX(msg_auto,,,3)     // e retorna
   RETU
ENDI

If Select("registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("Conregis")=0
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
If select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
EndIf
If Select("Departa")=0
   DbfParam=DrvDbf+"Departa"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=75
AREAS=SELECT()
REGISTROS=RECNO()
COROLD=SETCOLOR()
CURS=SETCURSOR()
Private DesUni:=.F.
SELE Movim
Barra=SaveScreen(24,00,24,79)
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,12,07,18,76," Desconto Cont¡nuo ")
SETCOLOR(drvcortel)
@ 12,07 Say "±±±±±±±±±±±±±±±±±±±±±±±± Desconto Cont¡nuo ±±±±±±±±±±±±±±±±±±±±±±±±±±±"
@ 14,08 SAY "Ú Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Data ÄÄÄÄÂ Hora ÄÄÄÄ¿"
@ 15,08 SAY "³      ³                                     ³          ³          ³"
@ 16,08 SAY "Ã Tipo de Despesa ÄÂ Porcentagem Â Valor ÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´"
@ 17,08 SAY "³                  ³         %   ³                                 ³"
@ 18,08 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
JANELA(01,02,01,11,38,[S]," Movimento Normal ",.T.)
@ 02,01 say "±±±±±±±±± Movimento Normal ±±±±±±±±±±±"
JANELA(01,02,41,11,78,[S]," Movimento Extra ",.T.)
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
   MPorc=0
   Mfinal=0
   @ 15,17 SAY THOSPEDE
   @ 15,55 SAY MDATMOV
   SETCOLOR(drvcorbox)
   InfoSis("Inclui","[F8] Tabela")
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 15,66 GET MHORAMOV      PICT "@R 99:99"         VALID(!EMPTY(MHORAMOV))
   @ 17,10 GET MTIPODESP     PICT "99"               VALID(VERTDESP(@MTIPODESP,17,13)) //MENU PICKS
   READ
   IF LASTKEY()=K_ESC
      DBox('Desconto Cont¡nuo n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   If Registro->movimn='C' .or. Registro->movime='C'
      TTipoDesp=MTipoDesp
      TTipoMov=MTipoMov
      Do VerConjunto
      MTipoDesp=TTipoDesp
      MTipoMov=TTipoMov
   EndIf
   Sele Desconto
   DbGoTop()
   Locate for Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp .And. TipoDesp=MTipoDesp
   If Found()
      TTValor=Trans(Desconto->Final,'@E 999,999.99')
      TTPorc=Str(Desconto->Porc)
      Sele Departa
      DbGoTop()
      Locate for Codigo=Desconto->TipoDesp
      DBox('J  existe Desconto Cont¡nuo cadastrado|para este hospede.||Tipo Despesa...: '+Departa->TipoDesp+'|Valor..........: '+TTValor+'   |Porcentagem....: '+TTPorc+' %        ',,,0,.T.,,)
   EndIF
   @ 17,31 Get MPorc         Pict "999"
   @ 17,50 GET MFinal        PICT "@E 999,999.99"    When(Empty(MPorc))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      DBox('Desconto Cont¡nuo n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   Sele Desconto
   mOperador=Usuario
   mTCON = "D"
   MEstorno='N'
   Mdatmov=DataC
   Mhoramov=Hora(Time())
   IF TRAVAREG()
      MCODIGO=REGISTRO->CODIGO
      REPL_VAR()
      UNLOCK
   ENDIF
   Do MudaJan
   THOSPEDE=SPACE(35)
   MDATMOV=DataC
   MHORAMOV=HORA(TIME())
   MTipoDesp=0
   MFinal=0
   MPorc=0
   @ 15,17 SAY THOSPEDE
   @ 15,55 SAY MDATMOV
   @ 15,66 say MHORAMOV      PICT "@R 99:99"
   @ 17,10 say MTIPODESP     PICT "99"
   @ 17,31 Say MPorc         Pict "999"
   @ 17,50 say MFinal        PICT "@E 999,999.99"
   @ 17,13 Say "            "
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
