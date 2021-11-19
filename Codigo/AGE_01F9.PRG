/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: AGE_01F9.PRG
 \ Data....: 11-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo HORALIB, subsistema AGENDA
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
LOCAL reg_dbf:=POINTER_DBF(),Rec,MSala,Ordem:=.T.,MData,MHora

Sele Agenda
If AchaProc([Age_Incl])
   MData=m->DataLib
   MHora=m->HoraLIb
   mSala=m->Sala
   Rec=Recno()
ElseIf AchaProc([Age_Get1])
   MData=DataLib
   MHora=HoraLIb
   mSala=Sala
   Rec=Recno()
EndIf
Locate for MData=DataLib .And. MHora<HoraLib .And. Recno()!=Rec .And. MSala=Sala
If Found()
   DBox('Existe reserva de sala|para o dia '+DtoC(Data)+' as '+Tran(Hora,"@R 99:99")+'.',,,0,.T.,,)
   Ordem=.F.
EndIf
POINTER_DBF(reg_dbf)
RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de AGE_01F9.PRG
