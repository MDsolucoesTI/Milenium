 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R013.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o de Hospedes
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=10, c_s:=19, l_i:=16, c_i:=62, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±±±± Rela‡„o de Hospedes ±±±±±±±±±±±"
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
                    AJUDA "Informe a partir de que Data"

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
      IF !USEARQ("CONREGIS",.f.,10,1)                        // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("CONREGIS")                                     // abre o dbf e seus indices
   #endi

   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)                  // abre arquivo p/ o relacionamento
   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)
   PTAB(STR(REGISTRO->firmaage,04,00),"CLIENTES",2,.t.)
   SET RELA TO STR(codigo,10,00) INTO REGISTRO,;             // relacionamento dos arquivos
            TO STR(codhosp,10,00) INTO HOSPEDES,;
            TO STR(REGISTRO->firmaage,04,00) INTO CLIENTES
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(REGISTRO->dtent)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,13,11)                   // nao quis configurar...
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
      qqu047=0                                               // contador de registros
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
         IF ativo='S' .And.REGISTRO->dtent>=Data             // se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Data de Entrada - ]+DtoC(REGISTRO->dtent)// titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb04701=REGISTRO->dtent                          // campo para agrupar 1a quebra
            qqu04701=0                                       // contador de registros
            DO WHIL !EOF() .AND. REGISTRO->dtent=qb04701
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF ativo='S' .And.REGISTRO->dtent>=Data       // se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,002 SAY TRAN(REGISTRO->apto,"9999")   // Apto
                  @ cl,007 SAY "³"
                  @ cl,009 SAY TRAN(REGISTRO->pax,"99")      // Pax
                  @ cl,012 SAY "³"
                  @ cl,013 SAY HOSPEDES->nome                // Nome
                  @ cl,049 SAY "³"
                  @ cl,053 SAY TRAN(REGISTRO->dtent,"@D")    // Data de Entrada
                  @ cl,064 SAY "³"
                  @ cl,068 SAY TRAN(dtsai,"@D")              // Data de Sa¡da
                  @ cl,078 SAY "³"
                  qqu04701++                                 // soma contadores de registros
                  qqu047++                                   // soma contadores de registros
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY "* Quantidade "+TRAN(qqu04701,"@E 999,999")
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      REL_CAB(2)                                             // soma cl/imprime cabecalho
      @ cl,000 SAY "*** Quantidade total "+TRAN(qqu047,"@E 999,999")
   ENDD ccop
END SEQUENCE
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(13)                                                    // grava variacao do relatorio
SELE CONREGIS                                                // salta pagina
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
   @ 0,067 SAY "Pag :"
   @ 0,073 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,024 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O  D E   H O S P E D E S",3,024)
   @ 5,000 SAY "ÚÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³ Apto ³Pax ³Hospede                             ³ Data Entrada ³  Data Sa¡da ³",6,000)
   @ 7,000 SAY "ÃÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+7 ; pg_++
ENDI
RETU

* \\ Final de MIL_R013.PRG
