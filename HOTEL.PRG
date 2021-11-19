/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOTEL.PRG
 \ Modulo..: Entrada do Sistema
 \ Vers∆o..: 1.1
 \ Data....: 17-08-94
 \ Revis∆o.: 01-02-95
 \ Sistema.: MILENIUM - AutomaáÑo Hoteleira
 \ Funcao..: Defini o Menu Principal 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'


// DEFINICAO DO AMBIENTE

CLEAR
SET WRAP ON
SET SCOREBOARD OFF
SET DATE TO BRIT
SET DELETE ON
SET CONFIRM ON
SET FIXED ON

// DEFINICAO DAS HOT KEYS PARA FUNCOES

SET KEY K_F5 TO CALC
SET KEY K_F6 TO CALEN
SET KEY K_ALT_X TO SAIDA
SET KEY K_F9 TO HOT511()
SET KEY K_F10 TO MUDAOP
SET KEY K_F3 TO PESQHOSP
SET KEY K_ALT_H TO DATATUAL()
SET KEY K_ALT_M TO HOT22

// INICIO DO SISTEMA

PUBLIC FMEN,CORMUNO,CORMU,CORMEN,CORMENER,CORBARER,CORJ,CORBAR
PUBLIC M1:={},MG:={},M2:={},M21:={},M22:={},MAT1:={},MAT2:={},M3:={},M4:={},M5:={},M41:={},M321:={},ML321:={}
PUBLIC ML1:={},ML2:={},ML3:={},ML4:={},ML5:={},ML21:={},ML22:={},MLG:={},ML41:={}
PUBLIC TELAJAN[10],COORD[10,4],CORJAN[10],MAT1:={},MAT2:={},MAT3:={},M51:={},MAT4:={}
PUBLIC NUJAN:=0,NIVEL,DAT_HOJE,REGISTRO:=1,WTCON:='N',TITULO:='Movimento',WOPERADOR,WNIVEL,WNUMOP,MATVER:={}
DAT_HOJE=CTOD('  /  /  ')
PUBLIC  mFinal:=0,mPorc:=0

FMEN = 5
SETBLINK(.T.)
CORMUNO = 'N/W,N+/W'
CORMU = 'N/W,W/N'
CORMEN = 'W+/B,B/W'
CORMENER = 'GR+/R,W+/N'
CORBARER = 'R/W'
CORJ = 'N/W,W+/N,,,N+/W'
CORBAR = 'W+/B'

SETCOLOR("W+/N")
CLEAR SCREEN

SETCOLOR(CORBAR)
@ 00,00 SAY PADC(" ",80)
@ 00,21 SAY "Milenium - Controle de Recepcao"
DO BARSTA


SET CURSOR OFF

ARQSEN()
DO MUDAOP
DATATUAL()
PREPMENU()
CLOSE ALL
ABREARQ()



//
// MENU PRINCIPAL
//

SETCOLOR(CORMU)
@ 01,00,01,79 BOX '         '
DO WHILE .T.
   @ 01,03 PROMPT 'Cadastro'
   @ 01,14 PROMPT 'Lancamento'
   @ 01,28 PROMPT 'Consultas'
   @ 01,40 PROMPT 'Relatorios'
   @ 01,53 PROMPT 'Utilitarios'
   // @ 01,67 PROMPT '?'
   MENU TO OPC
   IF LASTKEY()=K_ESC
       DO SAIDA
   ENDIF
   DO CASE
      CASE OPC=1
          DO HOTEL1   //Cadastros
      CASE OPC=2
          DO HOTEL2   // Lancamentos
      CASE OPC=3
          DO HOTEL3   //Consultas
      CASE OPC=4
          DO HOTEL4   //Relatorios
      CASE OPC=5
          DO HOTEL5   //Utilitarios
      //CASE OPC=FMEN
         // HELP   //Help
   ENDCASE
   SET CURSOR OFF
ENDDO
