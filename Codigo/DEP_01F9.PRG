/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: DEP_01F9.PRG
 \ Data....: 15-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Condi‡„o para exclusao de registros do arquivo DEPARTA
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
LOCAL reg_dbf:=POINTER_DBF(),Ordem:=.T.
Para XX

If XX=1
   DBox('N„o ‚ permitido a exclus„o deste Tipo de Despesa,|pois isto acarretar  problemas nos relat¢rios e|no lan‡amento autom tico de Di ria.',,,0,.T.,,)
   Ordem=.F.
Else
   If Select("Movim")=0
      Use Movim Shared New
   EndIf
   Sele Movim
   DbGoTop()
   Locate for tipodesp=XX
   If Found()
      Ordem=.F.
   EndIf
   Close
EndIf
Sele Departa

POINTER_DBF(reg_dbf)
RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de DEP_01F9.PRG
