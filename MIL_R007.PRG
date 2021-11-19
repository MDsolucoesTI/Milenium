/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_R007.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Mapa de Hospedes
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu
PARA  lin_menu, col_menu
nucop=1

#ifdef COM_REDE
   IF !USEARQ("CONREGIS",.f.,10,1)                           // se falhou a abertura do arq
      RETU                                                   // volta ao menu anterior
   ENDI
#else
   USEARQ("CONREGIS")                                        // abre o dbf e seus indices
#endi

PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)                     // abre arquivo p/ o relacionamento
PTAB(STR(REGISTRO->firmaage,04,00),"CLIENTES",2,.t.)
PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"MOVIM",2,.t.)
PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)
PTAB(STR(REGISTRO->apto,04,00),"APTOS",1,.t.)
PTAB(STR(APTOS->tipo,02,00),"TIPO",1,.t.)
SET RELA TO STR(codigo,10,00) INTO REGISTRO,;                // relacionamento dos arquivos
         TO STR(REGISTRO->firmaage,04,00) INTO CLIENTES,;
         TO STR(codigo,10,00)+STR(codhosp,10,00) INTO MOVIM,;
         TO STR(codhosp,10,00) INTO HOSPEDES,;
         TO STR(REGISTRO->apto,04,00) INTO APTOS,;
         TO STR(APTOS->tipo,02,00) INTO TIPO
titrel:=criterio := ""                                       // inicializa variaveis
cpord="STR(REGISTRO->apto,04,00)"
titrel:=chv_rela:=chv_1:=chv_2 := ""
tps:=op_x:=ccop := 1
IF !opcoes_rel(lin_menu,col_menu,11,11)                      // nao quis configurar...
   CLOS ALL                                                  // fecha arquivos e
   RETU                                                      // volta ao menu
ENDI
IF tps=2                                                     // se vai para arquivo/video
   arq_=ARQGER()                                             // entao pega nome do arquivo
   IF EMPTY(arq_)                                            // se cancelou ou nao informou
      RETU                                                   // retorna
   ENDI
ELSE
   arq_=drvporta                                             // porta de saida configurada
ENDI
SET PRINTER TO (arq_)                                        // redireciona saida
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
      tot045007:=tot045008 := 0                              // inicializa variaves de totais
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
         IF ativo='S'                                        // se atender a condicao...
            qb04501=TIPO->tipo                               // campo para agrupar 1a quebra
            DO WHIL !EOF() .AND. TIPO->tipo=qb04501
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF ativo='S'                                  // se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,002 SAY TRAN(REGISTRO->apto,"9999")   // Apto
                  @ cl,007 SAY "³"
                  @ cl,010 SAY TRAN(APTOS->tipo,"99")        // Tipo
                  @ cl,012 SAY "-"
                  @ cl,013 SAY TIPO->tipo                    // Tipos de Apto
                  @ cl,024 SAY "³"
                  @ cl,026 SAY R00703F9(REGISTRO->pax)       // C¢digo Categoria
                  @ cl,028 SAY "-"
                  @ cl,029 SAY R00702F9(REGISTRO->pax)       // Categoria
                  @ cl,040 SAY "³"
                  @ cl,042 SAY HOSPEDES->nome                // Nome do Hospede
                  @ cl,078 SAY "³"
                  IF R00704F9(REGISTRO->codigo)              // pode imprimir?
                     tot045007+=REGISTRO->pax
                     @ cl,081 SAY TRAN(REGISTRO->pax,"99")   // Pax
                  ENDI
                  @ cl,086 SAY "³"
                  IF R00704F9(REGISTRO->codigo)              // pode imprimir?
                     tot045008+=REGISTRO->chd
                     @ cl,089 SAY TRAN(REGISTRO->chd,"99")   // Chd
                  ENDI
                  @ cl,094 SAY "³"
                  @ cl,098 SAY TRAN(REGISTRO->dtent,"@D")    // Data de Entrada
                  @ cl,111 SAY "³"
                  @ cl,116 SAY TRAN(dtsai,"@D")              // Data de Sa¡da
                  @ cl,131 SAY "³"
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,081 SAY REPL('-',10)
      @ ++cl,081 SAY TRAN(tot045007,"99")                    // total Pax
      @ cl,089 SAY TRAN(tot045008,"99")                      // total Chd
   ENDD ccop
END SEQUENCE
IMPCTL(drvtcom)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(11)                                                    // grava variacao do relatorio
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
   @ 0,121 SAY "Pag :"
   @ 0,127 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 1,049 SAY Par([empresa1])                               // Nome do Hotel
   @ 3,052 SAY "M A P A  D E  H O S P E D E S"
   @ 4,000 SAY "ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³ Apto ³     Tipo       ³   Categoria   ³           Nome do Hospede           ³  Pax  ³  CHD  ³ Data Entrada   ³   Data Sa¡da      ³",5,000)
   @ 6,000 SAY "ÃÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   cl=qt+6 ; pg_++
ENDI
RETU

* \\ Final de MIL_R007.PRG
