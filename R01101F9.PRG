/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R01101F9.PRG
 \ Data....: 17-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Condi‡„o de impress„o do campo Forma de Pagamento, arquivo MIL_R011
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
LOCAL reg_dbf:=POINTER_DBF()
Para Cod,CodH

Sele Movim
DbSkip()
If Codigo=Cod .And. CodHosp=CodH
   Ordem=.F.
Else
   Ordem=.T.
EndIf
POINTER_DBF(reg_dbf)
RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de R01101F9.PRG
