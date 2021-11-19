/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT15.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Efetuar a Manutencao do Registro do Hospede
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'


JANELA(01,10,04,20,77,"Registro de Hospedes")
@ 12,04 SAY "Ã Apto Â Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ H. Entr. Â Dt. Entr ÄÄÄÄÄ´"
@ 13,04 SAY "³      ³                                      ³          ³               ³"
@ 14,04 SAY "Ã PAX Â CHD Â Ultima Procedencia ÄÄÄÄÄÄÂ Proximo Destino ÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 15,04 SAY "³     ³     ³                          ³                                 ³"
@ 16,04 SAY "Ã Firma ou Agente ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÁ Intermediario ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 17,04 SAY "³                                    ³                                   ³"
@ 18,04 SAY "Ã Observacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÂ Dt. Saida ÄÂ Por Conta ÄÄÄÄÄÄÄÄ´"
@ 19,04 SAY "³                                       ³            ³                   ³"
@ 20,04 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
SELE 05
SET FILTER TO (ATIVO='S')
DBGOTOP()
SET KEY 65 TO ALTHOSP
SET KEY K_RIGHT TO PROXIMO
SET KEY K_LEFT  TO ANTERIOR
SET KEY K_HOME  TO COMECO
SET KEY K_END   TO FINAL
SET KEY K_DEL   TO APAGA
@ 24,00 SAY PADR("[ESC] Sai  [] Prox  [] Ant  [HOME] Inicio  [END] Fim  [A] Altera",80)
SET CURSOR OFF
DO WHILE .T.
   SELE 04
   DBGOTOP()
   LOCATE FOR CODIGO=REGISTRO->CODHOSP
   THOSPE=NOME
   SELE 05
   IGUAL_VAR()
   TPCONTA=MPCONTA
   IF MPCONTA='F'
      TPCONTA='FIRMA  '
   ELSEIF MPCONTA='H'
      TPCONTA='HOSPEDE'
   ENDIF
   SELE 01
   DBGOTOP()
   LOCATE FOR CODIGO=REGISTRO->FIRMAAGE
   TFIRMA=NOME
   DBGOTOP()
   LOCATE FOR CODIGO=REGISTRO->INTERM
   IF FOUND()
      TINTERM=NOME
   ELSE
      TINTERM=SPACE(35)
   ENDIF
   @ 13,07 SAY MAPTO     PICT "999"
   @ 13,13 SAY THOSPE    PICT "@!"
   @ 13,52 SAY MHENT     PICT "@R 99:99"
   @ 13,63 SAY MDTENT
   @ 15,06 SAY MPAX      PICT "99"
   @ 15,12 SAY MCHD      PICT "99"
   @ 15,18 SAY MULTPROC  PICT "@!"
   @ 15,45 SAY MPROXDEST PICT "@!"
   @ 17,06 SAY TFIRMA    PICT "@!"
   @ 17,42 SAY TINTERM   PICT "@!"
   @ 19,07 SAY MOBS      PICT "@!"
   @ 19,46 SAY MDTSAI
   @ 19,59 SAY TPCONTA   PICT "@!"
   SELE 05
   SET CURSOR OFF
   OLDCOLOR=SETCOLOR("N/N")
   WAIT ""
   SETCOLOR(OLDCOLOR)
   IF LASTKEY()=K_ESC
      EXIT
   ENDIF
ENDDO
SET KEY 65 TO
SET KEY K_RIGHT TO
SET KEY K_LEFT  TO
SET KEY K_HOME  TO
SET KEY K_END   TO
SET KEY K_DEL   TO
JANELA(02)
DO BARSTA
SELE 05
SET FILTER TO
RETURN

//FUNCAO ALTERA DATA DE SAIDA DO REGISTRO

PROCEDURE ALTHOSP
SET KEY K_F8 TO PICKS
SET KEY 65 TO
SET KEY K_RIGHT TO
SET KEY K_LEFT  TO
SET KEY K_HOME  TO
SET KEY K_END   TO
SET KEY K_DEL   TO
SET CURSOR ON
@ 15,06 GET MPAX      PICT "99"        VALID (!EMPTY(MPAX))
@ 15,12 GET MCHD      PICT "99"
@ 15,18 GET MULTPROC  PICT "@!"
@ 15,45 GET MPROXDEST PICT "@!"
@ 17,06 GET TFIRMA    PICT "@!"         VALID REGFIRMA(@TFIRMA,'F')
@ 17,42 GET TINTERM   PICT "@!"         VALID REGFIRMA(@TINTERM,'I')
@ 19,07 GET MOBS      PICT "@!"
@ 19,46 GET MDTSAI
@ 19,59 GET TPCONTA   PICT "@!"         VALID(VERPCONTA(@TPCONTA))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   SET KEY K_F8 TO
   SET KEY 65 TO ALTHOSP
   SET KEY K_RIGHT TO PROXIMO
   SET KEY K_LEFT  TO ANTERIOR
   SET KEY K_HOME  TO COMECO
   SET KEY K_END   TO FINAL
   SET KEY K_DEL   TO APAGA
   SET CURSOR OFF
   KEYBOARD CHR(13)
   RETURN
ENDIF
SELE 05
DO WHILE .T.
   IF RLOCK()
      REPL_VAR()
      UNLOCK
      EXIT
   ELSE
      MENS('Arquivo sendo utilizado !!!')
      IF LASTKEY()=K_ESC
         EXIT
      ENDIF
   ENDIF
ENDDO
SET KEY K_F8 TO
SET KEY 65 TO ALTHOSP
SET KEY K_RIGHT TO PROXIMO
SET KEY K_LEFT  TO ANTERIOR
SET KEY K_HOME  TO COMECO
SET KEY K_END   TO FINAL
SET KEY K_DEL   TO APAGA
SET CURSOR OFF
KEYBOARD CHR(13)
RETURN
