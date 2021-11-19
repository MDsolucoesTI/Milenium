/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R01404F9.PRG
 \ Data....: 04-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Percentual de Agentes do relat¢rio MIL_R014
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
Para i,f
LOCAL reg_dbf:=POINTER_DBF(),Ordem:=0

If RelFre
   Sele Registro
   Count all for (DtSai>=i .and. DtSai<=f .and. firmaage=1) to Ordem
EndIf
POINTER_DBF(reg_dbf)
RETU(Ordem)       // <- deve retornar um valor qualquer

* \\ Final de R01404F9.PRG
