 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: PAG_01F9.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Forma Pagamento) a mostrar na tela de PAGAM
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analistas
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
