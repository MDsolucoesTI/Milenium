/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: CONAGEN.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Consulta de Reserva
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas

LOCAL t_, i_, col_cp, col_ti, cr_, ord_
PARA  lin_menu,col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=8, c_s:=17, l_i:=14, c_i:=60, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79),;
      prefixo_dbf:="CON", op_sis:=EVAL(qualsis,"AGENDA")
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±±±± Consulta de Reserva ±±±±±±±±±±±"
@ l_s+03,c_s+1 SAY "      Ú Data Inicial Â Data Final ¿"
@ l_s+04,c_s+1 SAY "      ³              ³            ³"
@ l_s+05,c_s+1 SAY "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ"
dataini=CTOD('')                                             // Data Inicial
datafim=CTOD('')                                             // Data final
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+10 GET  dataini;
                    PICT "@D";
                    VALI CRIT("!EMPT(dataini)~Necess rio informar DATA INICIAL")
                    DEFAULT "DataC"
                    AJUDA "Informe a Data Incial de consulta"

   @ l_s+04 ,c_s+24 GET  datafim;
                    PICT "@D";
                    VALI CRIT("!EMPT(datafim)~Necess rio informar DATA FINAL")
                    DEFAULT "DataC"
                    AJUDA "Informe a Data final de consulta"

   READ
   SET KEY K_ALT_F8 TO
   IF rola_t
      ROLATELA(.f.)
      LOOP
   ENDI
   IF LASTKEY()=K_ESC                                        // se quer cancelar
      RETU                                                   // retorna
   ENDI
   EXIT
ENDD
op_menu=PROJECOES                                            // flag consulta e faz projecoes
SELE 0

#ifdef COM_REDE
   IF !USEARQ("AGENDA",.f.,10,1)                             // se falhou a abertura do arq
      RETU                                                   // volta ao menu anterior
   ENDI
#else
   USEARQ("AGENDA")                                          // abre o dbf e seus indices
#endi

PTAB(STR(sala,02,00),"SALAO",1,.t.)                          // abre arquivo p/ o relacionamento
SET RELA TO STR(sala,02,00) INTO SALAO                       // relacionamento dos arquivos
col_cp={;                                                    // conteudo das colunas
          "data",;
          "hora",;
          "sala",;
          "TRAN(SALAO->descricao,[])",;
          "empresa",;
          "coffee";
       }
col_ti={;                                                    // titulo das colunas
          "Data",;
          "Hora",;
          "C¢digo da Sala",;
          "Nome da Sala",;
          "Nome",;
          "Coffee Break";
       }
cr_="data>=M->dataini.and.data<=M->datafim"                  // filtro inicial
ord_="DTOS(data)"                                            // ordem inicial
GO TOP                                                       // vai p/ inicio do arquivo
cod_sos=8
EDITA(3,3,MAXROW()-2,77,.t.,col_cp,col_ti,cr_,ord_)
SELE AGENDA                                                  // salta pagina
SET RELA TO                                                  // retira os relacionamentos
CLOSE ALL                                                    // fecha todos os arquivos e
RETU                                                         // volta para o menu anterior

* \\ Final de CONAGEN.PRG
