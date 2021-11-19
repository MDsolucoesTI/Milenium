/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: V00303F9.PRG
 \ Data....: 17-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o da variavel CODIHOSP, relatorio MIL_R003
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
Local Ordem
Para CodH,Cod

If Select("ConRegis")=0
   DbfParam=DbfDrv+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Registro")=0
   DbfParam=DbfDrv+"Registro"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DbfDrv+"Hospedes"
   UseArq(DbfParam)
EndIf

Sele ConRegis
DbGoTop()
Locate for Codigo=Registro->Codigo .And. CodHosp=M->CodiHosp .And. Ativo='S'
If Found()
   Ordem=.T.
Else
   Ordem=.F.
EndIf

RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de V00303F9.PRG
