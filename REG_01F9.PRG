/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: REG_01F9.PRG
 \ Data....: 09-11-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Intermedi rio) a mostrar na tela de REGISTRO
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
