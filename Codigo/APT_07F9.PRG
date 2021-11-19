/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: APT_07F9.PRG
 \ Data....: 11-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Condi‡„o para exclusao de registros do subsistema de APARTAMENTO
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
Para XApto
Local Ordem

If Select("Paramet")=0
   ParamDbf=DrvDbf+"Paramet"
   UseArq(ParamDbf)
EndIf
If (XApto>=Paramet->faixaini .and. XApto<=Paramet->faixafim)
   Ordem:=.F.
Else
   Ordem:=.T.
endIf
RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de APT_07F9.PRG
