/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT25.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa┤└o Hoteleira
 \ Funcao..: SubMenu de Reserva e a┤■es para Efetuar e Excluir Reserva
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

SET KEY K_F8 TO PICKS     //MENU PICK P/ APTO LIBERADO

JANELA(1,06,30,09,41,[S])
SELE 08
DO WHILE .T.
   NIVEL=2
   SET CURSOR OFF
   SETCOLOR(CORMUNO)
   KEYBOARD "1"
   OPC2=ACHOICE(07,31,08,40,M22,ML22,'VERMENU',1)
   DO CASE
      CASE OPC2 = 0         // CASO O USUARIO TECLE <ESC> SAIDA
         EXIT
      CASE OPC2 = 1         // INCLUSAO
         DO HOT251
      CASE OPC2 = 2         // EXCLUSAO
         DO HOT252
   ENDCASE
ENDDO
JANELA(2)
RETURN


// INCLUSAO DE RESERVA
PROCEDURE HOT251
SET KEY K_F8 TO PICKS
SELE 08
JANELA(01,08,13,18,71,"Inclusao de Reserva")
@ 10,13 SAY "ц DT. Reserva б Apartamento ддддддддб Hora Reserva ддддддд╢"
@ 11,13 SAY "Ё             Ё                     Ё                     Ё"
@ 12,13 SAY "ц Nome do Hospede ддддддддддддддддддаддддддддддддддддддддд╢"
@ 13,13 SAY "Ё                                                         Ё"
@ 14,13 SAY "ц Identidade ддддддддддддддддддддб Fone дддддддддддддддддд╢"
@ 15,13 SAY "Ё                                Ё                        Ё"
@ 16,13 SAY "ц Dt. Solicit.б Hrs. Solicit. б Recebeu Solic. Reserva ддд╢"
@ 17,13 SAY "Ё             Ё               Ё                           Ё"
@ 18,13 SAY "юдддддддддддддадддддддддддддддаддддддддддддддддддддддддддды"
DO WHILE .T.
   INIC_VAR()
   MDTSOLICIT=DAT_HOJE
   MHSOLICIT=HORA(TIME())
   MOPERADOR=WNUMOP
   SET CURSOR ON
   @ 11,15 GET MDTRESER       PICT "@D"        VALID(!EMPTY(MDTRESER))
   @ 11,29 GET MAPTO          PICT "999"       VALID (VERRES(MAPTO,MDTRESER,'INCLUSAO'))
   @ 11,51 GET MHRESER        PICT "@R 99:99"  VALID(!EMPTY(MHRESER))
   @ 13,15 GET MHOSPEDE       PICT "@!"        VALID (!EMPTY(MHOSPEDE))
   @ 15,15 GET MRG  PICT "@!"                  VALID (!EMPTY(MRG))
   @ 15,48 GET MFONE          PICT "@R (9999)!99-9999"
   @ 17,15 GET MDTSOLICIT                      VALID (!EMPTY(MDTSOLICIT))
   @ 17,29 GET MHSOLICIT      PICT "@R 99:99"  VALID(!EMPTY(MHSOLICIT))
   @ 17,45 GET MAUTORES       PICT "@!"
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      EXIT
   ENDI
   IF TRAVAREG()
      REPL_VAR()
      UNLOCK
      RESE_APTO(MAPTO)
   ELSE
      MENS('Reserva nao Cadastrada !!!')
   ENDIF
ENDDO
JANELA (2)
SET KEY K_F8 TO    //DESATIVA MENU PICKS
RETURN


//EXCLUSAO DE RESERVA

PROCEDURE HOT252
SET KEY K_RIGHT TO PROXIMO   // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR  // SETA ESQUERDA
SET KEY K_HOME  TO COMECO    // TECLA HOME
SET KEY K_END   TO FINAL     // TECLA END
SET KEY K_DEL   TO APAGA1     // TECLA DEL
SET KEY 80      TO PESQUISA  //TECLA P
SET KEY 65      TO ALTRESER  //TECLA A
@ 24,00 SAY PADR("[] Prox  [] Ant  [HOME] Inicio  [END] Fim  [DEL] Apaga  [P] Pesq  [A] Alt.",80)
JANELA(01,08,13,18,71,"Exclusao de Reserva")
@ 10,13 SAY "ц Dt. Reserva б Apartamento ддддддддб Hora Reserva ддддддд╢"
@ 11,13 SAY "Ё             Ё                     Ё                     Ё"
@ 12,13 SAY "ц Nome do Hospede ддддддддддддддддддаддддддддддддддддддддд╢"
@ 13,13 SAY "Ё                                                         Ё"
@ 14,13 SAY "ц Identidade ддддддддддддддддддддб Fone дддддддддддддддддд╢"
@ 15,13 SAY "Ё                                Ё                        Ё"
@ 16,13 SAY "ц Dt. Solicit.б Hrs. Solicit. б Recebeu Solic. Reserva ддд╢"
@ 17,13 SAY "Ё             Ё               Ё                           Ё"
@ 18,13 SAY "юдддддддддддддадддддддддддддддаддддддддддддддддддддддддддды"
GOTO TOP
DO WHILE .T.
   IGUAL_VAR()
   MOPERADOR=WNUMOP
   @ 11,15 SAY MDTRESER
   @ 11,29 SAY MAPTO       PICT "999"
   @ 11,51 SAY MHRESER     PICT "@R 99:99"
   @ 13,15 SAY MHOSPEDE    PICT "@!"
   @ 15,15 SAY MRG         PICT "@!"
   @ 15,48 SAY MFONE       PICT "@R (9999)!99-9999"
   @ 17,15 SAY MDTSOLICIT
   @ 17,29 SAY MHSOLICIT   PICT "@R 99:99"
   @ 17,45 SAY MAUTORES    PICT "@!"
   SET CURSOR OFF
   OLDCOLOR=SETCOLOR("N/N")
   WAIT ""
   SETCOLOR(OLDCOLOR)
   IF LASTKEY()=K_ESC
      EXIT
   ENDIF
ENDDO
SET KEY K_RIGHT TO
SET KEY K_LEFT  TO
SET KEY K_HOME  TO
SET KEY K_END   TO
SET KEY K_DEL   TO
SET KEY 80      TO
SET KEY 65      TO
JANELA(2)
DO BARSTA
RETURN


// FUNCAO PROCURA REGISTRO - MANUTENCAO

PROCEDURE PESQUISA
SET KEY K_RIGHT TO   // SETA DIREITA
SET KEY K_LEFT  TO   // SETA ESQUERDA
SET KEY K_HOME  TO   // TECLA HOME
SET KEY K_END   TO   // TECLA END
SET KEY K_DEL   TO   // TECLA DEL
SET KEY 80      TO  //TECLA P
SET KEY 65      TO  //TECLA A
THOSPEDE=SPACE(35)
JANELA(01,12,21,17,61,"Pesquisa Hosepdes")
AUX=RECNO()
SET CURSOR ON
@ 15,24 GET THOSPEDE  PICT "@!" VALID (!EMPTY(THOSPEDE))
READ
SET CURSOR OFF
JANELA(2)
IF LASTKEY()=K_ESC
   KEYBOARD ""
   SET KEY K_RIGHT TO PROXIMO   // SETA DIREITA
   SET KEY K_LEFT  TO ANTERIOR  // SETA ESQUERDA
   SET KEY K_HOME  TO COMECO    // TECLA HOME
   SET KEY K_END   TO FINAL     // TECLA END
   SET KEY K_DEL   TO APAGA1     // TECLA DEL
   SET KEY 80      TO PESQUISA  //TECLA P
   SET KEY 65      TO ALTRESER  //TECLA A
   RETURN
ENDIF
SEEK THOSPEDE
IF !FOUND()
   MENS("Reserva nao encontrada")
   GO AUX
ENDIF
SET KEY K_RIGHT TO PROXIMO   // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR  // SETA ESQUERDA
SET KEY K_HOME  TO COMECO    // TECLA HOME
SET KEY K_END   TO FINAL     // TECLA END
SET KEY K_DEL   TO APAGA1     // TECLA DEL
SET KEY 80      TO PESQUISA  //TECLA P
SET KEY 65      TO ALTRESER  //TECLA A
KEYBOARD CHR(13)
RETURN

//FUNCAO ALTERA DATA, APTO E HORA DA RESERVA

PROCEDURE ALTRESER
SET KEY K_RIGHT TO
SET KEY K_LEFT  TO
SET KEY K_HOME  TO
SET KEY K_END   TO
SET KEY K_DEL   TO
SET KEY 80      TO
SET KEY 65      TO
SET CURSOR ON
@ 11,15 GET MDTRESER PICT "@D"        VALID (!EMPTY(MDTRESER))
@ 11,29 GET MAPTO    PICT "999"       VALID (VERRES(MAPTO,MDTRESER,'ALTERACAO'))
@ 11,51 GET MHRESER  PICT "@R 99:99"  VALID (!EMPTY(MHRESER))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   SET KEY K_RIGHT TO PROXIMO   // SETA DIREITA
   SET KEY K_LEFT  TO ANTERIOR  // SETA ESQUERDA
   SET KEY K_HOME  TO COMECO    // TECLA HOME
   SET KEY K_END   TO FINAL     // TECLA END
   SET KEY K_DEL   TO APAGA1     // TECLA DEL
   SET KEY 80      TO PESQUISA  //TECLA P
   SET KEY 65      TO ALTRESER  //TECLA A
   SET CURSOR OFF
   RETURN
ENDIF
DO WHILE .T.
   IF RLOCK()
      REPL DTRESER WITH MDTRESER
      REPL APTO    WITH MAPTO
      REPL HRESER  WITH MHRESER
      UNLOCK
      EXIT
   ELSE
      MENS('Arquivo sendo utilizado !!!')
   ENDIF
ENDDO
SET KEY K_RIGHT TO PROXIMO   // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR  // SETA ESQUERDA
SET KEY K_HOME  TO COMECO    // TECLA HOME
SET KEY K_END   TO FINAL     // TECLA END
SET KEY K_DEL   TO APAGA1     // TECLA DEL
SET KEY 80      TO PESQUISA  //TECLA P
SET KEY 65      TO ALTRESER  //TECLA A
SET CURSOR OFF
RETURN

//FUNCAO FLAG DE APTO RESERVADOS

PROCEDURE RESE_APTO(X)
SELE 02
DBGOTOP()
LOCATE FOR APTO=X
IF LIBERADO!='N'
   DO WHILE .T.
      IF RLOCK()
         REPL LIBERADO WITH 'R'
         UNLOCK
         EXIT
      ELSE
         INKEY(0.5)
         IF LASTKEY()=K_ESC
            MENS('Reserva nao Cadastrado !!!')
            EXIT
         ENDIF
      ENDIF
   ENDDO
ENDIF
SELE 08
RETURN

// APAGA REGISTROS RESERVADOS

PROCEDURE APAGA1
SET KEY K_RIGHT TO   // SETA DIREITA
SET KEY K_LEFT  TO   // SETA ESQUERDA
SET KEY K_HOME  TO   // TECLA HOME
SET KEY K_END   TO   // TECLA END
SET KEY K_DEL   TO   // TECLA DEL
SET KEY 80      TO  //TECLA P
SET KEY 65      TO

IF RLOCK()
   JANELA(01,08,29,15,53,"Confirmacao de Exclusao")
   @ 11,31 SAY "Apaga o Registro ???"
   OPDEL=2
   @ 13,36 PROMPT "SIM"
   @ 13,42 PROMPT "NAO"
   MENU TO OPDEL
   JANELA(2)
   IF OPDEL = 1
      APTOR=APTO
      DELETE
      UNLOCK
      IF !EOF()
         SKIP +1
         REG=RECNO()
      ELSE
         IF !BOF()
            SKIP -1
            REG=RECNO()
         ELSE
            MENS('Arquivo Vazio !!!')
         ENDIF
      ENDIF
      DBGOTOP()
      LOCATE FOR APTO=APTOR
      IF !FOUND()
         SELE 02
         DBGOTOP()
         LOCATE FOR  APTO=APTOR
         IF LIBERADO!='N'
            DO WHILE .T.
               IF RLOCK()
                  REPL LIBERADO WITH 'S'
                  EXIT
               ELSE
                  MENS('Arquivo sendo utilizado - Aguarde')
               ENDIF
            ENDDO
         ENDIF
      ELSE
         GO REG
      ENDIF
      SELE 08
   ENDIF
ELSE
   MENS('Arquivo sendo utilizado !!!')
ENDIF
KEYBOARD CHR(13)
SET KEY K_RIGHT TO PROXIMO   // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR  // SETA ESQUERDA
SET KEY K_HOME  TO COMECO    // TECLA HOME
SET KEY K_END   TO FINAL     // TECLA END
SET KEY K_DEL   TO APAGA1     // TECLA DEL
SET KEY 80      TO PESQUISA  //TECLA P
SET KEY 65      TO ALTRESER  //TECLA A
RETURN
