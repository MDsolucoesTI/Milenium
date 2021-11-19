/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_R009.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o de Cheques-Pr‚
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=8, c_s:=19, l_i:=14, c_i:=62, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±± Rela‡„o de Cheques Pr‚-Datados ±±±±±"
@ l_s+03,c_s+1 SAY "    Ú Informe a partir de que Data ¿"
@ l_s+04,c_s+1 SAY "    ³                              ³"
@ l_s+05,c_s+1 SAY "    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
data=CTOD('')                                                // Data
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+17 GET  data;
                    PICT "@D";
                    VALI CRIT("!EMPT(data)~Necess rio informar DATA")
                    DEFAULT "DataC"
                    AJUDA "Informe a partir de que data"

   READ
   SET KEY K_ALT_F8 TO
   IF rola_t
      ROLATELA(.f.)
      LOOP
   ENDI
   IF LASTKEY()=K_ESC                                        // se quer cancelar
      RETU                                                   // retorna
   ENDI

   #ifdef COM_REDE
      IF !USEARQ("CHEQUES",.f.,10,1)                         // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("CHEQUES")                                      // abre o dbf e seus indices
   #endi

   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)                  // abre arquivo p/ o relacionamento
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"CONREGIS",1,.t.)
   PTAB(STR(CONREGIS->codhosp,10,00),"HOSPEDES",3,.t.)
   SET RELA TO STR(codigo,10,00) INTO REGISTRO,;             // relacionamento dos arquivos
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO CONREGIS,;
            TO STR(CONREGIS->codhosp,10,00) INTO HOSPEDES
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(datapre)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,7,11)                    // nao quis configurar...
      CLOS ALL                                               // fecha arquivos e
      LOOP                                                   // volta ao menu
   ENDI
   IF tps=2                                                  // se vai para arquivo/video
      arq_=ARQGER()                                          // entao pega nome do arquivo
      IF EMPTY(arq_)                                         // se cancelou ou nao informou
         LOOP                                                // retorna
      ENDI
   ELSE
      arq_=drvporta                                          // porta de saida configurada
   ENDI
   SET PRINTER TO (arq_)                                     // redireciona saida
   EXIT
ENDD
DBOX("[ESC] Interrompe",15,,,NAO_APAGA)
dele_atu:=SET(_SET_DELETED,.t.)                              // os excluidos nao servem...
SET DEVI TO PRIN                                             // inicia a impressao
maxli=62                                                     // maximo de linhas no relatorio
IMPCTL(drvpcom)                                              // comprime os dados
IF tps=2
   IMPCTL("' '+CHR(8)")
ENDI
BEGIN SEQUENCE
   DO WHIL ccop<=nucop                                       // imprime qde copias pedida
      pg_=1; cl=999
      INI_ARQ()                                              // acha 1o. reg valido do arquivo
      ccop++                                                 // incrementa contador de copias
      tot041006 := 0                                         // inicializa variaves de totais
      DO WHIL !EOF()
         #ifdef COM_TUTOR
            IF IN_KEY()=K_ESC                                // se quer cancelar
         #else
            IF INKEY()=K_ESC                                 // se quer cancelar
         #endi
            IF canc()                                        // pede confirmacao
               BREAK                                         // confirmou...
            ENDI
         ENDI
         IF datapre>=Data                                    // se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Cheques para ]+DtoC(datapre)       // titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb04101=datapre                                  // campo para agrupar 1a quebra
            st04101006 := 0                                  // inicializa sub-totais
            DO WHIL !EOF() .AND. datapre=qb04101
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF datapre>=Data                              // se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,002 SAY TRAN(REGISTRO->apto,"9999")   // Apto
                  @ cl,007 SAY "³"
                  @ cl,010 SAY HOSPEDES->nome                // Nome do Hospede
                  @ cl,046 SAY "³"
                  @ cl,049 SAY operador                      // Operador
                  @ cl,065 SAY "³"
                  @ cl,067 SAY TRAN(tipomov,"9")             // Tipo Movimento
                  @ cl,068 SAY "-"
                  @ cl,069 SAY If(tipomov=1,'NORMAL','EXTRA ')// Extenso Tipo Movimento
                  @ cl,077 SAY "³"
                  @ cl,080 SAY TRAN(ncheque,"999999999")     // N£mero do Cheque
                  @ cl,091 SAY "³"
                  @ cl,094 SAY TRAN(banco,"9999")            // Banco
                  @ cl,100 SAY "³"
                  @ cl,103 SAY TRAN(dataemis,"@D")           // Data de Emiss„o
                  @ cl,116 SAY "³"
                  st04101006+=valor
                  tot041006+=valor
                  @ cl,119 SAY TRAN(valor,"9999999.99")      // Valor
                  @ cl,131 SAY "³"
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,119 SAY REPL('-',10)
            @ ++cl,119 SAY TRAN(st04101006,"9999999.99")     // sub-tot Valor
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,119 SAY REPL('-',10)
      @ ++cl,119 SAY TRAN(tot041006,"9999999.99")            // total Valor
   ENDD ccop
END SEQUENCE
IMPCTL(drvtcom)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(7)                                                     // grava variacao do relatorio
SELE CHEQUES                                                 // salta pagina
SET RELA TO                                                  // retira os relacionamentos
SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
RETU

STATIC PROC REL_CAB(qt)                                      // cabecalho do relatorio
IF qt>0                                                      // se parametro maior que 0
   cl=cl+qt                                                  // soma no contador de linhas
ENDI
IF cl>maxli .OR. qt=0                                        // quebra de pagina
   @ 0,000 SAY Par([cidade1])                                // Cidade do Hotel
   @ 0,020 SAY ","
   @ 0,022 SAY NSEM(DATE())                                  // dia da semana
   @ 0,030 SAY "-"
   @ 0,032 SAY DTOC(DATE())                                  // data do sistema
   @ 0,121 SAY "Pag :"
   @ 0,127 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,045 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O  D E  C H E Q U E S - P R  - D A T A D O S",3,034)
   @ 5,000 SAY "ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³ Apto ³  Hospede                             ³     Operador     ³ Tp Movim. ³  N. Cheque  ³  Banco ³  Dt. Emiss„o  ³     Valor    ³",6,000)
   @ 7,000 SAY "ÃÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+7 ; pg_++
ENDI
RETU

* \\ Final de MIL_R009.PRG
