/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOTEL2.PRG
 \ Modulo..: SubMenu de Lancamento
 \ Vers∆o..: 1.1
 \ Data....: 17-08-94
 \ Revis∆o.: 09-01-95
 \ Sistema.: MILENIUM - AutomaáÑo Hoteleira
 \ Funcao..: Defini escolha do menu disparando o m¢dulo necess†rio
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

JANELA(01,02,14,11,29)
DO WHILE .T.
   NIVEL=1
   SET CURSOR OFF
   KEYBOARD "1"
   SETCOLOR(CORMUNO)
   OPC1=ACHOICE(03,15,10,28,M2,ML2,'VERMENU',1)
   DO CASE
      CASE OPC1 = 0
         EXIT
      CASE OPC1 = 1     //REGISTRO
         DO HOT21
      CASE OPC1 = 2     //MOVIMENTOS DOS HOSPEDES
         WTCON='N'
         TITULO='Movimento'
         DO HOT22
      CASE OPC1 = 3    //FECHAMENTO DE CONTA
         DO HOT23
      CASE OPC1 = 4    //CHEQUES PRE
         DO HOT24
      CASE OPC1 = 5    //RESERVA
         DO HOT25
      CASE OPC1 = 6    //ESTORNOS
         WTCON='E'
         TITULO='Estorno'
         DO HOT22
         WTCON='N'
         TITULO='Movimento'
      CASE OPC1 = 7    //REABERTURA
         DO HOT27
      CASE OPC1 = 8    //TROCA APARTAMENTO
         DO HOT28
   ENDCASE
ENDDO
JANELA(2)
RETURN
