/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: AGE_02F9.PRG
 \ Data....: 08-08-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo HORA, arquivo AGENDA
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Programado manualmente pelo analista
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
   MData=m->Data
   MHora=m->Hora
   mSala=m->Sala
   Rec=Recno()
ElseIf AchaProc([Age_Get1])
   MData=Data
   MHora=Hora
   mSala=Sala
   Rec=Recno()
EndIf
Locate for MData=Data .And. MHora>=Hora .And. Recno()!=Rec .And. MSala=Sala
If Found()
   DBox('Existe reserva de sala|para o dia '+DtoC(Data)+' as '+Tran(Hora,"@R 99:99")+'.',,,0,.T.,,)
   Ordem=.F.
EndIf
POINTER_DBF(reg_dbf)
RETU(Ordem)    // <- deve retornar um valor L¢GICO
* \\ Final de AGE_02F9.PRG
