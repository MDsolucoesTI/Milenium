/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT13.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: SubMenu de Eventuais e rotinas relacionadas
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'


JANELA(1,05,22,09,33)
SELE 03
DO WHILE .T.
   NIVEL=2
   SET CURSOR OFF
   SETCOLOR(CORMUNO)
   KEYBOARD "1"
   OPC2=ACHOICE(06,23,08,32,MG,MLG,'VERMENU',1)
   DO CASE
      CASE OPC2 = 0         // CASO O USUARIO TECLE <ESC> SAIDA
         EXIT
      CASE OPC2 = 1         // INCLUSAO
         DO HOT131
      CASE OPC2 = 2         // MANUTENCAO
         DO HOT132
      CASE OPC2 =  3          // CONSULTA
         DO HOT133
   ENDCASE
ENDDO
JANELA(2)
RETURN


// CADASTRO DE EVENTUAIS

PROCEDURE HOT131
SELE 03
JANELA(1,10,12,14,58,"Cadastro de Eventuais")
@ 12,12 SAY "� Apto � Liberado � Observacoes �������������Ĵ"
@ 13,13 SAY "      �          �              �"
@ 14,19 SAY "����������������������������������������"
DO WHILE .T.
   INIC_VAR()
   MLIBERADO='S'
   SET CURSOR ON
   @ 13,14 GET MAPTO      PICT "99"  VALID(CHEEVEN(@MAPTO,'I'))
   @ 13,21 SAY MLIBERADO
   @ 13,32 GET MDESCRICAO PICT "@!"
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      SELE 03
      EXIT
   ENDIF
   IF TRAVAREG()
      REPL_VAR()
      UNLOCK
   ELSE
      MENS('Eventual nao Cadastrado')
   ENDIF
ENDDO
JANELA(2)
DO BARSTA
RETURN

// MANUTENCAO DE EVENTUAIS

PROCEDURE HOT132
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA2     // DEL
SET KEY 65 TO ALTERA2       // A (ALTERACAO)
SET KEY 80 TO PESQUISA2     // P (PESQUISA)

@ 24,00 SAY PADR("[] Prox  [] Ant  [HOME] Inicio  [END] Fim  [DEL] Apaga  [A] Alt  [P] Pesq",80)
SELE 03
JANELA(1,10,12,14,58,"Manutencao de Eventuais")
@ 12,12 SAY "� Apto � Liberado � Observacoes �������������Ĵ"
@ 13,13 SAY "      �          �              �"
@ 14,19 SAY "����������������������������������������"
DBGOTOP()
DO WHILE .T.
   IGUAL_VAR()
   @ 13,14 SAY MAPTO      PICT "99"
   @ 13,21 SAY MLIBERADO  PICT "@!"
   @ 13,32 SAY MDESCRICAO PICT "@!"
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
JANELA(02)
DO BARSTA
RETURN

// CONSULTA DE EVENTUAIS

PROCEDURE HOT133
MDB1={"APTO","LIBERADO","DESCRICAO"}
MDB2={"99","@!","@!"}
MDB3={"Apto","Liberado","Observacoes"}
@ 24,00 SAY PADR("[ENTER] Altera Campo  [DEL] Apaga [ESC] Sai",80)
DBGOTOP()
JANELA(01,02,15,18,63,"Consulta de Eventuais")
SET CURSOR OFF
DBEDIT(04,16,17,62,MDB1,"VERDB",MDB2,MDB3,"�","�")
DO BARSTA
JANELA(2)
RETURN

// FUNCAO ALTERA REGISTRO - MANUTENCAO

PROCEDURE ALTERA2
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
IF RLOCK()
   SET CURSOR ON
   @ 13,14 GET MAPTO      PICT "99"  VALID(CHEEVEN(@MAPTO,'A'))
   @ 13,21 GET MLIBERADO  PICT "@!"
   @ 13,32 GET MDESCRICAO PICT "@!"
   READ
   SET CURSOR OFF
   IF !(LASTKEY()=K_ESC)
      REPL_VAR()
      UNLOCK
   ENDIF
ELSE
   MENS('Arquivo sendo utilizado !!!')
ENDIF
KEYBOARD CHR(13)
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA2     // DEL
SET KEY 65 TO ALTERA2       // A (ALTERACAO)
SET KEY 80 TO PESQUISA2     // P (PESQUISA)
Set Cursor Off
RETURN

// FUNCAO PROCURA REGISTRO - MANUTENCAO

PROCEDURE PESQUISA2
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
AUX=RECNO()
TAPTO=0
JANELA(01,09,25,15,53)
@ 11,27 SAY "Qual o Codigo Eventual ??"
SET CURSOR ON
@ 13,38 GET TAPTO PICT "99"  VALID CHEEVEN(TAPTO,"C")
READ
SET CURSOR OFF
JANELA(02)
IF (LASTKEY()=K_ESC)
   GO AUX
ENDIF
KEYBOARD CHR(13)
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA2     // DEL
SET KEY 65 TO ALTERA2       // A (ALTERACAO)
SET KEY 80 TO PESQUISA2     // P (PESQUISA)
RETURN

//FUNCAO VERIFICA SE POSSIVEL OU NAO DELETAR

PROCEDURE VERAPAGA2
SELE 05
DBGOTOP()
LOCATE FOR APTO=EVENTUAL->APTO
IF FOUND()
   MENS('Eventual em uso !!!')
ELSE
   DO APAGA
ENDIF
SELE 03
KEYBOARD " "
RETURN
