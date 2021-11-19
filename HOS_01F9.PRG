/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOS_01F9.PRG
 \ Data....: 21-11-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Estado Civil) a mostrar na tela de HOSPEDES
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
