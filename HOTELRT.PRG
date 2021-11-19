/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOTELRT.PRG
 \ Modulo..: Fun‡äes e Procedure do Sistema
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 14-06-95
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fun‡äes de procedures de uso geral
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

// CRIA E ABRE ARQUIVO DE PLANO DE SENHA E CONTROLE

FUNC ARQSEN
IF !FILE("SENHA.DBF")
   ARQ={}
   AADD(ARQ,{"NUMOP","N",2,0})
   AADD(ARQ,{"NOMEOP","C",20,0})
   AADD(ARQ,{"SENHA","C",6,0})
   AADD(ARQ,{"NIVELOP","N",1,0})
   DBCREATE("SENHA",ARQ)
ENDI
SELE 13
USE SENHA SHARED
IF LASTREC()=0
   IF TRAVAREG()
      REPL NUMOP WITH 1
      REPL NOMEOP WITH "HOTEL"
      REPL SENHA WITH CRIPT("HOTEL")
      REPL NIVELOP WITH 1
      UNLOCK
   ELSE
      CLOSE ALL
      SET COLOR TO
      CLEAR
      QUIT
   ENDI
ENDI
RETURN

// CRIPTOGRAFA AS SENHAS

FUNC CRIPT(X)
TAM=LEN(X)
Y=""
FOR Z=1 TO TAM
   Y+=CHR((ASC(SUBSTR(X,Z,1))+(70+Z)))
NEXT
RETURN(Y)

// DECRIPTOGRAFA AS SENHAS

FUNC DECRIP(X)
TAM=LEN(X)
Y=""
FOR Z=1 TO TAM
   Y+=CHR((ASC(SUBSTR(X,Z,1))-(70+Z)))
NEXT
RETURN(Y)

// ENTRADA DA SENHA

FUNC ENTRASEN
AUX=SETCOLOR()
SETCOLOR("W+/N")
@ 12,38 SAY SPACE(6)
COL=38
PALAVRA=""
TAM=0
DO WHILE (TAM<6)
   INKEY(0)
   DO CASE
      CASE (LASTKEY()>=48).AND.(LASTKEY()<=122)
         @ 12,COL SAY CHR(176)
         PALAVRA+=CHR(LASTKEY())
         TAM+=1
         COL+=1
      CASE LASTKEY()=K_BS .AND. TAM>0
         TAM-=1
         COL-=1
         PALAVRA=SUBSTR(PALAVRA,1,TAM)
         @ 12,COL SAY " "
      CASE LASTKEY()=K_ESC
         PALAVRA=""
         EXIT
      CASE LASTKEY()=K_ENTER
         TAM=6
   ENDC
ENDD
SETCOLOR(AUX)
RETURN(PALAVRA)

// ENTRADA DO PLANO DE SENHAS

PROC MUDAOP

LOCAL GETLIST:={}

SET KEY K_F5 TO
SET KEY K_F6 TO
SET KEY K_ALT_X TO
SET KEY K_F9 TO
SET KEY K_F10 TO
SET KEY K_F3 TO
SET KEY K_ALT_H TO
SET KEY K_ALT_M TO
X_POS=ROW()
Y_POS=COL()
CURS=SETCURSOR()
C_COR=SETCOLOR()
AREA=SELECT()
SET KEY K_F10 TO
JANELA(01,08,19,14,59,"Plano de Senhas")
@ 11,21 SAY "Nome  Operador :"
@ 12,21 SAY "Senha Operador :"
SELE 13
TENTA=0
DO WHILE .T.
   IF TENTA=3
      MENS("TENTATIVA DE VIOLACAO")
      MENS("ACESSO NEGADO")
      CLOSE ALL
      SET COLOR TO
      CLEAR
      QUIT
   ENDI
   INIC_VAR()
   SET CURSOR ON
   @ 11,38 GET MNOMEOP PICT "@!"
   READ
   SET CURSOR OFF
   LOCATE FOR NOMEOP=MNOMEOP
   IF !FOUND()
      TENTA+=1
      MENS("NOME DO OPERADOR INVALIDO")
      LOOP
   ENDIF
   TENTA=0
   DO WHILE .T.
      IF TENTA=3
         MENS("TENTATIVA DE VIOLACAO")
         MENS("ACESSO NEGADO")
         CLOSE ALL
         SET COLOR TO
         CLEAR
         QUIT
      ENDI
      IF ENTRASEN() != DECRIP(TRIM(SENHA))
         TENTA+=1
         MENS("SENHA INVALIDA")
         LOOP
      ENDIF
      EXIT
   ENDD
   EXIT
ENDD
DO BARSTA
WOPERADOR=NOMEOP
WNIVEL=NIVELOP
WNUMOP=NUMOP
JANELA(2)
DO CASE
   CASE NIVELOP = 1
      ML1={.T.,.T.,.T.,.T.,.T.,.F.,.T.}
      ML3={.T.,.T.}
      MLG={.T.,.T.,.T.}
      ML2={.T.,.T.,.T.,.T.,.T.,.T.,.T.}
      ML21={.T.,.T.}
      ML22={.T.,.T.}
      ML4={.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}
      ML41={.T.,.T.}
      ML5={.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}
      ML51={.T.,.T.}
   CASE NIVELOP = 2
      ML1={.T.,.T.,.T.,.T.,.F.,.F.,.T.}
      ML3={.T.,.T.}
      MLG={.T.,.T.,.T.}
      ML2={.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}
      ML21={.T.,.T.}
      ML22={.T.,.T.}
      ML4={.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}
      ML41={.T.,.T.}
      ML5={.F.,.F.,.F.,.F.,.T.,.T.,.F.,.T.,.T.,.T.,.T.}
   CASE NIVELOP = 3
      ML1={.T.,.T.,.T.,.T.,.F.,.F.,.T.}
      ML3={.T.,.T.}
      MLG={.T.,.F.,.T.}
      ML2={.T.,.T.,.T.,.T.,.T.,.F.,.F.}
      ML21={.T.,.T.}
      ML22={.T.,.F.}
      ML4={.T.,.F.,.T.,.F.}
      ML41={.T.,.T.}
      ML5={.F.,.F.,.F.,.F.,.F.,.T.,.F.,.T.,.T.,.T.,.T.}
ENDCASE
SETCOLOR(CORBAR)
@ 00,60 SAY "                   "  //LIMPA O ESPACO PARA NOVO OPERADOR
CON=LEN(ALLTRIM(NOMEOP))
@ 00,(80-CON) SAY (ALLTRIM(NOMEOP)) PICT "@!"
SELE &AREA
SETCURSOR(CURS)
SETPOS(Y_POS,X_POS)
SETCOLOR(C_COR)
SET KEY K_F10 TO MUDAOP
SET KEY K_F5 TO CALC
SET KEY K_F6 TO CALEN
SET KEY K_ALT_X TO SAIDA
SET KEY K_F9 TO HOT511()
SET KEY K_F10 TO MUDAOP
SET KEY K_F3 TO PESQHOSP
SET KEY K_ALT_H TO DATATUAL()
SET KEY K_ALT_M TO HOT22
RETURN

// CRIA E ABRE OS ARQUIVOS

FUNCTION ABREARQ
JANELA(1,11,15,15,66,"Abertura de Arquivos")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
ARQ={}
IF !FILE('CARTOES.DBF')
   ARQ:={}
   AADD(ARQ,{'NOMECAR','C',15,0})
   AADD(ARQ,{'TAXA','N',5,2})
   DBCREATE('CARTOES',ARQ)
   SELE 14
   USE CARTOES SHARED
   APPE BLAN
   REPLACE NOMECAR WITH  "CREDICARD",;
           TAXA    WITH  0
   APPE BLAN
   REPLACE NOMECAR WITH  "AMEX",;
           TAXA    WITH  0
   APPE BLAN
   REPLACE NOMECAR WITH  "VISA",;
           TAXA    WITH  0
   DBCOMMIT()
   CLOSE DATA
ENDIF
IF !FILE('CONREC.DBF')
   ARQ:={}
   AADD(ARQ,{'CODFIR','N',7,0})
   AADD(ARQ,{'DATAFEC','D',8,0})
   AADD(ARQ,{'VALOR','N',8,2})
   AADD(ARQ,{'NDOC','N',7,0})
   AADD(ARQ,{'DATAPAG','D',8,0})
   AADD(ARQ,{'VALORPAG','N',8,2})
   AADD(ARQ,{'SITUACAO','C',1,0,})
   DBCREATE('CONREC',ARQ)
ENDIF
IF !FILE('FIRMAS.DBF')
   ARQ={}
   AADD(ARQ,{'CODIGO','N',7,0})
   AADD(ARQ,{'NOME','C',35,0})
   AADD(ARQ,{'ENDER','C',40,0})
   AADD(ARQ,{'NUMER','N',5,0})
   AADD(ARQ,{'BAIRRO','C',20,0})
   AADD(ARQ,{"CEP","C",8,0})
   AADD(ARQ,{'CIDADE','C',20,0})
   AADD(ARQ,{'UF','C',2,0})
   AADD(ARQ,{'FONE','C',11,0})
   AADD(ARQ,{'IE','C',12,0})
   AADD(ARQ,{"CGC","C",16,0})
   AADD(ARQ,{"TURIS","C",1,0})
   DBCREATE('FIRMAS',ARQ)
ENDIF
IF !FILE('APTOS.DBF')
   ARQ={}
   AADD(ARQ,{'APTO','N',3,0})
   AADD(ARQ,{'LIBERADO','C',1,0})
   AADD(ARQ,{'DIARIA','N',07,2})
   AADD(ARQ,{'DESCRICAO','C',25,0})
   DBCREATE('APTOS',ARQ)
ENDIF
IF !FILE('EVENTUAL.DBF')
   ARQ={}
   AADD(ARQ,{'APTO','N',2,0})
   AADD(ARQ,{'LIBERADO','C',1,0})
   AADD(ARQ,{'DESCRICAO','C',25,0})
   DBCREATE('EVENTUAL',ARQ)
ENDIF
IF !FILE('HOSPEDES.DBF')
   ARQ={}
   AADD(ARQ,{'CODIGO','N',10,0})
   AADD(ARQ,{'NOME','C',35,0})
   AADD(ARQ,{'PROFISSAO','C',20,0})
   AADD(ARQ,{"ENDER","C",40,0})
   AADD(ARQ,{"BAIRRO","C",20,0})
   AADD(ARQ,{"CIDADE","C",20,0})
   AADD(ARQ,{"UF","C",2,0})
   AADD(ARQ,{"CEP","C",8,0})
   AADD(ARQ,{"PAIS","C",15,0})
   AADD(ARQ,{"FONE","C",11,0})
   AADD(ARQ,{"IDENTIDAD","C",14,0})
   AADD(ARQ,{"DTCAD","D",8,0})
   AADD(ARQ,{"DTNASC","D",8,0})
   AADD(ARQ,{"IDADE","N",2,0})
   AADD(ARQ,{"ESTCIVIL","N",1,0})
   AADD(ARQ,{"ATIVO","C",1,0})
   DBCREATE('HOSPEDES',ARQ)
ENDIF
IF !FILE('REGISTRO.DBF')
   ARQ={}
   AADD(ARQ,{'CODIGO','N',10,0})
   AADD(ARQ,{'APTO','N',3,0})
   AADD(ARQ,{"PAX","N",2,0})
   AADD(ARQ,{"CHD","N",2,0})
   AADD(ARQ,{'ATIVO','C',1,0})
   AADD(ARQ,{"FIRMAAGE","N",7,0})
   AADD(ARQ,{"INTERM","N",7,0})
   AADD(ARQ,{"HENT","C",4,0})
   AADD(ARQ,{"OPENT","N",2,0})
   AADD(ARQ,{"DTENT","D",8,0})
   AADD(ARQ,{"OPSAI","N",2,0})
   AADD(ARQ,{"DESPHOSP","C",1,0})
   DBCREATE('REGISTRO',ARQ)
ENDIF
IF !FILE('CONREGIS.DBF')
   ARQ:={}
   AADD(ARQ,{'CODIGO','N',10,0})
   AADD(ARQ,{'CODHOSP','N',10,0})
   AADD(ARQ,{"OBS","C",30,0})
   AADD(ARQ,{"PCONTA","C",1,0})
   AADD(ARQ,{"ULTPROC","C",20,0})
   AADD(ARQ,{"PROXDEST","C",20,0})
   AADD(ARQ,{"HSAI","C",4,0})
   AADD(ARQ,{"DTSAI","D",8,0})
   AADD(ARQ,{"VLNORMAL","N",13,2})
   AADD(ARQ,{"VLEXTRA","N",13,2})
   AADD(ARQ,{"SERNOR","N",11,2})
   AADD(ARQ,{"SEREXT","N",11,2})
   AADD(ARQ,{"RD","N",5,0})
   AADD(ARQ,{'ATIVO','C',1,0})
   DBCREATE('CONREGIS',ARQ)
ENDIF
IF !FILE('DESCONTO.DBF')
   ARQ={}
   AADD(ARQ,{'CODIGO','N',10,0})
   AADD(ARQ,{'Final','N',8,2})
   AADD(ARQ,{'PORC','N',2,0})
   AADD(ARQ,{'OBS','C',30,0})
   AADD(ARQ,{'OPERADOR','N',2,0})
   AADD(ARQ,{'AUTOR','C',15,0})
   Aadd(Arq,{'Quando','c',1,0})
   DBCREATE('DESCONTO',ARQ)
ENDIF
IF !FILE("CHEQUES.DBF")
   ARQ={}
   AADD(ARQ,{"CODIGO","N",10,0})
   AADD(ARQ,{'CODHOSP','N',10,0})
   AADD(ARQ,{"NCHEQUE","C",9,0})
   AADD(ARQ,{"BANCO","N",4,0})
   AADD(ARQ,{"VALOR","N",10,2})
   AADD(ARQ,{"DATAEMIS","D",8,0})
   AADD(ARQ,{"DATAPRE","D",8,0})
   AADD(ARQ,{"TIPOMOV","N",1,0})
   DBCREATE("CHEQUES",ARQ)
ENDIF
IF !FILE('RESERVA.DBF')
   ARQ={}
   AADD(ARQ,{'APTO','N',3,0})
   AADD(ARQ,{'HOSPEDE','C',35,0})
   AADD(ARQ,{'RG','C',14,0})
   AADD(ARQ,{'FONE','C',11,0})
   AADD(ARQ,{'DTSOLICIT','D',8,0})
   AADD(ARQ,{'HSOLICIT','C',4,0})
   AADD(ARQ,{'DTRESER','D',8,0})
   AADD(ARQ,{'HRESER','C',4,0})
   AADD(ARQ,{'OPERADOR','N',2,0})
   AADD(ARQ,{'AUTORES','C',15,0})
   DBCREATE('RESERVA',ARQ)
ENDIF
IF !FILE('MOVIM.DBF')
   ARQ={}
   AADD(ARQ,{"CODIGO","N",10,0})
   AADD(ARQ,{'CODHOSP','N',10,0})
   AADD(ARQ,{'DATMOV','D',8,0})
   AADD(ARQ,{'HORAMOV','C',4,0})
   AADD(ARQ,{'TIPOMOV','N',1,0})
   AADD(ARQ,{'TIPODESP','N',2,0})
   AADD(ARQ,{'VALOR','N',8,2})
   AADD(ARQ,{'OPERADOR','N',2,0})
   AADD(ARQ,{'TCON','C',1,0})
   DBCREATE('MOVIM',ARQ)
ENDIF
IF !FILE('PAGAM.DBF')
   ARQ={}
   AADD(ARQ,{"CODIGO","N",10,0})
   AADD(ARQ,{'CODHOSP','N',10,0})
   AADD(ARQ,{'TIPOMOV','N',1,0})
   AADD(ARQ,{'FORMAPAG','N',1,0})
   AADD(ARQ,{'TIPOCART','N',9,0})
   AADD(ARQ,{'VALOR','N',8,2})
   AADD(ARQ,{'NUMERO','C',20,0})
   AADD(ARQ,{'BANCO','N',4,0})
   AADD(ARQ,{'AGENCIA','N',5,0})
   DBCREATE('PAGAM',ARQ)
ENDIF
IF !FILE('BMD.DBF')
   ARQ={}
   AADD(ARQ,{'MESDIA','N',14,2})
   AADD(ARQ,{'MESSAME','N',14,2})
   AADD(ARQ,{'MESTEL','N',14,2})
   AADD(ARQ,{'MESLAV','N',14,2})
   AADD(ARQ,{'MESFRI','N',14,2})
   AADD(ARQ,{'MESCON','N',14,2})
   AADD(ARQ,{'MESCOP','N',14,2})
   AADD(ARQ,{'MESDIV','N',14,2})
   AADD(ARQ,{'MESRES','N',14,2})
   AADD(ARQ,{'MESSDIA','N',14,2})
   AADD(ARQ,{'MESTXSER','N',14,2})
   AADD(ARQ,{'MESTBRUTO','N',14,2})
   AADD(ARQ,{'MESDIN','N',14,2})
   AADD(ARQ,{'MESCHE','N',14,2})
   AADD(ARQ,{'MESCRE','N',14,2})
   AADD(ARQ,{'MESRDA','N',14,2})
   AADD(ARQ,{'MESCOB','N',14,2})
   AADD(ARQ,{'MESCORT','N',14,2})
   AADD(ARQ,{'MESSALDOT','N',14,2})
   AADD(ARQ,{'MESSALPAX','N',14,2})
   AADD(ARQ,{'MESENTPAX','N',14,2})
   AADD(ARQ,{'MESSTPAX','N',14,2})
   AADD(ARQ,{'MESSAIPAX','N',14,2})
   AADD(ARQ,{'MESSALDP','N',14,2})
   AADD(ARQ,{'MESOCUPAX','N',6,2})
   AADD(ARQ,{'MESSALAP','N',14,2})
   AADD(ARQ,{'MESENTAP','N',14,2})
   AADD(ARQ,{'MESSTAP','N',14,2})
   AADD(ARQ,{'MESSAIAP','N',14,2})
   AADD(ARQ,{'MESSDAP','N',14,2})
   AADD(ARQ,{'MESOCUAP','N',6,2})
   AADD(ARQ,{'MESSALR','N',14,2})
   AADD(ARQ,{'MESENTRE','N',14,2})
   AADD(ARQ,{'MESSTRE','N',14,2})
   AADD(ARQ,{'MESSAIRE','N',14,2})
   AADD(ARQ,{'MESSDRE','N',14,2})
   AADD(ARQ,{'MESVALREP','N',14,2})
   AADD(ARQ,{'MESVALREA','N',6,2})
   AADD(ARQ,{'MESSALANT','N',14,2})
   AADD(ARQ,{'SOMATORIA','N',14,2})
   DBCREATE('BMD',ARQ)
ENDIF
IF !FILE("CONTROLE.DBF")
   ARQ={}
   AADD(ARQ,{"NomHot","c",40,0})
   AADD(ARQ,{"EndHot","c",40,0})
   AADD(ARQ,{"NuHot","c",5,0})
   AADD(ARQ,{"CidHot","c",30,0})
   AADD(ARQ,{"UfHot","c",2,0})
   AADD(ARQ,{"CepHot","c",8,0})
   AADD(ARQ,{"TelHot","c",11,0})
   AADD(ARQ,{"FaxHot","c",11,0})
   AADD(ARQ,{"TexHot","c",15,0})
   AADD(ARQ,{"NUMRD","N",5,0})
   AADD(ARQ,{"BMD","D",8,0})
   AADD(ARQ,{"HBMD","C",4,0})
   AADD(ARQ,{"JUROS","N",6,2})
   AADD(ARQ,{"DTCAIXA","D",8,0})
   AADD(ARQ,{"HCAIXA","C",4,0})
   AADD(ARQ,{"COLCHAO","M",10,0})
   Aadd(Arq,{"TaxaSer","n",2,0})
   Aadd(Arq,{"Data","c",8,0})
   Aadd(Arq,{"Vezes","n",2,0})
   AADD(ARQ,{"DRIVE","C",1,0})
   DBCREATE("CONTROLE",ARQ)
   Use Controle
   Append Blank
   Replace TaxaSer With 10
   REPL DRIVE WITH 'A'
   Use
ENDI
IF !FILE("TEMPO.DBF")
   ARQ={}
   AADD(ARQ,{"DATMOV","D",8,0})
   AADD(ARQ,{"TIPOMOV","C",6,0})
   AADD(ARQ,{"TCON","C",3,0})
   AADD(ARQ,{"TIPODESP","C",15,0})
   AADD(ARQ,{"VALOR","N",8,2})
   AADD(ARQ,{"OPERADOR","C",20,0})
   DBCREATE("TEMPO",ARQ)
ENDI
IF !FILE("TEMPO1.DBF")
   ARQ={}
   AADD(ARQ,{'APTO','N',3,0})
   AADD(ARQ,{'NOME','C',35,0})
   AADD(ARQ,{'RG','C',14,0})
   AADD(ARQ,{'PAX','N',2,0})
   AADD(ARQ,{'CHD','N',2,0})
   DBCREATE('TEMPO1',ARQ)
ENDIF
IF !FILE("FIRMA1.NTX")
   USE FIRMAS EXCLUSIVE
   INDEX ON CODIGO TO FIRMA1
   CLOSE
ENDIF
IF !FILE("FIRMA2.NTX")
   USE FIRMAS EXCLUSIVE
   INDEX ON NOME TO FIRMA2
   CLOSE
ENDIF
IF !FILE("APTOS1.NTX")
   USE APTOS EXCLUSIVE
   INDEX ON APTO TO APTOS1
   CLOSE
ENDIF
IF !FILE("EVENT1.NTX")
   USE EVENTUAL EXCLUSIVE
   INDEX ON APTO TO EVENT1
   CLOSE
ENDIF
IF !FILE("HOSPED1.NTX")
   USE HOSPEDES EXCLUSIVE
   INDEX ON CODIGO TO HOSPED1
   CLOSE
ENDIF
IF !FILE("HOSPED2.NTX")
   USE HOSPEDES EXCLUSIVE
   INDEX ON NOME TO HOSPED2
   CLOSE
ENDIF
IF !FILE("REGIST3.NTX")
   USE REGISTRO EXCLUSIV
   INDEX ON APTO TO REGIST3
ENDIF
IF !FILE("CONREGIS1.NTX")
   USE CONREGIS EXCLUSIVE
   INDEX ON CODHOSP TO CONREGIS1
   CLOSE
ENDIF
IF !FILE("REGIST1.NTX")
   USE REGISTRO EXCLUSIVE
   INDEX ON APTO TO REGIST1
   CLOSE
ENDIF
IF !FILE("CONREGIS2.NTX")
   USE CONREGIS EXCLUSIVE
   INDEX ON (CTOD("31/12/99")-DTSAI) TO REGIST2
   CLOSE
ENDIF
IF !FILE("REGIST2.NTX")
   USE REGISTRO EXCLUSIVE
   INDEX ON DTENT TO REGIST2
   CLOSE
ENDIF
IF !FILE("DESCON1.NTX")
   USE DESCONTO EXCLUSIVE
   INDEX ON CODIGO TO DESCON1
   CLOSE
ENDIF
IF !FILE("CHEQUES1.NTX")
   USE CHEQUES EXCLUSIVE
   INDEX ON DATAPRE TO CHEQUES1
   CLOSE
ENDIF
IF !FILE("RESERV1.NTX")
   USE RESERVA EXCLUSIVE
   INDEX ON HOSPEDE TO RESERV1
   CLOSE
ENDIF
IF !FILE("RESERV2.NTX")
   USE RESERVA EXCLUSIVE
   INDEX ON DTRESER TO RESERV2
   CLOSE
ENDIF
IF !FILE("MOVIM1.NTX")
   USE MOVIM EXCLUSIVE
   INDEX ON CODIGO TO MOVIM1
   CLOSE
ENDIF
IF !FILE("MOVIM2.NTX")
   USE MOVIM EXCLUSIVE
   INDEX ON DATMOV TO MOVIM2
   CLOSE
ENDIF
IF !FILE("PAGAM1.NTX")
   USE PAGAM EXCLUSIVE
   INDEX ON CODIGO TO PAGAM1
   CLOSE
ENDIF
SELE 01
USE FIRMAS INDEX FIRMA1, FIRMA2 SHARED
SELE 02
USE APTOS INDEX APTOS1 SHARED
SELE 03
USE EVENTUAL INDEX EVENT1 SHARED
SELE 06
USE DESCONTO INDEX DESCON1 SHARED
SELE 07
USE CHEQUES INDEX CHEQUES1 SHARED
SELE 08
USE RESERVA INDEX RESERV1, RESERV2 SHARED
SELE 09
USE MOVIM INDEX MOVIM1, MOVIM2 SHARED
SELE 10
USE PAGAM INDEX PAGAM1 SHARED
SELE 05
USE REGISTRO INDEX REGIST1, REGIST2, REGIST3 SHARED
SELE 17
USE CONREGIS INDEX CONREGIS1, CONREGIS2 SHARED
SELE 04
USE HOSPEDES INDEX HOSPED1, HOSPED2 SHARED
SELE 11
USE BMD SHARED
SELE 12
USE CONTROLE SHARED
SELE 13
USE SENHA SHARED
SELE 14
USE CARTOES SHARED
JANELA(02)
RETURN

// PREPARA O ACESSO AOS MENUS

FUNCTION PREPMENU
   // M1 - SUBMENU ARQUIVOS - CADASTRO
AADD(M1,'Firmas/Agentes  '+CHR(16))
AADD(M1,'Apartamentos    '+CHR(16))
AADD(M1,'Eventuais       '+CHR(16))
AADD(M1,'Hospedes        '+CHR(16))
AADD(M1,'Manutencao Reg.  ')
AADD(M1,'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ')
AADD(M1,'Saida      Alt+X')

   //M3 - SUBMENU ARQUIVO - CONSULTAS
AADD(M3,'Apartamentos  ')
AADD(M3,'Movimentos   '+CHR(16))
AADD(M3,'Departamento  ')

   //M3L - SUBMENU DO SUBMENU ARQUIVO - CONSULTAS
AADD(M321,'Video       ')
AADD(M321,'Impressora  ')
ML321:={.T.,.T.}

   // MG - SUBMENU GERAL PARA USO DO MENU ARQUIVOS
AADD(MG,"Inclusao  ")
AADD(MG,"Manutencao")
AADD(MG,"Consulta  ")

   // M2 - SUBMENU ARQUIVOS - LANCAMENTO
AADD(M2,"Registro      ")
AADD(M2,"Movimentos    ")
AADD(M2,"Fechamento    ")
AADD(M2,"Cheques Pre  "+CHR(16))
AADD(M2,"Reserva      "+CHR(16))
AADD(M2,"Estornos      ")
AADD(M2,"Reabertura    ")
AADD(M2,"Troca Apto    ")

   // M21 - SUBMENU GERAL PARA USO DO MENU ARQUIVOS (CHEQUES PRE)
AADD(M21,"Inclusao  ")
AADD(M21,"Manutencao")

   // M22 - SUBMENU GERAL PARA USO DO MENU ARQUIVOS (RESERVA)
AADD(M22,"Inclusao")
AADD(M22,"Exclusao")

   // M4 - SUBMENU ARQUIVO - RELATORIOS
AADD(M4,"Relacao de Despesas      "+CHR(16))
AADD(M4,"Caixa                     ")
AADD(M4,"Relacao de Hospedes       ")
AADD(M4,"Boletim Movimento Diario  ")
AADD(M4,"Relacao de Departamentos  ")
AADD(M4,"Mapa de Hospedes          ")
AADD(M4,"Relacao de Saida Prevista ")

   // M41 - SUBMENU TIPO DE RELACAO DE DESPESAS
AADD(M41,"Normal")
AADD(M41,"Extra")

   //M5 - SUBMENU ARQUIVO - UTILITARIOS
AADD(M5,"Plano de Senha         "+CHR(16))
AADD(M5,"Informacoes do Hotel    ")
Aadd(M5,"Taxa de Servicos        ")
AADD(M5,"Eliminar Reg. Deletados ")
AADD(M5,"Recuperar Reg. Deletados")
AADD(M5,"Reconstroe Indices      ")
AADD(M5,"Faz Copias de Seguranca ")
Aadd(M5,"Restaura Copias         ")
Aadd(M5,"Altera Unidade de Copia ")
AADD(M5,"Calculadora           F5")
AADD(M5,"Calendario            F6")
AADD(M5,"Colchoes Magneticos     ")

   //M51 - SUBMENU ARQUIVO - UTILITARIOS / PLANO DE SENHA
AADD(M51,"Trocar Senha        F9")
AADD(M51,"Cadastrar Operador    ")
AADD(M51,"Operadores cadastrados")


   // MENU DO TIPO DE MOVIMENTO
AADD(MAT1,"NORMAL")
AADD(MAT1,"EXTRA ")

   // MENU DO TIPO DE DESPESA
AADD(MAT2,"DIARIA      ")
AADD(MAT2,"AMERICAN BAR")
AADD(MAT2,"TELEFONE    ")
AADD(MAT2,"LAVANDERIA  ")
AADD(MAT2,"FRIGOBAR    ")
AADD(MAT2,"CONVENCAO   ")
AADD(MAT2,"COPA        ")
AADD(MAT2,"DIVERSOS    ")
AADD(MAT2,"RESTAURANTE ")

   // MENU DO TIPO DE PAGAMENTO
AADD(MAT3,"DINHEIRO ")
AADD(MAT3,"CHEQUES  ")
AADD(MAT3,"C/CREDITO")
AADD(MAT3,"RDA      ")
AADD(MAT3,"COBRANCAS")

// TIPO DE ESTADO CIVIL

AADD(MAT4,"SOLTEIRO  ")
AADD(MAT4,"CASADO    ")
AADD(MAT4,"DIVORCIADO")
AADD(MAT4,"SEPARADO  ")
AADD(MAT4,"AMASEADO  ")

RETURN

//  TESTE DE TECLA PARA FUNCAO DBEDIT() - RAMALHO - MODIFICADA

FUNCTION VERDB(MD,COUNTER)
ORDEM=1
SET CURSOR OFF
DO CASE
   CASE MD=1                     // FOI PRESSIONADO PGUP OU
      MENS('Inicio do Arquivo')  // SETA SUPERIOR NO 1 REG.
      ORDEM=1
   CASE MD=2                     // FOI PRESSIONADO PGDN OU
      MENS('Fim do Arquivo')     // SETA INFERIOR NO ULTIMO
      ORDEM=1                    // REGISTRO
   CASE MD=3
      MENS('Arquivo sem Conteudo')
      ORDEM=0
   CASE MD=4
          // TESTA A ULTIMA TECLA PRESSIONADA
      DO CASE
         CASE LASTKEY()=27  // FOI PRESSIONADO ESC
            ORDEM=0       // ABANDONA DBEDIT
         CASE LASTKEY()=13
                  // FOI PRESSIONADO ENTER, NESSE CASO EDITAREMOS O CAMPO ATUAL
            IF WNIVEL<3
               SET CURSOR ON
               CAMPO=MDB1[COUNTER]
               MASCARA=MDB2[COUNTER]
               COLED=COL() // OBTEM COLUNA ATUAL
               LINED=ROW() // ABTEM LINHA ATUAL
               DO WHILE .T.
                  IF RLOCK()
                     SET CURSOR ON
                     @ LINED,COLED GET &CAMPO PICTURE MASCARA // EDITA CAMPO ATUAL
                     READ
                     SET CURSOR OFF
                     UNLOCK
                     EXIT
                  ELSE
                     MENS('Arquivo sendo utilizado !!!')
                  ENDI
               ENDD
               SET CURSOR OFF
               KEYBOARD CHR(4) // MOVE O CURSOR PARA A COLUNA DA
               ORDEM=1         // DIREITA COM ->
            ENDIF
         CASE LASTKEY()=7
            IF RLOCK()
               DELETE
               UNLOCK
               SET DELETED OFF
               AUX=0
               DBEVAL({|| AUX++ },{|| DELETED()=.T. })
               SET DELETED ON
               IF (LASTREC()-AUX)<01
                  MENS('Arquivo sem Conteudo')
                  ORDEM=0
               ELSE
                  KEYBOARD CHR(24) // MOVE O CURSOR PARA O PROXIMO REGISTRO
                  ORDEM=1
               ENDIF
            ELSE
               MENS('Arquivo sendo Utilizado !!!')
               IF LASTKEY()=K_ESC
                  ORDEM=0
                  SET CURSOR ON
                  RETURN(ORDEM)
               ENDIF
            ENDIF
      ENDCASE
ENDCASE
SET CURSOR ON
RETURN(ORDEM)

//  VERIFICA AS TECLAS NO MENU ACHOICE

FUNCTION VERMENU(MD)
SETCOLOR(CORMU)
ORDEM=2
DO CASE
   CASE MD=0
      ORDEM=2
   CASE MD=1 // ROTACAO - PARA O FIM DO MENU
      KEYBOARD CHR(30)
      ORDEM=2
   CASE MD=2 // ROTACAO - PARA O INICIO DO MENU
      KEYBOARD CHR(31)
      ORDEM=2
   CASE MD=3
      ULTECLA=LASTKEY()
      DO CASE
         CASE ULTECLA=27
            ORDEM=0
         CASE ULTECLA=13
            ORDEM=1
         CASE (ULTECLA>=65).AND.(ULTECLA<=122) // <LETRA>
            ORDEM=3
         CASE (ULTECLA=4) .AND. (NIVEL=1) // <SETA DIREITA>
            ORDEM=0
            OPC=OPC+1
            IF OPC>FMEN
               OPC=1
            ENDIF
            KEYBOARD CHR(13)
         CASE (ULTECLA=19) .AND. (NIVEL=1) // <SETA ESQUERDA>
            ORDEM=0
            OPC=OPC-1
            IF OPC<1
               OPC=FMEN
            ENDIF
            KEYBOARD CHR(13)
      ENDCASE
   OTHERWISE
      ORDEM=2
ENDCASE
RETURN(ORDEM)



//  CRIA/APAGA JANELA DE DIALOGO

FUNCTION JANELA(TIPO,JL1,JC1,JL2,JC2,TITULO)
IF TIPO=1
   NUJAN=NUJAN+1
   CORJAN[NUJAN]=SETCOLOR()
   COORD[NUJAN,1]=JL1
   COORD[NUJAN,2]=JC1
   COORD[NUJAN,3]=(JL2+1)
   COORD[NUJAN,4]=(JC2+1)
   TELAJAN[NUJAN]=(SAVESCREEN(JL1,JC1,JL2+1,JC2+1))
   SHADOW(JL1,JC1,JL2,JC2)
   SETCOLOR(CORJ)
   @ JL1,JC1,JL2,JC2 BOX "ÚÄ¿³ÙÄÀ³ "
   IF .NOT.EMPTY(TITULO)
      SETCOLOR(CORBAR)
      @ JL1+1,JC1+1 SAY PADC(TITULO,((JC2)-(JC1+1)))
      SETCOLOR(CORJ)
   ENDIF
ELSE
   RESTSCREEN(COORD[NUJAN,1],COORD[NUJAN,2],COORD[NUJAN,3],COORD[NUJAN,4],TELAJAN[NUJAN])
   SETCOLOR(CORJAN[NUJAN])
   NUJAN=NUJAN-1
ENDIF
RETURN(NIL)

//  CALCULADORA

FUNCTION CALC

X_POS=ROW()
Y_POS=COL()
C_COR=SETCOLOR()
CA_TELA=SAVESCREEN(0,53,14,79)
SET CURSOR OFF
SET COLOR TO /BG
SHADOW(1,54,13,78,6,8)
@ 1,54 CLEAR TO 13,78
SET COLOR TO W/BG
@ 02,55 SAY REPL(CHR(220),23)
@ 03,55 SAY CHR(219)+SPACE(21)+CHR(219)
@ 04,55 SAY REPL(CHR(223),23)
SET COLOR TO /W
@ 00,53 TO 14,79 DOUBLE
@ 06,55 SAY ' 7 '
@ 06,60 SAY ' 8 '
@ 06,65 SAY ' 9 '
@ 08,55 SAY ' 4 '
@ 08,60 SAY ' 5 '
@ 08,65 SAY ' 6 '
@ 10,55 SAY ' 1 '
@ 10,60 SAY ' 2 '
@ 10,65 SAY ' 3 '
@ 12,55 SAY '  0  '
@ 12,63 SAY '  .  '
SET COLOR TO W/B
@ 06,70 SAY ' - '
@ 12,75 SAY ' % '
@ 08,70 SAY ' + '
@ 08,75 SAY ' * '
@ 10,75 SAY ' / '
SET COLOR TO W/R
@ 10,70 SAY CHR(17)+CHR(196)+CHR(217)
@ 11,70 SAY '   '
@ 12,70 SAY ' = '
@ 06,75 SAY 'C/E'
SET COLOR TO W
C_RESULT=0
C_ALGA=SPACE(14)
C_DEC=''
C_DIG=CHR(0)
C_VAR='C_ALGA'
C_VERDAD=.F.
SET COLOR TO W
@ 03,56 SAY ' '+STR(C_RESULT,19,4)+' '
C_UOPER=''
C_PERC=' '
DO WHILE C_DIG<>CHR(27)
   C_DIG=CHR(INKEY(0))
   IF C_DIG=CHR(27)
      EXIT
   ENDIF
   C_VAR=IIF(C_DIG='.','C_DEC',C_VAR)
   C_ALGA=IIF(C_DIG='.' .AND. C_ALGA=SPACE(14),SPACE(13)+'0',C_ALGA)
   IF C_DIG='%'
      IF C_VERDAD
         C_PERC=IIF(C_PERC='%',' ','%')
         SET COLOR TO /W
         @ 03,77 SAY C_PERC
         SET COLOR TO W
      ELSE
         @ 03,57 SAY SPACE(13)+'0.0000'
      ENDIF
   ELSEIF C_DIG $ '0123456789' .AND. LEN(LTRIM(&C_VAR))<>IIF(C_VAR='C_DEC',4,14)
      &C_VAR=IIF(C_VAR='C_DEC',&C_VAR+C_DIG,SUBS(&C_VAR+C_DIG,2))
      @ 03,57 SAY C_ALGA+'.'+SUBS(C_DEC+SUBS('00000',LEN(C_DEC)+1),1,4)
      C_VERDAD=IIF(C_VERDAD .AND. C_UOPER $ '='+CHR(13),.F.,C_VERDAD)
   ELSEIF C_DIG $ '+-/*='+CHR(13)
      IF C_VERDAD
         IF VAL(C_ALGA+'.'+C_DEC)<>0
            IF C_PERC='%'
               OPE_RA=STR(C_RESULT,19,4)+C_UOPER+'('+STR(C_RESULT,19,4)+'*'+C_ALGA+'.'+SUBS(C_DEC+SUBS('00000',LEN(C_DEC)+1),1,4)+')/100.000'
            ELSE
               OPE_RA=STR(C_RESULT,19,4)+C_UOPER+C_ALGA+'.'+SUBS(C_DEC+SUBS('00000',LEN(C_DEC)+1),1,4)
            ENDIF
            C_RESULT=&OPE_RA
            @ 03,57 SAY STR(C_RESULT,19,4)
         ENDIF
      ELSEIF C_DIG $ '+-/*'
         C_VERDAD=.T.
         C_RESULT=VAL(C_ALGA+'.'+C_DEC)
      ENDIF
      SET COLOR TO N/W
      @ 03,55 SAY IIF(C_DIG $ '+-/*',C_DIG,' ')
      @ 03,77 SAY ' '
      SET COLOR TO W
      C_VAR='C_ALGA'
      C_ALGA=SPACE(14)
      C_DEC=''
      C_UOPER=C_DIG
      C_PERC=' '
   ELSEIF C_DIG $ 'EECC'
      C_VAR='C_ALGA'
      C_ALGA=SPACE(14)
      C_DEC=''
      C_PERC=' '
      IF C_DIG $ 'CC'
         C_VERDAD=.F.
         SET COLOR TO N/W
         @ 03,55 SAY ' '
         @ 03,77 SAY ' '
         SET COLOR TO W
      ENDIF
      @ 03,57 SAY SPACE(13)+'0.0000'
   ENDIF
ENDDO
SETCOLOR(C_COR)
RESTSCREEN(0,53,14,79,CA_TELA)
SET CURSOR OFF
@ X_POS,Y_POS SAY ''
RETURN(NIL)

//  CALENDARIO

FUNCTION CALEN
X_POS=ROW()
Y_POS=COL()
C_COR=SETCOLOR()
SET CURSOR OFF
CA_MES=MONTH(DAT_HOJE)
CA_ANO=YEAR(DAT_HOJE)
CA_DIA=DAY(DAT_HOJE)
CA_DATA=DAT_HOJE
CA_DIA1=CTOD('01/'+STR(CA_MES,2)+'/'+SUBS(STR(CA_ANO,4),3))
CA_TELA=SAVESCREEN(0,0,13,39)
C_VARDIA='   1    2    3    4    5    6    7    8    9   10   11   12   13'
C_VARDIA=C_VARDIA+'   14   15   16   17   18   19   20   21   22   23   24'
C_VARDIA=C_VARDIA+'   25   26   27   28   29   30   31 '
C_TEC=0
DO WHILE C_TEC<>27
   SET COLOR TO N/W
   @ 0,0 CLEAR TO 10,38
   SHADOW(0,0,10,38,1,0)
   @ 0,0 TO 10,38
   SET COLOR TO W+/R
   @ 4,2 SAY ' DOM  SEG  TER  QUA  QUI  SEX  SAB '
   SET COLOR TO N/W
   IF AT(SUBS(STR(CA_MES+100,3),2),'01 03 05 07 08 10 12')<>0
      CA_VAR=C_VARDIA+SPACE(32)
      ULT_DIA = 31
   ELSE
      IF CA_MES<>2
         CA_VAR=SUBS(C_VARDIA,1,150)+SPACE(32)
         ULT_DIA = 30
      ELSE
         IF INT(CA_ANO/4)=CA_ANO/4
            CA_VAR=SUBS(C_VARDIA,1,145)+SPACE(32)
            ULT_DIA = 29
         ELSE
            CA_VAR=SUBS(C_VARDIA,1,140)+SPACE(32)
            ULT_DIA = 28
         ENDIF
      ENDIF
   ENDIF
   V_AR=IIF(DOW(CA_DIA1)>1,REPL('     ',DOW(CA_DIA1)-1)+CA_VAR,CA_VAR)
   X_X=1
   DO WHILE .T.
      IF LEN(V_AR)<X_X*35
         EXIT
      ENDIF
      SET COLOR TO N/W
      SEM_ANA = SUBS(V_AR,(35*X_X)-34,34)
      @ 5+X_X,01 SAY ' '+SEM_ANA+'  '
      SET COLOR TO W+/R
      @ 5+X_X,00 SAY "³"
      @ 5+X_X,38 SAY "³"
      @ 5+X_X,2  SAY SUBS(SEM_ANA,1,5)
      SEM_ANA=' '+SEM_ANA
      IF AT(STR(CA_DIA,5),SEM_ANA) <> 0
         POS = AT(STR(CA_DIA,5),SEM_ANA)
         IF POS = 1
            SET COLOR TO W+/N
            @ 5+X_X,2 SAY STR(CA_DIA,4)
         ELSE
            SET COLOR TO W+/N
            @ 5+X_X,1 + POS SAY STR(CA_DIA,4)
         ENDIF
      ENDIF
      X_X=X_X+1
   ENDDO
   SET COLOR TO N/W
   @ 0,0 TO 5+X_X,38
   SHADOW(0,0,5+X_X,38,1,0)
   MES_ANO=SUBS('Janeriro FevereiroMar‡o    Abril    Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro ',CA_MES*9-8,9)
   MES_ANO=ALLTRIM(STR(DAY(CA_DATA),2))+' DE '+TRIM(MES_ANO)
   MES_ANO=MES_ANO+' DE '+STR(YEAR(CA_DATA),4)
   @ 2,0+(39-LEN(MES_ANO))/2 SAY MES_ANO
   C_TEC=INKEY(0)
   CA_ANO=CA_ANO+IIF(C_TEC=5,-1,IIF(C_TEC=24,1,0))
   CA_MES=CA_MES+IIF(C_TEC=19,-1,IIF(C_TEC=4,1,0))
   CA_MES=IIF(CA_MES<1,12,IIF(CA_MES>12,1,CA_MES))
   SET CENTURY ON
   IF CA_DIA > ULT_DIA
      CA_DIA = ULT_DIA
   ENDIF
   CA_DATA=CTOD(STR(CA_DIA,2)+'/'+STR(CA_MES,2)+'/'+STR(CA_ANO,4))
   CA_DIA1=CTOD('01/'+STR(CA_MES,2)+'/'+SUBS(STR(CA_ANO,4),3))
   SET CENTURY OFF
   RESTSCREEN(0,0,13,39,CA_TELA)
ENDDO
SETCOLOR(C_COR)
SET CURSOR OFF
@ X_POS,Y_POS SAY ''
RETURN(NIL)

//PESQUISA DE HOSPEDES - TECLA DE ATALHO F3

PROCEDURE PESQHOSP

LOCAL GETLIST:={}

X_POS=ROW()
Y_POS=COL()
C_COR=SETCOLOR()
CURS=SETCURSOR()
JANELA(01,08,19,13,58)
@ 09,26 SAY "Qual o nome do Hospede ?"
TNOME=SPACE(35)
SET CURSOR ON
@ 11,21 GET TNOME PICT "@!" VALID(!EMPTY(TNOME))
READ
SET CURSOR OFF
JANELA(02)
IF LASTKEY()=K_ESC
   SETCOLOR(C_COR)
   @ X_POS,Y_POS SAY ''
   SETCURSOR(CURS)
   RETURN
ENDIF
AREA=SELECT()
REG=RECNO()
SELE 04
DBGOTOP()
LOCATE FOR ((NOME=TRIM(TNOME)) .AND. (ATIVO='S'))
IF FOUND()
   SET FILTER TO ((NOME=TRIM(TNOME)) .AND. (ATIVO='S'))
   DBGOTOP()
   SET KEY K_RIGHT TO PROXIMO
   SET KEY K_LEFT  TO ANTERIOR
   SET KEY K_HOME  TO COMECO
   SET KEY K_END   TO FINAL
   SET KEY K_DEL   TO APAGA
   JANELA(01,10,07,14,75,"Consulta - Registro de Hospedes")
   BARRA=SAVESCREEN(24,01,24,79)
   @ 24,00 SAY PADR("[ESC] Sai  [] Prox  [] Ant  [HOME] Inicio  [END] Fim",80)
   SET CURSOR OFF
   @ 12,07 SAY "Ã Apto Â Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Identidade ÄÄÄÄÄÄÄÄÄ´"
   @ 13,07 SAY "³      ³                                      ³                     ³"
   @ 14,07 SAY "ÀÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   DO WHILE .T.
      SELE 04
      THOSPE=NOME
      TRG=IDENTIDAD
      SELE 05
      DBGOTOP()
      LOCATE FOR CODHOSP=HOSPEDES->CODIGO
      IGUAL_VAR()
      @ 13,09 SAY MAPTO     PICT "999"
      @ 13,16 SAY THOSPE    PICT "@!"
      @ 13,55 SAY TRG       PICT "@R 999.999.999-9"
      SELE 04
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
   JANELA(02)
   RESTSCREEN(24,01,24,79,BARRA)
ELSE
   MENS('Nome nao encontrado !!!')
ENDIF
SELE 04
SET FILTER TO
SELE &AREA
IF REG#0
   GO REG
ENDIF
SETCOLOR(C_COR)
SET CURSOR OFF
SETCURSOR(CURS)
@ X_POS,Y_POS SAY ''
RETURN

//FUNCAO VERIFICA APTO ATIVO='S' EM REGISTRO

FUNCTION VERIFICA(X)

LOCAL ORDEM

AREA=SELECT()
ORDEM=.F.
ACHOU=.F.
IF !EMPTY(X)
   IF X>99
      SELE 02          //AREA DE APARTAMENTO
      DBGOTOP()
      LOCATE FOR APTO=X
   ELSEIF X<100
      SELE 03          //AREA DE EVENTUAIS
      DBGOTOP()
      LOCATE FOR APTO=X
   ENDIF
   IF FOUND()
      SELE 05
      DBGOTOP()
      LOCATE FOR APTO=X
      TCOD=CODHOSP
      SELE 04
      DBGOTOP()
      LOCATE FOR CODIGO=TCOD
      THOSPEDE=NOME
      ORDEM=.T.
      SELE 05
      SET FILTER TO ATIVO='S'
      LOCATE FOR APTO=X
      IF !FOUND()
         TAPTO=0
         ORDEM=.F.
         MENS('Apartamento Liberado')
      ENDIF
   ELSE
      TAPTO=0
      MENS('Apartamento Inv lido')
   ENDIF
ELSE
   DO MENUAPART
   IF LASTKEY()!=K_ESC
      SELE 02
      TAPTO=APTO
      SELE 05
      SET FILTER TO ATIVO='S'
      LOCATE FOR APTO=APTOS->APTO
      IF FOUND()
         TCOD=CODHOSP
         SELE 04
         LOCATE FOR CODIGO=TCOD
         THOSPEDE=NOME
         ORDEM=.T.
      ELSE
         TAPTO=0
      ENDIF
   ENDIF
ENDIF
SET FILTER TO
SELE &AREA
RETURN(ORDEM)


//  ENTRA COM A DATA ATUAL

FUNCTION DATATUAL

LOCAL GETLIST:={}

SET KEY K_ALT_H TO
OLDCOLOR=SETCOLOR()
LINHA=ROW()
COLUNA=COL()
CURS=SETCURSOR()
JANELA(01,09,20,15,59,'Atualizacao da Data')
DAT_HOJE=DATE()
ULT_TEC=0
SET CURSOR ON
DO WHILE .T.
   SEM_ANA='DomingoSegundaTerca  Quarta Quinta Sexta  S bado '
   DIA_EXT=TRIM(SUBS(SEM_ANA,DOW(DAT_HOJE)*7-6,7))+', '+ALLTRIM(STR(DAY(DAT_HOJE),2))
   ME_SES='Janeiro  Fevereiro Mar‡o    Abril    Maio     Junho   '
   ME_SES=ME_SES+'Julho    Agosto   Setembro Outubro  Novembro Dezembro '
   DIA_EXT=DIA_EXT+' DE '+TRIM(SUBS(ME_SES,MONTH(DAT_HOJE)*9-8,9))+' DE '
   DIA_EXT=DIA_EXT+STR(YEAR(DAT_HOJE),4)
   @ 13,(80-LEN(DIA_EXT))/2 SAY DIA_EXT
   @ 11,29 SAY 'DATA DE HOJE ' GET DAT_HOJE
   READ
   ULT_TEC=LASTKEY()
   IF ULT_TEC=13 .OR. ULT_TEC=27
      EXIT
   ENDIF
ENDDO
JANELA(02)
SET CURSOR OFF
SETCOLOR(OLDCOLOR)
SETCURSOR(CURS)
@ LINHA,COLUNA SAY ''
SET KEY K_ALT_H TO DATATUAL()
RETURN(NIL)

//  EMITE MENSAGENS NA TELA

FUNCTION MENS(FRASE)
TEMEN=SAVESCREEN(21,20,24,61)
CORM=SETCOLOR()
SETCOLOR(CORMEN)
SET CURSOR OFF
SHADOW(21,20,23,60)
@ 21,20,23,60 BOX "ÚÄ¿³ÙÄÀ³ "
@ 22,21 SAY PADC(FRASE,38)
INKEY(3)
SETCOLOR(CORM)
RESTSCREEN(21,20,24,61,TEMEN)
RELEASE TEMEN
RELEASE CORM
SET CURSOR ON
RETURN(NIL)


//  CRIA SOMBRA REAL NAS JANELAS - RAMALHO - MODIFICADA

FUNCTION SHADOW(LS,CS,LI,CI)
COL=SAVESCREEN(LS+1,CI+1,LI+1,CI+1)
LIN=SAVESCREEN(LI+1,CS+1,LI+1,CI)
TA1=LEN(COL)
TA2=LEN(LIN)
ATTR=(0*16)+7
FOR I=2 TO TA1 STEP 2
   COL=STUFF(COL,I,1,CHR(ATTR))
NEXT
FOR I=2 TO TA2 STEP 2
   LIN=STUFF(LIN,I,1,CHR(ATTR))
NEXT
RESTSCREEN(LS+1,CI+1,LI+1,CI+1,COL)
RESTSCREEN(LI+1,CS+1,LI+1,CI,LIN)
RETURN(NIL)

//  SHELL DO DOS

FUNCTION SHELLDOS
X_DOS=ROW()
Y_DOS=COL()
COR=SETCOLOR()
SAVE SCREEN TO TELA
SET COLOR TO
CLEAR SCREEN
? 'N„O INSTALE NEM DESINSTALE PROGRAMAS RESIDENTES.'
? 'DIGITE EXIT E TECLE ENTER PARA RETORNAR.'
?
SET CURSOR ON
RUN COMMAND.COM
SET CURSOR OFF
RESTORE SCREEN FROM TELA
SET CURSOR OFF
@ X_DOS,Y_DOS SAY ''
SETCOLOR(COR)
RETURN(NIL)


//  MOSTRA A PORCENTAGEM DO SERVICO REALIZADO - RAMALHO - MODIFICADA

FUNCTION TERMOH(VALOR)
IF VALOR <=1
   JANELA(O1,10,11,17,67,"Percentual da Tarefa Executada")
   @ 13,12 SAY '  1   10   20   30  40   50   60   70   80   90   100'
   @ 14,12 SAY 'ÚÙ...|....|....|....|....|....|....|....|....|....À¿'
   @ 15,12 SAY '³                                                  ³'
   @ 16,12 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
ELSE
   SET CURSOR OFF
   SETCOLOR('B/W')
   @ 15,13 SAY REPLICATE(CHR(219),VALOR/2)
   SET CURSOR ON
ENDIF
RETURN(NIL)


//FUNCAO TRAVA REGISTROS

FUNCTION TRAVAREG
RET=.F.
DO WHILE .T.
   APPE BLAN
   IF !NETERR()
      RET=.T.
      EXIT
   ELSE
      MENS('Tentando abrir novo registro !!!')
   ENDIF
ENDDO
RETURN RET


// FUNCAO DE INICIALIZACAO DE VARIAVEIS  -  RAMALHO

FUNC INIC_VAR
A=FCOUNT()
FOR I=1 TO A
   IF TYPE (FIELD(I))<>"M"
      NOMECAMPO=FIELD(I)
      NOMEVAR="M"+NOMECAMPO
      PUBLIC &NOMEVAR
      DO CASE
         CASE TYPE (FIELD(I))="C"
            &NOMEVAR=SPACE(LEN(&NOMECAMPO))
         CASE TYPE (FIELD(I))="N"
            &NOMEVAR=0
         CASE TYPE (FIELD(I))="D"
            &NOMEVAR=CTOD("")
         CASE TYPE (FIELD(I))="L"
            &NOMEVAR=.F.
      ENDCASE
   ENDIF
NEXT
RETURN(NIL)


// FUNCAO DE ATRIBUICAO DE VARIVEIS COM VALORES DOS CAMPOS

FUNC IGUAL_VAR
A=FCOUNT()
FOR I = 1 TO A
   IF TYPE(FIELD(I))!= "M"
      NOMECAMPO=FIELDNAME(I)
      NOMEVAR="M"+NOMECAMPO
      PUBLIC &NOMEVAR
      &NOMEVAR=&NOMECAMPO
   ENDIF
NEXT
RETURN


// FUNCAO DE LIBERACAO DE VARIAVEIS DA MEMORIA - RAMALHO

FUNC LIB_VAR
A=FCOUNT()
FOR I= 1 TO A
   IF TYPE(FIELD(I))!="M"
      NOMEVAR="M"+FIELD(I)
      RELEASE &NOMEVAR
   ENDIF
NEXT
RELEASE NOMEVAR
RETURN


// FUNCAO  DE GRAVACAO DOS DADOS NO ARQUIVO

FUNC REPL_VAR
A=FCOUNT()
FOR I = 1 TO A
   IF TYPE(FIELD(I))!= "M"
      NOMECAMPO=FIELD(I)
      NOMEVAR="M"+NOMECAMPO
      IF TYPE ("&NOMEVAR")!="U"
         DO WHILE .T.
            IF RLOCK()
               REPLACE &NOMECAMPO WITH &NOMEVAR
               UNLOCK
               EXIT
            ELSE
               MENS('Arquivo sendo utilizado !!!')
            ENDIF
         ENDDO
      ENDIF
   ENDIF
NEXT
RETURN

// FUNCAO PROXIMO REGISTRO - MANUTENCAO

PROCEDURE PROXIMO
IF !EOF()
   SKIP +1
   IF RECNO() > RECCOUNT()
      SKIP -1
      MENS('FIM DO ARQUIVO')
   ENDIF
ELSE
   MENS('FIM DO ARQUIVO')
ENDIF
KEYBOARD CHR(13)
RETURN

// FUNCAO REGISTRO ANTERIOR - MANUTENCAO

PROCEDURE ANTERIOR
SKIP -1
IF BOF()
   MENS("INICIO DO ARQUIVO")
ENDIF
KEYBOARD CHR(13)
RETURN

// FUNCAO INICIO DO ARQUIVO - MANUTENCAO

PROCEDURE COMECO
DBGOTOP()
KEYBOARD CHR(13)
RETURN

// FUNCAO FIM DO ARQUIVO - MANUTENCAO

PROCEDURE FINAL
GO BOTTOM
KEYBOARD CHR(13)
RETURN

// FUNCAO APAGA REGISTRO - MANUTECAO

PROCEDURE APAGA
SET KEY K_RIGHT TO
SET KEY K_LEFT TO
SET KEY K_HOME TO
SET KEY K_END TO
SET KEY K_DEL TO
SET KEY 65 TO
SET KEY 80 TO
IF RLOCK()
   AUX=CORJ
   CORJ=CORMENER
   AUX1=CORBAR
   CORBAR=CORBARER
   JANELA(01,08,29,15,53,"Confirmacao de Exclusao")
   @ 11,31 SAY "Apaga o Registro ???"
   OPDEL=2
   @ 13,36 PROMPT "SIM"
   @ 13,42 PROMPT "NAO"
   MENU TO OPDEL
   JANELA(2)
   CORBAR=AUX1
   CORJ=AUX
   IF OPDEL = 1
      IF RLOCK()
         DELETE
         UNLOCK
         IF !EOF()
            SKIP +1
         ELSE
            IF !BOF()
               SKIP -1
            ELSE
               MENS('Arquivo Vazio !!!')
            ENDIF
         ENDIF
      ENDIF
   ENDIF
ELSE
   MENS('Arquivo sendo utilizado !!!')
   IF LASTKEY()=K_ESC
      KEYBOARD CHR(13)
      RETURN
   ENDIF
ENDIF
KEYBOARD CHR(13)
RETURN

//FUNCAO BARRA DE STATUS

PROCEDURE  BARSTA
SETCOLOR(CORJ)
@ 24,00 SAY SPACE(80)
@ 24,00 SAY "[F1] Help"
@ 24,COL()+1 SAY "[F3] Pesq Hosp"
@ 24,COL()+1 SAY "[F10] Troca Oper"
@ 24,COL()+1 SAY "[Alt+X] Sai Sistema"
@ 24,COL()+1 SAY "[Alt+H] Dt Atual"
RETURN

//FUNCAO DATA RESERVA

FUNCTION VERDTRESER(X,Z)

LOCAL ORDEM

ORDEM=.T.
LOCATE FOR (APTO=X .AND. DTRESER=Z)
IF FOUND()
   ORDEM=.F.
   MENS("Apato ja reservado para esta data")
ENDIF
RETURN(ORDEM)

//FUNCAO VERIFICA IDENTIDADE

FUNCTION VERID(X,Z)
IF !EMPTY(X)
   IF Z='A'
      REG=RECNO()
   ENDIF
   DBGOTOP()
   LOCATE FOR IDENTIDAD=X
   IF FOUND()
      DO CASE
         CASE Z='I'
            MENS("Pessoa ja Cadastrada !!!")
            ORDER=.F.
         CASE Z='A'
            IF RECNO()=REG
               ORDER=.T.
            ELSE
               MENS("Pessoa ja Cadastrada !!!")
               ORDER=.F.
            ENDIF
         OTHERWISE
            ORDER=.T.
      ENDCASE
   ELSE
      IF Z='I' .OR. Z='A'
         ORDER=.T.
      ELSE
         MENS("Pessoa nao Cadastrada !!!")
         ORDER=.F.
      ENDIF
   ENDIF
   IF Z='A'
      GO REG
   ENDIF
   SET ORDER TO 1
ELSE
   MENS('Identidade Invalida')
   ORDER=.F.
ENDIF
RETURN (ORDER)


//FUNCAO DE DESCONTO

PROCEDURE DESCONTO(P,L,V)

LOCAL GETLIST:={}

AREA=SELECT()
REGI=RECNO()
Sele 06
Inic_Var()
Set Key K_F7 to  // Desativa F7 Tela Desconto Unitario
SET KEY K_F4  TO        //DESATIVA F4 TELA DE DESCONTO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
JANELA(01,13,01,17,74,"Desconto")
@ 15,01 SAY "Ã Porc. ÄÂ Valor ÄÄÄÄÂ Observacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Quem Autorizou ÄÄ´"
@ 16,01 SAY "³    %   ³           ³                                ³                  ³"
@ 17,01 SAY "ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ 24,00 SAY PADR("[ESC] Sai",80)
D=.F.
DbGoTop()
Locate FOR CODIGO=REGISTRO->CODIGO
Do Case
   Case P = "HOT22" .OR. P="HOT21"
      IF FOUND() .and. Quando = "M"
         Mens("Desconto Ja Registrado")
         SELE &AREA
         SET KEY K_F4 TO DESCONTO   //TELA DE DESCONTO - HOTRT
         Set Key K_F7 to DescMovim
         SET KEY K_F8 TO PICKS      //MENU PICK
         @ 24,00 SAY PADR("[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo",80)
         JANELA(02)
         RETURN
      ELSE
         mAUTOR='GERENCIA       '
         mPORC=0
         mFinal=0
         mOBS=SPACE(30)
         mQuando="M"
         D=.T.
      ENDIF
   Case P = "HOT23"
      IF FOUND() .and. Quando != "M"
         Mens("Desconto Ja Registrado")
         SELE &AREA
         SET KEY K_F4 TO DESCONTO   //TELA DE DESCONTO - HOTRT
         Set Key K_F7 to DescMovim
         SET KEY K_F8 TO PICKS      //MENU PICK
         @ 24,00 SAY PADR("[F4] Tela de Desconto   [F8] Tabelas",80)
         JANELA(02)
         RETURN
      ELSE
         mAUTOR='GERENCIA       '
         mPORC=0
         mFinal=0
         mOBS=SPACE(30)
         mQuando="F"
         D=.T.
      ENDIF
EndCase
SET CURSOR ON
@ 16,03 GET mPORC       PICT "99"
@ 16,12 GET mFinal      PICT "@E 99,999.99"    WHEN(EMPTY(mPORC))
@ 16,24 GET mOBS        PICT "@!"
@ 16,57 GET mAUTOR      PICT "@!"              VALID(!EMPTY(mAUTOR))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   JANELA(2)
   SELE &AREA
   SET KEY K_F4 TO DESCONTO   //TELA DE DESCONTO - HOTRT
   Set Key K_F7 to DescMovim
   SET KEY K_F8 TO PICKS      //MENU PICK
   If p != "HOT22"
      @ 24,00 SAY PADR("[F4] Tela de Desconto   [F8] Tabelas",80)
   Else
      @ 24,00 SAY PADR("[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo",80)
   EndIf
   RETURN
ENDIF
MOPERADOR=WNUMOP
IF D
   IF TRAVAREG()
      MCODIGO=REGISTRO->CODIGO
      REPL_VAR()
      UNLOCK
   ENDIF
ENDIF
SELE &AREA
SET KEY K_F4 TO DESCONTO   //TELA DE DESCONTO - HOTRT
Set Key K_F7 to DescMovim
SET KEY K_F8 TO PICKS      //MENU PICK
If P != "HOT22"
   @ 24,00 SAY PADR("[F4] Tela de Desconto   [F8] Tabelas",80)
Else
   @ 24,00 SAY PADR("[F8] Tabela   [F7] Desconto Unitario   [F4] Desconto Continuo",80)
EndIf
JANELA(02)
RETURN

//FUNCAO HORA ATUAL

FUNCTION HORA(P)
T=''
H=SUBSTR(P,1,2)
M=SUBSTR(P,4,2)
T=H+M
RETURN (T)

// FUNCAO DE MENUS PICKS - GERAL

FUNCTION PICKS(P,L,V)

LOCAL ORDEM

ORDEM=.T.
DO CASE
   CASE (V="TFORMAPAG")
      ORDEM=VERFORMA(&V,"T")
   CASE (V="TTIPOCART")
      ORDEM=VERCARTAO(&V)
   CASE (V="TTIPOMOV")
      ORDEM=VERTMOV(&V,"T")
   CASE (V="TTIPODESP")
      ORDEM=VERTDESP(&V,"T")
   CASE (V="THOSPE") .OR. (V="MHOSPEDE")
      ORDEM=MENUHOSP(P)
   CASE (V="TFIRMA")
      ORDEM=MENUFIRMA('F')
   CASE (V="TINTERM")
      ORDEM=MENUFIRMA('I')
   CASE ((V="MAPTO").AND.((P="HOT21") .OR. (P="HOT25") .OR. (P="HOT28")))
      ORDEM=MENUAPTO()
   CASE ((V="MAPTO").AND.(P="HOT23")) .OR. ((V="TAPTO") .AND. ((P="HOT22") .OR. (P="HOT28")))
      MENUAPART(P)
   CASE (V="TESTCIVIL")
      ORDEM=MENUCIVIL()
   CASE (V="TTURIS")
      VERTURIS()
   CASE (V="TPCONTA")
      VERPCONTA()
ENDCASE
//KEYBOARD CHR(13)
RETURN(ORDEM)

// FUNCAO DE VERIFICACAO DA FORMA DE PAGAMENTO

FUNCTION VERFORMA(X,Z)
CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
IG=.F.
IF (Z!="T").AND.(!EMPTY(X))
   IG=.T.
   FOR C=1 TO 5
      IF X=MAT3[C]
         MFORMAPAG=C
         IG=.F.
      ENDIF
   NEXT
   IF IG
      MENS("Tipo de Pagamento Invalido !!!")
   ENDIF
ENDIF
IF EMPTY(X).OR.(IG).OR.(Z="T")
   JANELA(01,15,42,22,53,"Tipo Pagto")
   NIVEL=2
   SET CURSOR OFF
   OPC3=ACHOICE(17,43,21,52,MAT3,,"VERMENU",1)
   SET CURSOR ON
   JANELA(2)
   IF OPC3!=0
      TFORMAPAG=MAT3[OPC3]
      MFORMAPAG=OPC3
      ORDEM=.T.
   ELSE
      ORDEM=.F.
   ENDIF
ELSE
   ORDEM=.T.
ENDIF
SELECT &AREA
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO ATRIBUI VALOR PARA VALOR DE DIARIA
PROCEDURE VALDIA
ARE=SELECT()
REG=RECNO()
SELE 09
DBGOTOP()
LOCATE FOR CODIGO=REGISTRO->CODIGO .AND. TIPODESP=1
IF FOUND()
   MVALOR=VALOR
ELSE
   SELE 02
   DBGOTOP()
   LOCATE FOR APTO=REGISTRO->APTO
   MVALOR=DIARIA
ENDIF
SELE &ARE
IF REG#0
   GO REG
ENDIF
RETURN

// FUNCAO DE VERIFICACAO DO TIPO DE DESPESA

FUNCTION VERTDESP(X,Z)
CUR=SETCURSOR()
SET CURSOR OFF
IG=.F.
IF (Z!="T").AND.(!EMPTY(X))
   IG=.T.
   FOR C=1 TO 9
      IF X=MAT2[C]
         MTIPODESP=C
         IF C=1
            DO VALDIA
         ENDIF
         IG=.F.
      ENDIF
   NEXT
   IF IG
      MENS("Tipo de Despesa Invalido !!!")
   ENDIF
ENDIF
IF EMPTY(X).OR.(IG).OR.(Z="T")
   JANELA(01,11,47,22,60,"Tipo Despesa")
   NIVEL=2
   SET CURSOR OFF
   OPC3=ACHOICE(13,48,21,59,MAT2,,"VERMENU",1)
   SET CURSOR ON
   JANELA(02)
   IF OPC3!=0
      TTIPODESP=MAT2[OPC3]
      MTIPODESP=OPC3
      IF OPC3=1
         DO VALDIA
      ENDIF
      ORDEM=.T.
   ELSE
      ORDEM=.F.
   ENDIF
ELSE
   ORDEM=.T.
ENDIF
SETCURSOR(CUR)
RETURN(ORDEM)

// FUNCAO DE VERIFICACAO DO  TIPO DE MOVIMENTO

FUNCTION VERTMOV(X,Z)
CUR=SETCURSOR()
SET CURSOR OFF
IG=.F.
IF (Z!="T").AND.(!EMPTY(X))
   IG=.T.
   FOR C=1 TO 2
      IF (X=MAT1[C])
         MTIPOMOV=C
         IG=.F.
      ENDIF
   NEXT
   IF IG
      MENS("Tipo de Movimento Invalido !!!")
   ENDIF
ENDIF
IF EMPTY(X).OR.(IG).OR.(Z="T")
   JANELA(01,15,20,19,28,"Tp Mov.")
   NIVEL=2
   SET CURSOR OFF
   OPC3=ACHOICE(17,21,18,27,MAT1,,"VERMENU",1)
   SET CURSOR ON
   JANELA(02)
   IF OPC3!=0
      TTIPOMOV=MAT1[OPC3]
      MTIPOMOV=OPC3
      ORDEM=.T.
   ELSE
      ORDEM=.F.
   ENDIF
ELSE
   ORDEM=.T.
ENDIF
SETCURSOR(CUR)
RETURN(ORDEM)

// FUNCAO DE VERIFICACAO DO  TIPO DE ESTADO CIVIL

FUNCTION VEREST(X,Z)

LOCAL ORDEM

IG=.F.
IF (Z!="T").AND.(!EMPTY(X))
   IG=.T.
   FOR C=1 TO 5
      IF (X=MAT4[C])
         MESTCIVIL=C
         IG=.F.
         ORDEM=.T.
      ENDIF
   NEXT
   IF IG
      ORDEM=.F.
      MENS("Tipo de Est. Civil Invalido !!!")
   ENDIF
ENDIF
IF EMPTY(X).OR.(IG).OR.(Z="T")
   ORDEM=MENUCIVIL()
ENDIF
RETURN(ORDEM)

//FUNCAO MENU PICK DE ESTADO CIVIL

FUNCTION MENUCIVIL

LOCAL ORD

CUR=SETCURSOR()
SET CURSOR OFF
JANELA(01,14,38,21,51,"Est. Civil")
NIVEL=2
SET CURSOR OFF
OPC3=ACHOICE(16,39,20,50,MAT4,,"VERMENU",1)
SET CURSOR ON
JANELA(02)
IF OPC3!=0
   TESTCIVIL=MAT4[OPC3]
   MESTCIVIL=OPC3
   ORD=.T.
ELSE
   ORD=.F.
ENDIF
SETCURSOR(CUR)
RETURN(ORD)

//  TESTE DE TECLA PARA FUNCAO DBEDIT() - RAMALHO - MODIFICADA

FUNCTION VERDB1(MD,COUNTER)
ORDEM=1
SET CURSOR OFF
DO CASE
   CASE MD=1                     // FOI PRESSIONADO PGUP OU
      MENS('Inicio do Arquivo')  // SETA SUPERIOR NO 1 REG.
      ORDEM=1
   CASE MD=2                     // FOI PRESSIONADO PGDN OU
      MENS('Fim de Arquivo')     // SETA INFERIOR NO ULTIMO
      ORDEM=1                    // REGISTRO
   CASE MD=3
      MENS('Arquivo sem Conteudo')
      ORDEM=0
   CASE MD=4
       // TESTA A ULTIMA TECLA PRESSIONADA
      DO CASE
         CASE LASTKEY()=27  // FOI PRESSIONADO ESC
            ORDEM=0       // ABANDONA DBEDIT
         CASE LASTKEY()=13
               // FOI PRESSIONADO ENTER, NESSE CASO EDITAREMOS O CAMPO ATUAL
            REGISTRO=RECNO() // DECLARAR NA ROTINA
                                // QUE CHAMA A FUNCAO COM PRIVATE
            ORDEM=0

      ENDCASE
ENDCASE
SET CURSOR ON
RETURN(ORDEM)


//FUNCAO TIPO DE CARTAO DE CREDITO - HOT23

FUNCTION VERCARTAO(X,Z)
LOCAL AREA:=SELECT(),NCARTOES:=0
CUR=SETCURSOR()
SET CURSOR OFF
SELE 14
DBGOTOP()
MATVER={}
DO WHILE !EOF()
   AADD(MATVER,NOMECAR+SPACE(15-LEN(NOMECAR)))
   NCARTOES++
   DBSKIP()
ENDDO
IG=.F.
IF (Z!="T").AND.(!EMPTY(X))
   IG=.T.
   FOR C=1 TO NCARTOES
      IF X=MATVER[C]
         MTIPOCART=C
         IG=.F.
         LOCATE FOR NOMECAR=MATVER[C]
         MTAXA=TAXA
      ENDIF
   NEXT
   IF IG
      MENS("Tipo de Cartao Invalido !!!")
   ENDIF
ENDIF
IF EMPTY(X).OR.(IG).OR.(Z="T")
   JANELA(01,10,42,11+NCARTOES,53,"Tipo Cartao")
   NIVEL=2
   SET CURSOR OFF
   OPVER=ACHOICE(11,43,10+NCARTOES,52,MATVER,,"VERMENU",1)
   SET CURSOR ON
   JANELA(02)
   IF OPVER!=0
      TTIPOCART=ALLTRIM(MATVER[OPVER])
      TTIPOCART=TTIPOCART+SPACE(9-LEN(TTIPOCART))
      MTIPOCART=OPVER
      LOCATE FOR NOMECAR=MATVER[OPVER]
      MTAXA=TAXA
      ORDEM=CARTAO()
   ELSE
      ORDEM=.F.
   ENDIF
ELSE
   ORDEM=.T.
ENDIF
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)


//FUNCAO MENU PICK PARA APARTAMENTOS LIBERADOS

FUNCTION MENUAPTO

LOCAL ORDEM

CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE 02
SET FILTER TO LIBERADO!='N'
DBGOTOP()
MDB1={"APTO","LIBERADO"}
MDB2={"999","@!"}
MDB3={"Aptos","Liberado"}
DBGOTOP()
JANELA(01,11,15,21,31,"Cons. Aptos")
DBEDIT(13,16,20,30,MDB1,"VERDB1",MDB2,MDB3,"Ä","³")
SET FILTER TO
JANELA(2)
IF LASTKEY()=K_ESC
   ORDEM=.F.
ELSE
   GO REGISTRO
   MAPTO=APTO
   ORDEM=REGAPTO(@MAPTO)
ENDIF
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO MENU PICK PARA HOSPEDES

FUNCTION MENUHOSP(X)

LOCAL ORDEM

CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE 04
SET ORDER TO 02
MDB1={"NOME","IDENTIDAD"}
MDB2={"@!","@!"}
MDB3={"Nome","Identidade"}
JANELA(01,06,07,21,66,"Consulta de Hospedes")
DBGOTOP()
DBEDIT(08,08,20,65,MDB1,"VERDB1",MDB2,MDB3,"Ä","³")
JANELA(2)
SELE 04
SET ORDER TO 0
IF LASTKEY()=K_ESC
   ORDEM=.F.
ELSE
   GO REGISTRO
   IF (X="HOT22").OR.(X="HOT21")
     THOSPE=NOME
   ELSE
      MHOSPEDE=NOME
   ENDI
   MCODHOSP=CODIGO
   MRG=IDENTIDAD
   ORDEM=.T.
ENDIF
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)


//FUNCAO MENU PICK PARA HOSPEDES HOMONIMOS

PROCEDURE MENUHOMO(X)
AREA=SELECT()
SELE 04
SET FILTER TO NOME=(TRIM(THOSPE))
MDB1={"NOME","IDENTIDAD"}
MDB2={"@!","@!"}
MDB3={"Nome","Identidade"}
JANELA(01,13,14,23,73,X)
DBGOTOP()
DBEDIT(15,15,22,72,MDB1,"VERDB1",MDB2,MDB3,"Ä","³")
SET FILTER TO
JANELA(02)
IF LASTKEY()!=K_ESC
   VER='S'
   GO REGISTRO
   MCODHOSP=CODIGO
ELSE
   VER='N'
ENDIF
SELE &AREA
RETURN

//FUNCAO MENU PICK PARA FIRMAS HOMONIMAS

PROCEDURE FIRMAHOMO(X,Y)
AREA=SELECT()
SELE 01
IF Y='F'
   SET FILTER TO NOME=(TRIM(TFIRMA))
ELSEIF Y='I'
   SET FILTER TO NOME=(TRIM(TINTERM)) .AND. (TURIS='S')
ENDIF
MDB1={"NOME","CGC"}
MDB2={"@!","@R 999.999.999/9999-999"}
MDB3={"Nome","CGC"}
JANELA(01,13,14,23,73,X)
DBGOTOP()
DBEDIT(15,15,22,72,MDB1,"VERDB1",MDB2,MDB3,"Ä","³")
SET FILTER TO
JANELA(02)
FIR='N'
IF LASTKEY()!=K_ESC
   GO REGISTRO
   MFIRMAAGE=CODIGO
   TFIRMA=NOME
   FIR='S'
ENDIF
SELE &AREA
RETURN

//FUNCAO MENU PICK PARA FIRMAS/AGENTES

FUNCTION MENUFIRMA(A)

LOCAL ORDEM

CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE 01
SET ORDER TO 02     //ORDEM ALFABETICA
TITULO='Firmas/Agentes'
IF A='I'
   TITULO='Intermediario'
   SET FILTER TO TURIS='S'
ENDIF
MDB1={"NOME"}
MDB2={"@!"}
MDB3={"Nome"}
DBGOTOP()
JANELA(01,15,32,23,64,TITULO)
DBEDIT(17,33,22,63,MDB1,"VERDB1",MDB2,MDB3)
JANELA(2)
IF LASTKEY()!=K_ESC
   GO REGISTRO
   IF A='F'
      TFIRMA=NOME
      MFIRMAAGE=CODIGO
   ELSEIF A='I'
      TINTERM=NOME
      MINTERM=CODIGO
   ENDIF
   ORDEM=.T.
ENDIF
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)


//MENU PICK PARA APTO LIBERADOS E RESERVADOS

PROCEDURE MENUAPART(X)
CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE 02
SET FILTER TO LIBERADO = 'N'
MDB1={"APTO","LIBERADO"}
MDB2={"999","@!"}
MDB3={"Apto","Lib"}
DBGOTOP()
JANELA(01,11,15,21,31,"Cons. Aptos")
DBEDIT(13,16,20,30,MDB1,"VERDB1",MDB2,MDB3,"Ä","³")
SET FILTER TO
JANELA(2)
IF LASTKEY()!=K_ESC
   GO REGISTRO
   IF LIBERADO='N'
      IF (X="HOT22") .OR. (X="HOT28")
         IF !EMPTY(APTO)
            TAPTO=APTO
         ENDIF
      ELSE
         MAPTO=APTO
      ENDIF
   ENDIF
ENDIF
SETCURSOR(CUR)
SELE &AREA
RETURN

//MENU PICK PARA APTO NAO LIBERADOS

PROCEDURE MENUAP
AREA=SELECT()
SELE 02
SET FILTER TO LIBERADO = 'N'
MDB1={"APTO","LIBERADO"}
MDB2={"999","@!"}
MDB3={"Apto","Lib"}
DBGOTOP()
JANELA(01,11,15,21,31,"Cons. Aptos")
DBEDIT(13,16,20,30,MDB1,,MDB2,MDB3,"Ä","³")
SET FILTER TO
JANELA(2)
SELE 08
SELE &AREA
RETURN


//MENU PICK DATA RESERVA

PROCEDURE MENUDATA
AREA=SELECT()
SELE 08
SET FILTER TO LIBERADO='R'
MDB1={"APTO","DTRESER"}
MDB2={"999",""}
MDB3={"Apto","Dt. Reser."}
DBGOTOP()
JANELA(01,12,14,22,32,"Cons. Reser.")
DBEDIT={14,15,21,31,MDB1,,MDB2,MDB3,"Ä","³"}
SET FILTER TO
JANELA(2)
SELE &AREA
RETURN


//FUNCAO VERIFICA FIRMA JA CADASTRADA

FUNCTION VERFIRMA(X,Z)
IF !EMPTY(X)
   IF Z='A'
      REG=RECNO()
   ENDIF
   DBGOTOP()
   LOCATE FOR NOME=X
   IF FOUND()
      DO CASE
         CASE Z='I'
            MENS("Firma ja Cadastrado !!!")
            ORDER=.F.
         CASE Z='A'
            IF RECNO()=REG
               ORDER=.T.
            ELSE
               MENS("Firma ja Cadastrado !!!")
               ORDER=.F.
            ENDIF
         OTHERWISE
            ORDER=.T.
      ENDCASE
   ELSE
      IF Z='I' .OR. Z='A'
         ORDER=.T.
      ELSE
         MENS("Firma nao Cadastrado !!!")
         ORDER=.F.
      ENDIF
   ENDIF
   IF Z='A'
      GO REG
   ENDIF
   SET ORDER TO 1
ELSE
   MENS('Firma Invalida !!!')
   ORDER=.F.
ENDIF
RETURN (ORDER)


//FUNCAO VERIFICA APTO

FUNCTION VERAPTO(X,Z)
AREA=SELECT()
ORDEM=.F.
IF !EMPTY(X)
   SELE 02
   IF Z='A'
      REG=RECNO()
   ENDIF
   DBGOTOP()
   LOCATE FOR APTO=X
   IF FOUND()
      AT=SELECT()
      DO CASE
         CASE Z='I'
            MENS("Apto ja Cadastrado !!!")
         CASE Z='A'
            IF RECNO()=REG
               ORDEM=.T.
            ELSE
               MENS("Apto ja Cadastrado !!!")
            ENDIF
         OTHERWISE
            ORDEM=.T.
      ENDCASE
   ELSE
      IF Z='I' .OR. Z='A'
         ORDEM=.T.
      ELSE
         MENS("Apto nao Cadastrado !!!")
      ENDIF
      IF Z='A'
         GO REG
      ENDIF
      SET ORDER TO 1
      SELE &AREA
   ENDIF
ELSE
   MENS('Apto Invalido !!!')
ENDIF
SELE &AREA
RETURN(ORDEM)

//FUNCAO VERIFICA RESERVA

FUNCTION VERRES(X,D,T)
AREA=SELECT()
AUX=RECNO()
ORD=VERAPTO(@MAPTO,'C')
ORDEM=.T.
IF ORD
   SELE 08
   DBGOTOP()
   IF T='ALTERACAO'
      LOCATE FOR ((DTRESER=D) .AND. (APTO=X) .AND. (RECNO()!=AUX))
   ELSEIF T='INCLUSAO'
      LOCATE FOR ((DTRESER=D) .AND. (APTO=X))
   ENDIF
   IF FOUND()
      MENS('Apto reservado para esta data.')
      SELE &AREA
      GO AUX
      RETURN(ORDEM)
   ENDIF
   SELE 05
   DBGOTOP()
   LOCATE FOR APTO=X .AND. ATIVO='S'
   IF FOUND()
      JANELA(01,10,27,14,65)
      @ 11,35 SAY "Apartamento Ocupado !!!"
      @ 13,31 SAY "Data prevista de saida"
      @ 13,54 SAY DTSAI  PICT "@D"
      INKEY(0)
      JANELA(02)
   ENDIF
ENDIF
SELE &AREA
GO AUX
RETURN(ORDEM)

//FUNCAO RODAPE

PROCEDURE RODAPE
@ 63,00 SAY CHR(18)
@ 63,00 SAY "--------------------------------------------------------------------------------"
@ 65,00 SAY CHR(12)
RETURN

FUNCTION VEREVEN(X)

LOCAL ORDEM

ORDEM=.F.
IF !EMPTY(X)
   SELE 04
   IF X<100
      SELE 03
      LOCATE FOR APTO=X
      IF FOUND()
         IF LIBERADO='S'
            ORDEM=.T.
         ELSEIF LIBERADO ='N'
            MENS('Eventual ocupado !!!')
         ENDIF
      ELSE
         MENS('Evetual nao encontrado !!!')
      ENDIF
   ELSE
      ORDEM=REGAPTO(@MAPTO)
   ENDIF
   SELE 05
ELSE
   SELE 02
   DO MENUAPTO
   IF ((LASTKEY()!=K_ESC) .AND. (LIBERADO!='N'))
      ORDEM=REGAPTO(@MAPTO)
   ELSE
      MAPTO=0
   ENDIF
ENDIF
RETURN(ORDEM)

FUNC CHEEVEN(X,Z)

LOCAL ORDEM

ORDEM=.F.
IF !EMPTY(X)
   IF Z='A'
      REG=RECNO()
   ENDIF
   DBGOTOP()
   LOCATE FOR APTO=X
   IF FOUND()
      DO CASE
         CASE Z='I'
            MENS("Eventual ja Cadastrado !!!")
            ORDEM=.F.
         CASE Z='A'
            IF RECNO()=REG
               ORDEM=.T.
            ELSE
               MENS("Eventual ja Cadastrado !!!")
            ENDIF
         OTHERWISE
            ORDEM=.T.
      ENDCASE
   ELSE
      IF Z='I' .OR. Z='A'
         ORDEM=.T.
      ELSE
         MENS("Eventual nao Cadastrado !!!")
      ENDIF
   ENDIF
   IF Z='A'
      GO REG
   ENDIF
ELSE
   MENS('Apartamento Invalido !!!')
ENDIF
RETURN(ORDEM)

FUNC CALIDA(X)
MIDADE=INT((DAT_HOJE-MDTNASC)/365)
RETURN(.F.)

//FUNCAO REGISTRO DE APTO

FUNCTION REGAPTO(X)

LOCAL GETLIST:={},ORDEM

ORDEM=.F.
SELE 02                 //SELECIONA AREA APTOS
LOCATE FOR APTO=X                  //POSICIONA-SE NO REGISTRO DO APARTAMENTO
IF FOUND()
   DO CASE
      CASE LIBERADO='S'      //VERIFICA LIBERACAO=SIM
         SELE 05
         ORDEM=.T.
      CASE LIBERADO='N'      //VERIFICA LIBERACAO=NAO
         MENS("Apartamento Ocupado !!!")
         IF MENUAPTO(@MAPTO)
            ORDEM=.T.
         ENDIF
      CASE LIBERADO='R'      //VERIFICA LIBERACAO=RESERVADO
         SELE 08
         SET FILTER TO APTO=X
         LOCATE FOR DTRESER=DAT_HOJE
         IF FOUND()     //DATA DA RESERVA=DATA A SER OCUPADA
            SET FILTER TO
            AUX=CORJ
            CORJ=CORMENER
            JANELA(01,09,19,18,61)
            @ 11,32 SAY "Reservado para o"
            @ 12,21 SAY "Sr."
            @ 12,25 SAY HOSPEDE         //NOME DO HOSPEDE DA RESERVA
            @ 14,34 SAY "Prosseguir ?"
            OP=0
            @ 16,31 PROMPT "SIM"
            @ 16,46 PROMPT "NAO"
            MENU TO OP
            JANELA(2)
            CORJ=AUX
            DO CASE
               CASE OP=1           //HOSPEDE QUE VAI OCUPAR MESMO QUE A RESERVA
                  THOSPE=HOSPEDE
                  ORDEM=.T.
                  APRE='S'
                  REGRE=RECNO()
                  KEYBOARD CHR(13)    //<ENTER> CURSOR VAI PARA NOME HOSPEDE
               CASE OP=2       //HOSPEDE QUE VAI OCUPAR NAO E O MESMO QUE A RESERVA
                  DO WHILE .T.
                     JANELA(01,12,13,16,68)
                     OPC=1
                     @ 14,15 PROMPT "Reserva Outro"
                     @ 14,36 PROMPT "Excluir Reserva"
                     @ 14,59 PROMPT "Cancelar"
                     MENU TO OPC
                     JANELA(2)
                     DO CASE
                        CASE OPC=0
                           EXIT
                        CASE OPC=1        //RESERVAR OUTRO PARTAMENTO
                           JANELA(01,08,13,18,71,"Mudanca de Reserva")
                           @ 10,13 SAY "Ã DT. Reserva Â Apartamento ÄÄÄÄÄÄÄÄÂ Hora Reserva ÄÄÄÄÄÄÄ´"
                           @ 11,13 SAY "³             ³                     ³                     ³"
                           @ 12,13 SAY "Ã Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
                           @ 13,13 SAY "³                                                         ³"
                           @ 14,13 SAY "Ã Identidade ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Fone ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
                           @ 15,13 SAY "³                                ³                        ³"
                           @ 16,13 SAY "Ã Dt. Solicit.Â Hrs. Solicit. Â Recebeu Solic. Reserva ÄÄÄ´"
                           @ 17,13 SAY "³             ³               ³                           ³"
                           @ 18,13 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
                           IGUAL_VAR()
                           MOPERADOR=WNUMOP
                           SET CURSOR ON
                           @ 11,15 SAY MDTRESER
                           @ 11,50 SAY MHRESER     PICT "@R 99:99"
                           @ 13,15 SAY MHOSPEDE     PICT "@!"
                           @ 15,15 SAY MRG  PICT "@!"
                           @ 15,48 SAY MFONE        PICT "@R (9999)!99-9999"
                           @ 17,15 SAY MDTSOLICIT
                           @ 17,29 SAY MHSOLICIT    PICT "@R 99:99"
                           @ 17,45 SAY MAUTORES    PICT "@!"
                           @ 11,29 GET MAPTO       PICT "999"     VALID(VERRES(MAPTO,MDTRESER))
                           READ
                           SET CURSOR OFF
                           IF LASTKEY()!=K_ESC
                              DO WHILE .T.
                                 IF RLOCK()
                                    MATIVO='S'
                                    REPL_VAR()
                                    UNLOCK
                                    EXIT
                                 ELSE
                                    MENS('Arquivo sendo utilizado !!!')
                                 ENDIF
                              ENDDO
                              MAPTO=X
                              SELE 05
                              ORDEM=.T.
                           ENDI
                           JANELA (2)
                        CASE OPC=2       //EXCLUIR A RESERVA
                           AUX=CORJ
                           CORJ=CORMENER
                           AUX1=CORBAR
                           CORBAR=CORBARER
                           JANELA(01,08,29,15,53,"Confirmacao de Exclusao")
                           @ 11,31 SAY "Apaga a Reserva ???"
                           OPDEL=2
                           @ 13,36 PROMPT "SIM"
                           @ 13,42 PROMPT "NAO"
                           MENU TO OPDEL
                           JANELA(2)
                           CORBAR=AUX1
                           CORJ=AUX
                           DO CASE
                              CASE OPDEL = 1
                                 DO WHILE .T.
                                    IF RLOCK()
                                       VERRESER()    //MUDA O APTO P/ 'S'
                                       DELETE
                                       UNLOCK
                                       ORDEM=.T.
                                       EXIT
                                    ELSE
                                       MENS('Arquivo sendo utilizado !!!')
                                    ENDIF
                                 ENDDO
                              CASE OPDEL=2
                                 LOOP
                           ENDCASE
                        CASE OPC=3
                           EXIT
                     ENDCASE
                  ENDDO
            ENDCASE
            SELE 02                 //RETORNA A AREA DE APARTAMENTO
         ELSE            //DATA DA RESERVA E MAIOR QUE A DATA DA OCUPACAO
            AUX=CORJ
            CORJ=CORMENER
            DBGOTOP()
            JANELA(01,09,24,20,53)
            @ 11,34 SAY "ATENCAO !!!"
            @ 13,25 SAY "Apartamento Reservado para o"
            @ 14,32 SAY "dia"
            @ 14,36 SAY DTRESER
            @ 17,33 SAY "Prosseguir ?"
            OPC=0
            @ 19,30 PROMPT "SIM"
            @ 19,44 PROMPT "NAO"
            MENU TO OPC
            JANELA(2)
            CORJ=AUX
            IF OPC=1    //TUDO BEM, PODE LIBERAR O APTO MESMO COM A RESERVA
               ORDEM=.T.
            ENDIF
         ENDIF
         SET FILTER TO
   ENDCASE
ELSE       //NAO ENCONTROU O APARTAMENTO DIGITADO (APTO NAO CADASTRADO)
   MENS("Apartamento invalido !!!")
ENDIF
RETURN(ORDEM)

//FUNCAO ATUALIZA O APTO PARA 'S' DEPOIS DE EXCLUIR RESERVA - REGISTRO

FUNCTION VERRESER
AREA=SELECT()
REG=RECNO()
AUX=APTO
DBGOTOP()
COUNT ALL FOR APTO=AUX TO NUMAPTO
IF NUMAPTO=1
   SELE 02
   DBGOTOP()
   LOCATE FOR APTO=AUX
   DO WHILE .T.
      IF RLOCK()
         REPL LIBERADO WITH 'S'
         UNLOCK
         EXIT
      ELSE
         MENS('Arquivo sendo utilizado !!!')
      ENDIF
   ENDDO
ENDIF
SELE &AREA
GO REG
RETURN

//FUNCAO INCLUI CHEQUE PRE-DATADO OU NAO - USADO HOT23, FECHAMENTO

FUNCTION CHEQUE(TIPO)

LOCAL GETLIST:={}
AREA=SELECT()
ORDEM=.F.
JANELA(01,08,28,12,49)
@ 09,30 SAY "Cheque Pr‚-Datado ?"
@ 11,32 PROMPT "SIM"
@ 11,42 PROMPT "NAO"
MENU TO OPC
JANELA(02)
DO CASE
   CASE OPC=0
      SELECT &AREA
      TFORMAPAG=SPACE(08)
      RETURN(ORDEM)
   CASE OPC=1             //INCLUSAO DE CHEQUES-PRE
      JANELA(01,12,15,18,60,"Inclusao de Cheques Pre")
      @ 14,15 SAY "Ã N§ Cheques Â Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ´"
      @ 15,15 SAY "³            ³              ³                ³"
      @ 16,15 SAY "Ã Data da Emissao Â Data Predatada ÄÄÄÄÄÄÄÄÄÄ´"
      @ 17,15 SAY "³                 ³                          ³"
      @ 18,15 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      VALORAUX := MVALOR
      SELE 07
      DO WHILE .T.
         INIC_VAR()
         MVALOR := VALORAUX
         MAGENCIA=0
         MDATAEMIS=DAT_HOJE
         MTIPOMOV=TIPO
         SET CURSOR ON
         @ 15,17 GET MNCHEQUE     PICT "@!"  VALID (!EMPTY(MNCHEQUE))
         @ 15,30 GET MBANCO       PICT "9999"  VALID (!EMPTY(MBANCO))
         @ 15,45 GET MAGENCIA     PICT "99999"
         @ 17,17 GET MDATAEMIS      VALID(!EMPTY(MDATAEMIS))
         @ 17,35 GET MDATAPRE       VALID(!EMPTY(MDATAPRE))
         READ
         SET CURSOR OFF
         IF LASTKEY()=K_ESC
            SELE &AREA
            ORDEM=.F.
            TFORMAPAG=SPACE(08)
            JANELA(02)
            RETURN(ORDEM)
         ENDI
         AUX=VERCHEQUE(MNCHEQUE,MBANCO)
         IF AUX
            EXIT
         ENDIF
      ENDDO
      MNUMERO=MNCHEQUE
      MCODIGO=REGISTRO->CODIGO
      MCODHOSP=REGISTRO->CODHOSP
      IF TRAVAREG()
         REPL_VAR()
         UNLOCK
         ORDEM=.T.
      ELSE
         MENS('Cheque nao Cadastrado !!!')
      ENDIF
      JANELA (2)
   CASE OPC=2         //INCLUSAO DE CHEQUES
      SELE 10
      JANELA(01,10,13,14,67,"Inclusao de Cheques")
      @ 12,13 SAY "Ã N§ Cheques ÄÄÄÄÄÄÄÄÄÂ Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ´"
      @ 13,13 SAY "³                     ³              ³                ³"
      @ 14,13 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      DO WHILE .T.
         MNUMERO=SPACE(20)
         MBANCO=0
         MAGENCIA=0
         MDATAEMIS=DAT_HOJE
         SET CURSOR ON
         @ 13,15 GET MNUMERO     PICT "@!"  VALID(!EMPTY(MNUMERO))
         @ 13,37 GET MBANCO      PICT "9999"  VALID (!EMPTY(MBANCO))
         @ 13,52 GET MAGENCIA    PICT "99999"
         READ
         SET CURSOR OFF
         IF LASTKEY()=K_ESC
            SELE &AREA
            ORDEM=.F.
            TFORMAPAG=SPACE(08)
            JANELA(02)
            RETURN(ORDEM)
         ENDI
         AUX=VERCHEQUE(MNUMERO,MBANCO)
         IF AUX
            EXIT
         ENDIF
      ENDDO
      MCODIGO=REGISTRO->CODIGO
      MTIPOMOV=TIPO        //TIPO DE MOVIMENTO PASSADO COMO PARAMETRO
      IF TRAVAREG()
         REPL_VAR()
         UNLOCK
         ORDEM=.T.
      ELSE
         MENS('Cheque nao Cadastrado !!!')
      ENDIF
      JANELA (2)
      ORDEM=.T.
ENDCASE
SELE &AREA
RETURN (ORDEM)

//FUNCAO VERIFICACAO DE CHEQUES

FUNCTION VERCHEQUE(X,Z)

LOCAL ORDEM

ARE=SELECT()
REG=RECNO()
ORDEM=.T.
SELE 07
SET FILTER TO BANCO=Z
DBGOTOP()
LOCATE FOR NCHEQUE=X
IF FOUND()
   MENS('Cheque ja Cadastrado !!!')
   ORDEM=.F.
ENDIF
SET FILTER TO
SELE 10
SET FILTER TO BANCO=Z
DBGOTOP()
LOCATE FOR NUMERO=X
IF FOUND()
   MENS('Cheque ja Cadastrado !!!')
   ORDEM=.F.
ENDIF
SET FILTER TO
SELE &ARE
IF REG#0
   GO REG
ENDIF
RETURN (ORDEM)

//FUNCAO INCLUI CARTAO DE CREDITO - USADO HOT23, FECHAMENTO DE CONTA

FUNCTION CARTAO()
AREA=SELECT()
ORDEM=.T.
JANELA(01,10,13,14,67,"Inclusao de Cartoes")
@ 12,13 SAY "Ã N§ Cartao ÄÄÄÄÄÄÄÄÄÄÂ Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ´"
@ 13,13 SAY "³                     ³              ³                ³"
@ 14,13 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
SELE 10
SET CURSOR ON
@ 13,15 GET MNUMERO     PICT "@!"  VALID(!EMPTY(MNUMERO))
@ 13,37 GET MBANCO      PICT "9999"  VALID (!EMPTY(MBANCO))
@ 13,52 GET MAGENCIA    PICT "99999"
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   MNUMERO=SPACE(20)
   MBANCO=0
   MAGENCIA=0
   ORDEM=.F.
   TFORMAPAG=SPACE(08)
   JANELA(02)
   RETURN(ORDEM)
ENDIF
JANELA(2)
SELE &AREA
RETURN(ORDEM)

//FUNCAO INCLUI COBRANCAS - USADO HOT23, FECHAMENTO DE CONTA

FUNCTION COB()
AREA=SELECT()
DBCOMMITALL()
SELE 16
USE CONREC SHARED
IF !FILE("CONREC.NTX")
   INDEX ON CODFIR TO CONREC
ELSE
   SET INDEX TO CONREC
ENDIF
APPE BLAN
REPLACE CODFIR   WITH MFIRMAAGE,;
        DATAFEC  WITH MDTSAI,;
        VALOR    WITH MVALOR,;
        SITUACAO WITH "A"
DBCOMMIT()
USE
SELE &AREA
RETURN (NIL)

//FUNCAO VERIFICA SE JA EXISTE CGC DE FIRMA

FUNCTION VERCGC(X,T)
AUX=RECNO()
ORDEM=.F.
IF !EMPTY(X)
   DBGOTOP()
   IF T='I'
      LOCATE FOR CGC=X
   ELSE
      LOCATE FOR CGC=X .AND. RECNO()#AUX
   ENDIF
   IF !FOUND()
      ORDEM=.T.
   ELSE
      MENS('CGC ja existente !!!')
   ENDIF
ELSE
   MENS('CGC Invalido !!!')
ENDIF
GO AUX
RETURN(ORDEM)

FUNCTION SEMANA(X)
MSEN=DOW(X)
DO CASE
   CASE MSEN=1
      @ 02,PCOL()+1 SAY "Domingo"
   CASE MSEN=2
      @ 02,PCOL()+1 SAY "Segunda"
   CASE MSEN=3
      @ 02,PCOL()+1 SAY "Terca"
   CASE MSEN=4
      @ 02,PCOL()+1 SAY "Quarta"
   CASE MSEN=5
      @ 02,PCOL()+1 SAY "Quinta"
   CASE MSEN=6
      @ 02,PCOL()+1 SAY "Sexta"
   CASE MSEN=0
      @ 02,PCOL()+1 SAY "Sabado"
ENDCASE
RETURN(NIL)

//FUNCAO CONFIRMA DA ROTINA DE BACKUP E RESTAURACAO

FUNCTION CONFIRMA
PARAMETERS MENSA
PRIVATE TABULACAO, CORC, SN
//CORC=SETCOLOR(XCOR1)
CORC=SETCOLOR("CORJ")
TABULACAO=(70-LEN(MENSA))/2
@ 20,10+TABULACAO SAY MENSA
SN=SPACE(01)
TONE(1000,1)
SET CURSOR ON
@ 20,COL() GET SN PICT '!' VALID (SN$'SN')
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   SN='N'
ENDIF
@ 20,10 CLEAR TO 20,78
SETCOLOR(CORC)
RETURN(SN)
