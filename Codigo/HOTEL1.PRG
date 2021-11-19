 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOTEL1.PRG
 \ Data....: 06-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Defini escolha do menu disparando o m¢dulo necess rio
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

JANELA(01,02,03,10,21)
DO WHILE .T.
   NIVEL=1
   SET CURSOR OFF
   KEYBOARD "1"
   SETCOLOR(CORMUNO)
   OPC1=ACHOICE(03,04,09,20,M1,ML1,'VERMENU',1)
   DO CASE
      CASE OPC1 = 0
         EXIT
      CASE OPC1 = 1     //FIRMAS/AGENTES
         DO HOT11
      CASE OPC1 = 2     //APARTAMENTOS
         DO HOT12
      CASE OPC1 = 3    //EVENTUAIS
         DO HOT13
      CASE OPC1 = 4    //HOSPEDES
         DO HOT14
      CASE OPC1 = 5    //MANUTENCAO DE REGISTRO
         DO HOT15
      CASE OPC1 = 6    //SAIDA
         DO SAIDA
   ENDCASE
ENDDO
JANELA(2)
RETURN
