/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: RPE_01F9.PRG
 \ Data....: 28-09-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: Valor inicial do campo RG, arquivo RPES
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
LOCAL reg_dbf:=POINTER_DBF(),Compl:=Space(14),Area:=.F.
Para XX

If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
   Area=.T.
EndIf

Sele Hospedes
DbGoTop()
Locate for Nome=XX
If Found()
   Compl=identidad
Else
   Compl=Space(14)
EndIf

If Area
   Close
EndIf
Sele RPes
POINTER_DBF(reg_dbf)
RETU(Compl)       // <- deve retornar um valor CARACTER

* \\ Final de RPE_01F9.PRG
