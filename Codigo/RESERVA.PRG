/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: RESERVA.PRG
 \ Data....: 28-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Gerenciador do subsistema de controle de reserva
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

PARA lin_menu,col_menu
PRIV op_sis, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
op_sis=EVAL(qualsis,"RESERVA")
IF nivelop<sistema[op_sis,O_OUTROS,O_NIVEL]                  // se usuario nao tem permissao,
   ALERTA()                                                  // entao, beep, beep, beep
   DBOX(msg_auto,,,3)                                        // lamentamos e
   RETU                                                      // retornamos ao menu
ENDI
cn:=fgrep :=.f.

#ifdef COM_LOCK
   IF LEN(pr_ok)>0                                           // se a protecao acusou
      ? pr_ok                                                // erro, avisa e
      QUIT                                                   // encerra a aplicacao
   ENDI
#endi

t_fundo=SAVESCREEN(0,0,MAXROW(),79)                          // salva tela do fundo
op_cad=1
DO WHIL op_cad!=0
   criterio=""
   sistema[op_sis,O_TELA,O_ATUAL]=1
   RESTSCREEN(,0,MAXROW(),79,t_fundo)                        // restaura tela do fundo
   cod_sos=73 ; cn=.f.
   CLEA TYPEAHEAD                                            // limpa o buffer do teclado
   fgrep=.f.
   SET KEY K_F3 TO                                           // retira das teclas F3 e F4 as
   SET KEY K_F4 TO                                           // funcoes de repeticao e confirmacao
   msg="Inclus„o|"+;                                         // menu do subsistema
       "Manuten‡„o|"+;
       "Consulta"
   op_cad=DBOX(msg,lin_menu,col_menu,E_MENU,NAO_APAGA,,,,op_cad)
   IF op_cad!=0                                              // se escolheu uma opcao
      Tela_fundo=SAVESCREEN(0,0,MAXROW(),79)                 // salva a tela para ROLATELA()
      SELE A                                                 // e abre o arquivo e seus indices

      #ifdef COM_REDE
         IF !USEARQ(sistema[op_sis,O_ARQUI],.f.,20,1)        // se falhou a abertura do
            RETU                                             // arquivo volta ao menu anterior
         ENDI
      #else
         USEARQ(sistema[op_sis,O_ARQUI])
      #endi

      SET KEY K_F9 TO veoutros                               // habilita consulta em outros arquivos
   ENDI
   DO CASE
      CASE op_cad=01                                         // inclus„o
         op_menu=INCLUSAO
         IF AT("D",exrot[op_sis])=0                          // se usuario pode fazer inclusao
            RES_INCL()                                       // neste arquivo chama prg de inclusao
         ELSE                                                // caso contrario vamos avisar que
            ALERTA()                                         // ele nao tem permissao para isto
            DBOX(msg_auto,,,3)
         ENDI

      CASE op_cad=02                                         // manuten‡„o
         op_menu=ALTERACAO
         cod_sos=7
         EDIT()

      CASE op_cad=03                                         // consulta
         op_menu=PROJECOES
         cod_sos=8
         EDITA(3,3,MAXROW()-2,77)

   ENDC
   SET KEY K_F9 TO                                           // F9 nao mais consultara outros arquivos
   CLOS ALL                                                  // fecha todos arquivos abertos
ENDD
RETU

PROC RES_incl     // inclusao no arquivo RESERVA
LOCAL getlist:={},cabem:=1,rep:=ARRAY(FCOU()),ult_reg:=RECN(),dbfseq_,;
      ctl_r, ctl_c, ctl_w, t_f3_, t_f4_, dele_atu:=SET(_SET_DELETED,.f.)
PRIV op_menu:=INCLUSAO, sq_atual_, tem_borda, criterio:="", cpord:=""
FOR i=1 TO FCOU()                                            // cria/declara privadas as
   msg=FIEL(i)                                               // variaveis de memoria com
   PRIV &msg.                                                // o mesmo nome dos campos
NEXT                                                         // do arquivo
AFILL(rep,"")
t_f3_=SETKEY(K_F3,{||rep()})                                 // repeticao reg anterior
t_f4_=SETKEY(K_F4,{||conf()})                                // confirma campos com ENTER
ctl_w=SETKEY(K_CTRL_W,{||nadafaz()})                         // enganando o CA-Clipper...
ctl_c=SETKEY(K_CTRL_C,{||nadafaz()})
ctl_r=SETKEY(K_CTRL_R,{||nadafaz()})

#ifdef COM_REDE
   RES_CRIA_SEQ()                                            // cria dbf de controle de cp sequenciais
   FOR i=1 TO FCOU()                                         // cria/declara privadas as
      msg="sq_"+FIEL(i)                                      // variaveis de memoria com
      PRIV &msg.                                             // o mesmo nome dos campos
   NEXT                                                      // do arquivo com estensao _seq
#endi

DO WHIL cabem>0
   cod_sos=6
   sistema[op_sis,O_TELA,O_ATUAL]=1                          // primeira tela...
   rola_t=.f.                                                // flag se quer rolar a tela
   SELE RESERVA
   GO BOTT                                                   // forca o
   SKIP                                                      // final do arquivo
   
   /*
      cria variaveis de memoria identicas as de arquivo, para inclusao
      de registros
   */
   FOR i=1 TO FCOU()
      msg=FIEL(i)
      M->&msg.=IF(fgrep.AND.!EMPT(rep[1]),rep[i],&msg.)
   NEXT
   DISPBEGIN()                                               // apresenta a tela de uma vez so
   IMPRELA()
   RES_TELA()
   INFOSIS()                                                 // exibe informacao no rodape' da tela
   DISPEND()
   RES_GERA_SEQ()
   cabem=DISKSPACE(IF(LEN(drvdbf)<2.OR.drvdbf="\",0,ASC(drvdbf)-64))
   cabem=INT((cabem-2048)/RESERVA->(RECSIZE()))
   IF cabem<1                                                // mais nenhum!!!
      ALERTA()
      msg="Verifique ESPA€O EM DISCO, "+usuario
      DBOX(msg,,,,,"INCLUSO INTERROMPIDA!")                 // vamos parar por aqui!
      EXIT
   ENDI
   M->operador=Usuario
   M->efetivou=[N]
   SELE 0                                                    // torna visiveis variaveis de memoria
   RES_GET1(INCLUI)                                          // recebe campos
   SELE RESERVA
   IF LASTKEY()=K_ESC                                        // se cancelou
      cabem=0
      LOOP
   ENDI

   #ifdef COM_REDE
      GO BOTT                                                // vamos bloquear o final do
      SKIP                                                   // arq para que nehum outro
      BLOREG(0,.5)                                           // usuario possa incluir
   #endi

   APPEND BLANK                                              // inclui reg em branco no dbf
   FOR i=1 TO FCOU()                                         // para cada campo,
      msg=FIEL(i)                                            // salva o conteudo
      rep[i]=M->&msg.                                        // para repetir
      REPL &msg. WITH rep[i]                                 // enche o campo do arquivo
   NEXT

   #ifdef COM_REDE
      UNLOCK                                                 // libera o registro e
      COMMIT                                                 // forca gravacao
   #else
      IF RECC()-INT(RECC()/20)*20=0                          // a cada 20 registros
         COMMIT                                              // digitados forca gravacao
      ENDI
   #endi

   ult_reg=RECN()                                            // ultimo registro digitado
   SUBNIVEL("RPES")
ENDD

#ifdef COM_REDE
   RES_ANT_SEQ()                                             // restaura sequencial anterior
   SELE RESERVA
#endi

GO ult_reg                                                   // para o ultimo reg digitado
SETKEY(K_F3,t_f3_)                                           // restaura teclas de funcoes
SETKEY(K_F4,t_f4_)
SET(_SET_DELETED,dele_atu)                                      // ecluidos visiveis/invisiveis
SETKEY(K_CTRL_W,ctl_w)
SETKEY(K_CTRL_C,ctl_c)
SETKEY(K_CTRL_R,ctl_r)
RETU


#ifdef COM_REDE
   PROC RES_ANT_SEQ(est_seq)     // restaura sequencial anterior
   SELE RES_SEQ     // seleciona arquivo de controle de sequencial
   BLOARQ(0,.5)     // esta estacao foi a ultima a incluir?
   IF sq_atual_ == codigo
      REPL codigo WITH sq_codigo
   ENDI
   UNLOCK           // libera DBF para outros usuarios
   COMMIT           // atualiza cps sequenciais no disco
   RETU
#endi


PROC RES_CRIA_SEQ   // cria dbf de controle de campos sequenciais
LOCAL dbfseq_:=drvdbf+"RES_seq"       // arq temporario
SELE 0                                // seleciona area vazia
IF !FILE(dbfseq_+".dbf")              // se o dbf nao existe
   DBCREATE(dbfseq_,{;                // vamos criar a sua estrutura
                      {"codigo"    ,"N", 10, 0};
                    };
   )
ENDI
USEARQ(dbfseq_,.f.,,,.f.)             // abre arquivo de cps sequencial
IF RECC()=0                           // se o dbf foi criado agora
   BLOARQ(0,.5)                       // inclui um registro que tera
   APPEND BLANK                       // os ultomos cps sequenciais
   SELE RESERVA
   IF RECC()>0                        // se o DBF nao estiver
      SET ORDER TO 0                  // vazio, entao enche DBF seq
      GO BOTT                         // com o ultimo reg digitado
      REPL RES_SEQ->codigo WITH codigo
      SET ORDER TO 1                  // retorna ao indice principal
   ENDI
   SELE RES_SEQ                       // seleciona arq de sequencias
   UNLOCK                             // libera DBF para outros usuarios
   COMMIT                             // atualiza cps sequenciais no disco
ENDI
RETURN

PROC RES_GERA_SEQ()

#ifdef COM_REDE
   LOCAL ar_:=SELEC()
#else
   LOCAL reg_:=RECNO(),ord_ind:=INDEXORD()
#endi


#ifdef COM_REDE
   SELE RES_SEQ
   BLOARQ(0,.5)
   sq_codigo=RES_SEQ->codigo
#else
   SET ORDER TO 0
   GO BOTT
#endi

M->codigo=codigo+1
IF M->codigo=1
   M->codigo=1
ENDI

#ifdef COM_REDE
   RES_GRAVA_SEQ()
   sq_atual_=RES_SEQ->codigo
   UNLOCK                                                    // libera o registro
   COMMIT
   SELE (ar_)
#else
   DBSETORDER(ord_ind)
   GO reg_
#endi

RETU

PROC RES_GRAVA_SEQ
REPL codigo WITH M->codigo
RETU

PROC RES_tela     // tela do arquivo RESERVA
tem_borda=.f.
l_s=Sistema[op_sis,O_TELA,O_LS]           // coordenadas da tela
c_s=Sistema[op_sis,O_TELA,O_CS]
l_i=Sistema[op_sis,O_TELA,O_LI]
c_i=Sistema[op_sis,O_TELA,O_CI]
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
IF sistema[op_sis,O_TELA,O_ATUAL]=1
   @ l_s+01,c_s+1 SAY "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± Reserva ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
   @ l_s+03,c_s+1 SAY " Ú Reserva ÄÄÄÂ Tipo Apartamento Â Categoria ÄÄÄÄÄÄÂ Apartamento ÄÂ Pax ¿"
   @ l_s+04,c_s+1 SAY " ³            ³    -             ³    -            ³              ³     ³"
   @ l_s+05,c_s+1 SAY " Ã Dt. Reservada Â Dt. Prev. Sa¡da Â H. Reservada ÂÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÙ"
   @ l_s+06,c_s+1 SAY " ³               ³                 ³              ³"
   @ l_s+07,c_s+1 SAY " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   @ l_s+08,c_s+1 SAY " Ú Tratamento ÄÂ Unidade de Reserva ÄÄÄÄÄÄÄ¿"
   @ l_s+09,c_s+1 SAY " ³   -         ³    -                      ³"
   @ l_s+10,c_s+1 SAY " Ã Observa‡„o ÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Desconto ÄÄÄÄÄÄÄÄÂ Pre‡o Especial Ä¿"
   @ l_s+11,c_s+1 SAY " ³                                     ³     %            ³                 ³"
   @ l_s+12,c_s+1 SAY " Ã  Permuta Â Forma Pagamento ÄÄÄÄÂ Cart„o ÄÄÄÄÄÄÄÄÄÄÄÂ Cortesia/Autorizou Ä´"
   @ l_s+13,c_s+1 SAY " ³          ³   -                 ³                   ³                     ³"
   @ l_s+14,c_s+1 SAY " Ã Faturamento ÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ l_s+15,c_s+1 SAY " ³ Di rias     e            ³ Somente Di ria      ³ Di rias(C.P.)-(MAP)     ³"
   @ l_s+16,c_s+1 SAY " ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   @ l_s+17,c_s+1 SAY " ³ Reservado Por :                 ³"
   @ l_s+18,c_s+1 SAY " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
ELSE
   @ l_s+01,c_s+1 SAY "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± Reserva ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
   @ l_s+03,c_s+1 SAY "      Ú Empresa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Contato ÄÄÄÄÄÄÄÄÂ Ramal Ä¿"
   @ l_s+04,c_s+1 SAY "      ³                                     ³                 ³        ³"
   @ l_s+05,c_s+1 SAY "      Ã Telefone ÄÄÄÄÄÄÄÂ Agˆncia ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´"
   @ l_s+06,c_s+1 SAY "      ³                 ³                                              ³"
   @ l_s+07,c_s+1 SAY "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   @ l_s+08,c_s+1 SAY "      Ú Bonus Â Recebido por : Â Noshow ¿"
   @ l_s+09,c_s+1 SAY "      ³       ³   -            ³        ³"
   @ l_s+10,c_s+1 SAY "      ÀÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ"
   @ l_s+11,c_s+1 SAY "      Ú Dt. Solicita‡„o Â H. Solicita‡„o Â Autoriza‡„o ÄÄÄÄ¿"
   @ l_s+12,c_s+1 SAY "      ³                 ³                ³                 ³"
   @ l_s+13,c_s+1 SAY "      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
ENDI
RETU

PROC RES_gets     // mostra variaveis do arquivo RESERVA
LOCAL getlist := {}, ctl_c, ctl_r
RES_TELA()
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
PTAB(STR(TIPO,02,00),'TIPO',1)
PTAB(STR(CATEGORIA,02,00),'CATEG',1)
PTAB(STR(APTO,04,00),'APTOS',1)
PTAB(STR(UNIDADE,02,00),'UNIDADE',1)
PTAB(STR(CARTAO,02,00),'CARTOES',1)
IF sistema[op_sis,O_TELA,O_ATUAL]=1
   @ l_s+04 ,c_s+04 GET  codigo;
                    PICT sistema[op_sis,O_CAMPO,01,O_MASC]

   @ l_s+04 ,c_s+17 GET  tipo;
                    PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,02,O_CRIT],,"1")

   @ l_s+04 ,c_s+36 GET  categoria;
                    PICT sistema[op_sis,O_CAMPO,03,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,03,O_CRIT],,"2")

   @ l_s+04 ,c_s+58 GET  apto;
                    PICT sistema[op_sis,O_CAMPO,04,O_MASC]

   @ l_s+04 ,c_s+70 GET  pax;
                    PICT sistema[op_sis,O_CAMPO,05,O_MASC]

   @ l_s+06 ,c_s+05 GET  dtreser;
                    PICT sistema[op_sis,O_CAMPO,06,O_MASC]

   @ l_s+06 ,c_s+22 GET  dtsai;
                    PICT sistema[op_sis,O_CAMPO,07,O_MASC]

   @ l_s+06 ,c_s+38 GET  hreser;
                    PICT sistema[op_sis,O_CAMPO,08,O_MASC]

   @ l_s+09 ,c_s+04 GET  trata;
                    PICT sistema[op_sis,O_CAMPO,09,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,09,O_CRIT],,"3")

   @ l_s+09 ,c_s+18 GET  unidade;
                    PICT sistema[op_sis,O_CAMPO,10,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,10,O_CRIT],,"4")

   @ l_s+11 ,c_s+04 GET  obs

   @ l_s+11 ,c_s+42 GET  descporc;
                    PICT sistema[op_sis,O_CAMPO,12,O_MASC]

   @ l_s+11 ,c_s+49 GET  descvalor;
                    PICT sistema[op_sis,O_CAMPO,13,O_MASC]

   @ l_s+11 ,c_s+61 GET  preco;
                    PICT sistema[op_sis,O_CAMPO,14,O_MASC]

   @ l_s+13 ,c_s+07 GET  permuta;
                    PICT sistema[op_sis,O_CAMPO,15,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,15,O_CRIT],,"5")

   @ l_s+13 ,c_s+15 GET  formapag;
                    PICT sistema[op_sis,O_CAMPO,16,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,16,O_CRIT],,"6")

   @ l_s+13 ,c_s+37 GET  cartao;
                    PICT sistema[op_sis,O_CAMPO,17,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,17,O_CRIT],,"14")

   @ l_s+13 ,c_s+57 GET  cortesia;
                    PICT sistema[op_sis,O_CAMPO,18,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,18,O_CRIT],,"7")

   @ l_s+13 ,c_s+62 GET  autocorte

   @ l_s+15 ,c_s+12 GET  fatdiaria;
                    PICT sistema[op_sis,O_CAMPO,20,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,20,O_CRIT],,"8")

   @ l_s+15 ,c_s+18 GET  fatdespesa

   @ l_s+15 ,c_s+47 GET  somentedia;
                    PICT sistema[op_sis,O_CAMPO,22,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,22,O_CRIT],,"9")

   @ l_s+15 ,c_s+73 GET  diariacp;
                    PICT sistema[op_sis,O_CAMPO,23,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,23,O_CRIT],,"10")

   @ l_s+17 ,c_s+20 GET  reservado

ELSE
   @ l_s+04 ,c_s+09 GET  empresa

   @ l_s+04 ,c_s+47 GET  contato

   @ l_s+04 ,c_s+65 GET  ramal;
                    PICT sistema[op_sis,O_CAMPO,27,O_MASC]

   @ l_s+06 ,c_s+09 GET  fone;
                    PICT sistema[op_sis,O_CAMPO,28,O_MASC]

   @ l_s+06 ,c_s+27 GET  agencia

   @ l_s+09 ,c_s+10 GET  bonus;
                    PICT sistema[op_sis,O_CAMPO,30,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,30,O_CRIT],,"11")

   @ l_s+09 ,c_s+17 GET  recebido;
                    PICT sistema[op_sis,O_CAMPO,31,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,31,O_CRIT],,"12")

   @ l_s+09 ,c_s+35 GET  noshow;
                    PICT sistema[op_sis,O_CAMPO,32,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,32,O_CRIT],,"13")

   @ l_s+12 ,c_s+11 GET  dtsolicit;
                    PICT sistema[op_sis,O_CAMPO,33,O_MASC]

   @ l_s+12 ,c_s+31 GET  hsolicit;
                    PICT sistema[op_sis,O_CAMPO,34,O_MASC]

   @ l_s+12 ,c_s+44 GET  autores

ENDI
CLEAR GETS
RETU

PROC RES_get1     // capta variaveis do arquivo RESERVA
LOCAL getlist := {}, ctl_c, ctl_r
PRIV  blk_reserva:=.t.
PARA tp_mov
IF tp_mov=INCLUI
   ctl_r=SETKEY(K_CTRL_R,{||tela_ant()})
   IF op_menu!=INCLUSAO
      ctl_c=SETKEY(K_CTRL_C,{||tela_seg()})
   ENDI
   DO WHILE sistema[op_sis,O_TELA,O_ATUAL]<=sistema[op_sis,O_TELA,O_DEF]
      volta=0; rola_t=.f.
      SET KEY K_ALT_F8 TO ROLATELA
      SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
      IF sistema[op_sis,O_TELA,O_ATUAL]=1
         @ l_s+04 ,c_s+04 GET codigo;
                          PICT sistema[op_sis,O_CAMPO,01,O_MASC]
         CLEA GETS
         @ l_s+04 ,c_s+17 GET  tipo;
                          PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                          DEFINICAO 2
                          MOSTRA sistema[op_sis,O_FORMULA,1]

         @ l_s+04 ,c_s+36 GET  categoria;
                          PICT sistema[op_sis,O_CAMPO,03,O_MASC]
                          DEFINICAO 3
                          MOSTRA sistema[op_sis,O_FORMULA,2]

         @ l_s+04 ,c_s+58 GET  apto;
                          PICT sistema[op_sis,O_CAMPO,04,O_MASC]
                          DEFINICAO 4

         @ l_s+04 ,c_s+70 GET  pax;
                          PICT sistema[op_sis,O_CAMPO,05,O_MASC]
                          DEFINICAO 5

         @ l_s+06 ,c_s+05 GET  dtreser;
                          PICT sistema[op_sis,O_CAMPO,06,O_MASC]
                          DEFINICAO 6

         @ l_s+06 ,c_s+22 GET  dtsai;
                          PICT sistema[op_sis,O_CAMPO,07,O_MASC]
                          DEFINICAO 7

         @ l_s+06 ,c_s+38 GET  hreser;
                          PICT sistema[op_sis,O_CAMPO,08,O_MASC]
                          DEFINICAO 8

         @ l_s+09 ,c_s+04 GET  trata;
                          PICT sistema[op_sis,O_CAMPO,09,O_MASC]
                          DEFINICAO 9
                          MOSTRA sistema[op_sis,O_FORMULA,3]

         @ l_s+09 ,c_s+18 GET  unidade;
                          PICT sistema[op_sis,O_CAMPO,10,O_MASC]
                          DEFINICAO 10
                          MOSTRA sistema[op_sis,O_FORMULA,4]

         @ l_s+11 ,c_s+04 GET  obs
                          DEFINICAO 11

         @ l_s+11 ,c_s+42 GET  descporc;
                          PICT sistema[op_sis,O_CAMPO,12,O_MASC]
                          DEFINICAO 12

         @ l_s+11 ,c_s+49 GET  descvalor;
                          PICT sistema[op_sis,O_CAMPO,13,O_MASC]
                          DEFINICAO 13

         @ l_s+11 ,c_s+61 GET  preco;
                          PICT sistema[op_sis,O_CAMPO,14,O_MASC]
                          DEFINICAO 14

         @ l_s+13 ,c_s+07 GET  permuta;
                          PICT sistema[op_sis,O_CAMPO,15,O_MASC]
                          DEFINICAO 15
                          MOSTRA sistema[op_sis,O_FORMULA,5]

         @ l_s+13 ,c_s+15 GET  formapag;
                          PICT sistema[op_sis,O_CAMPO,16,O_MASC]
                          DEFINICAO 16
                          MOSTRA sistema[op_sis,O_FORMULA,6]

         @ l_s+13 ,c_s+37 GET  cartao;
                          PICT sistema[op_sis,O_CAMPO,17,O_MASC]
                          DEFINICAO 17
                          MOSTRA sistema[op_sis,O_FORMULA,14]

         @ l_s+13 ,c_s+57 GET  cortesia;
                          PICT sistema[op_sis,O_CAMPO,18,O_MASC]
                          DEFINICAO 18
                          MOSTRA sistema[op_sis,O_FORMULA,7]

         @ l_s+13 ,c_s+62 GET  autocorte
                          DEFINICAO 19

         @ l_s+15 ,c_s+12 GET  fatdiaria;
                          PICT sistema[op_sis,O_CAMPO,20,O_MASC]
                          DEFINICAO 20
                          MOSTRA sistema[op_sis,O_FORMULA,8]

         @ l_s+15 ,c_s+18 GET  fatdespesa
                          DEFINICAO 21

         @ l_s+15 ,c_s+47 GET  somentedia;
                          PICT sistema[op_sis,O_CAMPO,22,O_MASC]
                          DEFINICAO 22
                          MOSTRA sistema[op_sis,O_FORMULA,9]

         @ l_s+15 ,c_s+73 GET  diariacp;
                          PICT sistema[op_sis,O_CAMPO,23,O_MASC]
                          DEFINICAO 23
                          MOSTRA sistema[op_sis,O_FORMULA,10]

         @ l_s+17 ,c_s+20 GET  reservado
                          DEFINICAO 24

      ELSE
         @ l_s+04 ,c_s+09 GET  empresa
                          DEFINICAO 25

         @ l_s+04 ,c_s+47 GET  contato
                          DEFINICAO 26

         @ l_s+04 ,c_s+65 GET  ramal;
                          PICT sistema[op_sis,O_CAMPO,27,O_MASC]
                          DEFINICAO 27

         @ l_s+06 ,c_s+09 GET  fone;
                          PICT sistema[op_sis,O_CAMPO,28,O_MASC]
                          DEFINICAO 28

         @ l_s+06 ,c_s+27 GET  agencia
                          DEFINICAO 29

         @ l_s+09 ,c_s+10 GET  bonus;
                          PICT sistema[op_sis,O_CAMPO,30,O_MASC]
                          DEFINICAO 30
                          MOSTRA sistema[op_sis,O_FORMULA,11]

         @ l_s+09 ,c_s+17 GET  recebido;
                          PICT sistema[op_sis,O_CAMPO,31,O_MASC]
                          DEFINICAO 31
                          MOSTRA sistema[op_sis,O_FORMULA,12]

         @ l_s+09 ,c_s+35 GET  noshow;
                          PICT sistema[op_sis,O_CAMPO,32,O_MASC]
                          DEFINICAO 32
                          MOSTRA sistema[op_sis,O_FORMULA,13]

         @ l_s+12 ,c_s+11 GET  dtsolicit;
                          PICT sistema[op_sis,O_CAMPO,33,O_MASC]
                          DEFINICAO 33

         @ l_s+12 ,c_s+31 GET  hsolicit;
                          PICT sistema[op_sis,O_CAMPO,34,O_MASC]
                          DEFINICAO 34

         @ l_s+12 ,c_s+44 GET  autores
                          DEFINICAO 36

      ENDI
      READ
      SET KEY K_ALT_F8 TO
      IF rola_t
         ROLATELA()
         LOOP
      ENDI
      IF LASTKEY()!=K_ESC .AND. drvincl .AND. op_menu=INCLUSAO
         IF !CONFINCL()
            LOOP
         ENDI
      ENDI
      IF volta=0 .AND. LASTKEY()=K_ESC
         EXIT
      ENDI
      sistema[op_sis,O_TELA,O_ATUAL]++
      IF sistema[op_sis,O_TELA,O_ATUAL]<=sistema[op_sis,O_TELA,O_DEF]
         RES_TELA()
         IF op_menu=ALTERACAO .OR. volta=1
            RES_GETS()
         ENDI
         INFOSIS()
      ELSE
         sistema[op_sis,O_TELA,O_ATUAL]=sistema[op_sis,O_TELA,O_DEF]
         EXIT
      ENDI
   ENDD
   SETKEY(K_CTRL_R,ctl_r)
   IF op_menu!=INCLUSAO
      SETKEY(K_CTRL_C,ctl_c)
   ENDI
ENDI
PTAB(STR(TIPO,02,00),'TIPO',1)
PTAB(STR(CATEGORIA,02,00),'CATEG',1)
PTAB(STR(APTO,04,00),'APTOS',1)
PTAB(STR(UNIDADE,02,00),'UNIDADE',1)
PTAB(STR(CARTAO,02,00),'CARTOES',1)
IF tp_mov=EXCLUI .OR. tp_mov=FORM_INVERSA

   #ifdef COM_REDE
      REPBLO('APTOS->liberado',{||RES_02F9()})
   #else
      REPL APTOS->liberado WITH RES_02F9()
   #endi

   MANUREF(STR(TIPO,02,00),'TIPO',1,DECREMENTA)
   MANUREF(STR(CATEGORIA,02,00),'CATEG',1,DECREMENTA)
   MANUREF(STR(APTO,04,00),'APTOS',1,DECREMENTA)
   MANUREF(STR(UNIDADE,02,00),'UNIDADE',1,DECREMENTA)
   MANUREF(STR(CARTAO,02,00),'CARTOES',1,DECREMENTA)
   INTREF(FORM_INVERSA)
   DELE
ELSEIF tp_mov=INCLUI .OR. tp_mov=RECUPERA .OR. tp_mov=FORM_DIRETA
   IF (op_menu=INCLUSAO .AND. LASTKEY()!=K_ESC) .OR. op_menu!=INCLUSAO
      IF tp_mov=RECUPERA .AND. op_menu!=INCLUSAO .AND. (TIPO->(DELE()) .OR. CATEG->(DELE()) .OR. APTOS->(DELE()) .OR. UNIDADE->(DELE()) .OR. CARTOES->(DELE()))
         msg=""
         IF TIPO->(DELE())
            msg="|"+sistema[EVAL(qualsis,"TIPO"),O_MENU]
         ENDI
         IF CATEG->(DELE())
            msg+="|"+sistema[EVAL(qualsis,"CATEG"),O_MENU]
         ENDI
         IF APTOS->(DELE())
            msg+="|"+sistema[EVAL(qualsis,"APTOS"),O_MENU]
         ENDI
         IF UNIDADE->(DELE())
            msg+="|"+sistema[EVAL(qualsis,"UNIDADE"),O_MENU]
         ENDI
         IF CARTOES->(DELE())
            msg+="|"+sistema[EVAL(qualsis,"CARTOES"),O_MENU]
         ENDI
         ALERTA(2)
         DBOX("Registro exclu¡do em:"+msg+"|*",,,,,"IMPOSS¡VEL RECUPERAR!")
      ELSE

         #ifdef COM_REDE
            REPBLO('APTOS->liberado',{||RES_01F9()})
         #else
            REPL APTOS->liberado WITH RES_01F9()
         #endi

         MANUREF(STR(TIPO,02,00),'TIPO',1,INCREMENTA)
         MANUREF(STR(CATEGORIA,02,00),'CATEG',1,INCREMENTA)
         MANUREF(STR(APTO,04,00),'APTOS',1,INCREMENTA)
         MANUREF(STR(UNIDADE,02,00),'UNIDADE',1,INCREMENTA)
         MANUREF(STR(CARTAO,02,00),'CARTOES',1,INCREMENTA)
         IF op_menu!=INCLUSAO
            RECA
            INTREF(FORM_DIRETA)
         ENDI
      ENDI
   ENDI
ENDI
RETU

PROC RPE_incl     // inclusao no arquivo RPES
LOCAL getlist:={},cabem:=1,rep:=ARRAY(FCOU()),ult_reg:=RECN(),cond_incl_,dbfseq_,;
      ctl_r, ctl_c, ctl_w, t_f3_, t_f4_, dele_atu:=SET(_SET_DELETED,.f.)
cond_incl_={||numero<RESERVA->pax}                           // condicao de inclusao de registros
IF !EVAL(cond_incl_)                                         // se nao pode incluir
   RETU                                                      // e retorna
ENDI
PRIV op_menu:=INCLUSAO, sq_atual_, op_sis, l_s, c_s, l_i, c_i, cod_sos, chv_rela, chv_1, chv_2, tem_borda, criterio:="", cpord:=""
op_sis=EVAL(qualsis,"RPES")
IF AT("D",exrot[op_sis])>0
   RETU
ENDI
chv_rela=""
FOR i=1 TO LEN(sistema[op_sis,O_CPRELA])
   chv_rela+="+"+TRANSCAMPO(.f.,sistema[op_sis,O_CPRELA,i],i)
NEXT
chv_rela=IF(LEN(chv_rela)>2,SUBS(chv_rela,2),"")
PEGACHV2()
FOR i=1 TO FCOU()                                            // cria/declara privadas as
   msg=FIEL(i)                                               // variaveis de memoria com
   PRIV &msg.                                                // o mesmo nome dos campos
NEXT                                                         // do arquivo
AFILL(rep,"")
t_f3_=SETKEY(K_F3,{||rep()})                                 // repeticao reg anterior
t_f4_=SETKEY(K_F4,{||conf()})                                // confirma campos com ENTER
ctl_w=SETKEY(K_CTRL_W,{||nadafaz()})                         // enganando o CA-Clipper...
ctl_c=SETKEY(K_CTRL_C,{||nadafaz()})
ctl_r=SETKEY(K_CTRL_R,{||nadafaz()})

#ifdef COM_REDE
   RPE_CRIA_SEQ()                                            // cria dbf de controle de cp sequenciais
   FOR i=1 TO FCOU()                                         // cria/declara privadas as
      msg="sq_"+FIEL(i)                                      // variaveis de memoria com
      PRIV &msg.                                             // o mesmo nome dos campos
   NEXT                                                      // do arquivo com estensao _seq
#endi

DO WHIL cabem>0
   cod_sos=6
   sistema[op_sis,O_TELA,O_ATUAL]=1                          // primeira tela...
   rola_t=.f.                                                // flag se quer rolar a tela
   SELE RPES
   GO BOTT                                                   // forca o
   SKIP                                                      // final do arquivo
   
   /*
      cria variaveis de memoria identicas as de arquivo, para inclusao
      de registros
   */
   FOR i=1 TO FCOU()
      msg=FIEL(i)
      M->&msg.=IF(fgrep.AND.!EMPT(rep[1]),rep[i],&msg.)
   NEXT
   
   /*
      inicializa campos de relacionamentos do com os campos do arquivo
      superior (pai)
   */
   FOR i=1 TO LEN(sistema[op_sis,O_CPRELA])
      msg=FIEL(VAL(SUBS(sistema[op_sis,O_ORDEM,1],i*2-1,2)))
      M->&msg.=&(sistema[op_sis,O_CPRELA,i])
   NEXT
   DISPBEGIN()                                               // apresenta a tela de uma vez so
   RPE_TELA()
   INFOSIS()                                                 // exibe informacao no rodape' da tela
   DISPEND()
   RPE_GERA_SEQ()
   IF !EVAL(cond_incl_)
      EXIT
   ENDI
   cabem=DISKSPACE(IF(LEN(drvdbf)<2.OR.drvdbf="\",0,ASC(drvdbf)-64))
   cabem=INT((cabem-2048)/RPES->(RECSIZE()))
   IF cabem<1                                                // mais nenhum!!!
      ALERTA()
      msg="Verifique ESPA€O EM DISCO, "+usuario
      DBOX(msg,,,,,"INCLUSO INTERROMPIDA!")                 // vamos parar por aqui!
      EXIT
   ENDI
   SELE 0                                                    // torna visiveis variaveis de memoria
   RPE_GET1(INCLUI)                                          // recebe campos
   SELE RPES
   IF LASTKEY()=K_ESC                                        // se cancelou
      cabem=0
      LOOP
   ENDI

   #ifdef COM_REDE
      GO BOTT                                                // vamos bloquear o final do
      SKIP                                                   // arq para que nehum outro
      BLOREG(0,.5)                                           // usuario possa incluir
   #endi

   APPEND BLANK                                              // inclui reg em branco no dbf
   FOR i=1 TO FCOU()                                         // para cada campo,
      msg=FIEL(i)                                            // salva o conteudo
      rep[i]=M->&msg.                                        // para repetir
      REPL &msg. WITH rep[i]                                 // enche o campo do arquivo
   NEXT

   #ifdef COM_REDE
      UNLOCK                                                 // libera o registro e
      COMMIT                                                 // forca gravacao
   #else
      IF RECC()-INT(RECC()/20)*20=0                          // a cada 20 registros
         COMMIT                                              // digitados forca gravacao
      ENDI
   #endi

   ult_reg=RECN()                                            // ultimo registro digitado
ENDD

#ifdef COM_REDE
   RPE_ANT_SEQ()                                             // restaura sequencial anterior
   SELE RPES
#endi

GO ult_reg                                                   // para o ultimo reg digitado
SETKEY(K_F3,t_f3_)                                           // restaura teclas de funcoes
SETKEY(K_F4,t_f4_)
SET(_SET_DELETED,dele_atu)                                      // ecluidos visiveis/invisiveis
SETKEY(K_CTRL_W,ctl_w)
SETKEY(K_CTRL_C,ctl_c)
SETKEY(K_CTRL_R,ctl_r)
RETU


#ifdef COM_REDE
   PROC RPE_ANT_SEQ(est_seq)     // restaura sequencial anterior
   SELE RPE_SEQ     // seleciona arquivo de controle de sequencial
   BLOARQ(0,.5)     // esta estacao foi a ultima a incluir?
   IF sq_atual_ == numero
      REPL numero WITH sq_numero
   ENDI
   UNLOCK           // libera DBF para outros usuarios
   COMMIT           // atualiza cps sequenciais no disco
   RETU
#endi


PROC RPE_CRIA_SEQ   // cria dbf de controle de campos sequenciais
LOCAL dbfseq_:=drvdbf+"RPE_seq"       // arq temporario
SELE 0                                // seleciona area vazia
IF !FILE(dbfseq_+".dbf")              // se o dbf nao existe
   DBCREATE(dbfseq_,{;                // vamos criar a sua estrutura
                      {"numero"    ,"N",  2, 0};
                    };
   )
ENDI
USEARQ(dbfseq_,.f.,,,.f.)             // abre arquivo de cps sequencial
IF RECC()=0                           // se o dbf foi criado agora
   BLOARQ(0,.5)                       // inclui um registro que tera
   APPEND BLANK                       // os ultomos cps sequenciais
   SELE RPES
   IF RECC()>0                        // se o DBF nao estiver
      SET ORDER TO 0                  // vazio, entao enche DBF seq
      GO BOTT                         // com o ultimo reg digitado
      REPL RPE_SEQ->numero WITH numero
      SET ORDER TO 1                  // retorna ao indice principal
   ENDI
   SELE RPE_SEQ                       // seleciona arq de sequencias
   UNLOCK                             // libera DBF para outros usuarios
   COMMIT                             // atualiza cps sequenciais no disco
ENDI
RETURN

PROC RPE_GERA_SEQ()

#ifdef COM_REDE
   LOCAL ar_:=SELEC()
#else
   LOCAL reg_:=RECNO(),ord_ind:=INDEXORD()
#endi

FIM_ARQ()
M->numero=numero+1
IF M->numero=1
   M->numero=1
ENDI
RETU

PROC RPE_GRAVA_SEQ
REPL numero WITH M->numero
RETU

PROC RPE_tela     // tela do arquivo RPES
tem_borda=.f.
l_s=Sistema[op_sis,O_TELA,O_LS]           // coordenadas da tela
c_s=Sistema[op_sis,O_TELA,O_CS]
l_i=Sistema[op_sis,O_TELA,O_LI]
c_i=Sistema[op_sis,O_TELA,O_CI]
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±±±±±±±±±±±±±±±±± Reserva - Hospedes ±±±±±±±±±±±±±±±±±±±±±±±±"
@ l_s+03,c_s+1 SAY " Ú N£mero Â Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Identidade ÄÄÄÄ¿"
@ l_s+04,c_s+1 SAY " ³        ³                                     ³                ³"
@ l_s+05,c_s+1 SAY " ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
RETU

PROC RPE_gets     // mostra variaveis do arquivo RPES
LOCAL getlist := {}
RPE_TELA()
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
@ l_s+04 ,c_s+06 GET  numero;
                 PICT sistema[op_sis,O_CAMPO,02,O_MASC]

@ l_s+04 ,c_s+13 GET  nome

@ l_s+04 ,c_s+51 GET  rg

CLEAR GETS
RETU

PROC RPE_get1     // capta variaveis do arquivo RPES
LOCAL getlist := {}
PRIV  blk_rpes:=.t.
PARA tp_mov, excl_rela
excl_rela=IF(excl_rela=NIL,.f.,excl_rela)
IF tp_mov=INCLUI
   DO WHILE .t.
      rola_t=.f.
      SET KEY K_ALT_F8 TO ROLATELA
      SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
      @ l_s+04 ,c_s+06 GET  numero;
                       PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                       DEFINICAO 2

      @ l_s+04 ,c_s+13 GET  nome
                       DEFINICAO 3

      @ l_s+04 ,c_s+51 GET  rg
                       DEFINICAO 4

      READ
      SET KEY K_ALT_F8 TO
      IF rola_t
         ROLATELA()
         LOOP
      ENDI
      IF LASTKEY()!=K_ESC .AND. drvincl .AND. op_menu=INCLUSAO
         IF !CONFINCL()
            LOOP
         ENDI
      ENDI
      EXIT
   ENDD
ENDI
IF tp_mov=EXCLUI .OR. tp_mov=FORM_INVERSA

   #ifdef COM_REDE
      IF !excl_rela
         REPL flag_excl WITH '*'
      ENDI
   #else
      IF !excl_rela
         REPL flag_excl WITH '*'
      ENDI
   #endi

   DELE
ELSEIF tp_mov=INCLUI .OR. tp_mov=RECUPERA .OR. tp_mov=FORM_DIRETA
   IF (op_menu=INCLUSAO .AND. LASTKEY()!=K_ESC) .OR. op_menu!=INCLUSAO
      IF tp_mov=RECUPERA .AND. op_menu!=INCLUSAO .AND. (RESERVA->(DELE()))
         msg="|"+sistema[EVAL(qualsis,"RESERVA"),O_MENU]
         ALERTA(2)
         DBOX("Registro exclu¡do em:"+msg+"|*",,,,,"IMPOSS¡VEL RECUPERAR!")
      ELSE
            IF !excl_rela
               IF op_menu=INCLUSAO
                  flag_excl=' '
               ELSE
                  REPL flag_excl WITH ' '
               ENDI
            ENDI
         IF op_menu!=INCLUSAO
            RECA
         ENDI
      ENDI
   ENDI
ENDI
RETU

* \\ Final de RESERVA.PRG
