/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: CLIENTES.PRG
 \ Data....: 15-08-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: Gerenciador do subsistema de firmas/agentes (Clientes)
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

PARA lin_menu,col_menu
PRIV op_sis, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
op_sis=EVAL(qualsis,"CLIENTES")
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
   RESTSCREEN(,0,MAXROW(),79,t_fundo)                        // restaura tela do fundo
   cod_sos=5 ; cn=.f.
   CLEA TYPEAHEAD                                            // limpa o buffer do teclado
   fgrep=.f.
   SET KEY K_F3 TO                                           // retira das teclas F3 e F4 as
   SET KEY K_F4 TO                                           // funcoes de repeticao e confirmacao
   msg="Inclus�o|"+;
       "Manuten��o|"+;
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
      CASE op_cad=01                                         // inclus�o
         op_menu=INCLUSAO
         IF AT("D",exrot[op_sis])=0                          // se usuario pode fazer inclusao
            CLI_INCL()                                       // neste arquivo chama prg de inclusao
         ELSE                                                // caso contrario vamos avisar que
            ALERTA()                                         // ele nao tem permissao para isto
            DBOX(msg_auto,,,3)
         ENDI

      CASE op_cad=02                                         // manuten��o
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

PROC CLI_incl     // inclusao no arquivo CLIENTES
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
   CLI_CRIA_SEQ()                                            // cria dbf de controle de cp sequenciais
   FOR i=1 TO FCOU()                                         // cria/declara privadas as
      msg="sq_"+FIEL(i)                                      // variaveis de memoria com
      PRIV &msg.                                             // o mesmo nome dos campos
   NEXT                                                      // do arquivo com estensao _seq
#endi

DO WHIL cabem>0
   cod_sos=6
   rola_t=.f.                                                // flag se quer rolar a tela
   SELE CLIENTES
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
   CLI_TELA()
   INFOSIS()                                                 // exibe informacao no rodape' da tela
   DISPEND()
   CLI_GERA_SEQ()
   cabem=DISKSPACE(IF(LEN(drvdbf)<2.OR.drvdbf="\",0,ASC(drvdbf)-64))
   cabem=INT((cabem-2048)/CLIENTES->(RECSIZE()))
   IF cabem<1                                                // mais nenhum!!!
      ALERTA()
      msg="Verifique ESPA�O EM DISCO, "+usuario
      DBOX(msg,,,,,"INCLUS�O INTERROMPIDA!")                 // vamos parar por aqui!
      EXIT
   ENDI
   SELE 0                                                    // torna visiveis variaveis de memoria
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   SET KEY K_ALT_F8 TO ROLATELA
   
   /*
      recebe chaves do arquivo de indice basico
   */
   @ l_s+04 ,c_s+13 GET  cgc;
                    PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                    DEFINICAO 2

   READ
   SET KEY K_ALT_F8 TO
   IF rola_t
      ROLATELA()

      #ifdef COM_REDE
         CLI_ANT_SEQ()                                       // decrementa sequencial
      #endi

      LOOP
   ENDI
   SELE CLIENTES
   IF LASTKEY()=K_ESC                                        // cancelou ou chave em branco
      cabem=0                                                // prepara saida da inclusao
      LOOP                                                   // volta p/ menu de cadastramento
   ENDI
   SEEK M->cgc
   aprov_reg_=(FOUND().AND.DELE().AND.!drvvisivel)           // vai aproveitar o registro?
   IF FOUND() .AND. !aprov_reg_                              // pesquisou e achou!
      op_menu=ALTERACAO                                      // seta flag de ateracao

      #ifdef COM_REDE
         CLI_ANT_SEQ()                                       // decrementa sequencial
         SELE CLIENTES
      #endi

      DISPBEGIN()
      CLI_GETS()                                             // mostra conteudo do registro
      INFOSIS()                                              // exibe informacao no rodape' da tela
      DISPEND()
      ALERTA()
      msg="Consultar/alterar|Retornar � inclus�o"            // pergunta se deseja
      op_=DBOX(msg,,,E_MENU,,"REGISTRO J� EXISTE")           // alterar o registro
      IF op_ =1                                              // caso afirmativo
         EDIT()                                              // deixa alterar
      ENDI
      op_menu=INCLUSAO
      LOOP                                                   // volta para inclusao
   ENDI
   SELE 0
   CLI_GET1(INCLUI)                                          // recebe campos
   SELE CLIENTES
   IF LASTKEY()=K_ESC                                        // se cancelou

      #ifdef COM_REDE
         CLI_ANT_SEQ()                                       // decrementa sequencial
      #endi

      ALERTA()                                               // avisa que o registro
      DBOX("Registro n�o inclu�do!",18,,1)                   // nao foi incluido, e volta
      LOOP
   ENDI

   #ifdef COM_REDE
      GO BOTT                                                // vamos bloquear o final do
      SKIP                                                   // arq para que nehum outro
      BLOREG(0,.5)                                           // usuario possa incluir
      SEEK M->cgc                                            // se registro foi incluido
      aprov_reg_=(FOUND().AND.DELE().AND.!drvvisivel)        // vai aproveitar o registro?
      IF FOUND() .AND. !aprov_reg_                           // por outro usuario, entao
         BLOREG(0,.5)
         FOR i=1 TO FCOU()
            msg=FIEL(i)
            rep[i]=&msg.
            REPL &msg. WITH M->&msg.
         NEXT
         CLI_GET1(FORM_INVERSA)                              // executa formula inversa
         RECA
         FOR i=1 TO FCOU()
            msg=FIEL(i)
            REPL &msg. WITH rep[i]
         NEXT
         ALERTA(4)                                           // beep 4 vezes
         msg="Registro acabou de ser|inclu�do por outro usu�rio!"
         DBOX(msg,,,,,"ATEN��O!")                            // avisa
         SELE CLIENTES
         UNLOCK                                              // libera o registro
         LOOP                                                // e recebe chave novamente
      ENDI
   #endi

   IF aprov_reg_                                             // se vai aproveitar reg excluido

      #ifdef COM_REDE
         BLOREG(0,.5)
      #endi

      RECA                                                   // excluido, vamos recupera-lo
   ELSE                                                      // caso contrario
      APPEND BLANK                                           // inclui reg em branco no dbf
   ENDI
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
   CLI_ANT_SEQ()                                             // restaura sequencial anterior
   SELE CLIENTES
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
   PROC CLI_ANT_SEQ(est_seq)     // restaura sequencial anterior
   SELE CLI_SEQ     // seleciona arquivo de controle de sequencial
   BLOARQ(0,.5)     // esta estacao foi a ultima a incluir?
   IF sq_atual_ == codigo
      REPL codigo WITH sq_codigo
   ENDI
   UNLOCK           // libera DBF para outros usuarios
   COMMIT           // atualiza cps sequenciais no disco
   RETU
#endi


PROC CLI_CRIA_SEQ   // cria dbf de controle de campos sequenciais
LOCAL dbfseq_:=drvdbf+"CLI_seq"       // arq temporario
SELE 0                                // seleciona area vazia
IF !FILE(dbfseq_+".dbf")              // se o dbf nao existe
   DBCREATE(dbfseq_,{;                // vamos criar a sua estrutura
                      {"codigo"    ,"N",  4, 0};
                    };
   )
ENDI
USEARQ(dbfseq_,.f.,,,.f.)             // abre arquivo de cps sequencial
IF RECC()=0                           // se o dbf foi criado agora
   BLOARQ(0,.5)                       // inclui um registro que tera
   APPEND BLANK                       // os ultomos cps sequenciais
   SELE CLIENTES
   IF RECC()>0                        // se o DBF nao estiver
      SET ORDER TO 0                  // vazio, entao enche DBF seq
      GO BOTT                         // com o ultimo reg digitado
      REPL CLI_SEQ->codigo WITH codigo
      SET ORDER TO 1                  // retorna ao indice principal
   ENDI
   SELE CLI_SEQ                       // seleciona arq de sequencias
   UNLOCK                             // libera DBF para outros usuarios
   COMMIT                             // atualiza cps sequenciais no disco
ENDI
RETURN

PROC CLI_GERA_SEQ()

#ifdef COM_REDE
   LOCAL ar_:=SELEC()
#else
   LOCAL reg_:=RECNO(),ord_ind:=INDEXORD()
#endi


#ifdef COM_REDE
   SELE CLI_SEQ
   BLOARQ(0,.5)
   sq_codigo=CLI_SEQ->codigo
#else
   SET ORDER TO 0
   GO BOTT
#endi

M->codigo=codigo+1
IF M->codigo=1
   M->codigo=1
ENDI

#ifdef COM_REDE
   CLI_GRAVA_SEQ()
   sq_atual_=CLI_SEQ->codigo
   UNLOCK                                                    // libera o registro
   COMMIT
   SELE (ar_)
#else
   DBSETORDER(ord_ind)
   GO reg_
#endi

RETU

PROC CLI_GRAVA_SEQ
REPL codigo WITH M->codigo
RETU

PROC CLI_tela     // tela do arquivo CLIENTES
tem_borda=.f.
l_s=Sistema[op_sis,O_TELA,O_LS]           // coordenadas da tela
c_s=Sistema[op_sis,O_TELA,O_CS]
l_i=Sistema[op_sis,O_TELA,O_LI]
c_i=Sistema[op_sis,O_TELA,O_CI]
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "���������������������������� Firmas/Agentes �����������������������������"
@ l_s+03,c_s+1 SAY " � C�digo � C.G.C. ������������� Firma/Agente ������������������������Ŀ"
@ l_s+04,c_s+1 SAY " �        �                    �                                       �"
@ l_s+05,c_s+1 SAY " � Ins. Estadual � Desc. Val. � Desc. Porc � Turismo �������������������"
@ l_s+06,c_s+1 SAY " �               �            �       %    �         �"
@ l_s+07,c_s+1 SAY " �����������������������������������������������������"
@ l_s+08,c_s+1 SAY " � Endere�o ��������������������������������� N�mero � Complemento ���Ŀ"
@ l_s+09,c_s+1 SAY " �                                          �        �                 �"
@ l_s+10,c_s+1 SAY " � Bairro ��������������� Cidade ��������������� UF � CEP ������������Ĵ"
@ l_s+11,c_s+1 SAY " �                      �                      �    �                  �"
@ l_s+12,c_s+1 SAY " � Telefone ������� Ramal � Contato ������������������������������������"
@ l_s+13,c_s+1 SAY " �                �       �                           �"
@ l_s+14,c_s+1 SAY " ������������������������������������������������������"
RETU

PROC CLI_gets     // mostra variaveis do arquivo CLIENTES
LOCAL getlist := {}
CLI_TELA()
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
@ l_s+04 ,c_s+04 GET  codigo;
                 PICT sistema[op_sis,O_CAMPO,01,O_MASC]

@ l_s+04 ,c_s+13 GET  cgc;
                 PICT sistema[op_sis,O_CAMPO,02,O_MASC]

@ l_s+04 ,c_s+34 GET  nome

@ l_s+06 ,c_s+04 GET  ie

@ l_s+06 ,c_s+20 GET  descvalor;
                 PICT sistema[op_sis,O_CAMPO,05,O_MASC]

@ l_s+06 ,c_s+35 GET  descporc;
                 PICT sistema[op_sis,O_CAMPO,06,O_MASC]

@ l_s+06 ,c_s+48 GET  turis;
                 PICT sistema[op_sis,O_CAMPO,07,O_MASC]
                 CRIT(sistema[op_sis,O_CAMPO,07,O_CRIT],,"1")

@ l_s+09 ,c_s+04 GET  ender

@ l_s+09 ,c_s+47 GET  numer;
                 PICT sistema[op_sis,O_CAMPO,09,O_MASC]

@ l_s+09 ,c_s+56 GET  compl

@ l_s+11 ,c_s+04 GET  bairro

@ l_s+11 ,c_s+27 GET  cidade

@ l_s+11 ,c_s+50 GET  uf;
                 PICT sistema[op_sis,O_CAMPO,13,O_MASC]

@ l_s+11 ,c_s+55 GET  cep;
                 PICT sistema[op_sis,O_CAMPO,14,O_MASC]

@ l_s+13 ,c_s+04 GET  fone;
                 PICT sistema[op_sis,O_CAMPO,15,O_MASC]

@ l_s+13 ,c_s+21 GET  ramal

@ l_s+13 ,c_s+29 GET  contato

CLEAR GETS
RETU

PROC CLI_get1     // capta variaveis do arquivo CLIENTES
LOCAL getlist := {}
PRIV  blk_clientes:=.t.
PARA tp_mov
IF tp_mov=INCLUI
   DO WHILE .t.
      rola_t=.f.
      SET KEY K_ALT_F8 TO ROLATELA
      SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
      @ l_s+04 ,c_s+04 GET codigo;
                       PICT sistema[op_sis,O_CAMPO,01,O_MASC]
      CLEA GETS
      @ l_s+04 ,c_s+34 GET  nome
                       DEFINICAO 3

      @ l_s+06 ,c_s+04 GET  ie
                       DEFINICAO 4

      @ l_s+06 ,c_s+20 GET  descvalor;
                       PICT sistema[op_sis,O_CAMPO,05,O_MASC]
                       DEFINICAO 5

      @ l_s+06 ,c_s+35 GET  descporc;
                       PICT sistema[op_sis,O_CAMPO,06,O_MASC]
                       DEFINICAO 6

      @ l_s+06 ,c_s+48 GET  turis;
                       PICT sistema[op_sis,O_CAMPO,07,O_MASC]
                       DEFINICAO 7
                       MOSTRA sistema[op_sis,O_FORMULA,1]

      @ l_s+09 ,c_s+04 GET  ender
                       DEFINICAO 8

      @ l_s+09 ,c_s+47 GET  numer;
                       PICT sistema[op_sis,O_CAMPO,09,O_MASC]
                       DEFINICAO 9

      @ l_s+09 ,c_s+56 GET  compl
                       DEFINICAO 10

      @ l_s+11 ,c_s+04 GET  bairro
                       DEFINICAO 11

      @ l_s+11 ,c_s+27 GET  cidade
                       DEFINICAO 12

      @ l_s+11 ,c_s+50 GET  uf;
                       PICT sistema[op_sis,O_CAMPO,13,O_MASC]
                       DEFINICAO 13

      @ l_s+11 ,c_s+55 GET  cep;
                       PICT sistema[op_sis,O_CAMPO,14,O_MASC]
                       DEFINICAO 14

      @ l_s+13 ,c_s+04 GET  fone;
                       PICT sistema[op_sis,O_CAMPO,15,O_MASC]
                       DEFINICAO 15

      @ l_s+13 ,c_s+21 GET  ramal
                       DEFINICAO 16

      @ l_s+13 ,c_s+29 GET  contato
                       DEFINICAO 17

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
   IF intref>0 .AND. tp_mov=EXCLUI
      ALERTA()   // existe registro validado aqui!
      msg=LTRIM(STR(intref))+" valida��o(�es) neste registro"
      DBOX(msg,,,,,"IMPOSS�VEL EXCLUIR!")
   ELSE
      DELE
   ENDI
ELSEIF tp_mov=INCLUI .OR. tp_mov=RECUPERA .OR. tp_mov=FORM_DIRETA
   IF op_menu!=INCLUSAO
      RECA
   ENDI
ENDI
RETU

* \\ Final de CLIENTES.PRG
