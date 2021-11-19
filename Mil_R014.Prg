/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_R014.PRG
 \ Data....: 10-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Relat¢rio de Frequˆncia
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}, cod:=0
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=7, c_s:=21, l_i:=13, c_i:=64, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±± Relat¢rio de Frequˆncia ±±±±±±±±±"
@ l_s+03,c_s+1 SAY "      Ú Data Inicial Â Data Final Ä¿"
@ l_s+04,c_s+1 SAY "      ³              ³             ³"
@ l_s+05,c_s+1 SAY "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
datai=CTOD('')                                               // Data inicial
dataf=CTOD('')                                               // Data Final
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+10 GET  datai;
                    PICT "@D";
                    VALI CRIT("!EMPT(datai)~Necess rio informar DATA INICIAL")
   DEFAULT "DataC"
   AJUDA "Informe a Data Inicial"

   @ l_s+04 ,c_s+24 GET  dataf;
                    PICT "@D";
                    VALI CRIT("!EMPT(dataf)~Necess rio informar DATA FINAL")
   DEFAULT "DataC"
   AJUDA "Informe a Data Final"

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
      IF !USEARQ("REGISTRO",.f.,10,1)                        // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("REGISTRO")                                     // abre o dbf e seus indices
   #endi

   PTAB(STR(firmaage,04,00),"CLIENTES",2,.t.)                // abre arquivo p/ o relacionamento
   SET RELA TO STR(firmaage,04,00) INTO CLIENTES             // relacionamento dos arquivos
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="STR(firmaage,04,00)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,2,11)                    // nao quis configurar...
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
maxli=57                                                     // maximo de linhas no relatorio
BEGIN SEQUENCE
   DO WHIL ccop<=nucop                                       // imprime qde copias pedida
      pg_=1; cl=999
      INI_ARQ()                                              // acha 1o. reg valido do arquivo
      ccop++                                                 // incrementa contador de copias
      ult_imp=0                                              // ultimo reg impresso
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
            IF dtsai>=M->datai.and.dtsai<=M->dataf              // se atender a condicao...
               If cod!=Registro->Firmaage
                  REL_CAB(1,.t.)                                   // soma cl/imprime cabecalho
                  @ cl,000 SAY "³"
                  @ cl,002 SAY TRAN(firmaage,"9999")               // Firma/Agente
                  @ cl,008 SAY "³"
                  @ cl,010 SAY CLIENTES->nome                      // Nome
                  @ cl,046 SAY "³"
                  @ cl,048 SAY CLIENTES->cidade                    // Cidade
                  @ cl,068 SAY "/"
                  @ cl,069 SAY TRAN(CLIENTES->uf,"@!")             // UF
                  @ cl,072 SAY "³"
                  @ cl,074 SAY TRAN(R01401F9(M->datai,M->dataf,firmaage),"9999")// Quantidade Firma
                  @ cl,079 SAY "³"
                  ult_imp=RECNO()                                  // ultimo reg impresso
                  cod=Registro->Firmaage
               endIf
               SKIP                                             // pega proximo registro
            ELSE                                                // se nao atende condicao
               SKIP                                             // pega proximo registro
            ENDI
         ENDD
         REL_RDP(.t.)                                           // imprime rodape' do relatorio
      ENDD ccop
   END SEQUENCE
   SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
   SET DEVI TO SCRE                                             // direciona saida p/ video
   IF tps=2                                                     // se vai para arquivo/video
      BROWSE_REL(arq_,2,3,MAXROW()-2,78)
   ENDI                                                         // mostra o arquivo gravado
   GRELA(2)                                                     // grava variacao do relatorio
   SELE REGISTRO                                                // salta pagina
   SET RELA TO                                                  // retira os relacionamentos
   SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
   RETU

   STATIC PROC REL_RDP(volta_reg)                               // rodape'
   LOCAL reg_atual:=RECNO()
   IF volta_reg
      GO ult_imp                                                // ajusta reg p/ imp de campos no rodape'
   ENDI
   @ 58,026 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @ 59,026 SAY "³   Firma    ³  Agencia  ³  Particular ³"
   @ 60,012 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 61,012 SAY "³ Quantidade  ³"
   firma=R01403F9(M->datai,M->dataf)                            // variavel temporaria
   @ 61,031 SAY TRAN(firma,"9999")                              // Quantidade por Firma
   @ 61,039 SAY "³"
   agencia=R01402F9(M->datai,M->dataf)                          // variavel temporaria
   @ 61,044 SAY TRAN(agencia,"9999")                            // Quantidade por Agencia
   @ 61,051 SAY "³"
   particular=R01404F9(M->datai,M->dataf)                       // variavel temporaria
   @ 61,056 SAY TRAN(particular,"9999")                         // Quantidade por particular
   @ 61,065 SAY "³"
   @ 62,012 SAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 63,012 SAY "³ Porcentagem ³"
   @ 63,031 SAY TRAN(R01406F9(),"99")                           // Porcentagem por Firma
   @ 63,034 SAY "%    ³"
   @ 63,044 SAY TRAN(R01405F9(),"99")                           // Porcentagem por agencia
   @ 63,047 SAY "%   ³"
   @ 63,056 SAY TRAN(R01407F9(),"99")                           // Porcentagem por Particula
   @ 63,059 SAY "%     ³"
   @ 64,012 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   IF volta_reg
      GO reg_atual                                              // retorna reg a posicao original
   ENDI
   RelFre=.T.
   RETU

   STATIC PROC REL_CAB(qt, volta_reg)                           // cabecalho do relatorio
   volta_reg=IF(volta_reg=NIL,.f.,volta_reg)
   IF qt>0                                                      // se parametro maior que 0
      cl=cl+qt                                                  // soma no contador de linhas
   ENDI
   IF cl>maxli .OR. qt=0                                        // quebra de pagina
      IF pg_>1
         REL_RDP(volta_reg)                                     // imprime rodape' do relatorio
      ENDI
      IMPAC("RELAT¢RIO DE FREQUˆNCIA               Pag.",0,033)
      @ 0,076 SAY TRAN(pg_,'9999')                              // n£mero da p gina
      @ 2,031 SAY "Ú Data Inicial Â Data Final Ä¿"
      @ 3,031 SAY "³"
      @ 3,034 SAY TRAN(M->datai,"@D")                           // Data inicial
      @ 3,046 SAY "³"
      @ 3,048 SAY TRAN(M->dataf,"@D")                           // Data Final
      @ 3,060 SAY "³"
      @ 4,031 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
      @ 5,000 SAY "ÚÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄ¿"
      IMPAC("³C¢digo ³               Firma                 ³       Cidade/UF         ³Quant.³",6,000)
      @ 7,000 SAY "ÃÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄ´"
      cl=qt+7 ; pg_++
   ENDI
   RETU

* \\ Final de MIL_R014.PRG
