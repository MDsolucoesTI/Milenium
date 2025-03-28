/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: DESCONT.PRG
 \ Data....: 15-08-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: Gerenciador do subsistema de manuten��o de descontos
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

PARA lin_menu,col_menu
PRIV op_sis, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
op_sis=EVAL(qualsis,"DESCONTO")
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
   msg="Manuten��o|"+;                                       // menu do subsistema
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
   If Select("Desconto")=0
      DbfParam=DrvDbf+"Desconto"
      UseArq(DbfParam)
   EndIf
   If Select("ConRegis")=0
      DbfParam=DrvDbf+"ConRegis"
      UseArq(DbfParam)
   EndIf
   Sele ConRegis
   DbGoTop()
   Locate for Ativo='R'
   If Found()
      Sele Desconto
      DbGoTop()
      Locate for Codigo=ConRegis->Codigo .And. CodHosp=ConRegis->CodHosp
   Else
      Sele Desconto
      Set Filter to
      Con=Lastrec()
      Go (Con+1)
   EndIf
   Sele Desconto
   XCodHosp=0
   XCodigo=0
   If Lastrec()!=0
      Set Filter to Codigo=VerCod("Desconto","R") .And. CodHosp=XCodHosp
   EndIf
   DO CASE
      CASE op_cad=01                                         // manuten��o
         op_menu=ALTERACAO
         cod_sos=7
         EDIT()

      CASE op_cad=02                                         // consulta
         op_menu=PROJECOES
         cod_sos=8
         EDITA(3,3,MAXROW()-2,77)

   ENDC
   SET KEY K_F9 TO                                           // F9 nao mais consultara outros arquivos
   CLOS ALL                                                  // fecha todos arquivos abertos
ENDD
RETU

PROC DES_i     // inclusao no arquivo DESCONTO
LOCAL getlist:={}, cabem:=1, rep:=ARRAY(FCOU()), ult_reg:=RECN(), cond_incl_,;
      ctl_r, ctl_c, ctl_w, t_f3_, t_f4_, dele_atu:=SET(_SET_DELETED,.f.)
PRIV op_menu:=INCLUSAO, tem_borda, criterio:="", cpord:=""
cond_incl_={||1=2}                                           // condicao de inclusao de registros
IF !EVAL(cond_incl_)                                         // se nao pode incluir
   ALERTA(2)                                                 // avisa o motivo
   DBOX("N�o � permitido fazer inclus�es|neste m�dulo",,,4,,"ATEN��O, "+usuario)
   RETU                                                      // e retorna
ENDI
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
DO WHIL cabem>0
   sistema[op_sis,O_TELA,O_ATUAL]=1                          // primeira tela...
   rola_t=.f.                                                // flag se quer rolar a tela
   SELE DESCONTO
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
   DES_T()
   INFOSIS()                                                 // exibe informacao no rodape' da tela
   DISPEND()
   IF !EVAL(cond_incl_)
      EXIT
   ENDI
   cabem=DISKSPACE(IF(LEN(drvdbf)<2.OR.drvdbf="\",0,ASC(drvdbf)-64))
   cabem=INT((cabem-2048)/DESCONTO->(RECSIZE()))
   IF cabem<1                                                // mais nenhum!!!
      ALERTA()
      msg="Verifique ESPA�O EM DISCO, "+usuario
      DBOX(msg,,,,,"INCLUS�O INTERROMPIDA!")                 // vamos parar por aqui!
      EXIT
   ENDI
   SELE 0                                                    // torna visiveis variaveis de memoria
   DES_G1(INCLUI)                                          // recebe campos
   SELE DESCONTO
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
GO ult_reg                                                   // para o ultimo reg digitado
SETKEY(K_F3,t_f3_)                                           // restaura teclas de funcoes
SETKEY(K_F4,t_f4_)
SET(_SET_DELETED,dele_atu)                                      // ecluidos visiveis/invisiveis
SETKEY(K_CTRL_W,ctl_w)
SETKEY(K_CTRL_C,ctl_c)
SETKEY(K_CTRL_R,ctl_r)
RETU

PROC DES_t     // tela do arquivo DESCONTO
tem_borda=.f.
l_s=Sistema[op_sis,O_TELA,O_LS]           // coordenadas da tela
c_s=Sistema[op_sis,O_TELA,O_CS]
l_i=Sistema[op_sis,O_TELA,O_LI]
c_i=Sistema[op_sis,O_TELA,O_CI]
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "������������������ Manuten��o de Desconto �������������������"
@ l_s+03,c_s+1 SAY " � N� Registro � C�digo Hospede �"
@ l_s+04,c_s+1 SAY " �             �                �"
@ l_s+05,c_s+1 SAY " � Apto � Hospede ���������������������������Ŀ"
@ l_s+06,c_s+1 SAY " �      �                                     �"
@ l_s+07,c_s+1 SAY " ����������������������������������������������"
@ l_s+08,c_s+1 SAY " � Valor ���� Porcentagem � Observa��o �������������������Ŀ"
@ l_s+09,c_s+1 SAY " �          �             �                                �"
@ l_s+10,c_s+1 SAY " � Tipo Despesa ������ Autoriza��o ����� Operador ��������Ĵ"
@ l_s+11,c_s+1 SAY " �    -              �                 �                   �"
@ l_s+12,c_s+1 SAY " �����������������������������������������������������������"
RETU

PROC DES_g     // mostra variaveis do arquivo DESCONTO
LOCAL getlist := {}
DES_T()
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
PTAB(STR(CODIGO,10,00),'REGISTRO',1)
PTAB(STR(CODHOSP,10,00),'HOSPEDES',3)
PTAB(STR(TIPODESP,02,00),'DEPARTA',1)
@ l_s+04 ,c_s+04 GET  codigo;
                 PICT sistema[op_sis,O_CAMPO,01,O_MASC]
                 CRIT(sistema[op_sis,O_CAMPO,01,O_CRIT],,"1")

@ l_s+04 ,c_s+18 GET  codhosp;
                 PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                 CRIT(sistema[op_sis,O_CAMPO,02,O_CRIT],,"2")

@ l_s+09 ,c_s+04 GET  final;
                 PICT sistema[op_sis,O_CAMPO,03,O_MASC]

@ l_s+09 ,c_s+15 GET  porc;
                 PICT sistema[op_sis,O_CAMPO,04,O_MASC]

@ l_s+09 ,c_s+29 GET  obs

@ l_s+11 ,c_s+42 GET  operador

@ l_s+11 ,c_s+04 GET  tipodesp;
                 PICT sistema[op_sis,O_CAMPO,07,O_MASC]
                 CRIT(sistema[op_sis,O_CAMPO,07,O_CRIT],,"3")

@ l_s+11 ,c_s+24 GET  autor

CLEAR GETS
RETU

PROC DES_g1     // capta variaveis do arquivo DESCONTO
LOCAL getlist := {}
PRIV  blk_desconto:=.t.
PARA tp_mov
IF tp_mov=INCLUI
   DO WHILE .t.
      rola_t=.f.
      SET KEY K_ALT_F8 TO ROLATELA
      SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
      @ l_s+11 ,c_s+42 GET operador
      CLEA GETS
      @ l_s+04 ,c_s+04 GET  codigo;
                       PICT sistema[op_sis,O_CAMPO,01,O_MASC]
                       DEFINICAO 1
                       MOSTRA sistema[op_sis,O_FORMULA,1]

      @ l_s+04 ,c_s+18 GET  codhosp;
                       PICT sistema[op_sis,O_CAMPO,02,O_MASC]
                       DEFINICAO 2
                       MOSTRA sistema[op_sis,O_FORMULA,2]

      @ l_s+09 ,c_s+04 GET  final;
                       PICT sistema[op_sis,O_CAMPO,03,O_MASC]
                       DEFINICAO 3

      @ l_s+09 ,c_s+15 GET  porc;
                       PICT sistema[op_sis,O_CAMPO,04,O_MASC]
                       DEFINICAO 4

      @ l_s+09 ,c_s+29 GET  obs
                       DEFINICAO 5

      @ l_s+11 ,c_s+04 GET  tipodesp;
                       PICT sistema[op_sis,O_CAMPO,07,O_MASC]
                       DEFINICAO 7
                       MOSTRA sistema[op_sis,O_FORMULA,3]

      @ l_s+11 ,c_s+24 GET  autor
                       DEFINICAO 8

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
PTAB(STR(CODIGO,10,00),'REGISTRO',1)
PTAB(STR(CODHOSP,10,00),'HOSPEDES',3)
PTAB(STR(TIPODESP,02,00),'DEPARTA',1)
IF tp_mov=EXCLUI .OR. tp_mov=FORM_INVERSA
   MANUREF(STR(CODIGO,10,00),'REGISTRO',1,DECREMENTA)
   MANUREF(STR(CODHOSP,10,00),'HOSPEDES',3,DECREMENTA)
   MANUREF(STR(TIPODESP,02,00),'DEPARTA',1,DECREMENTA)
   DELE
ELSEIF tp_mov=INCLUI .OR. tp_mov=RECUPERA .OR. tp_mov=FORM_DIRETA
   IF (op_menu=INCLUSAO .AND. LASTKEY()!=K_ESC) .OR. op_menu!=INCLUSAO
      IF tp_mov=RECUPERA .AND. op_menu!=INCLUSAO .AND. (REGISTRO->(DELE()) .OR. HOSPEDES->(DELE()) .OR. DEPARTA->(DELE()))
         msg=""
         IF REGISTRO->(DELE())
            msg="|"+sistema[EVAL(qualsis,"REGISTRO"),O_MENU]
         ENDI
         IF HOSPEDES->(DELE())
            msg+="|"+sistema[EVAL(qualsis,"HOSPEDES"),O_MENU]
         ENDI
         IF DEPARTA->(DELE())
            msg+="|"+sistema[EVAL(qualsis,"DEPARTA"),O_MENU]
         ENDI
         ALERTA(2)
         DBOX("Registro exclu�do em:"+msg+"|*",,,,,"IMPOSS�VEL RECUPERAR!")
      ELSE
         MANUREF(STR(CODIGO,10,00),'REGISTRO',1,INCREMENTA)
         MANUREF(STR(CODHOSP,10,00),'HOSPEDES',3,INCREMENTA)
         MANUREF(STR(TIPODESP,02,00),'DEPARTA',1,INCREMENTA)
         IF op_menu!=INCLUSAO
            RECA
         ENDI
      ENDI
   ENDI
ENDI
RETU

* \\ Final de DESCONTO.PRG
