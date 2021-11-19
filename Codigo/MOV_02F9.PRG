 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MOV_02F9.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Tipo Movimento) a mostrar na tela de MOVIM
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
Local Compl:=Space(07)
Para Xt

If Xt=1
   Compl='NORMAL'
Else
  Compl='EXTRA  '
EndIF

RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de MOV_02F9.PRG
