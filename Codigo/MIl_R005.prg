 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R005.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o de Caixa
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=7, c_s:=20, l_i:=15, c_i:=63, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±±±±±± Rela‡„o de Caixa ±±±±±±±±±±±±"
@ l_s+03,c_s+1 SAY "    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ l_s+04,c_s+1 SAY "    ³ De :                        h ³"
@ l_s+05,c_s+1 SAY "    ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ l_s+06,c_s+1 SAY "    ³ At‚:                        h ³"
@ l_s+07,c_s+1 SAY "    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
dtentr=CTOD('')                                              // Data da Rela‡„o de Caixa
hentr=SPAC(4)                                                // Hora da Rela‡„o do Caixa
dsai=CTOD('')                                                // Data de Sa¡da
hsaid=SPAC(4)                                                // Hora da Rela‡„o do Caixa
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+14 GET  dtentr;
                    PICT "@D";
                    VALI CRIT("!EMPT(dtentr)~Necess rio informar DATA DA RELA€O DE CAIXA")
                    DEFAULT "M->dtcaixa"
                    AJUDA "Informe a data inicial para a|Rela‡„o de Caixa"

   @ l_s+04 ,c_s+29 GET  hentr;
                    PICT "@R 99:99";
                    VALI CRIT("!EMPT(hentr)~Necess rio informar HORA DA RELA€O DO CAIXA")
                    DEFAULT "M->hcaixa"
                    AJUDA "Informe a hora inicial para a|Rela‡„o de Caixa"

   @ l_s+06 ,c_s+14 GET  dsai;
                    PICT "@D";
                    VALI CRIT("!EMPT(dsai) .And. dsai<=DataC~Necess rio informar DATA DE SA¡DA")
                    DEFAULT "DataC"
                    AJUDA "Informe a data final para a|Rela‡„o de Caixa"

   @ l_s+06 ,c_s+29 GET  hsaid;
                    PICT "@R 99:99";
                    VALI CRIT("!EMPT(hsaid) .And. hsaid<=Time()~Necess rio informar HORA DA RELA€O DO CAIXA")
                    DEFAULT "Hora(Time())"
                    AJUDA "Informe a hora inicial para a|Rela‡„o de Caixa"

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
      IF !USEARQ("PAGAM",.t.,10,1)                           // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("PAGAM")                                        // abre o dbf e seus indices
   #endi

   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)                 // abre arquivo p/ o relacionamento
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"CONREGIS",1,.t.)
   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"DESCONTO",2,.t.)
   SET RELA TO STR(codhosp,10,00) INTO HOSPEDES,;            // relacionamento dos arquivos
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO CONREGIS,;
            TO STR(codigo,10,00) INTO REGISTRO,;
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO DESCONTO
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(datamov)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,4,11)                    // nao quis configurar...
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
      tot037011:=tot037012:=tot037013:=tot037014:=tot037015 := 0// inicializa variaves de totais
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
         IF DataMov>=DtEntr .And. DataMov<=DSai              // se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Pagamentos Efetuados em ]+DtoC(datamov)// titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            RELEASE ALL LIKE omt037*                         // imprime campos omitidos
            qb03701=datamov                                  // campo para agrupar 1a quebra
            st03701011:=st03701012:=st03701013:=st03701014:=st03701015 := 0// inicializa sub-totais
            DO WHIL !EOF() .AND. datamov=qb03701
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF DataMov>=DtEntr .And. DataMov<=DSai        // se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  IF TYPE("omt037002")!="N" .OR. omt037002!=REGISTRO->apto// imp se dif do anterior
                     @ cl,002 SAY TRAN(REGISTRO->apto,"9999")// Apto
                     omt037002=REGISTRO->apto                // imp se dif do anterior
                  ENDI
                  @ cl,011 SAY "³"
                  IF TYPE("omt037004")!="C" .OR. omt037004!=HOSPEDES->nome// imp se dif do anterior
                     @ cl,012 SAY HOSPEDES->nome             // Nome
                     omt037004=HOSPEDES->nome                // imp se dif do anterior
                  ENDI
                  @ cl,048 SAY "³"
                  @ cl,053 SAY TRAN(formapag,"9")            // C¢d. Forma de Pagamento
                  @ cl,059 SAY "³                ³             ³          ³                  ³          ³"
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³          ³"
                  @ cl,015 SAY TRAN(CONREGIS->rd,"99999")    // N£mero da Fatura
                  @ cl,036 SAY TRAN(tipomov,"9")             // Tipo de Movimento
                  @ cl,037 SAY "-"
                  @ cl,038 SAY If(tipomov=1,'NORMAL','EXTRA')// Extenso Tp Movimento
                  @ cl,048 SAY "³"
                  @ cl,049 SAY PAG_01F9(formapag)            // Nome da Forma de Pagame.
                  @ cl,059 SAY "³"
                  IF R00502F9(codigo,codhosp,tipomov)        // pode imprimir?
                     st03701011+=valor  //If(tipomov=1,CONREGIS->vlnormal,CONREGIS->vlextra)
                     tot037011+=valor  //If(tipomov=1,CONREGIS->vlnormal,CONREGIS->vlextra)
                     @ cl,060 SAY TRAN(valor,"@E 99,999,999.99")  //If(tipomov=1,CONREGIS->vlnormal,CONREGIS->vlextra),"@E 9,999,999,999.99")// Total Geral
                  ENDI
                  @ cl,076 SAY "³"
                  IF R00502F9(codigo,codhosp,tipomov)        // pode imprimir?
                     st03701012+=valor*M->txser/100
                     tot037012+=valor*M->txser/100
                     @ cl,077 SAY TRAN(valor*M->txser/100,"@E 99,999,999.99")// Total Taxa de Servi‡o
                  ENDI
                  @ cl,090 SAY "³"
                  IF R00502F9(codigo,codhosp,tipomov)        // pode imprimir?
                     st03701013+=R00501f9(CONREGIS->finalnor,CONREGIS->porcnor,CONREGIS->finalext,CONREGIS->porcext)
                     tot037013+=R00501f9(CONREGIS->finalnor,CONREGIS->porcnor,CONREGIS->finalext,CONREGIS->porcext)
                     @ cl,092 SAY TRAN(R00501f9(CONREGIS->finalnor,CONREGIS->porcnor,CONREGIS->finalext,CONREGIS->porcext),"@E 99,999.99")// Desconto Geral
                  ENDI
                  @ cl,101 SAY "³"
                  IF R00502F9(codigo,codhosp,tipomov)        // pode imprimir?
                     st03701014+=R00601F9()
                     tot037014+=R00601F9()
                     @ cl,102 SAY TRAN(R00601F9(),"@E 999,999,999,999.99")// Total … Pagar
                  ENDI
                  @ cl,120 SAY "³"
                  st03701015+=valor
                  tot037015+=valor
                  @ cl,121 SAY TRAN(valor,"@E 999,999.99")   // Valor
                  @ cl,131 SAY "³"
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,060 SAY REPL('-',71)
            @ ++cl,060 SAY TRAN(st03701011,"@E 9,999,999,999.99")// sub-tot Total Geral
            @ cl,077 SAY TRAN(st03701012,"@E 99,999,999.99") // sub-tot Total Taxa de Servi‡o
            @ cl,092 SAY TRAN(st03701013,"@E 99,999.99")     // sub-tot Desconto Geral
            @ cl,102 SAY TRAN(st03701014,"@E 999,999,999,999.99")// sub-tot Total … Pagar
            @ cl,121 SAY TRAN(st03701015,"@E 999,999.99")    // sub-tot Valor
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,060 SAY REPL('-',71)
      @ ++cl,060 SAY TRAN(tot037011,"@E 9,999,999,999.99")   // total Total Geral
      @ cl,077 SAY TRAN(tot037012,"@E 99,999,999.99")        // total Total Taxa de Servi‡o
      @ cl,092 SAY TRAN(tot037013,"@E 99,999.99")            // total Desconto Geral
      @ cl,102 SAY TRAN(tot037014,"@E 999,999,999,999.99")   // total Total … Pagar
      @ cl,121 SAY TRAN(tot037015,"@E 999,999.99")           // total Valor
   ENDD ccop
END SEQUENCE
IMPCTL(drvtcom)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(4)                                                     // grava variacao do relatorio
msgt="PROCESSAMENTOS DO RELAT¢RIO|RELA€O DE CAIXA"
ALERTA()
op_=DBOX("Prosseguir|Cancelar opera‡„o",,,E_MENU,,msgt)
IF op_=1
   DBOX("Processando registros",,,,NAO_APAGA,"AGUARDE!")
   dele_atu:=SET(_SET_DELETED,.t.)                           // os excluidos nao servem...
   SELE PAGAM                                                // processamentos apos emissao
   INI_ARQ()                                                 // acha 1o. reg valido do arquivo
   DO WHIL !EOF()
      IF DataMov>=DtEntr .And. DataMov<=DSai                 // se atender a condicao...
         PARAMETROS('dtcaixa',M->dsai)
         PARAMETROS('hcaixa',M->hsaid)
         SKIP                                                // pega proximo registro
      ELSE                                                   // se nao atende condicao
         SKIP                                                // pega proximo registro
      ENDI
   ENDD
   ALERTA(2)
   DBOX("Processo terminado com sucesso!",,,,,msgt)
ENDI
SELE PAGAM                                                   // salta pagina
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
   @ 0,119 SAY "Pag :"
   @ 0,125 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,054 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O  D E  C A I X A",3,057)
   @ 5,060 SAY "De  :"
   @ 5,066 SAY TRAN(M->dtentr,"@D")                          // Data da Rela‡„o de Caixa
   @ 5,076 SAY "-"
   @ 5,079 SAY TRAN(M->hentr,"@R 99:99")                     // Hora da Rela‡„o do Caixa
   IMPAC("At‚ :",6,060)
   @ 6,066 SAY TRAN(M->dsai,"@D")                            // Data de Sa¡da
   @ 6,076 SAY "-"
   @ 6,079 SAY TRAN(M->hsaid,"@R 99:99")                     // Hora da Rela‡„o do Caixa
   @ 7,000 SAY "ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿"
   @ 8,000 SAY "³          ³                                    ³          ³                ³             ³          ³                  ³          ³"
   IMPAC("³ Apto     ³ Hospede                            ³Forma Pg. ³Total Geral     ³Taxa Servi‡o ³Desc.Geral³ Total … Pagar    ³Valor Pago³",9,000)
   @ 10,000 SAY "³          ³ N§ Fatura            Tp. Movimento ³          ³                ³             ³          ³                  ³          ³"
   @ 11,000 SAY "ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+11 ; pg_++
ENDI
RETU

* \\ Final de MIL_R005.PRG
