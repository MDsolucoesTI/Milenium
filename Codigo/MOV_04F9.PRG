 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MOV_04F9.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo VALOR, subsistema de MOVIMENTO
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analistas
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
Local Ordem:=.F.
Para XVal, XTCon, XEst

If XTCon='N' .And. XEst='N' .Or. XTCon='D' .And. XEst='E'
   If XVal>0
      Ordem=.T.
   Else
      DBox("Este valor obrigatoriamente|tem que ser positivo.",,,0,.T.,,)
   EndiF
Else
   If XVal<0
      Ordem=.T.
   Else
      DBox("Este valor obrigatoriamente|tem que ser negativo.",,,0,.T.,,)
   EndiF
EndIf

RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de MOV_04F9.PRG
