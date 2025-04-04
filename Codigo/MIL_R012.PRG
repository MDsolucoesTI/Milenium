 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R012.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa噭o Hoteleira
 \ Funcao..: Boletim Movimento Di爎io
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=7, c_s:=19, l_i:=17, c_i:=62, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
IF nivelop < 2                                               // se usuario nao tem
   DBOX("Emiss刼 negada, "+usuario,20)                       // permissao, avisa
   RETU                                                      // e retorna
ENDI
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "北北北 Boletim de Movimento Di爎io 北北北�"
@ l_s+03,c_s+1 SAY "       � Data B.M.D. �"
@ l_s+04,c_s+1 SAY "       �             �"
@ l_s+05,c_s+1 SAY "       媚哪哪哪哪哪哪聊哪哪哪哪哪目"
@ l_s+06,c_s+1 SAY "       � De  :                  h �"
@ l_s+07,c_s+1 SAY "       �                          �"
@ l_s+08,c_s+1 SAY "       � At� :                  h �"
@ l_s+09,c_s+1 SAY "       滥哪哪哪哪哪哪哪哪哪哪哪哪馁"
tdata=CTOD('')                                               // Data
tdatai=CTOD('')                                              // Data Inicial
thorai=SPAC(4)                                               // Hora Inicial
tdataf=CTOD('')                                              // Data Final
thoraf=SPAC(4)                                               // Hora Final
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+10 GET  tdata;
                    PICT "@D";
                    VALI CRIT("VERDATA(tdata,.F.)~Necess爎io informar DATA")
                    DEFAULT "DataC"
                    AJUDA "Informe a Data do B.M.D."

   @ l_s+06 ,c_s+16 GET  tdatai;
                    PICT "@D";
                    VALI CRIT("!EMPT(tdatai)~Necess爎io informar DATA INICIAL")
                    AJUDA "Informe a Data Inicial"

   @ l_s+06 ,c_s+27 GET  thorai;
                    PICT "@R 99:99";
                    VALI CRIT("!EMPT(thorai)~Necess爎io informar HORA INICIAL")
                    AJUDA "Informe a Hora Inicial"

   @ l_s+08 ,c_s+16 GET  tdataf;
                    PICT "@D";
                    VALI CRIT("!EMPT(tdataf)~Necess爎io informar DATA FINAL")
                    AJUDA "Informe a Data Final"

   @ l_s+08 ,c_s+27 GET  thoraf;
                    PICT "@R 99:99";
                    VALI CRIT("!EMPT(thoraf)~Necess爎io informar HORA FINAL")
                    AJUDA "Informe a Hora Final"

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
      IF !USEARQ("ACUMULO",.f.,10,1)                         // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("ACUMULO")                                      // abre o dbf e seus indices
   #endi

   PTAB(STR(ACUMULO->despesa,02,00),"DEPARTA",1,.t.)         // abre arquivo p/ o relacionamento
   PTAB(DTOS(data),"BMD",1,.t.)
   SET RELA TO STR(ACUMULO->despesa,02,00) INTO DEPARTA,;    // relacionamento dos arquivos
            TO DTOS(data) INTO BMD
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="STR(despesa,02,00)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,10,11)                   // nao quis configurar...
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
maxli=40                                                     // maximo de linhas no relatorio
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
         IF BMD->data=M->tdata .And. BMD->datai=M->tdatai .And.BMD->horai=M->thorai .And.BMD->dataf=M->tdataf.And.BMD->horaf=M->thoraf// se atender a condicao...
            REL_CAB(1,.t.)                                   // soma cl/imprime cabecalho
            @ cl,002 SAY TRAN(despesa,"99")                  // Cigo da Despesa
            @ cl,004 SAY "-"
            @ cl,005 SAY DEPARTA->tipodesp                   // Tipo de Despesa
            @ cl,018 SAY "�"
            @ cl,020 SAY TRAN(dia,"@E 999,999,999,999.99")   // Aculo Di爎io
            @ cl,040 SAY "�"
            @ cl,044 SAY TRAN(pordia,"999")                  // Porc. dia
            @ cl,049 SAY "�"
            @ cl,053 SAY TRAN(pormes,"999")                  // Porc mes
            @ cl,058 SAY "�"
            @ cl,060 SAY TRAN(mes,"@E 999,999,999,999.99")   // Mes
            @ cl,079 SAY "�"
            ult_imp=RECNO()                                  // ultimo reg impresso
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
GRELA(10)                                                    // grava variacao do relatorio
SELE ACUMULO                                                 // salta pagina
SET RELA TO                                                  // retira os relacionamentos
SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
RETU

STATIC PROC REL_RDP(volta_reg)                               // rodape'
LOCAL reg_atual:=RECNO()
IF volta_reg
   GO ult_imp                                                // ajusta reg p/ imp de campos no rodape'
ENDI
@ 41,018 SAY "----------------------                  ----------------------"
@ 42,020 SAY TRAN(totaldia,"@E 999,999,999,999.99")          // Total do dia
@ 42,060 SAY TRAN(totalmes,"@E 999,999,999,999.99")          // Total no m坰
@ 43,000 SAY "谀哪哪哪哪哪哪哪哪哪哪哪履哪哪哪哪哪哪哪哪哪穆哪哪哪履哪哪穆哪哪哪哪哪哪哪哪哪目"
IMPAC("� Discrim. Prod. Fechada�      do DIA        � %DIA � %M圫 �       no M圫      �",44,000)
@ 45,000 SAY "媚哪哪哪哪哪哪哪哪哪哪哪拍哪哪哪哪哪哪哪哪哪呐哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪拇"
@ 46,000 SAY "� Em Dinheiro           �"
@ 46,026 SAY TRAN(BMD->dinheiro,"@E 999,999,999,999.99")     // Dinheiro
@ 46,045 SAY "�"
@ 46,048 SAY TRAN(BMD->pordin,"999")                         // Porc. Dinheiro por Dia
@ 46,052 SAY "�"
@ 46,055 SAY TRAN(BMD->pordinm,"999")                        // Porc. Dinheiro por m坰
@ 46,059 SAY "�"
@ 46,061 SAY TRAN(BMD->dinheirom,"@E 999,999,999,999.99")    // Dinheiro M坰
@ 46,079 SAY "�"
@ 47,000 SAY "� Em Cheque             �"
@ 47,026 SAY TRAN(BMD->cheque,"@E 999,999,999,999.99")       // Cheque
@ 47,045 SAY "�"
@ 47,048 SAY TRAN(BMD->porche,"999")                         // Porc. cheque dia
@ 47,052 SAY "�"
@ 47,055 SAY TRAN(BMD->porchem,"999")                        // Porc. Cheque por M坰
@ 47,059 SAY "�"
@ 47,061 SAY TRAN(BMD->chequem,"@E 999,999,999,999.99")      // Cheque M坰
@ 47,079 SAY "�"
IMPAC("� Em Cheque-Pr�-Datado  �",48,000)
@ 48,026 SAY TRAN(BMD->chequepre,"@E 999,999,999,999.99")    // Cheque-Pr�-Datado
@ 48,045 SAY "�"
@ 48,048 SAY TRAN(BMD->porchepre,"999")                      // Porc. Cheque-Pr� Dia
@ 48,052 SAY "�"
@ 48,055 SAY TRAN(BMD->porchepm,"999")                       // Porc. Cheque-Pr� M坰
@ 48,059 SAY "�"
@ 48,061 SAY TRAN(BMD->chequepm,"@E 999,999,999,999.99")     // Cheque-Pr�-Datado M坰
@ 48,079 SAY "�"
IMPAC("� Em Cart刼 de Cr俤ito  �",49,000)
@ 49,026 SAY TRAN(BMD->cartao,"@E 999,999,999,999.99")       // Cart刼 de Cr俤ito
@ 49,045 SAY "�"
@ 49,048 SAY TRAN(BMD->porcar,"999")                         // Porc. Cart刼 por  Dia
@ 49,052 SAY "�"
@ 49,055 SAY TRAN(BMD->porcarm,"999")                        // Porc. cart刼 m坰
@ 49,059 SAY "�"
@ 49,061 SAY TRAN(BMD->cartaom,"@E 999,999,999,999.99")      // Cart刼 M坰
@ 49,079 SAY "�"
@ 50,000 SAY "� Em R.D.A.             �"
@ 50,026 SAY TRAN(BMD->rda,"@E 999,999,999,999.99")          // R.D.A.
@ 50,045 SAY "�"
@ 50,048 SAY TRAN(BMD->porrda,"999")                         // Porc RDA por Dia
@ 50,052 SAY "�"
@ 50,055 SAY TRAN(BMD->porrdam,"999")                        // Porc RDA m坰
@ 50,059 SAY "�"
@ 50,061 SAY TRAN(BMD->rdam,"@E 999,999,999,999.99")         // R.D.A. M坰
@ 50,079 SAY "�"
IMPAC("� Em Cobran嘺           �",51,000)
@ 51,026 SAY TRAN(BMD->cobranca,"@E 999,999,999,999.99")     // Cobran嘺
@ 51,045 SAY "�"
@ 51,048 SAY TRAN(BMD->porcob,"999")                         // Porc. Cobran嘺 Dia
@ 51,052 SAY "�"
@ 51,055 SAY TRAN(BMD->porcobm,"999")                        // Porc. Cobran嘺 no m坰
@ 51,059 SAY "�"
@ 51,061 SAY TRAN(BMD->cobrancam,"@E 999,999,999,999.99")    // Cobran嘺 M坰
@ 51,079 SAY "�"
@ 52,000 SAY "� Em Permuta            �"
@ 52,026 SAY TRAN(BMD->permuta,"@E 999,999,999,999.99")      // Permuta
@ 52,045 SAY "�"
@ 52,048 SAY TRAN(BMD->porper,"999")                         // Porc. Permuta Dia
@ 52,052 SAY "�"
@ 52,055 SAY TRAN(BMD->porperm,"999")                        // Porc. Permuta no m坰
@ 52,059 SAY "�"
@ 52,061 SAY TRAN(BMD->permutam,"@E 999,999,999,999.99")     // Permuta M坰
@ 52,079 SAY "�"
IMPAC("� Em Taxa de Servi噊    �",53,000)
@ 53,032 SAY TRAN(BMD->taxas,"@E 9,999,999.99")              // Taxa de Servi噊
@ 53,045 SAY "�"
@ 53,048 SAY TRAN(BMD->portaxa,"999")                        // Porc. Taxa do Dia
@ 53,052 SAY "�"
@ 53,055 SAY TRAN(BMD->portaxam,"999")                       // Porc. taxa m坰
@ 53,059 SAY "�"
@ 53,067 SAY TRAN(BMD->taxam,"@E 9,999,999.99")              // Taxa m坰
@ 53,079 SAY "�"
@ 54,000 SAY "媚哪哪哪哪哪哪哪哪哪哪哪拍哪哪哪哪哪哪哪哪哪呐哪哪哪拍哪哪呐哪哪哪哪哪哪哪哪哪拇"
@ 55,000 SAY "� Totais                �"
@ 55,026 SAY TRAN(BMD->totalb,"@E 999,999,999,999.99")       // Total Bruto
@ 55,045 SAY "� 哪哪 � 哪哪 �"
@ 55,061 SAY TRAN(BMD->totalbm,"@E 999,999,999,999.99")      // Total bruto m坰
@ 55,079 SAY "�"
@ 56,000 SAY "滥哪哪哪哪哪哪哪哪哪哪哪聊哪哪哪哪哪哪哪哪哪牧哪哪哪聊哪哪牧哪哪哪哪哪哪哪哪哪馁"
@ 57,012 SAY "谀哪哪哪哪哪哪哪哪哪哪哪履哪哪哪哪哪哪哪哪哪哪履哪哪哪哪哪哪哪哪哪目"
IMPAC("�        no DIA         �    Di爎ia M俤ia     �   Receita M俤ia    �",58,012)
@ 59,012 SAY "媚哪哪履哪哪履哪哪履哪哪拍哪哪哪哪哪哪哪哪哪哪拍哪哪哪哪哪哪哪哪哪拇"
IMPAC("� Ent.� Sa�.� Tot.� M坰 �        no DIA       �       no DIA       �",60,012)
@ 61,000 SAY "谀哪哪哪哪哪拍哪哪拍哪哪拍哪哪拍哪哪�"
@ 61,039 SAY TRAN(BMD->diamedia,"@E 999,999,999,999.99")     // Di爎ia M俤ia Dia
@ 61,058 SAY "�"
@ 61,060 SAY TRAN(BMD->recmedia,"@E 999,999,999,999.99")     // Receita M俤ia no dia
@ 61,079 SAY "�"
@ 62,000 SAY "矨ptos Ocup.�"
@ 62,014 SAY TRAN(BMD->aptoent,"999")                        // Apto entrada
@ 62,018 SAY "�"
@ 62,020 SAY TRAN(BMD->aptosai,"999")                        // Apto Saa
@ 62,024 SAY "�"
@ 62,026 SAY TRAN(BMD->aptotot,"999")                        // Total de Apartamentos
@ 62,030 SAY "�"
@ 62,032 SAY TRAN(BMD->aptototal,"999")                      // Apto total
@ 62,036 SAY "�                     �                    �"
IMPAC("媚哪哪哪哪哪拍哪哪拍哪哪拍哪哪拍哪哪�        no M圫       �       no M圫       �",63,000)
@ 64,000 SAY "砃� Hospedes�"
@ 64,014 SAY TRAN(BMD->hospent,"999")                        // Hospedes entrada
@ 64,018 SAY "�"
@ 64,020 SAY TRAN(BMD->hospsai,"999")                        // Hospede saa
@ 64,024 SAY "�"
@ 64,026 SAY TRAN(BMD->hosptot,"999")                        // Total de Hospede
@ 64,030 SAY "�"
@ 64,032 SAY TRAN(BMD->hosptotal,"999")                      // Hospede Total
@ 64,036 SAY "�"
@ 64,039 SAY TRAN(BMD->diamediam,"@E 999,999,999,999.99")    // Di爎ia M俤ia no M坰
@ 64,058 SAY "�"
@ 64,060 SAY TRAN(BMD->recmediam,"@E 999,999,999,999.99")    // Receita M俤ia no m坰
@ 64,079 SAY "�"
@ 65,000 SAY "滥哪哪哪哪哪聊哪哪聊哪哪聊哪哪聊哪哪聊哪哪哪哪哪哪哪哪哪哪聊哪哪哪哪哪哪哪哪哪馁"
IF volta_reg
   GO reg_atual                                              // retorna reg a posicao original
ENDI
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
   @ 0,000 SAY Paramet->cidade1                              // Cidade do Hotel
   @ 0,020 SAY ","
   @ 0,022 SAY NSEM(DATE())                                  // dia da semana
   @ 0,030 SAY "-"
   @ 0,032 SAY DTOC(DATE())                                  // data do sistema
   @ 0,070 SAY "Pag :"
   @ 0,076 SAY TRAN(pg_,'9999')                              // nero da p爂ina
   @ 2,025 SAY Paramet->empresa1                             // Nome do Hotel
   IMPAC("B O L E T I M  D E  M O V I M E N T O  D I � R I O",4,019)
   @ 6,032 SAY "Data do B.M.D."
   @ 6,047 SAY TRAN(data,"@D")                               // Data
   @ 8,032 SAY "De  :"
   @ 8,038 SAY TRAN(BMD->datai,"@D")                         // Data Inicial
   @ 8,047 SAY "-"
   @ 8,049 SAY TRAN(BMD->horai,"@R 99:99")                   // Hora Inicial
   IMPAC("At� :",9,032)
   @ 9,038 SAY TRAN(BMD->dataf,"@D")                         // Data Final
   @ 9,047 SAY "-"
   @ 9,049 SAY TRAN(BMD->horaf,"@R 99:99")                   // Hora Final
   @ 11,022 SAY "谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目"
   @ 12,022 SAY "�  Saldo do Dia     :"
   @ 12,045 SAY TRAN(BMD->saldod,"@E 999,999,999,999.99")    // Saldo do Dia
   @ 12,065 SAY "�"
   @ 13,022 SAY "�  Saldo Anterior   :"
   @ 13,045 SAY TRAN(BMD->saldoa,"@E 999,999,999,999.99")    // Saldo Anterior
   @ 13,065 SAY "�"
   IMPAC("�  Produ噭o Fechada :",14,022)
   @ 14,045 SAY TRAN(BMD->proddia,"@E 999,999,999,999.99")   // Produ噭o do Dia
   @ 14,065 SAY "�"
   @ 15,022 SAY "滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁"
   @ 16,000 SAY REPL("�",80)
   @ 17,000 SAY "谀哪哪哪哪哪哪哪哪履哪哪哪哪哪哪哪哪哪哪履哪哪哪穆哪哪哪哪履哪哪哪哪哪哪哪哪哪目"
   IMPAC("�     Despesa     �       do DIA        � %  DIA � %  M圫 �    Total do M圫    �",18,000)
   @ 19,000 SAY "滥哪哪哪哪哪哪哪哪聊哪哪哪哪哪哪哪哪哪哪聊哪哪哪牧哪哪哪哪聊哪哪哪哪哪哪哪哪哪馁"
   cl=qt+19 ; pg_++
ENDI
RETU

* \\ Final de MIL_R012.PRG
