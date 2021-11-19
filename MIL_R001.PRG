/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_R001.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o de Reservas
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
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
@ l_s+01,c_s+1 SAY "±±±±±±±±±± Rela‡„o de Reservas ±±±±±±±±±±±"
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
                    AJUDA "Informe a partir de que data o relat¢rio|imprimir "

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
      IF !USEARQ("RESERVA",.f.,10,1)                         // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("RESERVA")                                      // abre o dbf e seus indices
   #endi

   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(dtreser)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,1,11)                    // nao quis configurar...
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
BEGIN SEQUENCE
   DO WHIL ccop<=nucop                                       // imprime qde copias pedida
      pg_=1; cl=999
      INI_ARQ()                                              // acha 1o. reg valido do arquivo
      ccop++                                                 // incrementa contador de copias
      tot029002 := 0                                         // inicializa variaves de totais
      qqu029=0                                               // contador de registros
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
         IF dtreser>=M->data                                 // se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Reservas para : ]+DtoC(dtreser)    // titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb02901=dtreser                                  // campo para agrupar 1a quebra
            qqu02901=0                                       // contador de registros
            DO WHIL !EOF() .AND. dtreser=qb02901
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF dtreser>=M->data                           // se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,004 SAY TRAN(apto,"9999")             // Apto
                  @ cl,014 SAY "³"
                  @ cl,016 SAY empresa                       // Nome
                  @ cl,053 SAY "³"
                  tot029002+=pax
                  @ cl,057 SAY TRAN(pax,"99")                // Pax
                  @ cl,062 SAY "³"
                  @ cl,066 SAY TRAN(dtsai,"@D")              // Data de Sa¡da
                  @ cl,078 SAY "³"
                  qqu02901++                                 // soma contadores de registros
                  qqu029++                                   // soma contadores de registros
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            @ cl,004 SAY "* Quantidade "+TRAN(qqu02901,"@E 999,999")
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,057 SAY REPL('-',2)
      @ ++cl,057 SAY TRAN(tot029002,"99")                    // total Pax
      REL_CAB(2)                                             // soma cl/imprime cabecalho
      @ cl,004 SAY "*** Quantidade total "+TRAN(qqu029,"@E 999,999")
   ENDD ccop
END SEQUENCE
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(1)                                                     // grava variacao do relatorio
SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
RETU

STATIC PROC REL_CAB(qt)                                      // cabecalho do relatorio
IF qt>0                                                      // se parametro maior que 0
   cl=cl+qt                                                  // soma no contador de linhas
ENDI
IF cl>maxli .OR. qt=0                                        // quebra de pagina
   IMPAC("R E L A €  O   D E   R E S E R V A",0,023)
   @ 2,000 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³ Apartamento ³ Empresa                              ³   Pax  ³  Data Sa¡da   ³",3,000)
   @ 4,000 SAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+4 ; pg_++
ENDI
RETU

* \\ Final de MIL_R001.PRG
