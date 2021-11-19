/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: PAG_01F9.PRG
 \ Data....: 07-11-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Forma Pagamento) a mostrar na tela de PAGAM
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
Local NomePag:=Space(10)
Para XF

Do Case
   Case XF=1
        NomePag='DINHEIRO  '
   Case XF=2
        NomePag='CARTŽO    '
   Case XF=3
        NomePag='CHEQUE    '
   Case XF=4
        NomePag='CHEQUE-PR‚'
   Case XF=5
        Nomepag='RDA       '
   Case XF=6
        Nomepag='COBRAN€A  '
   Case XF=7
        NomePag='PERMUTA   '
EndCase
RETU(NomePag)       // <- deve retornar um valor qualquer

* \\ Final de PAG_01F9.PRG
