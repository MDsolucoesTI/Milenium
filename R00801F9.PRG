/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R00801F9.PRG
 \ Data....: 16-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Total de Di rias do relat¢rio MIL_R008
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
LOCAL reg_dbf:=POINTER_DBF(),Area:=.F.,ToTal:=0
Para Cod,Codh

If Select("Movim")=0
   Use Movim Index Movim1, Movim2 Shared New
   Area=.T.
EndIf
Sele Movim
Set Filter to Codigo=Cod .And. CodHosp=CodH .And. TipoDesp=1
DbGoTop()
Do While !Eof()
   ToTal=ToTal+Valor
   DbSkip()
EndDo
If Area
   Close
EndIf
Sele ConRegis
POINTER_DBF(reg_dbf)
RETU(Total)       // <- deve retornar um valor qualquer

* \\ Final de R00801F9.PRG
