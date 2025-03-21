 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: REG_04F9.PRG
 \ Data....: 22-09-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: F�rmula (Tp. Mov. Extra) a mostrar na tela de REGISTRO
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
Local Compl:=Space(09)
Para Xtp1

If XTp1='I'
   Compl='NDIVIDUAL'
Else
   Compl='ONJUNTO   '
EndIf

RETU(Compl)       // <- deve retornar um valor qualquer

* \\ Final de REG_04F9.PRG
