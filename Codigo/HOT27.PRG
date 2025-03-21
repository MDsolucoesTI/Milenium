/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT27.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa噭o Hoteleira
 \ Funcao..: Efetuar Reabertura de Conta
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
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
If Select("registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Pagam")=0
   DbfParam=DrvDbf+"Pagam"
   UseArq(DbfParam)
EndIf
If Select("Cheques")=0
   DbfParam=DrvDbf+"Cheques"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=71
JANELA(01,12,06,18,70," Reabertura de Conta ")
SETCOLOR(drvcortel)
@ 12,06 Say "北北北北北北北北北北� Reabertura de Conta 北北北北北北北北北北北"
@ 14,08 SAY "� Apto 穆 Nome do Hospede 哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目"
@ 15,08 SAY "�       �                                                    �"
@ 16,08 SAY "� N� Identidade � Dt. Entr. � H. Entr. � Dt Saida � H. Saida �"
@ 17,08 SAY "�               �           �          �          �          �"
@ 18,08 SAY "滥哪哪哪哪哪哪哪聊哪哪哪哪哪聊哪哪哪哪牧哪哪哪哪哪聊哪哪哪哪馁"
AT=04
DO WHILE .T.
   Sele Registro
   TAPTO=0
   SET CURSOR ON
   @ 15,11 GET TAPTO    PICT "9999"   VALID(VERREA(@TAPTO))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      EXIT
   ENDIF
   Sele Registro
   DbGoTop()
   Locate for Apto=TApto
   If !Found()
      DBox('Hospede muito antigo.|Hospede excluo !!!',,,0,.T.,,)
      Loop
   EndIF
   IGual_Var()
   Sele ConRegis
   Ord=.F.
   Do Case
      Case  Registro->MovimN='I' .And. Registro->MovimE='I'
         Set Relation to Codigo into Registro
         Set Relation to CodHosp into Hospedes
         Set Filter to ((Ativo='N') .And. (Codigo=Regsitro->Codigo))
         DBGOTOP()
         MDB3={"Registro->Apto","Hospedes->Nome"}
         JANELA(01,11,11,21,53,[S]," Consulta de Apartamentos ")
         Vd=.F.
         VDbf(11,11,21,53,"ConRegis",MDb3,,"",)
         Vd=.T.
         Set Relation to
         Set Filter to
      Case Registro->MovimN='C' .And. Registro->MovimE='C'
         DbGoTop()
         Locate for Codigo=Registro->Codigo
      Case Registro->MovimN='C' .And. Registro->MovimE='I'
         XXX=Space(01)
         @ 18,22 Get XXX When Balao(8)
         Read
         Reabri()
      Case Registro->MovimN='I' .And. Registro->MovimE='C'
         XXX=Space(01)
         @ 18,22 Get XXX  When Balao(9)
         Read
         Reabri()
   EndCase
   IGUAL_VAR()
   Sele Hospedes
   LOCATE FOR CODIGO=ConRegis->CODHOSP
   IF !FOUND()
      DBox('Registro Muito Antigo !!!',,,0,.T.,,)
      LOOP
   ELSE
      THOSPEDE=NOME
      TIDENTIDAD=IDENTIDAD
   ENDIF
   Sele Registro
   @ 15,18 SAY THOSPEDE
   @ 17,10 SAY TIDENTIDAD
   @ 17,26 SAY MDTENT
   @ 17,38 SAY MHENT        PICT"@R 99:99"
   @ 17,49 SAY MDTSAI
   @ 17,61 SAY MHSAI        PICT"@R 99:99"
   XXX=Space(01)
   Opr=Space(01)
   @ 18,22 Get XXX  When Balao(7)
   Read
   DO CASE
      CASE OPR='N'
         THOSPEDE=SPACE(35)
         TIDENTIDAD=SPACE(14)
         MDTENT=CTOD("  /  /  ")
         MHENT=0
         MDTSAI=CTOD("  /  /  ")
         MHSAI=0
         @ 15,18 SAY THOSPEDE
         @ 17,10 SAY TIDENTIDAD
         @ 17,26 SAY MDTENT
         @ 17,38 SAY MHENT        PICT"@R 99:99"
         @ 17,49 SAY MDTSAI
         @ 17,61 SAY MHSAI        PICT"@R 99:99"
         LOOP
      CASE OPR='S'     //REABRIR CONTA SIM
         DO REABRI
   ENDCASE
   THOSPEDE=SPACE(35)
   TIDENTIDAD=SPACE(14)
   MDTENT=CTOD("  /  /  ")
   MHENT=0
   MDTSAI=CTOD("  /  /  ")
   MHSAI=0
   @ 15,18 SAY THOSPEDE
   @ 17,10 SAY TIDENTIDAD
   @ 17,26 SAY MDTENT
   @ 17,38 SAY MHENT        PICT"@R 99:99"
   @ 17,49 SAY MDTSAI
   @ 17,61 SAY MHSAI        PICT"@R 99:99"
ENDDO
JANELA(2)
SET FILTER TO
Close All
Cod_Sos=Cod_Sos_Ant
Set Cursor On
RETURN

//FUNCAO REABERTURA DE CONTA

PROCEDURE REABRI
Sele Aptos
LOCATE FOR APTO=TAPTO
IF LIBERADO='S'
   DO WHILE .T.
      IF RLOCK()
         REPL LIBERADO WITH 'N'
         UNLOCK
         EXIT
      ENDIF
   ENDDO
   Sele Registro
   DO WHILE .T.
      IF RLOCK()
         REPL ATIVO WITH 'S'
         UNLOCK
         EXIT
      ENDIF
   ENDDO
   Sele ConRegis
   If Registro->MovimN='C'
      Set Filter to Codigo=Registro->Codigo
      DbGoTop()
      DO WHILE !Eof()
         IF RLOCK()
            REPL ATIVO WITH 'S'
            UNLOCK
            DbSkip()
         ENDIF
      ENDDO
      Set Filter to
   Else
      DO WHILE .T.
         IF RLOCK()
            REPL ATIVO WITH 'S'
            UNLOCK
            Exit
         ENDIF
      ENDDO
   EndIf
   Sele Hospedes
   If Registro->MovimN='C'
      Set Filter to Codigo=ConRegis->CodHosp
      DBGOTOP()
      DO WHILE !Eof()
         IF RLOCK()
            REPL ATIVO WITH 'S'
            UNLOCk
            DbSkip()
         ENDIF
      ENDDO
      DbGoTop()
      Set Filter to
   Else
      DbGoTop()
      Locate for Codigo=Conregis->CodHosp
      Do While .T.
         If Rlock()
            Repl Ativo With 'S'
            Unlock
            Exit
         EndIf
      EndDo
   EndIf
   Sele Pagam
   SET FILTER TO ((CODIGO=Registro->Codigo) .And. (CodHosp=Hospedes->Codigo))
   DBGOTOP()
   DO WHILE !EOF()
      DO WHILE .T.
         IF RLOCK()
            DELETE
            UNLOCK
            EXIT
         EndIf
      ENDDO
      DBSKIP()
   ENDDO
   DBSETFILTER()
   Sele Cheques
   SET FILTER TO ((CODIGO=REGISTRO->CODIGO) .And. (CodHosp=Hospedes->Codigo))
   DBGOTOP()
   DO WHILE !EOF()
      IF RLOCK()
         DELETE
         UNLOCK
         DbSkip()
      ENDIF
   ENDDO
   DBSETFILTER()
ELSE
   OPR=1
   IF AT=04
      If Liberado='N'
         Opr=Space(01)
         @ 18,22 Get XXX  When Balao(9)
         Read
      Else
         Opr=Space(01)
         @ 18,22 Get XXX  When Balao(10)
         Read
      EndIf
   ENDIF
   IF OPR='S'
      DO WHILE .T.
         IF RLOCK()
            REPL LIBERADO WITH 'N'
            UNLOCK
            EXIT
         ENDIF
      ENDDO
      Sele Registro
      DO WHILE .T.
         IF RLOCK()
            REPL ATIVO WITH 'S'
            UNLOCK
            EXIT
         ENDIF
      ENDDO
      Sele ConRegis
      If Registro->DespHosp='C'
         Set Filter to Codigo=Registro->Codigo
         DbGoTop()
         DO WHILE !Eof()
            IF RLOCK()
               REPL ATIVO WITH 'S'
               UNLOCK
               DbSkip()
            ENDIF
         ENDDO
         Set Filter to
      Else
         DO WHILE .T.
            IF RLOCK()
               REPL ATIVO WITH 'S'
               UNLOCK
               Exit
            ENDIF
         ENDDO
      EndIf
      Sele Hospedes
      If Registro->DespHosp='C'
         Set Filter to Codigo=ConRegis->CodHosp
         DBGOTOP()
         DO WHILE !Eof()
            IF RLOCK()
               REPL ATIVO WITH 'S'
               UNLOCk
               DbSkip()
            ENDIF
         ENDDO
         DbGoTop()
         Set Filter to
      Else
         DbGoTop()
         Locate for Codigo=Conregis->CodHosp
         Do While .T.
            If Rlock()
               Repl Ativo With 'S'
               Unlock
               Exit
            EndIf
         EndDo
      EndIf
      Sele Pagam
      SET FILTER TO ((CODIGO=Registro->Codigo) .And. (CodHosp=Hospedes->Codigo))
      DBGOTOP()
      DO WHILE !EOF()
         DO WHILE .T.
            IF RLOCK()
               DELETE
               UNLOCK
               EXIT
            EndIf
         ENDDO
         DBSKIP()
      ENDDO
      DBSETFILTER()
      Sele Cheques
      SET FILTER TO ((CODIGO=REGISTRO->CODIGO) .And. (CodHosp=Hospedes->Codigo))
      DBGOTOP()
      DO WHILE !EOF()
         IF RLOCK()
            DELETE
            UNLOCK
            DbSkip()
         ENDIF
      ENDDO
      DBSETFILTER()
   ENDIF
EndIF
Sele Registro
RETURN

//FUNCAO VERIFICA O APARTAMENTO

FUNCTION VERREA(X)

LOCAL ORDEM:=.F.,Antiga,Regist

ANTIGA=SELECT()
REGIST=RECNO()
Sele Aptos
Locate for Apto=X
If Found()
   If Liberado='S'
      Ordem=.T.
   Else
      DBox('Apartamento Ocupado !!!',,,0,.T.,,)
   EndIf
Else
   DBox('Apartamento Inv爈ido !!!',,,0,.T.,,)
EndIF
SELE &ANTIGA
IF REGIST#0
   GO REGIST
ENDIF
RETURN(ORDEM)
