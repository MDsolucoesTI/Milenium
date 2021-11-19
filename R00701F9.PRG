/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R00701F9.PRG
 \ Data....: 15-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Total Di ria do relat¢rio MIL_R007
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
LOCAL reg_dbf:=POINTER_DBF(),Total:=0
Para Cod,Codh

Sele Movim
DbSetFilter(Codigo=Cod .And. CodHosp=CodH .And. tipomov=1)
DbGoTop()
Do While !Eof()
   Total=Total+Valor
   DbSkip()
EndDo
DbSetFilter()
POINTER_DBF(reg_dbf)
RETU(Total)       // <- deve retornar um valor qualquer

* \\ Final de R00701F9.PRG
