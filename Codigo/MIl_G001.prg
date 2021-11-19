 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_G001.PRG
 \ Data....: 11-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Gr fico de Frequˆncia
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}, sgr_dad:={}, arq_, arqsgr_, qt_1, ii, cod:=0
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=7, c_s:=21, l_i:=13, c_i:=64, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
arqsgr_=drvdbf+"G"+ide_maq+".003"
arq_=drvdbf+"SGR"+ide_maq+".par"                             // nome do arquivo de parametro do SGR

#ifndef COM_TUTOR
   IF FILE(arqsgr_)
      cod_sos=58
      msgt="EXISTEM ESPECIFICA€™ES|DESTE GRFICO!"
      msg="Utilizar|Recalcular"
      i=DBOX(msg,,,E_MENU,,msgt)
      IF i=1
         COPY FILE (arqsgr_) TO (arq_)
         SGRAFICO(GRAFICO)                                   // ativa o SGR atraves de interrupt
         ERASE (arq_)                                        // eclui arquivo .par do SGR
         RETU
      ENDI
   ENDI
#endi

SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±±± Gr fico de Frequˆncia ±±±±±±±±±±"
@ l_s+03,c_s+1 SAY "      Ú Data Inicial Â Data Final Ä¿"
@ l_s+04,c_s+1 SAY "      ³              ³             ³"
@ l_s+05,c_s+1 SAY "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
datai=CTOD('')                                               // Data Incial
dataf=CTOD('')                                               // Data Final
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+10 GET  datai;
                    PICT "@D";
                    VALI CRIT("!EMPT(datai)~Necess rio informar DATA INCIAL")
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
   resolucao=100
   cor_col=.t.
   titrel="GR FICO DE FREQUˆNCIA"
   criterio := ""                                            // inicializa variaveis
   cpord="STR(firmaage,04,00)"
   chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_sgr(lin_menu,col_menu,57)                      // nao quis configurar...
      CLOS ALL                                               // fecha arquivos e
      LOOP                                                   // volta ao menu
   ENDI
   EXIT
ENDD
DBOX("[ESC] Interrompe",15,,,NAO_APAGA)
dele_atu:=SET(_SET_DELETED,.t.)                              // os excluidos nao servem...
BEGIN SEQUENCE
   INI_ARQ()                                                 // acha 1o. reg valido do arquivo
   AADD(sgr_dad,{"por Firma",0})
   AADD(sgr_dad,{"por Agencia",0})
   AADD(sgr_dad,{"por Particular",0})
   DO WHIL !EOF()
      #ifdef COM_TUTOR
         IF IN_KEY()=K_ESC                                   // se quer cancelar
         #else
            IF INKEY()=K_ESC                                    // se quer cancelar
            #endi
            IF canc()                                           // pede confirmacao
               BREAK                                            // confirmou...
            ENDI
         ENDI
         IF dtsai>=M->datai.and.dtsai<=M->dataf                 // se atender a condicao...
            If cod!=Registro->firmaage
               sgr_dad[1,2]+=G00101F9(M->datai,M->dataf)           // acumula no vetor
               sgr_dad[2,2]+=G00102F9(M->datai,M->dataf)
               sgr_dad[3,2]+=G00103F9(M->datai,M->dataf)
               cod=Registro->firmaage
            EndIf
            SKIP                                                // pega proximo registro
         ELSE                                                   // se nao atende condicao
            SKIP                                                // pega proximo registro
         ENDI
      ENDD
      SET ALTE TO (arqsgr_)                                     // abre o arquivo para gravacao
      SET ALTE ON                                               // liga gravacao
      SET CONS OFF                                              // nao iremos exibir na tela
      IF EMPTY(titrel)                                          // se nao definiu um titulo
         ?? "Titulo = GR FICO DE FREQUˆNCIA"                    // pegaremos o default
      ELSE                                                      // caso contrario
         ?? "Titulo = "+titrel                                  // usaremos o titulo definido
      ENDI
      ? "Tipo = 2 "
      ? "Titulo X = "
      ? "Titulo Y = "
      ? "Porta = "+drvporta
      IF !cor_col
         ? "Pintar areas = NAO"
      ENDI
      IF !EMPTY(drvland)                                        // prn matricial nao tem resolucao
         ? "Resolucao = "+STR(resolucao)
      ENDI
      ? "Posicao do titulo = Centro"
      qt_1=LEN(sgr_dad)                                         // quantidade de colunas
      ? "Quantidade Linhas = 1"
      ? "Quantidade Colunas = "+LTRIM(STR(qt_1))
      ? "[DADOS]"
      IF qt_1>0
         ? ""
         FOR ii=1 TO qt_1                                       // grava os titulos
            ?? CHR(34)+ALLTRIM(TRAN(sgr_dad[ii,1],""))+CHR(34)+IF(ii=qt_1,"",",")
         NEXT
         ? ""
         ?? CHR(34)+CHR(34)+","
         FOR ii=1 TO qt_1
            ?? LTRIM(TRAN(sgr_dad[ii,2],""))                    // grava o dado
            IF ii!=qt_1                                         // se nao for a ultima coluna
               ?? ","                                           // grava o delimitador
            ENDI
         NEXT
      ENDI
      ? ""
      SET ALTE OFF                                              // desliga a gravacao
      SET ALTE TO                                               // fecha arquivo
      SET CONS ON                                               // reabilita o video
      COPY FILE (arqsgr_) TO (arq_)
      SGRAFICO(GRAFICO)                                         // ativa o SGR atraves de interrupt
      ERASE (arq_)                                              // eclui arquivo .par do SGR
   END SEQUENCE
   SELE REGISTRO                                                // salta pagina
   SET RELA TO                                                  // retira os relacionamentos
   SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
   RelFre=.T.
   RETU

* \\ Final de MIL_G001.PRG
