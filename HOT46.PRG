 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT46.PRG
 \ Modulo..: Mapa de Hospedes
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 15-05-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: EmissÆo de Relat¢rio de hospedes 
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

PRIV TAPTO:=0,TPAX:=0;TENT:=0;TSUB:=0;TSAI:=0;TTAOTAL:=0;TPORC:=0;MEDAPTO:=0;MEDPAX:=0

SET DATE TO BRIT
NUCOP:=COPIA:=1
JANELA(01,10,24,15,57,"")
@ 11,35 SAY "Informe a Data"
DO WHILE .T.
   MDATA=CTOD("  /  /  ")
   MDATAF=CTOD("  /  /  ")
   SET CURSOR ON
   @ 14,30 GET MDATA  PICT "@D" VALID(!EMPTY(MDATA))
   @ 14,46 GET MDATAF PICT "@D" VALID(!EMPTY(MDATAF))
   READ
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      JANELA(02)
      RETURN
   ENDIF
   IF ((MDATAF>DAT_HOJE) .OR. (MDATA>DAT_HOJE))
      MENS('Data Invalida !!!')
   ELSE
      JANELA(02)
      EXIT
   ENDIF
ENDDO
JANELA(01,09,18,14,63,"Solicitacao de Copias")
@ 12,25 SAY "Informe o Numero de Copias :"
SET CURSOR ON
@ 12,54 GET NUCOP PICT "99" RANGE 1,99
READ
SET CURSOR OFF
JANELA(02)
IF LASTKEY()=K_ESC
   RETURN
ENDIF
JANELA(01,09,18,14,63,"Verificacao de Impressora")
@ 12,21 SAY "Prepare o Formulario e pressione <ENTER> "
INKEY(0)
DO WHILE .T.
   IF !ISPRINTER()
      @ 12,21 SAY "Impressora nao esta Pronta ou sem Papel "
      INKEY(0.5)
      IF LASTKEY()=K_ESC
         JANELA(02)
         RETURN
      ENDIF
   ELSE
      EXIT
   ENDIF
ENDDO
JANELA(02)
IF LASTKEY()=K_ESC
   RETURN
ENDIF
JANELA(1,11,15,15,66,"Imprimindo Mapa de Hospedes")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
AREA=SELECT()
SELE 12
LIN=MLCOUNT(COLCHAO,80,3,.T.)   //CONTA O NUMERO DE LINHAS DO MEMOEDIT
SELE 05
SET ORDER TO 3
SELE &AREA
DO WHILE NUCOP>=COPIA
   SET DEVICE TO PRINT
   APTOS->(DBGOTOP())
   APTOS->(DBSETFILTER())
   FIRMAS->(DBGOTOP())
   FIRMAS->(DBSETFILTER())
   HOSPEDES->(DBGOTOP())
   HOSPEDES->(DBSETFILTER())
   SELE 05
   SET FILTER TO ((DTENT<=MDATA.AND.(DTSAI>=MDATAF.OR.Empty(DtSai))).and.Ativo='S')
   DBGOTOP()
   COUNT TO TENT ALL FOR DTENT=MDATA
   COUNT TO TSAI ALL FOR DTSAI=MDATAF
   DBGOTOP()
   @ 01,00 SAY CHR(15)
   CABECALHO1(MDATA)
   DO WHILE !EOF()
      TPAX=TPAX+REGISTRO->PAX
      TAPTO=TAPTO+1
      APTOS->(DBSEEK(REGISTRO->APTO))
      FIRMAS->(DBSEEK(REGISTRO->FIRMAAGE))
      HOSPEDES->(DBSEEK(REGISTRO->CODHOSP))
      @PROW()+1,02 SAY APTO PICT "999"
      @PROW(),09   SAY SUBSTR(HOSPEDES->NOME,1,20) PICT "@!"
      @PROW(),34   SAY SUBSTR(APTOS->DESCRICAO,1,15) PICT "@!"
      @PROW(),54   SAY SUBSTR(FIRMAS->NOME,1,20) PICT "@!"
      @PROW(),79   SAY PAX PICT "999"
      @PROW(),87   SAY DTENT PICT "@D"
      @PROW(),100  SAY DTSAI PICT "@D"
      @PROW(),110  SAY APTOS->DIARIA PICT "99,999.99"
      IF PCONTA='H'
         @PROW(),122  SAY "HOSPEDE"
      ELSEIF PCONTA='F'
         @PROW(),122  SAY "FIRMA  "
      ENDIF
      DBSKIP()
      IF PROW()>=(60-LIN)
         DO IMPCOL
         DO RODAPE
         @ 01,00 SAY CHR(15)
         CABECALHO1(MDATA)
      ENDIF
   ENDDO
   COPIA++
   DO IMPCOL
   DO RODAPE
ENDDO
SET DEVICE TO SCREEN
SELE 05
DBSETFILTER()
SET ORDER TO 0
JANELA(02)
RETURN

FUNCTION CABECALHO1(X)
@ 01,00 SAY Padc(Controle->NomHot+' -  Mapa de Hospedes',80)
@ 02,03 SAY "Dia da Semana : "
SEMANA(MDATA)
@ 02,PCOL()+80 SAY " Dia : "
@ 02,PCOL()+1 SAY DAT_HOJE
@ PROW()+1,01 SAY"==================================================================================================================================="
@ PROW()+2,01 SAY"Apto    Nome                     Descricao           Firma                    Pax     Dt. Ent.     Dt. Sai.     Diaria   P/C       "
@ PROW()+1,01 SAY"-----------------------------------------------------------------------------------------------------------------------------------"
RETURN

//FUNCAO IMPRIME MEMOEDIT - COLCHOES MAGNETICOS

PROCEDURE IMPCOL
AREA=SELECT()
SELE 12
POS=60-LIN
@ POS,01 SAY REPL("-",132)
FOR C:=1 TO LIN
   @ (POS+C)-1,01 SAY MEMOLINE(COLCHAO,80,C,3,.T.)
NEXT
SELE &AREA
RETURN
