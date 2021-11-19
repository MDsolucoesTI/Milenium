 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: R00602F9.PRG
 \ Data....: 22-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Total Movimento Normal do relat¢rio MIL_R006
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
LOCAL reg_dbf:=POINTER_DBF(),TotalN:=0,Area:=.F.
Para Cod,CodH

If Select("Movim")=0
   Use Movim Index Movim1, Movim2 Shared New
   Area=.T.
EndIf
Sele Movim
Set Filter to Codigo=Cod .And. CodHosp=CodH .And. MOVIM->tipomov=1
DbGoTop()
Do While !Eof()
   TotalN=valor+TotalN
   DbSkip()
EndDo
Set Filter to
If Area
   Close
EndIf
Sele ConRegis
POINTER_DBF(reg_dbf)
RETU(TotalN)       // <- deve retornar um valor qualquer

* \\ Final de R00602F9.PRG
