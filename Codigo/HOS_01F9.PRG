/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOS_01F9.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Estado Civil) para exibir na tela do subsistema HOSPEDES
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
Local TP:=Space(10)
Para XEst

Do Case
   Case XEst=1
        Tp='SOLTEIRO  '
   Case XEst=2
        Tp='CASADO    '
   Case XEst=3
        Tp='SEPARADO  '
   Case XEst=4
        Tp='DIVORCIADO'
   Case XEst=5
        Tp='AMASIADO  '
EndCase
RETU(Tp)       // <- deve retornar um valor qualquer

* \\ Final de HOS_01F9.PRG
