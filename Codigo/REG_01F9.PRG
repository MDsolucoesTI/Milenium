 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: REG_01F9.PRG
 \ Data....: 22-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Intermedi rio) a mostrar na tela de REGISTRO
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
LOCAL reg_dbf:=POINTER_DBF()
Para XF

T=.F.
If Select("Clientes")=0
   DbfParam=DrvDbf+"Clientes"
   UseArq(DbfParam)
   T=.T.
Else
   Select Clientes
EndIf
DbGoTop()
Locate for Codigo=XF
If Found()
   Int=Nome
Else
   Int=Space(35)
EndIf
If T
   Close
EndIf
POINTER_DBF(reg_dbf)

RETU(Int)      // <- deve retornar um valor qualquer

* \\ Final de REG_01F9.PRG
