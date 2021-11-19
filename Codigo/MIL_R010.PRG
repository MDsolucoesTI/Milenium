 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R010.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o de Cart”es
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analistas
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
@ l_s+01,c_s+1 SAY "±±±±± Rela‡„o de Cart”es de Cr‚dito ±±±±±±"
@ l_s+03,c_s+1 SAY "    Ú Informe a partir de que data ¿"
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
      IF !USEARQ("PAGAM",.f.,10,1)                           // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("PAGAM")                                        // abre o dbf e seus indices
   #endi

   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)                  // abre arquivo p/ o relacionamento
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"CONREGIS",1,.t.)
   PTAB(STR(CONREGIS->codhosp,10,00),"HOSPEDES",3,.t.)
   PTAB(STR(tipocart,02,00),"CARTOES",1,.t.)
   SET RELA TO STR(codigo,10,00) INTO REGISTRO,;             // relacionamento dos arquivos
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO CONREGIS,;
            TO STR(CONREGIS->codhosp,10,00) INTO HOSPEDES,;
            TO STR(tipocart,02,00) INTO CARTOES
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="STR(tipocart,02,00)+DTOS(datamov)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,8,11)                    // nao quis configurar...
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
      tot042004:=tot042005 := 0                              // inicializa variaves de totais
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
         IF datamov>=Data.and.formapag=2                     // se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Tipo de Cart„o : ]+Str(tipocart)+[-]+(CARTOES->nomecar)+[    -    ]+DtoC(datamov)// titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb04201=tipocart+datamov                         // campo para agrupar 1a quebra
            st04201004:=st04201005 := 0                      // inicializa sub-totais
            DO WHIL !EOF() .AND. tipocart+datamov=qb04201
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF datamov>=Data.and.formapag=2               // se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,001 SAY TRAN(REGISTRO->apto,"9999")   // Apto
                  @ cl,005 SAY "³"
                  @ cl,006 SAY HOSPEDES->nome                // Nome
                  @ cl,041 SAY "³"
                  @ cl,042 SAY operador                      // Operador
                  @ cl,057 SAY "³"
                  @ cl,058 SAY TRAN(tipomov,"9")             // Tipo de Movimento
                  @ cl,059 SAY "-"
                  @ cl,060 SAY If(tipomov=1,'NORMAL','EXTRA ')// Extenso Tipo Movimento
                  @ cl,067 SAY "³"
                  @ cl,068 SAY numero                        // N£mero
                  @ cl,088 SAY "³"
                  @ cl,090 SAY TRAN(banco,"9999")            // Banco
                  @ cl,096 SAY "³"
                  @ cl,097 SAY TRAN(agencia,"99999")         // Agˆncia
                  @ cl,103 SAY "³"
                  @ cl,104 SAY TRAN(CARTOES->taxa,"99.99")   // Taxa
                  @ cl,110 SAY "³"
                  st04201004+=valor
                  tot042004+=valor
                  @ cl,111 SAY TRAN(valor,"999999.99")       // Valor
                  @ cl,121 SAY "³"
                  st04201005+=valor*CARTOES->taxa/100
                  tot042005+=valor*CARTOES->taxa/100
                  @ cl,122 SAY TRAN(valor*CARTOES->taxa/100,"@E 999,999.99")// Valor Taxa
                  @ cl,134 SAY "³"
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,111 SAY REPL('-',21)
            @ ++cl,111 SAY TRAN(st04201004,"999999.99")      // sub-tot Valor
            @ cl,122 SAY TRAN(st04201005,"@E 999,999.99")    // sub-tot Valor Taxa
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,111 SAY REPL('-',21)
      @ ++cl,111 SAY TRAN(tot042004,"999999.99")             // total Valor
      @ cl,122 SAY TRAN(tot042005,"@E 999,999.99")           // total Valor Taxa
   ENDD ccop
END SEQUENCE
IMPCTL(drvtcom)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(8)                                                     // grava variacao do relatorio
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
   @ 0,123 SAY "Pag :"
   @ 0,129 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,040 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O  D E  C A R T ™ E S  D E  C R  D I T O",3,031)
   @ 5,000 SAY "ÚÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³Apto³Hospede                            ³    Operador   ³Tp Movim.³  N£mero do Cart„o  ³ Banco ³ Agˆn.³ Taxa ³ Vl. Pag. ³   Vl Taxa  ³",6,000)
   @ 7,000 SAY "ÃÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+7 ; pg_++
ENDI
RETU

* \\ Final de MIL_R010.PRG
