 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: RES_06F9.PRG
 \ Data....: 28-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo DTSAI, arquivo RESERVA
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

/*
   -------------------------------------------------------------------
   Se abrir outros arquivos salve situacao anterior e restaure ao sair
   como no exemplo abaixo:
     LOCAL reg_dbf:=POINTER_DBF()
     ...        ...        ...        ...
     POINTER_DBF(reg_dbf)
     RETU
   -------------------------------------------------------------------
*/
LOCAL reg_dbf:=POINTER_DBF(),DtE,DtS,Encontrou:=.F.,Rec
Para dtsa
Set Deleted On

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
   Area=.T.
Else
   Area=.F.
EndIf
Sele Registro
DbGoTop()
If AchaProc('Res_Incl')
   Locate for (Registro->Ativo='S' .And. REGISTRO->Apto=m->Apto .And. REGISTRO->dtent<=dtsa .and. (REGISTRO->dtsai>=dtsa .or. Empty(REGISTRO->dtsai)))
ElseIf AchaProc('Res_Get1')
   Locate for (Registro->Ativo='S' .And. REGISTRO->Apto=Apto .And. REGISTRO->dtent<=dtsa .and. (REGISTRO->dtsai>=dtsa .or. Empty(REGISTRO->dtsai)))
EndIf
If Found()
   If Empty(Registro->Dtsai)
      DtS=("  /  /  ")
   Else
      DtS=DtoC(REGISTRO->dtsai)
   EndIF
   DBox("Apartamento ocupado !!!|Data prevista de sa¡da ‚ "+Dts+".",,,0,.T.,,)
Else
   If AchaProc('Res_Incl')
      Locate for (Registro->Ativo='S' .And. REGISTRO->Apto=m->Apto .And. REGISTRO->dtent>=Xdtreser .and. (REGISTRO->dtsai<=dtsa .or. Empty(REGISTRO->dtsai)))
   ElseIf AchaProc('Res_Get1')
      Locate for (Registro->Ativo='S' .And. REGISTRO->Apto=Apto .And. REGISTRO->dtent>=Xdtreser .and. (REGISTRO->dtsai<=dtsa .or. Empty(REGISTRO->dtsai)))
   EndIf
   If Found()
      If Empty(Registro->Dtsai)
         DtS=("  /  /  ")
      Else
         DtS=DtoC(REGISTRO->dtsai)
      EndIF
      DBox("Apartamento ocupado !!!|Data prevista de sa¡da ‚ "+Dts+".",,,0,.T.,,)
   Else
      Encontrou=.T.
   EndIf
EndIf

If Encontrou                     //Faz Verifica‡„o em Reserva
   Sele Reserva
   If AchaProc('Res_Incl')
      DbGoTop()
      Locate for (RESERVA->Apto=m->Apto .And. RESERVA->dtreser<=dtsa .and. (RESERVA->dtsai>=dtsa .or. Empty(RESERVA->dtsai))).and.efetivou=[N]
   ElseIf AchaProc('Res_Get1')
      Rec=Recno()
      DbGoTop()
      Locate for (Recno()!=Rec .And. RESERVA->Apto=Apto .And. RESERVA->dtreser<=dtsa .and. (RESERVA->dtsai>=dtsa .or. Empty(RESERVA->dtsai))).and.efetivou=[N]
   EndIf
   If Found()
      DtE=DtoC(RESERVA->dtreser)
      If Empty(Reserva->DtSai)
         Dts=("  /  /  ")
      Else
         DtS=DtoC(RESERVA->dtsai)
      EndIf
      DBox("Encontrado reserva de|"+(DtE)+" … "+(DtS)+".",,,0,.T.,,)
   Else
      If AchaProc('Res_Incl')
         Locate for (RESERVA->Apto=m->Apto .And. RESERVA->dtreser>=Xdtreser .and. (RESERVA->dtsai<=dtsa .or. Empty(RESERVA->dtsai))).And.efetivou=[N]
      ElseIf AchaProc('Res_Get1')
         Locate for (Recno()!=Rec .And. RESERVA->Apto=Apto .And. RESERVA->dtreser>=Xdtreser .and. (RESERVA->dtsai<=dtsa .or. Empty(RESERVA->dtsai))).And.efetivou=[N]
      EndIf
      If Found()
         DtE=DtoC(RESERVA->dtreser)
      If Empty(Reserva->DtSai)
         Dts=("  /  /  ")
      Else
         DtS=DtoC(RESERVA->dtsai)
      EndIf
         DBox("Encontrado reserva de|"+(DtE)+" … "+(DtS)+".",,,0,.T.,,)
      Endif
   EndIf
   Sele Registro
   If Area
      Close
   EndIf
EndIf
Sele Aptos

POINTER_DBF(reg_dbf)
RETU(.T.)       // <- deve retornar um valor L¢GICO

* \\ Final de RES_06F9.PRG
