/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT24.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Efetuar a sa¡da de Hospede
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
EndIf
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
If Select("Desconto")=0
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam)
EndIf
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=76
Op_Menu=1
Barra=SaveScreen(24,00,24,79)
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,12,07,18,76," Sa¡da de Hospede ")
SETCOLOR(drvcortel)
@ 12,07 Say "±±±±±±±±±±±±±±±±±±±±±±±±±± Sa¡da de Hospede ±±±±±±±±±±±±±±±±±±±±±±±±±±"
@ 14,08 SAY "Ú Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Pax Â Data Entrada Ä¿"
@ 15,08 SAY "³      ³                                     ³     ³               ³"
@ 16,08 SAY "Ã Hora Entr. Â Movimento Normal Â Movimento Extra ÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 17,08 SAY "³            ³                  ³                  ³±±±±±±±±±±±±±±±³"
@ 18,08 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
MOPERADOR=Usuario
TAPTO=0
SET CURSOR ON
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
Set Key K_F8 to Picks
@ 15,10 GET TAPTO PICT "9999"   VALID (VERIFICA(@TAPTO,'C'))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   Janela(02)
   Cod_Sos=Cod_Sos_Ant
   Return
ENDI
Sele Hospedes
DbGoTop()
Locate for Codigo=ConRegis->CodHosp
THospede=Nome
@ 15,17 SAY THOSPEDE
@ 15,55 SAY Registro->Pax     Pict "99"
@ 15,63 Say Registro->dtent
@ 17,12 Say Registro->hent    PIct "@R 99:99"
@ 17,25 Say Registro->movimn
If Registro->movimn='C'
   @ 17,26 Say 'ONJUNTO  '
Else
   @ 17,26 Say 'NDIVIDUAL'
EndIf
@ 17,44 Say Registro->movimE
If Registro->movimE='C'
   @ 17,45 Say 'ONJUNTO  '
Else
   @ 17,45 Say 'NDIVIDUAL'
EndIf
Mfinalnor=Conregis->finalnor
Mporcnor=Conregis->Porcnor
Mfinalext=Conregis->finalext
Mporcext=Conregis->porcext
If (Registro->movimn='I' .And. Registro->movime='I')
   DBox('N„o ‚ poss¡vel efetuar a Sa¡da do Hospede pois|o Movimento Normal e o Movimento Extra|s„o Individuais.',,,0,.T.,,)
   Janela(02)
   Cod_Sos=Cod_Sos_Ant
   Return
EndIF
If !Registro->Pax>1
   DBox('N„o ‚ poss¡vel efetuar a Sa¡da do Hospede pois|no apartamento possui um £nico hospede.',,,0,.T.,,)
   Janela(02)
   Cod_Sos=Cod_Sos_Ant
   Return
EndIf
If (Registro->movimn='I' .or. Registro->movime='I')   //Verifica se fechou conta individual
   reg_dbf=POINTER_DBF()                         // salva situacao de todos dbf's
   MCodHosp=ConRegis->CodHosp
   Sele Registro
   Set Order to 1           //por c¢digo
   If Registro->movimn='I'
      Set Filter to Apto=TApto .And. Ativo='N' .And. movimn='I' .And. movime='C'
   Else
      Set Filter to Apto=TApto .And. Ativo='N' .And. movime='I' .And. movimn='C'
   EndIf
   DbGoBoTtom()
   Sele ConRegis
   DbGoTop()
   Locate for Codigo=Registro->Codigo .And. Ativo='N' .And. CodHosp=MCodHosp .And. Rd!=0
   If !Found()
      DBox('N„o ‚ poss¡vel efetuar a Sa¡da do Hospede pois|a conta individual do hospede est |em aberto.',,,0,.T.,,)
      Janela(02)
      Cod_Sos=Cod_Sos_Ant
      Return
   Else
      Do While .T.
         If Rlock()
            Repl finalnor With mfinalnor
            Repl porcnor  With mporcnor
            Repl finalext With mfinalext
            Repl porcext  With mporcext
            Unlock
            Exit
         EndIf
      EndDo
   EndIf
   Sele Registro
   Set Filter to
   Set Order to 0
   Sele ConRegis
   Set Filter to
   POINTER_DBF(reg_dbf)                          // restaura ponteiro dos dbf's
EndIf
XXX=Space(01)
XX=Space(01)
@ 17,10 Get XX  When Balao(11)
Read
If XXX='S'
   If Registro->movimn='I'
      Mov=2
   Else
      Mov=1
   EndIF
   Sele ConRegis
   Set Filter to Codigo=Registro->Codigo .And. Ativo='S'
   DbGoTop()
   DbSkip()
   TCodHosp=CodHosp     //Ser  o novo CodHosp do Titular
   DbGoTop()
   Sele Movim
   Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp .And. tipomov=Mov
   DbGoTop()
   Do While !Eof()
      Do While .T.
         If Rlock()
            Repl CodHOsp With TCodHosp
            Unlock
            Exit
         EndIF
      EndDo
      DbSkip()
   EndDo
   Sele Desconto
   Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp
   DbGoTop()
   Do While !Eof()
      Do While .T.
         If Rlock()
            Repl CodHosp With TCodHosp
            Unlock
            Exit
         EndIF
      EndDo
      DbSkip()
   EndDo
   Sele ConRegis
   mCodHosp=CodHosp
   Do While .T.
      If Rlock()
         Repl Ativo with 'N'
         Repl dtsai With DataC
         Repl hsai  With Hora(Time())
         Unlock
         Exit
      EndIF
   EndDo
   Set Filter to Ativo='S'
   DbGoTop()
   Locate for codHosp=mCodHosp
   If !Found()
      Sele Hospedes
      DbGoTop()
      Locate for Codigo=mCodHosp
      Do While .T.
         If Rlock()
            Repl Ativo With 'N'
            Unlock
            Exit
         EndIf
      EndDo
   EndIf
   Sele ConRegis
   Set Filter to
   Sele Registro
   Do While .T.
      If Rlock()
         mPax=Pax-1
         Repl Pax With mPax
         Unlock
         Exit
      EndIf
   EndDo
   DBox('Sa¡da do Hospede efetuada com sucesso !!!',,,0,.T.,,)
EndIf
Janela(02)
Cod_Sos=Cod_Sos_Ant
Return
