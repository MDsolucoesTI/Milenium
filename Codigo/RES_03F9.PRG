 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: RES_03F9.PRG
 \ Data....: 28-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo DTRESER, arquivo RESERVA
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
LOCAL reg_dbf:=POINTER_DBF(),DtE,DtS,Rec
Para Dt
Public XDtreser:=Dt
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
   Locate for (Registro->Ativo='S' .And. REGISTRO->Apto=m->Apto .And. REGISTRO->dtent<=dt .and. (REGISTRO->dtsai>=dt .or. Empty(REGISTRO->dtsai)))
ElseIf AchaProc('Res_Get1')
   Locate for (Registro->Ativo='S' .And.REGISTRO->Apto=Apto .And. REGISTRO->dtent<=dt .and. (REGISTRO->dtsai>=dt .or. Empty(REGISTRO->dtsai)))
EndIf
If Found()
   If Empty(Registro->DtSai)
      Dts=("  /  /  ")
   Else
      DtS=DtoC(REGISTRO->dtsai)
   EndIf
   DBox("Apartamento ocupado !!!|Data prevista de sa¡da ‚ "+(Dts)+".",,,0,.T.,,)
Else
   Sele Reserva
   If AchaProc('Res_Incl')
      DbGoTop()
      Locate for (RESERVA->Apto=m->Apto .And. RESERVA->dtreser<=dt .and. (RESERVA->dtsai>=dt .or. Empty(RESERVA->dtsai))).and.efetivou=[N]
   ElseIf AchaProc('Res_Get1')
      Rec=Recno()
      DbGoTop()
      Locate for (Recno()!=Rec .And. RESERVA->Apto=Apto .And. RESERVA->dtreser<=dt .and. (RESERVA->dtsai>=dt .or. Empty(RESERVA->dtsai))).and.efetivou=[N]
   EndIf
   If Found()
      If Empty(Reserva->Dtreser)
         DtE=("  /  /  ")
      Else
         DtE=DtoC(RESERVA->dtreser)
      EndIf
      If Empty(Reserva->DtSai)
         Dts=("  /  /  ")
      Else
         DtS=DtoC(RESERVA->dtsai)
      EndIF
      DBox("Encontrado reserva de|"+(DtE)+" … "+(DtS)+".",,,0,.T.,,)
   Endif
EndIf
Sele Registro
If Area
   Close
EndIf
Sele Aptos

POINTER_DBF(reg_dbf)
RETU(.T.)       // <- deve retornar um valor L¢GICO

* \\ Final de RES_03F9.PRG
