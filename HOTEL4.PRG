/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOTEL4.PRG
 \ Modulo..: SubMenu de Relatorios
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

JANELA(01,02,40,10,67)
DO WHILE .T.
   NIVEL=1
   SET CURSOR OFF
   KEYBOARD "1"
   SETCOLOR(CORMUNO)
   OPC1=ACHOICE(03,41,09,66,M4,ML4,'VERMENU',1)
   DO CASE
      CASE OPC1 = 0
         EXIT
      CASE OPC1 = 1     //RELACAO DE DESPESAS
         DO HOT41
      CASE OPC1 = 2    //CAIXA
         DO HOT42
      CASE OPC1 = 3    //RELACAO DE HOSPEDES
         DO HOT43
      CASE OPC1 = 4    //BOLETIM MOVIMENTO DIARIO
         DO HOT44
      CASE OPC1 = 5
         DO HOT45
      CASE OPC1 = 6
         DO HOT46
      CASE OPC1 = 7    //RELACAO DE SAIDA PREVISTA
         DO HOT47
   ENDCASE
ENDDO
JANELA(2)
RETURN
