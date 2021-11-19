/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: CHE_01F9.PRG
 \ Data....: 15-08-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo NCHEQUE, arquivo CHEQUES
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
Local Ordem:=.F.,Reg
LOCAL reg_dbf:=POINTER_DBF()

Reg=Recno()
MNum=NCheque
DbGoTop()
Locate for NCheque=MNum .And. Recno()!=Reg
If !Found()
   Ordem=.T.
Else
   DBox("N£mero de Cheque j  cadastrado.",,,0,.T.,,)
   Ordem=.F.
EndIf

POINTER_DBF(reg_dbf)
RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de CHE_01F9.PRG
