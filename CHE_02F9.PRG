/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: CHE_02F9.PRG
 \ Data....: 15-08-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Nome Hosp) a mostrar na tela de CHEQUES
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
Local Cheques:=Pointer_Dbf(),MNome:=Space(35)

MCodhosp=Codhosp
Use Hospedes
DbGoTop()
Locate for Codigo=MCodhosp
If Found()
   MNome=Nome
EndIf
Pointer_Dbf(Cheques)
RETU(MNome)       // <- deve retornar um valor qualquer

* \\ Final de CHE_02F9.PRG
