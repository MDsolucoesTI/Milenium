/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: RES_08F9.PRG
 \ Data....: 06-08-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: F¢rmula (Forma Pagamento) a mostrar na tela de RESERVA
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
Para form
Local Ordem:=Space(15)
Do Case
   Case form=1
        ordem='DINHEIRO       '
   Case form=2
        ordem='CARTŽO         '
   Case form=3
        ordem='CHEQUE         '
   Case form=4
        ordem='CHEQUE-PR‚     '
   Case form=5
        ordem='RDA            '
   Case form=6
        ordem='COBRAN€A       '
   Case form=7
        ordem='PERMUTA        '
   Case Form=8
        Ordem='NŽO ESPECIFICOU'
EndCase
RETU(Ordem)       // <- deve retornar um valor qualquer

* \\ Final de RES_08F9.PRG
