 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: R00501F9.PRG
 \ Data....: 22-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Desconto em Valor do relat¢rio MIL_R005
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
Local Total:=0
Para VlNor,PorNor,VlExt,PorExt

If Pagam->TipoMov=1
   If !Empty(VlNor)
      Total=VlNor
   Else
      Total=((CONREGIS->vlnormal+CONREGIS->sernor)*(PorNor/100))
   EndIf
Else
   If !Empty(VlExt)
      Total=VlExt
   Else
      Total=((CONREGIS->vlextra+CONREGIS->serext)*(PorExt/100))
   EndIf
EndIf

RETU(Total)       // <- deve retornar um valor qualquer

* \\ Final de R00501F9.PRG
