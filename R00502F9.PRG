/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R00502F9.PRG
 \ Data....: 12-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Condi‡„o de impress„o do campo Total Geral, arquivo MIL_R005
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
Local Ordem:=.F.
LOCAL reg_dbf:=POINTER_DBF()
Para Cod,CodH,Tp

Sele Pagam
//DbSkip()
If Cod=Codigo .And. CodH=CodHosp .and. Tipomov=Tp
   Ordem=.F.
Else
   Ordem=.T.
EndIf

POINTER_DBF(reg_dbf)

RETU(.T.)       // <- deve retornar um valor L¢GICO

* \\ Final de R00502F9.PRG
