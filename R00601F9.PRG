/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R00601F9.PRG
 \ Data....: 11-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Total … Pagar do relat¢rio MIL_R005
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
Local Total:=0,Desc:=0

If Pagam->TipoMov=1
   If !Empty(CONREGIS->finalnor)
      Desc=CONREGIS->finalnor
   Else
      Desc=(CONREGIS->vlnormal+CONREGIS->sernor)*(CONREGIS->porcnor/100)
   EndIf
   Total=CONREGIS->vlnormal+CONREGIS->sernor-Desc
Else
   If !Empty(CONREGIS->finalext)
      Desc=CONREGIS->finalext
   Else
      Desc=(CONREGIS->vlextra+CONREGIS->serext)*(CONREGIS->porcext/100)
   EndIf
   Total=CONREGIS->vlextra+CONREGIS->serext-Desc
EndIf

RETU(Total)       // <- deve retornar um valor qualquer

* \\ Final de R00601F9.PRG
