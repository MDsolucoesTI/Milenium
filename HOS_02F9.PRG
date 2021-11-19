/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOS_02F9.PRG
 \ Data....: 14-12-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: Pr‚-valida‡„o do campo IDADE, arquivo HOSPEDES
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
Local XXX
Para XX

If !empty(XX)
   XXX=Calida(XX)
   M->Idade=XXX
   Idade=XXX
EndIf
RETU(.T.)       // <- deve retornar um valor L¢GICO

* \\ Final de HOS_02F9.PRG
