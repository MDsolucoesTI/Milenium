/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_R006.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o Data de Sa¡da
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=6, c_s:=19, l_i:=12, c_i:=62, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±± Rela‡„o de Data de Sa¡da ±±±±±±±±"
@ l_s+03,c_s+1 SAY "     Ú Informe a partir de que Data ¿"
@ l_s+04,c_s+1 SAY "     ³                              ³"
@ l_s+05,c_s+1 SAY "     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
data=CTOD('')                                                // Data
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+17 GET  data;
                    PICT "@D";
                    VALI CRIT("!EMPT(data)~Necess rio informar DATA")
                    DEFAULT "Datac"
                    AJUDA "Informe a partir de que data|ser  a rela‡„o de data prevista|de sa¡da"

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
   PTAB(STR(REGISTRO->firmaage,04,00),"CLIENTES",2,.t.)
   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)
   SET RELA TO STR(codigo,10,00) INTO REGISTRO,;             // relacionamento dos arquivos
            TO STR(REGISTRO->firmaage,04,00) INTO CLIENTES,;
            TO STR(codhosp,10,00) INTO HOSPEDES
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(dtsai)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,14,11)                   // nao quis configurar...
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
      tot048009:=tot048010 := 0                              // inicializa variaves de totais
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
         IF ((dtsai>=Data .or. Empty(dtsai)) .And. ativo='S')// se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Data Prevista de Sa¡da em ]+Dtoc(dtsai)// titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb04801=dtsai                                    // campo para agrupar 1a quebra
            st04801009:=st04801010 := 0                      // inicializa sub-totais
            DO WHIL !EOF() .AND. dtsai=qb04801
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF ((dtsai>=Data .or. Empty(dtsai)) .And. ativo='S')// se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,002 SAY TRAN(REGISTRO->apto,"9999")   // Apto
                  @ cl,007 SAY "³"
                  @ cl,008 SAY HOSPEDES->nome                // Nome do Hospede
                  @ cl,043 SAY "³"
                  @ cl,045 SAY TRAN(REGISTRO->pax,"99")      // Pax
                  @ cl,048 SAY "³"
                  @ cl,049 SAY Substr(CLIENTES->nome,01,20)  // Nome da Firma
                  @ cl,070 SAY "³"
                  @ cl,071 SAY TRAN(REGISTRO->movimn,"@!")   // Movimento Normal
                  @ cl,072 SAY "-"
                  @ cl,073 SAY TRAN(If(REGISTRO->movimn='C','ONJUNTO  ','NDIVIDUAL'),"@!")// Tipo Movimento Normal
                  @ cl,083 SAY "³"
                  @ cl,084 SAY TRAN(REGISTRO->movime,"@!")   // Movimento Extra
                  @ cl,085 SAY "-"
                  @ cl,086 SAY TRAN(If(REGISTRO->movime='C','ONJUNTO  ','NDIVIDUAL'),"@!")// Tipo Movimento Extra
                  @ cl,095 SAY "³"
                  st04801009+=R00602F9(codigo,codhosp)
                  tot048009+=R00602F9(codigo,codhosp)
                  @ cl,097 SAY TRAN(R00602F9(codigo,codhosp),"@E 999,999,999.99")// Total Movimento Normal
                  @ cl,111 SAY "³"
                  st04801010+=R00603F9(codigo,codhosp)
                  tot048010+=R00603F9(codigo,codhosp)
                  @ cl,114 SAY TRAN(R00603F9(codigo,codhosp),"@E 999,999,999.99")// Total Movimento Extra
                  @ cl,130 SAY "³"
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,097 SAY REPL('-',31)
            @ ++cl,097 SAY TRAN(st04801009,"@E 999,999,999.99")// sub-tot Total Movimento Normal
            @ cl,114 SAY TRAN(st04801010,"@E 999,999,999.99")// sub-tot Total Movimento Extra
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,097 SAY REPL('-',31)
      @ ++cl,097 SAY TRAN(tot048009,"@E 999,999,999.99")     // total Total Movimento Normal
      @ cl,114 SAY TRAN(tot048010,"@E 999,999,999.99")       // total Total Movimento Extra
   ENDD ccop
END SEQUENCE
IMPCTL(drvtcom)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(14)                                                    // grava variacao do relatorio
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
   @ 0,122 SAY "Pag :"
   @ 0,128 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,040 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O  D E  D A T A  P R E V I S T A  D E  S A ¡ D A",3,027)
   @ 5,000 SAY "ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @ 6,000 SAY "³ Apto ³Nome do Hospede                    ³Pax ³Firma                ³Mov. Normal ³Mov. Extra ³  Valor Normal ³   Valor Extra    ³"
   @ 7,000 SAY "ÃÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+7 ; pg_++
ENDI
RETU

* \\ Final de MIL_R006.PRG
