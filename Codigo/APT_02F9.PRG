/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: APT_02F9.PRG
 \ Data....: 11-08-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: Valida��o do campo CATEG2, subsistema de APARTAMENTO
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
LOCAL reg_dbf:=POINTER_DBF(),T:=.F.,Compl
Para XCateg2

If Select("Categ")=0
   DbfParam=DrvDbf+"Categ"
   UseArq(DbfParam)
   T=.T.
Else
  Sele Categ
EndIf
DbGoTop()
Locate for Codigo=XCateg2
If Found()
   Compl=Categoria
Else
   Compl=Space(10)
EndIf
If T
   Close
EndIf
POINTER_DBF(reg_dbf)
RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de APT_02F9.PRG
