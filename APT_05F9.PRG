/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: APT_05F9.PRG
 \ Data....: 16-11-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Categoria 5) a mostrar na tela de APTOS
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
LOCAL reg_dbf:=POINTER_DBF(),Compl,T:=.F.
Para XCateg5

If Select("Categ")=0
   DbfParam= DrvDbf+"Categ"
   UseArq(DbfParam)
   T=.T.
Else
  Sele Categ
EndIf
DbGoTop()
Locate for Codigo=XCateg5
If Found()
   Compl=Categ->Categoria
Else
   Compl=Space(10)
EndIf
If T
   Close
EndIf
POINTER_DBF(reg_dbf)
RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de APT_05F9.PRG
