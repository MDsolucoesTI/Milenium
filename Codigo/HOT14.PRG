/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT14.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: SubMenu de Hospedes e rotinas relacionadas
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'


JANELA(1,06,22,10,33)
SELE 04
DO WHILE .T.
   NIVEL=2
   SET CURSOR OFF
   SETCOLOR(CORMUNO)
   KEYBOARD "1"
   OPC2=ACHOICE(07,23,09,32,MG,MLG,'VERMENU',1)
   DO CASE
      CASE OPC2 = 0         // CASO O USUARIO TECLE <ESC> SAIDA
         EXIT
      CASE OPC2 = 1         // INCLUSAO
         DO HOT141
      CASE OPC2 = 2         // MANUTENCAO
         DO HOT142
      CASE OPC2 = 3          // CONSULTA
         DO HOT143
   ENDCASE
ENDDO
JANELA(2)
RETURN

// CADASTRO DE HOSPEDES

PROCEDURE HOT141
SET KEY K_F8 TO PICKS
JANELA(01,08,05,18,76,"Cadastro Hospedes")
@ 10,05 SAY "Ã Identidade ÄÄÄÄÄÄÄÄÄÄÂ Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 11,05 SAY "³                      ³                                               ³"
@ 12,05 SAY "Ã Endere‡o ÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Bairro ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 13,05 SAY "³                                          ³                           ³"
@ 14,05 SAY "Ã Cidade/UF ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ CEP ÄÄÄÄÄÄÂ Pa¡s ÄÄÄÄÄÄÄÄÄÄÂ Fone ÄÄÄÄÄÄÄÄÄ´"
@ 15,05 SAY "³                     /   ³           ³                ³               ³"
@ 16,05 SAY "Ã Profissao ÄÄÄÄÄÄÄÄÄÄÄÂ Dt Cad. Â Dt. Nasc Å Idade ÄÄÂ Est. CivilÄÄÄÄÄ´"
@ 17,05 SAY "³                      ³         ³          ³    Anos ³                ³"
@ 18,05 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
DO WHILE .T.
   INIC_VAR()
   MDTCAD=DAT_HOJE
   MPAIS='BRASIL         '
   MATIVO='N'
   TESTCIVIL='CASADO    '
   SET CURSOR ON
   @ 11,07 GET MIDENTIDAD   PICT "@!"  VALID (VERID(MIDENTIDAD,'I'))
   @ 11,30 GET MNOME         PICT "@!" VALID (!EMPTY(MNOME))
   @ 13,07 GET MENDER     PICT "@!"
   @ 13,49 GET MBAIRRO       PICT "@!"
   @ 15,07 GET MCIDADE       PICT "@!"
   @ 15,29 GET MUF           PICT "@!"
   @ 15,32 GET MCEP          PICT "@R 99999-999"
   @ 15,45 GET MPAIS         PICT "@!"
   @ 15,62 GET MFONE         PICT "@R (9999)!99-9999"
   @ 17,07 GET MPROFISSAO   PICT "@!"
   @ 17,30 GET MDTCAD                     VALID(!EMPTY(MDTCAD))
   @ 17,40 GET MDTNASC                    VALID(!EMPTY(MDTNASC))
   @ 17,51 GET MIDADE        PICT "99"  WHEN(CALIDA(@MIDADE))
   @ 17,61 GET TESTCIVIL     PICT "@!"  VALID(VEREST(TESTCIVIL))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      SET KEY K_F8 TO
      EXIT
   ENDIF
   SET ORDER TO 0
   IF TRAVAREG()
      GO BOTTOM
      IF LASTREC()>1
         SKIP -1
         MCODIGO=CODIGO+1
         SKIP +1
      ELSE
         MCODIGO=1
      ENDIF
      IF MESTCIVIL=0
         MENS('Conferir Estado Civil !!!')
         MESTCIVIL=2
      ENDIF
      REPL_VAR()
      UNLOCK
   ELSE
      MENS('Hospede nao Cadastrado !!!')
   ENDIF
   SET ORDER TO 1
ENDDO
JANELA (2)
SET KEY K_F8 TO
RETURN

// MANUTENCAO DE HOSPEDES

PROCEDURE HOT142
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA3     // DEL
SET KEY 65 TO ALTERA3       // A (ALTERACAO)
SET KEY 80 TO PESQUISA3     // P (PESQUISA)

@ 24,00 SAY PADR("[] Prox  [] Ant  [HOME] Inicio  [END] Fim  [DEL] Apaga  [A] Alt  [P] Pesq",80)
JANELA(01,08,05,18,76,"Manutencao Hospedes")
@ 10,05 SAY "Ã Identidade ÄÄÄÄÄÄÄÄÄÄÂ Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 11,05 SAY "³                      ³                                               ³"
@ 12,05 SAY "Ã Endere‡o ÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Bairro ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 13,05 SAY "³                                          ³                           ³"
@ 14,05 SAY "Ã Cidade/UF ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ CEP ÄÄÄÄÄÄÂ Pa¡s ÄÄÄÄÄÄÄÄÄÄÂ Fone ÄÄÄÄÄÄÄÄÄ´"
@ 15,05 SAY "³                     /   ³           ³                ³               ³"
@ 16,05 SAY "Ã Profissao ÄÄÄÄÄÄÄÄÄÄÄÂ Dt Cad. Â Dt. Nasc Å Idade ÄÄÂ Est. CivilÄÄÄÄÄ´"
@ 17,05 SAY "³                      ³         ³          ³    Anos ³                ³"
@ 18,05 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
GOTO TOP
DO WHILE .T.
   IGUAL_VAR()
   IF MESTCIVIL!=0
      TESTCIVIL=MAT4[MESTCIVIL]
   ELSE
      TESTCIVIL=SPACE(10)
   ENDIF
   @ 11,07 SAY MIDENTIDAD    PICT "@!"
   @ 11,30 SAY MNOME         PICT "@!"
   @ 13,07 SAY MENDER        PICT "@!"
   @ 13,49 SAY MBAIRRO       PICT "@!"
   @ 15,07 SAY MCIDADE       PICT "@!"
   @ 15,29 SAY MUF           PICT "@!"
   @ 15,32 SAY MCEP          PICT "@R 99999-999"
   @ 15,45 SAY MPAIS         PICT "@!"
   @ 15,62 SAY MFONE         PICT "@R (9999)!99-9999"
   @ 17,07 SAY MPROFISSAO   PICT "@!"
   @ 17,30 SAY MDTCAD
   @ 17,40 SAY MDTNASC
   @ 17,51 SAY MIDADE        PICT "99"
   @ 17,61 SAY TESTCIVIL     PICT "@!"
   SET CURSOR OFF
   OLDCOLOR=SETCOLOR("N/N")
   WAIT ""
   SETCOLOR(OLDCOLOR)
   IF LASTKEY()=K_ESC
      EXIT
   ENDIF
ENDDO
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
JANELA(2)
DO BARSTA
RETURN

// CONSULTA DE HOSPEDES

PROCEDURE HOT143
SET DELETED OFF
AUX=0
DBEVAL({|| AUX++ },{|| DELETED()=.T. })
SET DELETED ON
IF (LASTREC()-AUX)>=01
   DBGOTOP()
   LOCATE FOR ESTCIVIL=0
   IF FOUND()
      MENS('Verifique Estado Civil=0')
      RETURN
   ENDIF
   MDB1={"NOME","PROFISSAO","ENDER","BAIRRO","CIDADE","UF","CEP","PAIS","FONE","IDENTIDAD","DTCAD","DTNASC","IDADE","MAT4[ESTCIVIL]"}
ELSE
   MDB1={"NOME","PROFISSAO","ENDER","BAIRRO","CIDADE","UF","CEP","PAIS","FONE","IDENTIDAD","DTCAD","DTNASC","IDADE"}
ENDIF
MDB2={"@!","@!","@!","@!","@!","@!","@R 99.999-999","@!","@R (9999)!99-9999","@!","","","99","@!"}
MDB3={"Nome","Profissao","Endereco","Bairro","Cidade","UF","CEP","Pais","Fone","Identidade","Dt. Cadastro","Dt. Nasc.","Idade","Est. Civ."}
@ 24,00 SAY PADR("[ENTER] Altera Campo  [DEL] Apaga [ESC] Sai",80)
GO TOP
JANELA(01,02,01,23,78,"Consulta de Hospedes")
SET CURSOR OFF
DBEDIT(04,03,22,77,MDB1,"VERDB",MDB2,MDB3,"Ä","³")
JANELA(2)
DO BARSTA
RETURN

// FUNCAO ALTERA REGISTRO - MANUTENCAO

PROCEDURE ALTERA3
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
IF RLOCK()
   SET CURSOR ON
   @ 11,07 GET MIDENTIDAD   PICT "@!"  VALID (VERID(MIDENTIDAD,'A'))
   @ 11,30 GET MNOME         PICT "@!"
   @ 13,07 GET MENDER     PICT "@!"
   @ 13,49 GET MBAIRRO       PICT "@!"
   @ 15,07 GET MCIDADE       PICT "@!"
   @ 15,29 GET MUF           PICT "@!"
   @ 15,32 GET MCEP          PICT "@R 99999-999"
   @ 15,45 GET MPAIS         PICT "@!"
   @ 15,62 GET MFONE         PICT "@R (9999)!99-9999"
   @ 17,07 GET MPROFISSAO   PICT "@!"
   @ 17,30 GET MDTCAD                     VALID(!EMPTY(MDTCAD))
   @ 17,40 GET MDTNASC                    VALID(!EMPTY(MDTNASC))
   @ 17,51 GET MIDADE        PICT "99" WHEN(CALIDA(@MIDADE))
   @ 17,61 GET TESTCIVIL     PICT "@!" VALID(VEREST(TESTCIVIL,'A'))
   READ
   SET CURSOR OFF
   IF (LASTKEY()!=K_ESC)
      REPL_VAR()
   ENDIF
ELSE
   MENS('Arquivo sendo utilizado !!!')
ENDIF
KEYBOARD CHR(13)
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA3     // DEL
SET KEY 65 TO ALTERA3       // A (ALTERACAO)
SET KEY 80 TO PESQUISA3     // P (PESQUISA)
Set Cursor Off
RETURN

// FUNCAO PROCURA REGISTRO - MANUTENCAO

PROCEDURE PESQUISA3
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
JANELA(01,12,21,17,61,"Pesquisa Hospedes")
TNOME=SPACE(35)
SET CURSOR ON
@ 15,24 GET TNOME     PICT "@!" VALID (!EMPTY(TNOME))
READ
SET CURSOR OFF
JANELA(2)
IF LASTKEY()=K_ESC
   RETURN
ENDIF
AUX=RECNO()
SET ORDER TO 2
SEEK (TRIM(TNOME))
SET ORDER TO 1
IF !FOUND()
   MENS("Hospede nao encontrado")
   GO AUX
ENDIF
KEYBOARD CHR(13)
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA3     // DEL
SET KEY 65 TO ALTERA3       // A (ALTERACAO)
SET KEY 80 TO PESQUISA3     // P (PESQUISA)
RETURN

//FUNCAO VERIFICA SE POSSIVEL OU NAO DELETAR

PROCEDURE VERAPAGA3
SELE 05
DBGOTOP()
LOCATE FOR CODHOSP=HOSPEDES->CODIGO
IF FOUND()
   MENS('Pessoa Hospedada !!!')
ELSE
   DO APAGA
ENDIF
SELE 04
KEYBOARD CHR(13)
RETURN
