/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: PAR_07F9.PRG
 \ Data....: 06-12-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Ve¡culo) a mostrar na tela de PARAMET
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
Local Compl:=Space(02)
Para XT

If Xt='S'
   Compl='IM'
Else
   Compl='ŽO'
EndIf

RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de PAR_07F9.PRG
