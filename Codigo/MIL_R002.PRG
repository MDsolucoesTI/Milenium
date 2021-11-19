 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R002.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o por Departamento
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=8, c_s:=23, l_i:=16, c_i:=66, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±± Rela‡„o por Departamento ±±±±±±±±"
@ l_s+03,c_s+1 SAY " Ú Informe a partir de que data e Hora ¿"
@ l_s+04,c_s+1 SAY " ³ Data              Hora              ³"
@ l_s+05,c_s+1 SAY " Ã Tipo de Despesa ÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ l_s+06,c_s+1 SAY " ³    -               ³"
@ l_s+07,c_s+1 SAY " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
data=CTOD('')                                                // Data
hora=SPAC(4)                                                 // Hora
departam=0                                                   // Tipo de Despesa
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+10 GET  data;
                    PICT "@D";
                    VALI CRIT("!EMPT(data)~Necess rio informar DATA")
                    DEFAULT "Date()"
                    AJUDA "Informe a partir de que data|ser  feita a consulta"

   @ l_s+04 ,c_s+28 GET  hora;
                    PICT "@R 99:99";
                    VALI CRIT("!EMPT(hora)~Necess rio informar HORA")
                    DEFAULT "Hora(Time())"
                    AJUDA "Informe a partir de que hora|ser  feita a consulta"

   @ l_s+06 ,c_s+04 GET  departam;
                    PICT "99";
                    VALI CRIT("PTAB(STR(departam,02,00),'DEPARTA',1)~TIPO DE DESPESA n„o existe na tabela")
                    AJUDA "Informe o Tipo de Despesa|F8 Tabela Pick"
                    CMDF8 "VDBF(6,57,20,77,'DEPARTA',{'codigo','tipodesp'},1,'codigo',[])"
                    MOSTRA {"LEFT(TRAN(DEPARTA->tipodesp,[]),12)", 6 , 9 }

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
      IF !USEARQ("MOVIM",.f.,10,1)                           // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("MOVIM")                                        // abre o dbf e seus indices
   #endi

   PTAB(STR(tipodesp,02,00),"DEPARTA",1,.t.)                 // abre arquivo p/ o relacionamento
   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)
   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)
   SET RELA TO STR(tipodesp,02,00) INTO DEPARTA,;            // relacionamento dos arquivos
            TO STR(codhosp,10,00) INTO HOSPEDES,;
            TO STR(codigo,10,00) INTO REGISTRO
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(datmov)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,9,11)                    // nao quis configurar...
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
IMPCTL(drvpeli)                                              // comprime os dados
IF tps=2
   IMPCTL("' '+CHR(8)")
ENDI
BEGIN SEQUENCE
   DO WHIL ccop<=nucop                                       // imprime qde copias pedida
      pg_=1; cl=999
      INI_ARQ()                                              // acha 1o. reg valido do arquivo
      ccop++                                                 // incrementa contador de copias
      tot043008 := 0                                         // inicializa variaves de totais
      qqu043=0                                               // contador de registros
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
         IF datmov>=Data .And.horamov>=Hora.And.tipodesp=Departam// se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Despesa Efetuado em ]+DtoC(datmov) // titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb04301=datmov                                   // campo para agrupar 1a quebra
            st04301008 := 0                                  // inicializa sub-totais
            qqu04301=0                                       // contador de registros
            DO WHIL !EOF() .AND. datmov=qb04301
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF datmov>=Data .And.horamov>=Hora.And.tipodesp=Departam// se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,001 SAY TRAN(REGISTRO->apto,"9999")   // Apto
                  @ cl,005 SAY "³"
                  @ cl,007 SAY TRAN(horamov,"@R 99:99")      // Hora do Movimento
                  @ cl,013 SAY "³"
                  @ cl,018 SAY R00201F9(tipomov)             // Tipo de Movimento
                  @ cl,029 SAY "³"
                  @ cl,032 SAY R00202F9(tcon)                // Tipo de Opera‡„o
                  @ cl,044 SAY "³"
                  @ cl,046 SAY R00203F9(estorno)             // Estorno
                  @ cl,052 SAY "³"
                  @ cl,053 SAY operador                      // Operador
                  @ cl,069 SAY "³"
                  st04301008+=valor
                  tot043008+=valor
                  @ cl,070 SAY TRAN(valor,"999999.99")       // Valor
                  @ cl,079 SAY "³"
                  qqu04301++                                 // soma contadores de registros
                  qqu043++                                   // soma contadores de registros
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,070 SAY REPL('-',9)
            @ ++cl,070 SAY TRAN(st04301008,"999999.99")      // sub-tot Valor
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY "* Quantidade "+TRAN(qqu04301,"@E 999,999")
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,070 SAY REPL('-',9)
      @ ++cl,070 SAY TRAN(tot043008,"999999.99")             // total Valor
      REL_CAB(2)                                             // soma cl/imprime cabecalho
      @ cl,000 SAY "*** Quantidade total "+TRAN(qqu043,"@E 999,999")
   ENDD ccop
END SEQUENCE
IMPCTL(drvteli)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(9)                                                     // grava variacao do relatorio
SELE MOVIM                                                   // salta pagina
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
   @ 0,070 SAY "Pag :"
   @ 0,076 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,027 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O   P O R   D E P A R T A M E N T O",3,021)
   @ 5,000 SAY "Tipo de Despesa:"
   @ 5,017 SAY TRAN(tipodesp,"99")                           // Tipo de Despesa
   @ 5,019 SAY "-"
   @ 5,020 SAY DEPARTA->tipodesp                             // Tipo de Despesa
   @ 6,000 SAY "ÚÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³Apto³  Hora ³ Tipo Movimento³Tipo Opera‡„o ³Estorno³    Operador    ³  Valor  ³",7,000)
   @ 8,000 SAY "ÃÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"
   cl=qt+8 ; pg_++
ENDI
RETU

* \\ Final de MIL_R002.PRG
