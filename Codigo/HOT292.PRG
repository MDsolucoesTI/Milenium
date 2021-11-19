 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT292.PRG
 \ Data....: 04-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Aplicar desconto de valores     
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


Use Registro Index Registr1, Registr2, Registr3 shared New
Use Conregis Index Conregi1 Shared New
Use clientes Index clientes1, clientes2, clientes3 Shared New
Use Aptos Index Aptos1 Shared New
Use Hospedes Index Hospede1, Hospede2, Hospede3 Shared New
Use Desconto Index Descont1 Shared New
Use Movim Index Movim1 Shared New
Use Departa Index Departa1 Shared New

Cod_Sos_Ant=Cod_Sos
Cod_Sos=67
AREAS=SELECT()
REGISTROS=RECNO()
COROLD=SETCOLOR()
CURS=SETCURSOR()
Private DesUni:=.F.
SELE Movim
Barra=SaveScreen(24,00,24,79)
SETCOLOR(drvcorbox)
@ 24,00 SAY PADR("[F8] Tabela",80)
JANELA(01,13,08,19,75," Desconto Geral ")
SETCOLOR(drvcortel)
@ 14,09 SAY " Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Data ÄÄÄÄÂ Hora ÄÄÄÄ"
@ 15,09 SAY "      ³                                     ³          ³          "
@ 16,09 SAY " Tp. Mov. Â Tipo de Despesa ÄÄÄÄÄÄÄÄÄÂ Valor ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ"
@ 17,09 SAY "          ³                          ³                            "
@ 18,09 Say "ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
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
   REGIST=RECNO()
   SET FILTER TO CODIGO=REGISTRO->CODIGO .AND. TIPOMOV=1 .And. CodHosp=ConRegis->CodHosp
   DBGOTOP()
   DO WHILE !EOF()
      AADD(NORMALT,TCON)
      AADD(NORMALDT,DATMOV)
      Sele Departa
      DbGoTop()
      Locate for Codigo=Movim->TipoDesp
      AADD(NORMALTP,TipoDesp)
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
   @ 05,03 CLEAR TO 09,33
   @ 05,46 CLEAR TO 09,76
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
      @ 10,10 SAY TOTALN PICT "@R 999,999,999.99"
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
      @ 10,51 SAY TOTALE PICT "@R 999,999,999.99"
   ENDIF
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
   @ 24,00 SAY PADR("[F8] Tabela",80)
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 15,66 GET MHORAMOV      PICT "@R 99:99"         VALID(!EMPTY(MHORAMOV))
   @ 17,10 GET MTIPOMOV      PICT "9"                VALID(VERTMOV(@MTIPOMOV,"C"))   //MENU PICKS
   @ 17,21 GET MTIPODESP     PICT "99"               VALID(VERTDESP(@MTIPODESP,"C")) //MENU PICKS
   @ 17,48 GET MVALOR        PICT "@E 999,999.99"    VALID(MValor>0)
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      DBox('Desconto n„o Cadastrado !!!',,,0,.T.,,)
      EXIT
   ENDIF
   TValor=MValor
   MValor=TValor*(-1)
   mOperador=Usuario
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
