/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: DES_01F9.PRG
 \ Data....: 26-09-95
 \ Sistema.: Milenium - Controle de Recep‡„o
 \ Funcao..: F¢rmula (Excluso ?) a mostrar na tela de DESCONTO
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
Local Compl:=Space(12)
LOCAL reg_dbf:=POINTER_DBF()
Para XTipo

Sele Departa
DbGoTop()
Locate for Codigo=XTipo
If Found()
   Compl=Desconto->TipoDesp
EndIF

POINTER_DBF(reg_dbf)
RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de DES_01F9.PRG
