/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: REG_02F9.PRG
 \ Data....: 09-11-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Nome) a mostrar na tela de REGISTRO
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
Para XI

T=.F.
If Select("clientes")=0
   DbfParam=DrvDbf+"clientes"
   UseArq(DbfParam)
   T=.T.
Else
  Select clientes
EndIf
DbGoTop()
Locate for Codigo=XI
If Found()
   Inter=Nome
Else
   Inter=Space(35)
EndIf
If T
   Close
EndIf
POINTER_DBF(reg_dbf)

RETU(Inter)      // <- deve retornar um valor qualquer

* \\ Final de REG_02F9.PRG
