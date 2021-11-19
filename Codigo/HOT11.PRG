/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT11.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: SubMenu de Firmas/Agentes e rotinas relacionadas
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'


JANELA(1,03,22,07,33)
SELE 01
DO WHILE .T.
   NIVEL=2
   SET CURSOR OFF
   SETCOLOR(CORMUNO)
   KEYBOARD "1"
   OPC2=ACHOICE(04,23,06,32,MG,MLG,'VERMENU',1)
   DO CASE
      CASE OPC2 = 0         // CASO O USUARIO TECLE <ESC> SAIDA
         EXIT
      CASE OPC2 = 1         // INCLUSAO
         DO HOT111
      CASE OPC2 = 2         // MANUTENCAO
         DO HOT112
      CASE OPC2 = 3          // CONSULTA
         DO HOT113
   ENDCASE
ENDDO
JANELA(2)
RETURN

// CADASTRO DE FIRMAS/AGENTES

PROCEDURE HOT111
JANELA(01,07,15,19,68,"Cadastro Firmas/Agentes")
@ 09,15 SAY "Ã Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Turismo ÄÄ´"
@ 10,15 SAY "³                                        ³           ³"
@ 11,15 SAY "Ã Endere‡o ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÂ N§ ÄÄÄÄÄ´"
@ 12,15 SAY "³                                          ³         ³"
@ 13,15 SAY "Ã Bairro ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ CEP ÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´"
@ 14,15 SAY "³                         ³                          ³"
@ 15,15 SAY "Ã Cidade/UF ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÂ Fone ÄÄÄÄÄÄÄÄÄÄ´"
@ 16,15 SAY "³                            /      ³                ³"
@ 17,15 SAY "Ã Ins. Est. ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ C.G.C. ÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 18,15 SAY "³                         ³                          ³"
@ 19,15 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
SET KEY K_F8 TO PICKS
DO WHILE .T.
   INIC_VAR()
   TTURIS="NAO"
   SET CURSOR ON
   @ 10,17 GET MNOME     PICT "@!"     VALID (!EMPTY(MNOME))
   @ 10,58 GET TTURIS    PICT "@!"     VALID (VERTURIS(@TTURIS))
   @ 12,17 GET MENDER    PICT "@!"
   @ 12,60 GET MNUMER    PICT "99999"
   @ 14,17 GET MBAIRRO   PICT "@!"
   @ 14,43 GET MCEP      PICT "@R 99.999-999"
   @ 16,17 GET MCIDADE   PICT "@!"
   @ 16,45 GET MUF       PICT "@!"
   @ 16,53 GET MFONE     PICT "@R (9999)!99-9999"
   @ 18,17 GET MIE       PICT "@R 999.999.999-999"
   @ 18,43 GET MCGC      PICT "@R !!!.!!!.!!!/!!!!-!!" VALID (Empty(mCgc).or.(VERCGC(@MCGC,'I')))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      EXIT
   ENDI
   IF TRAVAREG()
      SET ORDER TO 0
      IF LASTREC()>1
         SKIP -1
         MCODIGO=CODIGO+1
         SKIP +1
      ELSE
         MCODIGO=1
      ENDI
      SET ORDER TO 1
      REPL_VAR()
      UNLOCK
   ELSE
      MENS('Firma/Agente nao Cadastrado')
   ENDIF
ENDDO
JANELA (2)
SET KEY K_F8 TO
RETURN

// MANUTENCAO DE FIRMAS/AGENTES

PROCEDURE HOT112

SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA     // DEL
SET KEY 65 TO ALTERA0       // A (ALTERACAO)
SET KEY 80 TO PESQUISA0     // P (PESQUISA)

@ 24,00 SAY PADR("[] Prox  [] Ant  [HOME] Inicio  [END] Fim  [DEL] Apaga  [A] Alt  [P] Pesq",80)
JANELA(01,07,15,19,68,"Manutencao Firmas/Agentes")
@ 09,15 SAY "Ã Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Turismo ÄÄ´"
@ 10,15 SAY "³                                        ³           ³"
@ 11,15 SAY "Ã Endere‡o ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÂ N§ ÄÄÄÄÄ´"
@ 12,15 SAY "³                                          ³         ³"
@ 13,15 SAY "Ã Bairro ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ CEP ÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´"
@ 14,15 SAY "³                         ³                          ³"
@ 15,15 SAY "Ã Cidade/UF ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÂ Fone ÄÄÄÄÄÄÄÄÄÄ´"
@ 16,15 SAY "³                                   ³                ³"
@ 17,15 SAY "Ã Ins. Est. ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ C.G.C. ÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 18,15 SAY "³                         ³                          ³"
@ 19,15 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
GOTO TOP
DO WHILE .T.
   IGUAL_VAR()
   IF MTURIS='S'
      TTURIS='SIM'
   ELSEIF MTURIS='N'
      TTURIS='NAO'
   ENDIF
   @ 10,17 SAY MNOME     PICT "@!"
   @ 10,58 SAY TTURIS    PICT "@!"
   @ 12,17 SAY MENDER    PICT "@!"
   @ 12,60 SAY MNUMER    PICT "99999"
   @ 14,17 SAY MBAIRRO   PICT "@!"
   @ 14,43 SAY MCEP      PICT "@R 99.999-999"
   @ 16,17 SAY MCIDADE   PICT "@!"
   @ 16,45 SAY MUF       PICT "@!"
   @ 16,53 SAY MFONE     PICT "@R (9999)999-9999"
   @ 18,17 SAY MIE       PICT "@R 999.999.999-999"
   @ 18,43 SAY MCGC      PICT "@R !!!.!!!.!!!/!!!!-!!"
   SET CURSOR OFF
   OLDCOLOR=SETCOLOR("N/N")
   WAIT""
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

// CONSULTA DE FIRMAS/AGENTES

PROCEDURE HOT113
MDB1={"NOME","ENDER","NUMER","BAIRRO","CEP","CIDADE","UF","FONE","IE","CGC","TURIS"}
MDB2={"@!","@!","99999","@!","@R 99.999999","@!","@!","@R (9999)!99-9999","@R 999.999.999-999","@R !!!.!!!.!!!/!!!!-!!","@!"}
MDB3={"Nome","Endereco","Numero","Bairro","CEP","Cidade","UF","Fone","Ins. Est.","CGC","TURISMO"}
@ 24,00 SAY PADR("[ENTER] Altera Campo  [DEL] Apaga [ESC] Sai",80)
GO TOP
JANELA(01,02,01,23,78,"Consulta de Firmas/Agentes")
SET CURSOR OFF
DBEDIT(04,02,22,77,MDB1,"VERDB",MDB2,MDB3,"Ä","³")
JANELA(2)
DO BARSTA
RETURN

// FUNCAO ALTERA REGISTRO - MANUTENCAO

PROCEDURE ALTERA0
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
SET KEY K_F8 TO PICKS
Set Cursor On
IF RLOCK()
   SET CURSOR ON
   @ 10,17 GET MNOME     PICT "@!"    VALID(!EMPTY(MNOME))
   @ 10,58 GET TTURIS    PICT "@!"    VALID(VERTURIS(@TTURIS))
   @ 12,17 GET MENDER    PICT "@!"
   @ 12,60 GET MNUMER    PICT "99999"
   @ 14,17 GET MBAIRRO   PICT "@!"
   @ 14,43 GET MCEP      PICT "@R 99.999-999"
   @ 16,17 GET MCIDADE   PICT "@!"
   @ 16,45 GET MUF       PICT "@!"
   @ 16,53 GET MFONE     PICT "@R (9999)999-9999"
   @ 18,17 GET MIE       PICT "@R 999.999.999-999"
   @ 18,43 GET MCGC      PICT "@R !!!.!!!.!!!/!!!!-!!"  VALID (Empty(mCgc).or.(VERCGC(@MCGC,'A')))
   READ
   SET CURSOR OFF
   IF LASTKEY()!=K_ESC
      REPL_VAR()
      UNLOCK
   ELSE
      KEYBOARD ""
   ENDIF
ELSE
   MENS('Arquivo sendo utilizado, Aguarde !!!')
ENDIF
SET KEY K_F8 TO
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA     // DEL
SET KEY 65 TO ALTERA0       // A (ALTERACAO)
SET KEY 80 TO PESQUISA0     // P (PESQUISA)
Set Cursor Off
RETURN

// FUNCAO PROCURA REGISTRO - MANUTENCAO

PROCEDURE PESQUISA0
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
JANELA(01,10,22,15,60)
AUX=RECNO()
TNOME=SPACE(35)
@ 11,29 SAY "Qual o Nome da Firma ???"
SET CURSOR ON
@ 13,24 GET TNOME PICT "@!" VALID VERFIRMA(@TNOME,'C')
READ
SET CURSOR OFF
JANELA(2)
IF (LASTKEY()=K_ESC)
   GO AUX
ENDIF
KEYBOARD CHR(13)
SET KEY K_RIGHT TO PROXIMO  // SETA DIREITA
SET KEY K_LEFT  TO ANTERIOR // SETA ESQUERDA
SET KEY K_HOME TO COMECO    // SETA HOME
SET KEY K_END  TO FINAL    // TECLA END
SET KEY K_DEL TO VERAPAGA     // DEL
SET KEY 65 TO ALTERA0       // A (ALTERACAO)
SET KEY 80 TO PESQUISA0     // P (PESQUISA)
RETURN

//VERIFICA SE  TURISMO OU NŽO A FIRMA

FUNCTION VERTURIS(X)

LOCAL ORDEM

IF !EMPTY(X)
   DO CASE
      CASE (X='SIM')
         MTURIS='S'
         ORDEM=.T.
      CASE (X='NAO')
         MTURIS='N'
         ORDEM=.T.
      OTHERWISE
         ORDEM=.F.
         MENS('Invalido !!!')
   ENDCASE
ELSE
   JANELA(01,08,53,13,66,"Turismo")
   TUR=1
   @ 11,55 PROMPT "SIM"
   @ 11,62 PROMPT "NAO"
   MENU TO TUR
   JANELA(02)
   DO CASE
      CASE TUR=0
         ORDEM=.F.
      CASE TUR=1
         TTURIS="SIM"
         MTURIS='S'
         ORDEM=.T.
      CASE TUR=2
         TTURIS="NAO"
         MTURIS='N'
         ORDEM=.T.
   ENDCASE
ENDIF
RETURN(ORDEM)

//FUNCAO VERIFICA SE POSSIVEL OU NAO DELETAR O REGISTRO

PROCEDURE VERAPAGA
SELE 05
DBGOTOP()
LOCATE FOR FIRMAAGE=FIRMAS->CODIGO
IF FOUND()
   MENS('Firma sendo utilizada !!!')
ELSE
   DO APAGA
ENDIF
SELE 01
KEYBOARD CHR(13)
RETURN
