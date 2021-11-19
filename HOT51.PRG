/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT51.PRG
 \ Modulo..: Reabertura de Conta do Hospede
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 01-02-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Reabrir conta fechada de hospedes 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
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
If Select("Registro")=0
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
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf

Cod_Sos_Ant=Cod_Sos
Cod_Sos=71
InfoSis("Inclui","[F8] Tabela")
JANELA(01,12,07,18,70," Reabertura de Conta ")
SETCOLOR(drvcortel)
@ 12,07 Say "±±±±±±±±±±±±±±±±±±±±± Reabertura de Conta ±±±±±±±±±±±±±±±±±±±±±±"
@ 14,08 SAY "Ú Apto ÄÂ Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 15,08 SAY "³       ³                                                    ³"
@ 16,08 SAY "Ã Nø Identidade Â Dt. Entr. Â H. Entr. Â Dt Saida Â H. Saida ´"
@ 17,08 SAY "³               ³           ³          ³          ³          ³"
@ 18,08 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ"
AT=04
Set Key K_F8 to Picks
DO WHILE .T.
   Sele Registro
   TAPTO=0
   SET CURSOR ON
   @ 15,11 GET TAPTO    PICT "9999"   VALID(VERREA(@TAPTO))
   READ
   SET CURSOR OFF
   IF LASTKEY()=27 .or. TApto=0
      EXIT
   ENDIF
   Sele Hospedes
   THospede=Nome
   TIDENTIDAD=identidad
   MCodHosp=Codigo
   Sele Registro
   @ 15,18 SAY THOSPEDE
   @ 17,10 SAY TIDENTIDAD
   @ 17,26 SAY DTENT
   @ 17,38 SAY HENT             PICT"@R 99:99"
   @ 17,49 SAY ConRegis->DTSAI
   @ 17,61 SAY ConRegis->HSAI    PICT"@R 99:99"
   XXX=Space(01)
   Opr=Space(01)
   @ 15,55 Get XXX  When Balao(7)
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
Set Key K_F8 to
JANELA(2)
SET FILTER TO
Close All
Cod_Sos=Cod_Sos_Ant
Set Cursor On
RETURN

//FUNCAO REABERTURA DE CONTA

PROCEDURE REABRI
Sele Registro
If Ativo='N'
   DO WHILE .T.
      IF RLOCK()
         REPL ATIVO WITH 'R'
         UNLOCK
         EXIT
      ENDIF
   ENDDO
EndIf
Sele ConRegis
DO WHILE .T.
   IF RLOCK()
      REPL ATIVO    WITH 'R'
      Repl vlnormal With 0
      Repl sernor   With 0
      Repl vlextra  With 0
      Repl serext   With 0
      UNLOCK
      Exit
   ENDIF
ENDDO
Sele Hospedes
If Ativo='N'
   DO WHILE .T.
      IF RLOCK()
         REPL ATIVO WITH 'R'
         UNLOCk
         Exit
      ENDIF
   ENDDO
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
RETURN

//FUNCAO VERIFICA O APARTAMENTO

FUNCTION VERREA(X)

Local mDela_Atu:=SET(_SET_DELETED,.t.),Ordem:=.F.

If Flag
   Ordem=.T.
   Flag=.F.
Else
   CUR=SETCURSOR()
   SET CURSOR OFF
   AREA=SELECT()
   If !Empty(X)
      Sele Paramet
      If NumReabre<1
         MNumReabre=20
      Else
         MNumReabre=NumReabre
      EndIf
      DataX=CalcData(DtoC(DataC),-MNumReabre)
      Sele Registro
      DbGoTop()
      Locate for Apto=X .And. dtsai>=CtoD(DataX)
      If !found()
         DBox('N„o foi encontrado nenhuma conta|para reabertura.|Certifique-se que a data de|sa¡da do hospede esteja|entre '+DataX+' … '+DtoC(DataC)+',|para poder ser reaberta.',,,0,.T.,,)
      Else
         If Select("&Usuario")!=0
            Close
         EndIF
         Do While .T.
            If !file("&Usuario")
               Arq:={}
               AADD(Arq,{"CodHosp","N",10,0})
               AADD(Arq,{"Nome","C",35,0})
               AADD(Arq,{"Codigo","N",10,0})
               AADD(Arq,{"DtEntr","D",8,0})
               AADD(Arq,{"HEnt","C",4,0})
               AADD(Arq,{"DtSai","D",8,0})
               AADD(Arq,{"HSai","C",4,0})
               DbCreAte("&Usuario",Arq)
               Exit
            Else
               FErase("&Usuario")
            EndIf
         EndDo
         Use &Usuario Exclusiv New
         Sele Paramet
         If NumReabre<1
            MNumReabre=20
         Else
            MNumReabre=NumReabre
         EndIf
         Sele Registro
         DataX=(CalcData(DtoC(DataC),-MNumReabre))
         Set Filter to Apto=X .And. dtsai>=CtoD(DataX)
         Do While !Eof()
            Sele Conregis
            Set Filter to dtsai>=CtoD(DataX) .And. Ativo='N' .And. Codigo=Registro->Codigo
            DbGoTop()
            Do While !Eof()
               Sele Hospedes
               DbGoTop()
               Locate for Codigo=ConRegis->CodHosp
               Sele &Usuario
               Appe Blan
               Repl Codigo  With Registro->Codigo
               Repl CodHosp With Hospedes->Codigo
               Repl Nome    With Hospedes->Nome
               Repl DtEntr  With Registro->dtent
               Repl HEnt    With Registro->hent
               Repl DtSai   With ConRegis->dtsai
               Repl HSai    With ConRegis->hsai
               Sele ConRegis
               DbSkip()
            EndDo
            Sele Registro
            DbSkip()
         EndDo
         SET(_SET_DELETED,mDela_Atu)
         MDB3={"Nome","DtEntr","HEnt","DtSai","HSai"}
         MDB1={"Nome","DtEntr","HEnt","DtSai","HSai"}
         Sele &Usuario
         DBGOTOP()
         Vd=.F.
         Sol_Vdbf(12,02,20,75,Usuario,MDB1,Mdb3,"tApto","CONSULTA DE HOSPEDES")
         Vd=.T.
         Sele Hospedes
         Set Order to 0
         Sele ConRegis
         SET FILTER TO
         Sele Registro
         Set Filter to
         If LastKey()!=27
            Ordem=.T.
            Sele Registro
            DbGoTop()
            Locate for Codigo=&Usuario->Codigo
            TApto=Apto
            MCodigo=Codigo
            Sele ConRegis
            DbGoTop()
            Locate for Codigo=&Usuario->Codigo
            Sele Hospedes
            DbGoTop()
            Locate for Codigo=Conregis->CodHosp
         EndIf
         Sele &Usuario
         Zap
         Close
         FErase("&Usuario")
      EndIf
   Else
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
            AADD(Arq,{"DtEntr","D",8,0})
            AADD(Arq,{"HEnt","C",4,0})
            AADD(Arq,{"DtSai","D",8,0})
            AADD(Arq,{"HSai","C",4,0})
            DbCreAte("&Usuario",Arq)
            Exit
         Else
            FErase("&Usuario")
         EndIf
      EndDo
      Use &Usuario Exclusiv New
      Sele Paramet
      If NumReabre<1
         MNumReabre=20
      Else
         MNumReabre=NumReabre
      EndIf
      Sele Conregis
      DataX=CalcData(DtoC(DataC),-MNumReabre)
      Set Filter to dtsai>=CtoD(DataX) .And. Ativo='N'
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
         Repl Codigo  With Registro->Codigo
         Repl Apto    With Registro->Apto
         Repl CodHosp With Hospedes->Codigo
         Repl Nome    With Hospedes->Nome
         Repl DtEntr  With Registro->dtent
         Repl HEnt    With Registro->hent
         Repl DtSai   With ConRegis->dtsai
         Repl HSai    With ConRegis->hsai
         Sele ConRegis
         DbSkip()
      EndDo
      SET(_SET_DELETED,mDela_Atu)
      MDB3={"Apto","Nome","DtEntr","HEnt","DtSai","HSai"}
      MDB1={"Apto","Nome","DtEntr","HEnt","DtSai","HSai"}
      Sele &Usuario
      DBGOTOP()
      Vd=.F.
      Sol_Vdbf(12,02,20,75,Usuario,MDB1,Mdb3,"tApto","CONSULTA DE APARTAMENTOS")
      Vd=.T.
      If LastKey()!=27
         Flag=.T.
         Ordem=.T.
         TApto=Apto
         MCodigo=Codigo
         MCodHosp=CodHosp
         Sele Registro
         DbGoTop()
         Locate for Codigo=&Usuario->Codigo
         Sele ConRegis
         DbGoTop()
         Locate for Codigo=&Usuario->Codigo .And. CodHosp=MCodHosp
         Sele Hospedes
         DbGoTop()
         Locate for Codigo=Conregis->CodHosp
      EndIf
      Sele &Usuario
      Zap
      Close
      FErase("&Usuario")
      Sele Hospedes
      Set Order to 0
      Sele ConRegis
      SET FILTER TO
   EndIf
   SETCURSOR(CUR)
   SELE &AREA
EndIf
RETURN(Ordem)
