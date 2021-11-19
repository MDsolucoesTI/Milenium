 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R003.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automao Hoteleira
 \ Funcao..: Relao de Movimentos
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=8, c_s:=16, l_i:=16, c_i:=71, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ Relao de Movimentos ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ"
@ l_s+03,c_s+1 SAY " ฺ Apto ฟ"
@ l_s+04,c_s+1 SAY " ณ      ณ"
@ l_s+05,c_s+1 SAY " ร Cขdigo Hospede ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ"
@ l_s+06,c_s+1 SAY " ณ            -                                     ณ"
@ l_s+07,c_s+1 SAY " ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู"
apto=0                                                       // Apto
codihosp=0                                                   // Cขdigo Hospede
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+04 GET  apto;
                    PICT "9999";
                    VALI CRIT("PTAB(STR(apto,04,00),'REGISTRO',2)~APTO no existe na tabela")
                    AJUDA "Informe o nฃmero do Apartamento"
                    CMDF8 "VDBF(6,50,20,65,'APTOS',{'apto'},1,'apto',[liberado='N'])"

   @ l_s+06 ,c_s+04 GET  codihosp;
                    PICT "9999999999";
                    VALI CRIT("V00303F9()~CขDIGO HOSPEDE no existe na tabela")
                    CMDF8 "V00302F9(apto,REGISTRO->codigo)"
                    MOSTRA {"LEFT(TRAN(V00301F9(codihosp),[]),35)", 6 , 17 }

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
   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"CONREGIS",1,.t.)
   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)
   SET RELA TO STR(tipodesp,02,00) INTO DEPARTA,;            // relacionamento dos arquivos
            TO STR(codigo,10,00) INTO REGISTRO,;
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO CONREGIS,;
            TO STR(codhosp,10,00) INTO HOSPEDES
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(datmov)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,5,11)                    // nao quis configurar...
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
      tot039013 := 0                                         // inicializa variaves de totais
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
         IF codigo=REGISTRO->codigo .And.codhosp=CONREGIS->codhosp .And.CONREGIS->ativo='S'// se atender a condicao...
            qb03901=datmov                                   // campo para agrupar 1a quebra
            st03901013 := 0                                  // inicializa sub-totais
            DO WHIL !EOF() .AND. datmov=qb03901
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF codigo=REGISTRO->codigo .And.codhosp=CONREGIS->codhosp .And.CONREGIS->ativo='S'// se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,000 SAY "ณ"
                  @ cl,001 SAY TRAN(datmov,"@D")             // Data do Movimento
                  @ cl,010 SAY "ณ"
                  @ cl,012 SAY TRAN(horamov,"@R 99:99")      // Hora do Movimento
                  @ cl,018 SAY "ณ"
                  @ cl,020 SAY If(tipomov=1,'Normal','Extra ')// Tipo de Movimento
                  @ cl,027 SAY "ณ"
                  @ cl,029 SAY DEPARTA->tipodesp             // Tipo de Despesa
                  @ cl,042 SAY "ณ"
                  @ cl,044 SAY If(tcon='N','Normal  ','Desconto')// Tipo de Operao
                  @ cl,053 SAY "ณ"
                  @ cl,057 SAY If(estorno='S','SIM','   ')   // Estorno
                  @ cl,063 SAY "ณ"
                  st03901013+=valor
                  tot039013+=valor
                  @ cl,065 SAY TRAN(valor,"999999.99")       // Valor
                  @ cl,075 SAY "ณ"
                  @ cl,077 SAY operador                      // Operador
                  @ cl,092 SAY "ณ"
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,065 SAY REPL('-',9)
            @ ++cl,065 SAY TRAN(st03901013,"999999.99")      // sub-tot Valor
            REL_CAB(1)                                       // espacejamento duplo
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,065 SAY REPL('-',9)
      @ ++cl,065 SAY TRAN(tot039013,"999999.99")             // total Valor
   ENDD ccop
END SEQUENCE
IMPCTL(drvteli)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(5)                                                     // grava variacao do relatorio
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
   @ 0,080 SAY "Pag :"
   @ 0,086 SAY TRAN(pg_,'9999')                              // nฃmero da p gina
   @ 1,029 SAY Par([empresa1])                               // Nome do Hotel
   IMPAC("R E L A €  O  D E  M O V I M E N T O S",3,028)
   @ 4,000 SAY "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ"
   @ 5,000 SAY "ณ Apartamento :"
   @ 5,016 SAY TRAN(REGISTRO->apto,"9999")                   // Apto
   @ 5,029 SAY "Pax :"
   @ 5,035 SAY TRAN(REGISTRO->pax,"99")                      // Pax
   @ 5,041 SAY "ณ Nome :"
   @ 5,050 SAY HOSPEDES->nome                                // Nome
   @ 5,092 SAY "ณ"
   @ 6,000 SAY "รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด"
   @ 7,000 SAY "ณ Movimento Normal :"
   @ 7,021 SAY If(REGISTRO->movimn='C','Conjunto  ','Individual')// Movimento Normal
   @ 7,043 SAY "Movimento Extra :"
   @ 7,061 SAY if(REGISTRO->movime='C','Conjunto  ','Individual')// Movimento Extra
   @ 7,092 SAY "ณ"
   @ 8,000 SAY "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู"
   @ 9,000 SAY "ษอออออออออหอออออออหออออออออหออออออออออออออหออออออออออหอออออออออหอออออออออออหออออออออออออออออป"
   @ 10,000 SAY "บ  Data   บ Hora  บ Tipo   บ Tipo Despesa บ Tp. Oper.บ Estorno บ  Valor    บ Operador       บ"
   @ 11,000 SAY "ศอออออออออสอออออออสออออออออสออออออออออออออสออออออออออสอออออออออสอออออออออออสออออออออออออออออผ"
   cl=qt+11 ; pg_++
ENDI
RETU

* \\ Final de MIL_R003.PRG
