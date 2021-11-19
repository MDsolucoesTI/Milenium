/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: SALAO.PRG
 \ Data....: 28-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Saida do Sistema
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

LOCAL GETLIST:={}

CURS=SETCURSOR()
JANELA(1,11,23,15,56,"Deseja mesmo Sair do Sistema ?")
OPC1=2
DO WHILE .T.
   @ 14,33 PROMPT 'SIM'
   @ 14,43 PROMPT 'NAO'
   MENU TO OPC1
   DO CASE
      CASE OPC1=1
         CLOSE ALL
         USE TEMPO1 EXCLUSIVE
         IF LASTREC()>0
            ZAP
         ENDIF
         CLOSE ALL
         SET COLOR TO
         CLEAR
         QUIT
      CASE OPC1=2 .OR. LASTKEY()=K_ESC
         SETCURSOR(CURS)
         EXIT
   ENDCASE
ENDDO
JANELA(2)
RETURN
