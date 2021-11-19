/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: R01401F9.PRG
 \ Data....: 06-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Quantidade Firma do relat¢rio MIL_R014
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
Para i,f,cod
Local Ordem:=0
LOCAL reg_dbf:=POINTER_DBF()
Sele registro
Count All for (Dtsai>=i .and. DtSai<=f .and. firmaage=cod) to Ordem
POINTER_DBF(reg_dbf)
RETU(Ordem)       // <- deve retornar um valor qualquer

* \\ Final de R01401F9.PRG
