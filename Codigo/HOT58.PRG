 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT58.PRG
 \ Data....: 04-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rotina avulsa (Exclus„o de Movimentos) 
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

/*
   Nivelop = Nivel de acesso do usuario (1=operacao, 2=manutencao e
   3=gerencia)
*/

Local Ant_Sos:=Cod_Sos
Cod_Sos=80

IF nivelop < 1          // se usuario nao tem
   ALERTA()               // permissao, avisa
   DBOX(msg_auto,,,3)     // e retorna
   RETU
ENDI

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
Cod_Sos=80
AREAS=SELECT()
REGISTROS=RECNO()
COROLD=SETCOLOR()
CURS=SETCURSOR()
Private DesUni:=.F.
SELE Movim
Barra=SaveScreen(24,00,24,79)
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,12,07,16,76," Exclus„o de Movimentos ")
SETCOLOR(drvcortel)
@ 12,07 Say "±±±±±±±±±±±±±±±±±±±±±±± Exclus„o de Movimentos ±±±±±±±±±±±±±±±±±±±±±±±"
@ 14,08 SAY "Ú Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Dt Sa¡da Â H. Sa¡da ¿"
@ 15,08 SAY "³      ³                                     ³          ³          ³"
@ 16,08 Say "ÀÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ"
DO WHILE .T.
   Sele Movim
   INIC_VAR()
   THOSPEDE=SPACE(35)
   TTIPOMOV=SPACE(01)
   TTIPODESP=SPACE(01)
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
   SETCOLOR(drvcortel)
   @ 15,17 SAY THOSPEDE
   @ 15,55 SAY ConRegis->DtSai
   @ 15,66 Say ConRegis->hsai      PICT "@R 99:99"
   SET CURSOR Off
   Opcao="S"
   XXX=Space(01)
   @ 15,63 Get XXX  When Balao(14)
   Read
   If Opcao='S' .and. LastKey()!=27
      Sele Movim
      Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp
      Do While !Eof()
         Do While .T.
            If Rlock()
               Dele
               Unlock
               Exit
            EndIf
         EndDo
         DbSkip()
      EndDo
      Sele Desconto
      DbGoTop()
      Locate for Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp
      If Found()
         Ocao="S"
         XXX=Space(01)
         @ 15,63 Get XXX  When Balao(17)
         Read
         If Ocao='S'
            Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp
            DbGoTop()
            Do While !Eof()
               Do While .T.
                  If Rlock()
                     Dele
                     Unlock
                     Exit
                  EndIf
               EndDo
               DbSkip()
            EndDo
         EndIf
      EndIf
   EndIf
   SETCOLOR(drvcortel)
   THOSPEDE=SPACE(35)
   MDATMOV=CtoD("  /  /  ")
   MHORAMOV=0
   @ 15,17 SAY THOSPEDE
   @ 15,55 SAY MDATMOV
   @ 15,66 say MHORAMOV      PICT "@R 99:99"
ENDDO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
JANELA(02)         //FECHA JANELA PRINCIPAL
SETCURSOR(CURS)
SELE &AREAS
IF REGISTROS#0
   GO REGISTROS
ENDIF
RestScreen(24,00,24,79,Barra)
SETCOLOR(COROLD)
Cod_Sos=Ant_Sos
RETU

* \\ Final de HOT58.PRG
