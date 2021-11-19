/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: RES_02F9.PRG
 \ Data....: 13-11-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: Processo inverso no campo liberado, arquivo APTOS
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
Ret=Space(01)
Reg=Recno()
MApto=Apto
DbGoTop()
Locate for Apto=MApto .And. Recno()!=Reg .And. DtReser>DataC
If Found()
   Ret='R'
Else
   If Aptos->Liberado='S' .Or. Aptos->Liberado='R'
      Ret='S'
   Else
      Ret='N'
   EndIf
EndIf
If Reg!=0
   Go Reg
EndIf
RETU(Ret)    // <- deve retornar um valor CARACTER

* \\ Final de RES_02F9.PRG
