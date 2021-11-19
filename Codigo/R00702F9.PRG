 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: R00702F9.PRG
 \ Data....: 22-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Categoria do relat¢rio MIL_R007
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
LOCAL reg_dbf:=POINTER_DBF(),Area:=.F.,Compl
Para P

If Select("Categ")=0
   Use Categ Index Categ1 Shared New
   Area=.T.
Else
   Area=.F.
EndIf

Sele Categ
DbGoTop()
Locate for Pax=P
If Found()
   Compl=Categoria
Else
   Compl=Space(10)
EndIf
If Area
   Close
EndIf
Sele ConRegis
POINTER_DBF(reg_dbf)
RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de R00702F9.PRG
