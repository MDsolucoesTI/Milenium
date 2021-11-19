/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: PAR_09F9.PRG
 \ Data....: 25-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Protetor Tela) a mostrar na tela de PARAMET
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
Local Compl
Para XX

If XX='S'
   Compl='IM'
Else
   Compl='ŽO'
EndIF
RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de PAR_09F9.PRG
