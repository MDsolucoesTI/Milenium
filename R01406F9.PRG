/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R01406F9.PRG
 \ Data....: 06-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Porcentagem por Firma do relat¢rio MIL_R014
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
Local Ordem:=0,Soma

If RelFre
   Soma=particular+agencia+firma
   Ordem=firma*100/soma
EndIf
RETU(Ordem)       // <- deve retornar um valor qualquer

* \\ Final de R01406F9.PRG
