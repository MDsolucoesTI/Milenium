/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R00202F9.PRG
 \ Data....: 19-12-95
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Tipo de Opera‡„o do relat¢rio MIL_R002
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
Local Compl
Para XT

If Xt='N'
   Compl='Normal  '
Else
   Compl='Desconto'
EndIf

RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de R00202F9.PRG
