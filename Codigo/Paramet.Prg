 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: PARAMET.PRG
 \ Data....: 18-09-2000
 \ Sistema.: MILENIUM - Automa噭o Hoteleira
 \ Funcao..: Gerenciador do subsistema de configura嚁es do sistema
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

PARA lin_menu,col_menu
PRIV op_sis, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
op_sis=EVAL(qualsis,"PARAMET")
IF nivelop<sistema[op_sis,O_OUTROS,O_NIVEL]                  // se usuario nao tem permissao,
   ALERTA()                                                  // entao, beep, beep, beep
   DBOX(msg_auto,,,3)                                        // lamentamos e
   RETU                                                      // retornamos ao menu
ENDI

#ifdef COM_LOCK
   IF LEN(pr_ok)>0                                           // se a protecao acusou
      ? pr_ok                                                // erro, avisa e
      QUIT                                                   // encerra a aplicacao
   ENDI
#endi

SELE A

#ifdef COM_REDE
   IF !USEARQ(sistema[op_sis,O_ARQUI],.t.,20,1,.f.)          // se falhou a abertura do
      RETU                                                   // arquivo volta ao menu anterior
   ENDI
#else
   USEARQ(sistema[op_sis,O_ARQUI],,,,.f.)
#endi

SET KEY K_F9 TO veoutros                                     // habilita consulta em outros arquivos
ctl_w=SETKEY(K_CTRL_W,{||nadafaz()})                         // enganando o CA-Clipper...
ctl_c=SETKEY(K_CTRL_C,{||nadafaz()})
ctl_r=SETKEY(K_CTRL_R,{||nadafaz()})
op_menu=ALTERACAO                                            // parametro e' como se fosse alteracao
cod_sos=54
rola_t=.f.                                                   // flag se quer rolar a tela
SELE PARAMET
DISPBEGIN()                                                  // monta tela na pagina de traz
PAR_TELA()
PAR_GETS()
INFOSIS()                                                  // exibe informacao no rodape' da tela
DISPEND()
PAR_GET1(INCLUI)
SELE PARAMET
mudou_=.f.
FOR i=1 TO FCOU()                                            // atualiza variaveis publicas
   msg=FIEL(i)                                               // do arquivo de parametros
   mudou_=IF(M->&msg.!=&msg.,.t.,mudou_)
   M->&msg.=&msg.
NEXT
SET KEY K_F9 TO                                              // desativa tecla F9 (veoutros)
SETKEY(K_CTRL_W,ctl_w)
SETKEY(K_CTRL_C,ctl_c)
SETKEY(K_CTRL_R,ctl_r)
If Senha()!=AllTrim(Paramet->Palavra)
   DBox('Houve Viola噭o na Configura噭o do Sistema ou na Senha de libera噭o|comunique-se com sua empresa de suporte ou com Denny Paulista Azevedo Filho|para verifica噭o do ocorrido.',,,0,.T.,,)
   Close all
   KeyBoard chr(13)
   do Sair
EndIf
IF mudou_
   CBC1(.t.)
   v01=SAVESCREEN(0,0,MAXROW(),79)
   BREAK
ENDI
RETU

PROC PAR_tela     // tela do arquivo PARAMET
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
   @ l_s+01,c_s+1 SAY "北北北北北北北北北北北� Configura嚁es do Sistema 北北北北北北北北北北北�"
   @ l_s+03,c_s+1 SAY " � Empresa 哪哪哪哪哪哪哪哪哪哪哪哪哪哪� CGC 哪哪哪哪哪哪哪哪哪哪哪哪目"
   @ l_s+04,c_s+1 SAY " �                                     �                              �"
   @ l_s+05,c_s+1 SAY " � Inscri噭o Estadual 哪� Endere噊 哪哪哪哪哪哪哪哪哪哪哪哪哪穆 N� 哪拇"
   @ l_s+06,c_s+1 SAY " �                      �                                     �       �"
   @ l_s+07,c_s+1 SAY " � Bairro 哪哪哪哪哪哪� Cidade 哪哪哪哪哪哪哪� UF � Pa 哪哪牧哪哪哪拇"
   @ l_s+08,c_s+1 SAY " �                    �                      �    �                   �"
   @ l_s+09,c_s+1 SAY " � CEP 哪哪哪哪穆腡elefone 哪哪哪穆 Fax 哪哪牧哪哪聊� Telex 哪哪哪哪哪�"
   @ l_s+10,c_s+1 SAY " �              �                 �                 �                 �"
   @ l_s+11,c_s+1 SAY " 滥哪哪哪哪哪哪牧哪哪哪哪哪哪哪哪牧哪哪哪哪哪哪哪哪牧哪哪哪哪哪哪哪哪馁"
   @ l_s+13,c_s+1 SAY " 圹圹圹圹圹圹圹圹圹圹圹圹� Mulos Instalados 圹圹圹圹圹圹圹圹圹圹圹圹�"
   @ l_s+14,c_s+1 SAY " 赏屯屯屯屯屯屯屯脱屯屯退屯屯屯屯屯屯屯屯淹屯屯送屯屯屯屯屯屯屯脱屯屯突"
   @ l_s+15,c_s+1 SAY " � Recep噭o       �     � Reserva        �     � Retaguarda     �     �"
   @ l_s+16,c_s+1 SAY " 悄哪哪哪哪哪哪哪呐哪哪淖哪哪哪哪哪哪哪哪拍哪哪啄哪哪哪哪哪哪哪呐哪哪亩"
   @ l_s+17,c_s+1 SAY " � Restaurante    �     � Estoque        �     � Financeiro     �     �"
   @ l_s+18,c_s+1 SAY " 悄哪哪哪哪哪哪哪呐哪哪淖哪哪哪哪哪哪哪哪拍哪哪啄哪哪哪哪哪哪哪呐哪哪亩"
   @ l_s+19,c_s+1 SAY " � Or嘺ment爎io   �     � Veulo        �     � Marina         �     �"
   @ l_s+20,c_s+1 SAY " 韧屯屯屯屯屯屯屯拖屯屯褪屯屯屯屯屯屯屯屯贤屯屯释屯屯屯屯屯屯屯拖屯屯图"
ELSEIF sistema[op_sis,O_TELA,O_ATUAL]= 2
   @ l_s+01,c_s+1 SAY "北北北北北北北北北北北� Configura嚁es do Sistema 北北北北北北北北北北北�"
   @ l_s+03,c_s+1 SAY " 圹圹圹圹圹圹圹圹圹圹圹圹圹 Mulo Recep噭o 圹圹圹圹圹圹圹圹圹圹圹圹圹�"
   @ l_s+05,c_s+1 SAY " � Taxa Servi噊 � N� Fatura � Faa Eventuais � Reabertura � Di爎ia 哪�"
   @ l_s+06,c_s+1 SAY " �       %      �           �        a        �     dias   �       h  �"
   @ l_s+07,c_s+1 SAY " � timo BMD gerado em 哪哪聊哪哪� timo Caixa fechado em 哪哪哪哪哪�"
   @ l_s+08,c_s+1 SAY " �               as         h     �                as         h       �"
   @ l_s+09,c_s+1 SAY " 滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁"
   @ l_s+11,c_s+1 SAY " 圹圹圹圹圹圹圹圹圹圹圹圹圹 Mulo Finaneiro 圹圹圹圹圹圹圹圹圹圹圹圹圹"
   @ l_s+12,c_s+1 SAY " 赏屯屯屯屯屯屯屯屯屯脱屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯脱屯屯屯屯屯屯突"
   @ l_s+13,c_s+1 SAY " �                    � Lan嘺r no Movimento Financeiro  �             �"
   @ l_s+14,c_s+1 SAY " � Ao emitir cheques  媚哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪拍哪哪哪哪哪哪�"
   @ l_s+15,c_s+1 SAY " �                    � Dar Baixa no Contas a Pagar     �             �"
   @ l_s+16,c_s+1 SAY " 韧屯屯屯屯屯屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯拖屯屯屯屯屯屯图"
ELSE
   @ l_s+01,c_s+1 SAY "北北北北北北北北北北北� Configura嚁es do Sistema 北北北北北北北北北北北�"
   @ l_s+03,c_s+1 SAY " 圹圹圹圹圹圹圹圹圹圹圹圹圹 Libera噭o de Uso 圹圹圹圹圹圹圹圹圹圹圹圹圹"
   @ l_s+04,c_s+1 SAY " 赏屯屯屯屯屯屯屯屯屯屯淹屯屯屯屯屯屯送屯屯屯脱屯屯屯屯屯屯屯屯屯屯屯突"
   @ l_s+05,c_s+1 SAY " � Inicio do Contrato  �             �        �                       �"
   @ l_s+06,c_s+1 SAY " 悄哪哪哪哪哪哪哪哪哪哪拍哪哪哪哪哪哪� Senha  �                       �"
   @ l_s+07,c_s+1 SAY " � Termino do Contrato �             �        �                       �"
   @ l_s+08,c_s+1 SAY " 韧屯屯屯屯屯屯屯屯屯屯贤屯屯屯屯屯屯释屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯图"
ENDI
RETU

PROC PAR_gets     // mostra variaveis do arquivo PARAMET
LOCAL getlist := {}, ctl_c, ctl_r
PAR_TELA()
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
IF sistema[op_sis,O_TELA,O_ATUAL]=1
   @ l_s+04 ,c_s+04 GET  empresa1

   @ l_s+04 ,c_s+42 GET  cgc1;
                    PICT sistema[op_sis,O_CAMPO,02,O_MASC]

   @ l_s+06 ,c_s+04 GET  inscr1;
                    PICT sistema[op_sis,O_CAMPO,03,O_MASC]

   @ l_s+06 ,c_s+27 GET  ender1

   @ l_s+06 ,c_s+65 GET  numero1;
                    PICT sistema[op_sis,O_CAMPO,05,O_MASC]

   @ l_s+08 ,c_s+04 GET  bairro1

   @ l_s+08 ,c_s+25 GET  cidade1

   @ l_s+08 ,c_s+48 GET  uf1;
                    PICT sistema[op_sis,O_CAMPO,08,O_MASC]

   @ l_s+08 ,c_s+53 GET  pais1

   @ l_s+10 ,c_s+04 GET  cep1;
                    PICT sistema[op_sis,O_CAMPO,10,O_MASC]

   @ l_s+10 ,c_s+19 GET  tele1;
                    PICT sistema[op_sis,O_CAMPO,11,O_MASC]

   @ l_s+10 ,c_s+37 GET  fax1;
                    PICT sistema[op_sis,O_CAMPO,12,O_MASC]

   @ l_s+10 ,c_s+55 GET  tex1

   @ l_s+15 ,c_s+21 GET  recepcao;
                    PICT sistema[op_sis,O_CAMPO,14,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,14,O_CRIT],,"1")

   @ l_s+15 ,c_s+44 GET  reserva;
                    PICT sistema[op_sis,O_CAMPO,15,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,15,O_CRIT],,"2")

   @ l_s+15 ,c_s+67 GET  retaguarda;
                    PICT sistema[op_sis,O_CAMPO,16,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,16,O_CRIT],,"5")

   @ l_s+17 ,c_s+21 GET  restaurant;
                    PICT sistema[op_sis,O_CAMPO,17,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,17,O_CRIT],,"3")

   @ l_s+17 ,c_s+44 GET  estoque;
                    PICT sistema[op_sis,O_CAMPO,18,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,18,O_CRIT],,"4")

   @ l_s+17 ,c_s+67 GET  financeiro;
                    PICT sistema[op_sis,O_CAMPO,19,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,19,O_CRIT],,"6")

   @ l_s+19 ,c_s+21 GET  orcamen;
                    PICT sistema[op_sis,O_CAMPO,20,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,20,O_CRIT],,"7")

   @ l_s+19 ,c_s+44 GET  veiculo;
                    PICT sistema[op_sis,O_CAMPO,21,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,21,O_CRIT],,"8")

   @ l_s+19 ,c_s+67 GET  marina;
                    PICT sistema[op_sis,O_CAMPO,22,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,22,O_CRIT],,"9")

ELSEIF sistema[op_sis,O_TELA,O_ATUAL]= 2
   @ l_s+06 ,c_s+06 GET  txser;
                    PICT sistema[op_sis,O_CAMPO,23,O_MASC]

   @ l_s+06 ,c_s+20 GET  numrd;
                    PICT sistema[op_sis,O_CAMPO,24,O_MASC]

   @ l_s+06 ,c_s+33 GET  faixaini;
                    PICT sistema[op_sis,O_CAMPO,25,O_MASC]

   @ l_s+06 ,c_s+40 GET  faixafim;
                    PICT sistema[op_sis,O_CAMPO,26,O_MASC]

   @ l_s+06 ,c_s+50 GET  numreabre;
                    PICT sistema[op_sis,O_CAMPO,27,O_MASC]

   @ l_s+06 ,c_s+62 GET  terdia;
                    PICT sistema[op_sis,O_CAMPO,28,O_MASC]

   @ l_s+08 ,c_s+05 GET  bmd;
                    PICT sistema[op_sis,O_CAMPO,29,O_MASC]

   @ l_s+08 ,c_s+23 GET  hbmd;
                    PICT sistema[op_sis,O_CAMPO,30,O_MASC]

   @ l_s+08 ,c_s+39 GET  dtcaixa;
                    PICT sistema[op_sis,O_CAMPO,31,O_MASC]

   @ l_s+08 ,c_s+57 GET  hcaixa;
                    PICT sistema[op_sis,O_CAMPO,32,O_MASC]

   @ l_s+13 ,c_s+63 GET  lancmov;
                    PICT sistema[op_sis,O_CAMPO,33,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,33,O_CRIT],,"10")

   @ l_s+15 ,c_s+63 GET  baixpag;
                    PICT sistema[op_sis,O_CAMPO,34,O_MASC]
                    CRIT(sistema[op_sis,O_CAMPO,34,O_CRIT],,"11")

ELSE
   @ l_s+05 ,c_s+27 GET  dtinicont;
                    PICT sistema[op_sis,O_CAMPO,35,O_MASC]

   @ l_s+07 ,c_s+27 GET  dtfimcont;
                    PICT sistema[op_sis,O_CAMPO,36,O_MASC]

   @ l_s+06 ,c_s+50 GET  palavra

ENDI
CLEAR GETS
RETU

PROC PAR_get1     // capta variaveis do arquivo PARAMET
LOCAL getlist := {}, ctl_c, ctl_r
PRIV  blk_paramet:=.t.
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
         @ l_s+04 ,c_s+04 GET  empresa1
                          DEFINICAO 1

         @ l_s+04 ,c_s+42 GET  cgc1;
                          PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                          DEFINICAO 2

         @ l_s+06 ,c_s+04 GET  inscr1;
                          PICT sistema[op_sis,O_CAMPO,03,O_MASC]
                          DEFINICAO 3

         @ l_s+06 ,c_s+27 GET  ender1
                          DEFINICAO 4

         @ l_s+06 ,c_s+65 GET  numero1;
                          PICT sistema[op_sis,O_CAMPO,05,O_MASC]
                          DEFINICAO 5

         @ l_s+08 ,c_s+04 GET  bairro1
                          DEFINICAO 6

         @ l_s+08 ,c_s+25 GET  cidade1
                          DEFINICAO 7

         @ l_s+08 ,c_s+48 GET  uf1;
                          PICT sistema[op_sis,O_CAMPO,08,O_MASC]
                          DEFINICAO 8

         @ l_s+08 ,c_s+53 GET  pais1
                          DEFINICAO 9

         @ l_s+10 ,c_s+04 GET  cep1;
                          PICT sistema[op_sis,O_CAMPO,10,O_MASC]
                          DEFINICAO 10

         @ l_s+10 ,c_s+19 GET  tele1;
                          PICT sistema[op_sis,O_CAMPO,11,O_MASC]
                          DEFINICAO 11

         @ l_s+10 ,c_s+37 GET  fax1;
                          PICT sistema[op_sis,O_CAMPO,12,O_MASC]
                          DEFINICAO 12

         @ l_s+10 ,c_s+55 GET  tex1
                          DEFINICAO 13

         @ l_s+15 ,c_s+44 GET  reserva;
                          PICT sistema[op_sis,O_CAMPO,15,O_MASC]
                          DEFINICAO 15
                          MOSTRA sistema[op_sis,O_FORMULA,2]

         @ l_s+15 ,c_s+67 GET  retaguarda;
                          PICT sistema[op_sis,O_CAMPO,16,O_MASC]
                          DEFINICAO 16
                          MOSTRA sistema[op_sis,O_FORMULA,5]

         @ l_s+17 ,c_s+21 GET  restaurant;
                          PICT sistema[op_sis,O_CAMPO,17,O_MASC]
                          DEFINICAO 17
                          MOSTRA sistema[op_sis,O_FORMULA,3]

         @ l_s+17 ,c_s+44 GET  estoque;
                          PICT sistema[op_sis,O_CAMPO,18,O_MASC]
                          DEFINICAO 18
                          MOSTRA sistema[op_sis,O_FORMULA,4]

         @ l_s+17 ,c_s+67 GET  financeiro;
                          PICT sistema[op_sis,O_CAMPO,19,O_MASC]
                          DEFINICAO 19
                          MOSTRA sistema[op_sis,O_FORMULA,6]

         @ l_s+19 ,c_s+21 GET  orcamen;
                          PICT sistema[op_sis,O_CAMPO,20,O_MASC]
                          DEFINICAO 20
                          MOSTRA sistema[op_sis,O_FORMULA,7]

         @ l_s+19 ,c_s+44 GET  veiculo;
                          PICT sistema[op_sis,O_CAMPO,21,O_MASC]
                          DEFINICAO 21
                          MOSTRA sistema[op_sis,O_FORMULA,8]

         @ l_s+19 ,c_s+67 GET  marina;
                          PICT sistema[op_sis,O_CAMPO,22,O_MASC]
                          DEFINICAO 22
                          MOSTRA sistema[op_sis,O_FORMULA,9]

      ELSEIF sistema[op_sis,O_TELA,O_ATUAL]= 2
         @ l_s+06 ,c_s+06 GET  txser;
                          PICT sistema[op_sis,O_CAMPO,23,O_MASC]
                          DEFINICAO 23

         @ l_s+06 ,c_s+20 GET  numrd;
                          PICT sistema[op_sis,O_CAMPO,24,O_MASC]
                          DEFINICAO 24

         @ l_s+06 ,c_s+33 GET  faixaini;
                          PICT sistema[op_sis,O_CAMPO,25,O_MASC]
                          DEFINICAO 25

         @ l_s+06 ,c_s+40 GET  faixafim;
                          PICT sistema[op_sis,O_CAMPO,26,O_MASC]
                          DEFINICAO 26

         @ l_s+06 ,c_s+50 GET  numreabre;
                          PICT sistema[op_sis,O_CAMPO,27,O_MASC]
                          DEFINICAO 27

         @ l_s+06 ,c_s+62 GET  terdia;
                          PICT sistema[op_sis,O_CAMPO,28,O_MASC]
                          DEFINICAO 28

         @ l_s+13 ,c_s+63 GET  lancmov;
                          PICT sistema[op_sis,O_CAMPO,33,O_MASC]
                          DEFINICAO 33
                          MOSTRA sistema[op_sis,O_FORMULA,10]

         @ l_s+15 ,c_s+63 GET  baixpag;
                          PICT sistema[op_sis,O_CAMPO,34,O_MASC]
                          DEFINICAO 34
                          MOSTRA sistema[op_sis,O_FORMULA,11]

      ELSE
         @ l_s+05 ,c_s+27 GET  dtinicont;
                          PICT sistema[op_sis,O_CAMPO,35,O_MASC]
                          DEFINICAO 35

         @ l_s+07 ,c_s+27 GET  dtfimcont;
                          PICT sistema[op_sis,O_CAMPO,36,O_MASC]
                          DEFINICAO 36

         @ l_s+06 ,c_s+50 GET  palavra
                          DEFINICAO 37

      ENDI
      READ
      SET KEY K_ALT_F8 TO
      IF rola_t
         ROLATELA()
         LOOP
      ENDI
      IF volta=0 .AND. LASTKEY()=K_ESC
         EXIT
      ENDI
      sistema[op_sis,O_TELA,O_ATUAL]++
      IF sistema[op_sis,O_TELA,O_ATUAL]<=sistema[op_sis,O_TELA,O_DEF]
         PAR_TELA()
         IF op_menu=ALTERACAO .OR. volta=1
            PAR_GETS()
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
RETU

* \\ Final de PARAMET.PRG
