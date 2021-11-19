/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT28.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Efetuar Troca de Apartamento
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

SET KEY K_F8 TO PICKS   //ATIVA MENU PICK

If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"Conregis"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=72
THOSPEDE=SPACE(35)
TDTENT=""
THENT=""
JANELA(01,10,16,15,62)
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
DO WHILE .T.
   SETCOLOR(drvcortel)
   @ 10,16 Say "±±±±±±±±±±±± Troca de Apartamento ±±±±±±±±±±±±±"
   @ 12,19 SAY "Ú Qual o n£mero do Apto a ser trocado ? ¿"
   @ 13,19 Say "³                                       ³"
   @ 14,19 Say "³                                       ³"
   @ 15,19 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   TAPTO=0
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 14,37 GET TAPTO PICT "9999" VALID(VerAp(@TAPTO))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      JANELA(02)
      SET KEY K_F8 TO
      Cod_Sos=Cod_Sos_Ant
      Set Cursor On
      RETURN
   ENDIF
   Sele Aptos
   DBGOTOP()
   LOCATE FOR APTO=TAPTO
   IF FOUND()
      IF LIBERADO='N'
         EXIT
      ELSE
         DBox('Apartamento Liberado !!!',,,0,.T.,,)
      ENDIF
   ENDIF
ENDDO
Sele Aptos
     TAPTO=APTO
Sele Registro            // localiza registro
     DBGOTOP()
     Locate For (apto=tapto .and. ativo='S')
     tdtent=dtent
     thent=hent
     TCodReg=codigo
Sele ConRegis
     DBGOTOP()
     Locate For codigo=TCodReg
     TCOD=CODHOSP
Sele Hospedes
     DBGOTOP()
     LOCATE FOR CODIGO=TCOD
     THOSPEDE=NOME
JANELA(02)
IF LASTKEY()=K_ESC
   Cod_Sos=Cod_Sos_Ant
   Set Cursor On
   RETURN
ENDIF
JANELA(01,09,16,17,65," Troca de Apartamento ")
SETCOLOR(drvcortel)
@ 09,16 Say "±±±±±±±±±±±±±± Troca de Apartamento ±±±±±±±±±±±±±±"
@ 11,17 SAY "Ú Apto Â Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 12,17 SAY "³      ³                                       ³"
@ 13,17 SAY "Ã Dt. Ent.  Â H. EntÂ Novo Apto ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 14,17 SAY "³           ³       ³                          ³"
@ 15,17 SAY "Ã Observa‡„o do Bloqueio ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 16,17 Say "³                                              ³"
@ 17,17 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ 12,19 SAY TAPTO PICT "9999"
@ 12,26 SAY THOSPEDE
@ 14,19 SAY TDTENT
@ 14,30 SAY THENT PICT "@R 99:99"
MObs=Space(30)
DO WHILE .T.
   MAPTO=0
   SET CURSOR ON
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   @ 14,40 GET MAPTO PICT "9999" VALID (VerApt(@MAPTO))
   @ 16,19 Get MObs
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      JANELA(02)
      Cod_Sos=Cod_Sos_Ant
      Set Cursor On
      RETURN
   ENDIF
   IF !EMPTY(MAPTO)
      EXIT
   ELSE
      DBox('Apartamento Inv lido !!!',,,0,.T.,,)
   ENDIF
ENDDO
DO WHILE .T.
   Sele Registro
   IF RLOCK()
      REPL APTO WITH MAPTO
      UNLOCK
   ENDIF
   Sele Aptos
   DBGOTOP()
   LOCATE FOR APTO=MAPTO
   IF RLOCK()
      REPL LIBERADO WITH 'N'
      UNLOCK
   ENDIF
   LOCATE FOR APTO=TAPTO
   IF RLOCK()
      REPL LIBERADO WITH 'S'
      Repl Obs  With MObs
      UNLOCK
      EXIT
   ENDIF
   TAPTO=0
   THOSPEDE=SPACE(35)
   TDTENT=CTOD("  /  /  ")
   THENT=0
   @ 12,19 SAY TAPTO PICT "9999"
   @ 12,26 SAY THOSPEDE
   @ 14,19 SAY TDTENT
   @ 14,30 SAY THENT PICT "@R 99:99"
ENDDO
JANELA(02)
SET KEY K_F8 TO    //DESABILITA MENU PICK
Cod_Sos=Cod_Sos_Ant
Set Cursor On
RETURN

//Fun‡„o Abre Menu Pick Para Apartamentos n„o Liberados

Function VerAp(X)

Local Ordem:=.F.

If !Empty(X)
   Sele Aptos
   DbGoTop()
   Locate for Apto=X
   If Found()
      If Liberado='N'
         Ordem=.T.
      Else
         DBox('Apartamento Liberado !!!',,,0,.T.,,)
      EndIf
   Else
      DBox('Apartamento inv lido !!!',,,0,.T.,,)
   EndIf
Else
   SELE Aptos
   MDB3={"Apto","Liberado"}
   DBGOTOP()
   Vd=.F.
   VDbf(13,16,20,30,"Aptos",MDb3,,"TApto",[Liberado='N'])
   Vd=.T.
   SET FILTER TO
   IF LASTKEY()=K_ESC
      ORDEM=.F.
   ELSE
      TAPTO=APTO
      Ordem=.T.
//      ORDEM=REGAPTO(@MAPTO)
   ENDIF
EndIf
Return(Ordem)

//Fun‡„o Abre Menu Pick Para Apartamentos Liberados e reservados
Function VerApt(X)

Local Ordem:=.F.

If !Empty(X)
   Sele Aptos
   DbGoTop()
   Locate for Apto=X
   If Found()
      If Liberado!='N'
         Ordem=.T.
      Else
         DBox('Apartamento Ocupado !!!',,,0,.T.,,)
      EndIf
   Else
      DBox('Apartamento inv lido !!!',,,0,.T.,,)
   EndIf
Else
   SELE Aptos
   MDB3={"Apto","Liberado"}
   DBGOTOP()
   Vd=.F.
   VDbf(13,16,20,30,"Aptos",MDb3,,"MApto",[Liberado!='N'])
   Vd=.T.
   SET FILTER TO
   IF LASTKEY()=K_ESC
      ORDEM=.F.
   ELSE
      MAPTO=APTO
      Ordem=.T.
//      ORDEM=REGAPTO(@MAPTO)
   ENDIF
EndIf
Return(Ordem)
