/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: FIR_01F9.PRG
 \ Data....: 06-12-95
 \ Sistema.: Milenium - Controle de Recep‡„o
 \ Funcao..: F¢rmula (Turismo) a mostrar na tela de FIRMAS
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
Para Xt

If CLIENTES->turis='S'
  Compl='IM'
Else
  Compl='ŽO'
EndIf

RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de FIR_01F9.PRG
