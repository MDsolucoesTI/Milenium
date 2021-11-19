/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: DIVERSAS.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - AutomaÁ‰o Hoteleira
 \ Funcao..: FunÁıes diversas do Sistema
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
   Sintaxe: VDBF( <N1> <,N2> <,N3> <,N4> <,ExpC1> [,ExpA1] [,ExpN] [,ExpC2] )
   Funcao.: Abre janela de consulta a outro arquivo da aplicacao
              N1,N2,N3,N4 = coordenadas da janela
                    ExpC1 = nome do arquivo a ser consultado
                    ExpA1 = arranjo de campos a mostrar na consulta
                     ExpN = ordem do indice associado ao arquivo
                    ExpC2 = campo a ser transferido para o get pendente
                    ExpC3 = expressao de filtro inicial
   Retorna: logico sempre .t.
*/
FUNC VDBF(l_1,c_1,l_2,c_2,db,cp_db,ord_db,cp_trans,fil_db)
LOCAL v_ar, v_:=SAVESCREEN(0,0,MAXROW(),79), t_w, t_r, t_c, t_7, t_9,;
      reg_dbf:={}, ret_val
PRIV tela_fundo
v_ar=READVAR()
ord_db=IF(ord_db=NIL,1,ord_db)
//reg_dbf=POINTER_DBF()                         // salva situacao de todos dbf's
tem_t=.f.
IF !EMPTY(v_ar)                               // alguma variavel pendente?
   IF VALTYPE(&v_ar.) $ "CNDL"                // se for caracter, numerica, data
      tem_t=!("OP_" $ UPPER(v_ar))            // ou logico e nao for de menu, pode
      v_ar=TRIM(TRANSCAMPO(.t.,v_ar))         // transferir para o get pendente
   ENDI
ENDI
PTAB(IF(tem_t,v_ar,"%^"),db)                  // abre arquivo e tenta posicionar

#ifdef COM_REDE
   IF NETERR()                                // se ocorreu erro de abertura
      RETU .t.                                // retorna
   ENDI
#endi

SELE (db)                                     // seleciona o arquivo escolhido
IF EOF()                                      // se fim de arquivo,
   GO TOP                                     // vai para o 1o. registro
ENDI
t_w:=SETKEY(K_CTRL_W,NIL)                     // desabilita e salva
t_r:=SETKEY(K_CTRL_R,NIL)                     // as teclas de controle
t_c:=SETKEY(K_CTRL_C,NIL)
t_7:=SETKEY(K_F7,NIL); t_9:=SETKEY(K_F9,NIL)
IF sistema[EVAL(qualsis,ALIAS()),O_OUTROS,O_NIVEL]>nivelop
   ALERTA()                                   // usuario nao tem permissao
   DBOX(msg_auto,,,3)                         // avisa
ELSE
   l_2=IF(l_2-l_1-1>RECC(),l_1+RECC()+1,l_2)
   v_out=.t.
   cod_sos=10
   EDITA(l_1,c_1,l_2,c_2,.t.,cp_db,,fil_db,INDEXKEY(ord_db))
   IF LASTKEY()!=K_ESC .AND. cp_trans!=NIL
      ret_val=&cp_trans.
   ENDI
   v_out=.f.
ENDI
//POINTER_DBF(reg_dbf)                          // restaura ponteiro dos dbf's
SETKEY(K_CTRL_W,t_w)                          // restaura teclas de controle
SETKEY(K_CTRL_R,t_r)
SETKEY(K_CTRL_C,t_c)
SETKEY(K_F7,t_7); SETKEY(K_F9,t_9)
RESTSCREEN(0,0,MAXROW(),79,v_)                // restaura tela
RETU ret_val

/*
   Sintaxe: EDITA( <N1> <,N2> <,N3> <,N4> <,ExpL|ExpC1> <,Arr1> <,Arr2> <,ExpC2> <,ExpC3> )
   Funcao.: Apresenta a tela de consulta no objeto "TBrowse" com diversos recursos.
              N1,N2,N3,N4 = coordenadas da janela de consulta
               ExpL|ExpC1 = rotinas nao acessadas
                     Arr1 = arranjo de campos a apresentar na janela
                     Arr2 = titulos dos campos de Arr1
                    ExpC2 = filtro inicial
                    ExpC3 = ordem inicial
   Retorna: NIL
*/
FUNC EDITA(li_supp,co_supp,li_infp,co_infp,mo_difp,coluna_cp,coluna_tit,cr_,ord_)
LOCAL op_sy_:=op_sis, cor_orig, i_, t_f8, dele_atu:=SET(_SET_DELETED,.f.)
PRIV cp_:="", cond_p:="", tit_cons:={"",""}, db_1rela:="", cpord,;
     db_2rela:="", cpord:="", criterio, ind_ord:=1, chvpesq:="",;
     grava_db:=.f., op_db:=1, volta_db, ch_tecl:="05042419", op_menu:=PROJECOES,;
     di_tecl:="24262527", br_reg_ori, br_reg_out, brw_tempo,;
     col_cp:=coluna_cp,col_tit:=coluna_tit, li_sup:=li_supp, vr_edita,;
     li_inf:=li_infp, co_sup:=co_supp, co_inf:=co_infp, posi_cur,;
     dir_cur:=IF(op_sis>nss,2,3), mo_dif:=mo_difp, hlp_cod:=cod_sos
IF ! USED()                                  // se nao existir arquivo
   RETU .f.                                  // aberto, cai fora
ENDI
criterio=IF(cr_=NIL,"",cr_)                  // tem filtro inicial?
cpord=IF(ord_=NIL,"",ord_)                   // tem ordem inicial?
FOR i_=1 TO FCOU()                           // declara privados todos os
   msg=FIELD(i_)                             // campos do arquivo da consulta
   PRIV &msg.
NEXT

#ifdef COM_MOUSE
   IF drvmouse
      DO WHIL MOUSEGET(0,0)!=0               // se qualquer botao do mouse
      ENDD                                   // estiver pressionado espera
   ENDI                                      // liberacao
#endi

brw=.t.                                      // pega posicao atual da tela
vr_edita=NOVAPOSI(@li_sup,@co_sup,@li_inf,@co_inf)
mo_dif=IF(mo_dif=NIL,.t.,mo_dif)             // trata as rotinas
IF TYPE("mo_dif")="L"                        // que nao poderao
   IF !mo_dif                                // ser acessadas
      mo_dif="DERMG"                         // durante a consulta
   ELSE
      mo_dif=""
   ENDI
ENDI
cor_orig=SETCOLOR()                          // salva cor original
brw_reg=RECN()                               // registro atual
volta_db=.t.
SET KEY K_TAB TO dir_cur                     // TAB muda posicao do cursor

#ifdef COM_REDE
   brw_tempo=drvtempo                        // tempo de "refresh"
#endi

t_f8=SETKEY(K_ALT_F8,NIL)                    // salva/reseta tecla ALT-F8
BRWFUNC(PROCNAME(1)!="VDBF")                 // funcoes auxiliares
SETKEY(K_ALT_F8,t_f8)                        // seta tecla ALT-F8

#ifdef COM_REDE
   IF brw_tempo!=drvtempo                    // se alterou o tempo de "refresh"
      SAVE TO (arqconf) ALL LIKE drv*        // salva em disco
   ENDI
#endi

SETCOLOR(cor_orig)                           // restaura cor original
op_sis = op_sy_
SET KEY K_TAB TO                             // resta TAB
brw=.f.
SET(_SET_DELETED,dele_atu)                   // SET DELE=anterior
RETU .t.

/*
   Sintaxe: BRWFUNC( [ExpL] )
   Funcao.: Diversas funcoes auxiliares da EDITA()
              ExpL = .t./omitida le consultas gravadas
   Retorna: NIL
*/
STATIC FUNC BRWFUNC(nao_vdbf)
LOCAL br_w1, brw_tela, cri_ant, brw_reg, cp_exp:={}, estr_dbf:={}, tps,;
      tecl_p, l_sup, l_inf, m_od, arqexp, dli_exp, id_carg:={}, q_tela,;
      just_memo, tot_num, Li:=1, Co:=1, ppp:=0, pp:=0, t, i, l_m, Tp_Sai,;
      tit_rel, brw_fundo:=SAVESCREEN(0,0,MAXROW(),79), dele_atu, x_, y_
PRIV cp_, cp_titu, cp_masc, cp_crit, cp_when, cp_help, cp_cmd, tp_cp, br_w,;
     fg_loc:=.f., volta_db:=.t., arq_cor:=LEFT(ALIAS(),3), br_origem,;
     br_outro:=NIL, m_origem, outro_db:=NIL, chv_rela:="", chv_1:="",;
     chv_2:="", l_s, c_s, l_i, c_i, db_zoom:=.f.
m_origem = ALLTRIM(STR(SELEC()))
br_origem = TBROWSENEW(li_sup,co_sup,li_inf,co_inf)
br_origem:colorspec := drvcorbox+","+INVCOR(drvcorbox)+","+drvcorenf+","+drvcorget
br_w = br_origem
CABBRW()                                                    // monta cabecalho da consulta
nao_vdbf=IF(nao_vdbf=NIL,.t.,nao_vdbf)                      // trata parametro
IF !LDBEDIT(nao_vdbf)                                       // menu de consultas gravadas
   RETU NIL
ENDI
col_cp:=col_tit := NIL
tb = {{K_DOWN,      {||br_w:down()}},;                      // vetor contendo as teclas
      {K_UP,        {||br_w:up()}},;                        // e suas acoes
      {K_PGDN,      {||br_w:pagedown()}},;
      {K_PGUP,      {||br_w:pageup()}},;
      {K_CTRL_PGUP, {||br_w:gotop()}},;
      {K_CTRL_PGDN, {||br_w:gobottom()}},;
      {K_RIGHT,     {||br_w:right()}},;
      {K_LEFT,      {||br_w:left()}},;
      {K_HOME,      {||br_w:home()}},;
      {K_END,       {||br_w:end()}},;
      {K_CTRL_LEFT, {||br_w:panleft()}},;
      {K_CTRL_RIGHT,{||br_w:panright()}},;
      {K_CTRL_HOME, {||br_w:panhome()}},;
      {K_CTRL_END,  {||br_w:panend()}};
     }
SETCOLOR(drvcorbox)
volta_db=.t.
MONTABRW()                                                  // inicializa tbrowse
DO WHILE volta_db
   SET CURSO OFF                                            // apaga cursor da tela
   DO WHILE !br_w:stabilize() .AND. NEXTKEY()=0             // apresenta dados na tela
   ENDD
   x_ = COL() ; y_ = ROW()                                  // salva posicao atual do cursor
   READINSERT(.f.)                                          // retira o "insert"
   t = SUBS(mold,2,1)
   IF br_w:nleft+22<br_w:nright                             // msg no canto superior esquerdo
      @ br_w:ntop-2,br_w:nleft+12 SAY IF(DELE(),"{Exclu°do}",REPL(t,10))
   ENDI
   IF br_w:nleft+31<br_w:nright                             // msg inicio/fim de arq no centro
      msg=IF(br_w:hittop,"{In°cio}",IF(br_w:hitbottom,"{Final}"+t,REPL(t,8)))
      @ br_w:ntop-2,br_w:nleft+23 SAY msg
   ENDI
   IF br_w == br_origem .AND. br_w:stable                   // esta na janela superior
      IF MOSTRA_RELA()                                      // e' preciso refazer janela de baixo
         FORCABRW(.f.)                                      // entao vamos la...
      ENDI
   ENDI
   cod_sos=hlp_cod

   #ifdef COM_MOUSE
      tecl_p=MOUSETECLA(br_w:ntop-1,br_w:nleft-1,;           // aguarda com controle de mouse
                        br_w:nbottom+1,br_w:nright+1,.f.;
             )
      MOUSEGET(@li,@co)                                      // salva posicao atual do mouse
      IF tecl_p=CLICK                                        // se botao esquerdo foi pressionado
         t=br_w:rowpos; colpos_=br_w:colpos                  // salva linha/coluna atual
         br_w:dehilite(); tecl_p=0                           // desliga cursor do browse
         br_w:rowpos:=t+li-y_                                // linha do clique
         FOR i=br_w:rightvisible TO br_w:leftvisible STEP -1
            br_w:dehilite()                                  // deliga/liga cursor da coluna para
            br_w:colpos:=i                                   // pegar as nova coordenadas do cursor
            br_w:hilite()
            IF COL()-1<=co                                   // a coluna do clique e' esta?
               tecl_p=1                                      // flag fim da procura
               EXIT                                          // e sai do FOR...
            ENDI
         NEXT
         IF tecl_p=0 .AND. Br_w:freeze>0                     // se ainda nao achou a coluna
            FOR i=br_w:freeze TO 1 STEP -1                   // verifica se esta' nas colunas
               br_w:dehilite()                               // congeladas
               br_w:colpos:=i
               br_w:hilite()
               IF COL()-1<=Co                                // achamos a coluna do clique
                  EXIT
               ENDI
            NEXT
         ENDI
         IF t=br_w:rowpos .AND. colpos_=br_w:colpos          // clicou duas vezes na mesma
            KEYB CHR(77)                                     // coluna entao forca modificacao
         ENDI
         tecl_p=0                                            // nao faz nada
      ENDI
   #else

      #ifdef COM_REDE
         tecl_p=INKEY(drvtempo)                              // espera tecla ser digitada
      #else
         tecl_p=INKEY(0)                                     // espera tecla ser digitada
      #endi

   #endi

   #ifdef COM_REDE
      IF tecl_p=0                                            // nao teclou nada, sai pelo
         br_w:refreshall()                                   // tempo de "refresh" entao
         FORCABRW(.f.)                                       // forca reimpressao dos dados
         LOOP                                                // na tela e volta
      ENDI
   #endi

   IF SETKEY(tecl_p)!=NIL                                    // executa funcao associada a
      EVAL(SETKEY(tecl_p))                                   // tecla digitada se existir
      tecl_p=0                                               // nao faz mais nada
   ENDI
   SET CURSO ON                                              // acende o cursor
   nm = ASCAN(tb,{|ve_a| tecl_p = ve_a[1]})                  // verifica se tecla esta
   IF nm != 0                                                // no vetor de teclas progamadas
      IF tb[nm,2]!=NIL                                       // em caso afirmativo,
         EVAL(tb[nm,2])                                      // executa a funcao definida para
      ENDI                                                   // a tecla
   ELSE
      br_w:dehilite()                                        // apaga barra cursora
      IF tecl_p=K_F10
         SET CURS OFF                                        // desliga cursor
         tbmenu="PFDMERVNAIOQL"+IF(fg_loc,"S","")+;
                "GCTJXZ"

         #ifdef COM_REDE
            tbmenu+="+-"                                     // teclas de "refresh"
         #endi

         l_m=IF(op_sis>nss,"",exrot[op_sis])                 // senhas nao tem rotinas
         l_m=RTRIM(mo_dif+l_m)                               // para serem retiradas
         FOR i=1 TO LEN(l_m)                                 // retira rotina que o usuario
            tbmenu=STRTRAN(tbmenu,SUBS(l_m,i,1),"")          // nao pode acessar e monta menu
            tbmenu=STRTRAN(tbmenu,SUBS(l_m,i,1),"")          // nao pode acessar e monta menu
         NEXT                                                // com as rotinas disponiveis
         msg =IF(AT("P",tbmenu)>0,"P. Procura determinado registro  ˇ|","")
         msg+=IF(AT("F",tbmenu)>0,"F. Filtragem (seleciona/ordena)  ˇ|","")
         msg+=IF(AT("D",tbmenu)>0,"D. DigitaáÑo - inclui registros  ˇ|","")
         msg+=IF(AT("M",tbmenu)>0,"M. Modifica conte£do do campo    ˇ|","")
         msg+=IF(AT("E",tbmenu)>0,"E. Exclui (marca apagamento)     ˇ|","")
         msg+=IF(AT("R",tbmenu)>0,"R. Recupera (desmarca apagamento)ˇ|","")
         msg+=IF(AT("V",tbmenu)>0,"V. Và todo o registro na tela    ˇ|","")
         msg+=IF(AT("N",tbmenu)>0,"N. Nova coluna                    |","")
         msg+=IF(AT("A",tbmenu)>0,"A. Apaga coluna do cursor        ˇ|","")
         msg+=IF(AT("I",tbmenu)>0,"I. Imprime a consulta            ˇ|","")
         msg+=IF(AT("O",tbmenu)>0,"O. Ordena os registros           ˇ|","")
         msg+=IF(AT("Q",tbmenu)>0,"Q. Quantifica registros          ˇ|","")
         msg+=IF(AT("L",tbmenu)>0,"L. Localiza um registro          ˇ|","")
         msg+=IF(AT("S",tbmenu)>0,"S. Seguinte - localiza seguinte  ˇ|","")
         msg+=IF(AT("G",tbmenu)>0,"G. Global - processa os registrosˇ|","")
         msg+=IF(AT("C",tbmenu)>0,"C. Congela/descongela colunas    ˇ|","")
         msg+=IF(AT("T",tbmenu)>0,"T. Tamanho - muda tamanho coluna ˇ|","")
         msg+=IF(AT("J",tbmenu)>0,"J. "+IF(outro_db=NIL,"Janela - abre uma nova janela ˇ|","Janela - troca de janelas     ˇ|"),"")
         msg+=IF(AT("X",tbmenu)>0,"X. eXporta dados (TXT, SDF, DBF) ˇ|","")
         msg+=IF(AT("Z",tbmenu)>0,"Z. totaliZa coluna (se numÇrica) ˇ|","")

         #ifdef COM_REDE
            msg+=IF(AT("+",tbmenu)>0,"+. +5 seg na remontagem da tela  ˇ|","")
            msg+=IF(AT("-",tbmenu)>0,"-. -5 seg na remontagem da tela  ˇ|","")
         #endi

         msgt="OPÄôES|(ALT-F10=excluidos, ALT-Z=zoom)"
         op_db=DBOX(msg,,,E_MENU,,msgt,,,op_db)               // escolhe a rotina
         IF op_db = 0                                         // cancelou...
            LOOP
         ENDI
         tecl_p = ASC(SUBS(tbmenu,op_db,1))                   // pega o ASC
         IF SUBS(tbmenu,op_db,1)="L"                          // se escolheu "localiza", entao ajusta
            op_db++                                           // default para o continua
         ENDI
         SET CURSO ON                                         // acende o cursor
      ELSEIF tecl_p = K_F9 .AND. op_sis<=nss                  // ve outros arquivos
         tecl_p=K_F9
         IF !M->v_out                                         // se tem permissao
            l_sup=li_sup; l_inf=li_inf                        // salva coordenadas da janela
            c_sup=co_sup; c_inf=co_inf
            m_od=mo_dif                                       // salva rotinas acessadas e
            br_w1 := br_w                                     // o objeto browse atual
            VEOUTROS()                                        // escolhe arquivo a consultar
            br_w := br_w1                                     // restaura o browse
            br_w:configure()                                  // remonta titulo da colunas
            volta_db=.t.
            li_sup=l_sup; li_inf=l_inf                        // restaura as coordenadas da
            co_sup=c_sup; co_inf=c_inf                        // janela e
            mo_dif=m_od                                       // rotinas acessadas
            br_w:refreshall()                                 // refaz os dados na tela
            FORCABRW(.f.)                                     // forca browse do 2a. janela (se existir)
            MONTABRW()                                        // remonta as bordas da janela
         ELSEIF tem_t                                         // transfere o campo para o get pendente
            IF nao_vdbf                                       // se nao veio do VDBF()
               SEPARA(br_w:getcolumn(br_w:colpos):cargo)      // separa atrib coluna e transf p/ caracter
               IF tp_cp="D"
                  msg=STRTRAN(DTOC(&cp_.),"/")
               ELSE
                  msg=TRANSCAMPO(.t.,cp_)
               ENDI
               KEYB ALLTRIM(msg)                              // coloca campo no buffer do teclado
            ENDI
            volta_db=.f.
         ENDI
      ELSEIF tecl_p = K_ALT_F10                               // ALT-F10 esconde e mostra os
         SET(_SET_DELETED,!SET(_SET_DELETED))                 // registros excluidos na consulta
         IF DELE() .AND. SET(_SET_DELETED)                    // registro esta apagado
            MOV_PTR(1)                                        // acha o 1o. reg nao apagado
         ENDI
         br_w:refreshall()                                    // remonta os dados do browse
         br_w:forcestable()                                   // apresenta os dados
         br_w:refreshcurrent()                                // refaz so' a linha do browse
         FORCABRW(.f.)

      ELSEIF tecl_p = K_ALT_F8                                // ALT-F8 rola a janela
         li_sup-=2; co_sup--                                  // ajusta coordenadas e
         li_inf++; co_inf++                                   // executa a rolagem da janela
         MUDA_PJ(@li_sup,@co_sup,@li_inf,@co_inf,brw_fundo,.t.)
         li_sup+=2; co_sup++                                  // reajusta as coordenadas
         li_inf--; co_inf--
         PUBL &vr_edita.:=STR(li_sup,2)+STR(co_sup,2)         // publica variaves que contem
         SAVE TO (arqconf) ALL LIKE drv*                      // as coordenadas da janela e
         REST FROM (arqconf) ADDI                             // grava em disco
         br_origem:ntop   := li_sup                           // ajusta browse com
         br_origem:nleft  := co_sup                           // as novas coordenadas
         br_origem:nbottom:= li_inf
         br_origem:nright := co_inf
         IF br_outro != NIL                                   // se existe outra janela aberta
            M->tp=li_sup+INT((li_inf-li_sup-1)/2)+1           // ajusta as coordenadas dela
            br_origem:nbottom:=M->tp-2                        // tambem
            br_outro:ntop   := M->tp+1
            br_outro:nleft  := co_sup
            br_outro:nbottom:= li_inf
            br_outro:nright := co_inf
            FORCABRW(.f.)                                     // reemprime dados na tela
         ENDI
      ENDI
      carac_ = UPPER(CHR(tecl_p))                             // escolheu uma rotina...
      l_m=IF(op_sis>nss,"",exrot[op_sis])                     // arq de senhas nao tem restricoes
      IF AT(carac_,mo_dif+l_m)>0                              // se usuario nao tem permissao
         LOOP                                                 // nao deixa executar
      ENDI
      IF AT(carac_,"DERMGV")>0 .AND.;                         // se vai alterar um registro
         LEN(sistema[op_sis,O_CPRELA])>0                      // e se e' um filho
         POSIPAI()                                            // abre/posiciona seus pais
      ENDI
      DO CASE

         #ifdef COM_REDE
            CASE (tecl_p=43 .OR. tecl_p=45)                   // teclou + ou - para mudar o "refresh"
               DO WHILE .T.
                  msg=LTRIM(STR(drvtempo))
                  msg=IF(drvtempo=0,"NÑo",msg+" seg")         // tempo=0 nao tem "refresh"
                  ALERTA(1)
                  DBOX(msg,,,25,,"'REFRESH`|(+/-)")           // mostra msg do tempo atual
                  IF LASTKEY()=43                             // teclou +, entao
                     drvtempo=IF(drvtempo>57,60,drvtempo+5)   // aumenta o tempo em 5 seg
                  ELSEIF LASTKEY()=45                         // teclou -, entao
                     drvtempo=IF(drvtempo<1,0,drvtempo-5)     // diminui o tempo em 5 seg
                  ELSE                                        // teclou algo diferente de + e -
                     EXIT                                     // entao aceita refresh atual
                  ENDI
               ENDD
         #endi


         CASE tecl_p = K_ENTER                                // teclou o ENTER
            IF nao_vdbf                                       // nao veio do VDBF() o ENTER movimentara'
               KEYB CHR(VAL(SUBS(ch_tecl,dir_cur*2-1,2)))     // para onde a SETA (TAB) esta apontando
            ELSE                                              // caso contrario,
               volta_db=.f.                                   // retorna falso
            ENDI

         CASE tecl_p = K_TAB                                  // teclou o TAB
            dir_cur()                                         // muda direcao do cursor

         CASE tecl_p = K_ALT_Z .AND. !db_zoom                 // aumenta o tamanho da janela
            li_sup=3; li_inf=22; co_sup=3; co_inf=77          // coordenadas da janela expandida
            br_origem:nTop   := li_sup                        // passa as novas coordenadas
            br_origem:nbottom:= li_inf                        // para o browse de cima
            br_origem:nleft  := co_sup
            br_origem:nright := co_inf
            IF br_outro != NIL                                // existe a janela de baixo
               M->tp=li_sup+INT((li_inf-li_sup-1)/2)+1        // linha de divisao das janelas
               br_origem:nbottom := M->tp - 2                 // final da janela de cima
               br_outro:nTop   := M->tp+1                     // topo da jenela de baixo
               br_outro:nbottom:= li_inf                      // ajusta o resto das
               br_outro:nleft  := co_sup                      // coordenadas
               br_outro:nright := co_inf
            ENDI
            db_zoom:=.t.                                      // flag dizendo do zoom
            FORCABRW(.t.)                                     // reimprime janela nao ativa
            MONTABRW()                                        // remonta janela

         CASE tecl_p = K_F1                                   // teclou F1
            help()                                            // mostra ajuda correspondente

         CASE tecl_p = K_ESC                                  // teclou ESC
            volta_db=.f.                                      // abandona a consulta

         CASE carac_="A" .AND. br_w:colcount > 1              // apaga consulta se mais de 1 coluna
            ALERTA(2)                                         // pede confirmacao
            msg="Apagar a coluna|Cancelar a operaáÑo"
            cod_sos=1
            op_=DBOX(msg,,,E_MENU,,"COLUNA "+MAIUSC(br_w:getcolumn(br_w:colpos):heading))
            IF op_=1                                          // confirmou...
               br_w:delColumn(br_w:colpos)                    // retira a coluna do browse
               grava_db = .t.                                 // seta flag de consulta alterada
               br_w:configure()                               // remonta todo browse
            ENDI

         CASE carac_="C" .AND.;                               // congela/descongela coluna se
              br_w:colpos-1 != br_w:freeze                    // a coluna ja' congelada
            IF br_w:freeze != 0                               // se outra coluna ja' congelada
               br_w:getcolumn(br_w:freeze+1):colsep:=NIL      // retira o marcador da coluna congelada
            ENDI
            br_w:freeze := br_w:colpos - 1                    // congela coluna requerida
            IF br_w:freeze != 0                               // se nao descongelou todas colunas
               br_w:getcolumn(br_w:colpos):colsep:=" € "      // coloca marcador de colunas congeladas
            ENDI
            br_w:configure()                                  // remonta todo browse
            grava_db = .t.                                    // seta flag de consulta alterada

         CASE carac_="D"                                      // inclusao de registros
            IF LEN(sistema[op_sis,O_CPRELA])>0 .AND.;         // se for arquivo filho
               (br_w==br_origem .OR. EMPTY(chv_rela))         // e for janela original
               ALERTA(2)                                      // nao pode incluir!
               DBOX("InclusÑo nÑo permitida!",,,3)            // mensagem ao usuario
               LOOP                                           // e retorna ao browse
            ENDI
            dele_atu=SET(_SET_DELETED,.f.)                    // salva DELE() atual,
            br_w1 := br_w                                     // browse atual,
            brw_tela = SAVESCREEN(0,0,MAXROW(),79)            // tela atual e o
            in_=INDEXORD()                                    // indice atual para incluirmos
            DBSETORDER(1)                                     // sempre pelo indice principal
            brw=.f.; op_menu=INCLUSAO                         // prepara para inclusao
            Tela_fundo=SAVESCREEN(0,0,MAXROW(),79)            // salva pano de fundo para ALT-F8
            IF op_sis>nss
               PW_INCL()                                      // inclusao de novos operadores
            ELSE
               &arq_cor._incl()                               // inclusao de novos registros de dados
            ENDI
            op_menu=PROJECOES; brw=.t.                        // volta para consulta
            DBSETORDER(in_)                                   // retorna ao indice da consulta
            REGINICIO()                                       // verifica se reg esta' no filtro
            RESTSCREEN(0,0,MAXROW(),79,brw_tela)              // restaura a tela,
            SET(_SET_DELETED,dele_atu)                        // DELE() e o
            br_w := br_w1                                     // browse anteriores
            br_w:refreshall()                                 // reapresenta os dados na tela
            FORCABRW(.f.)                                     // forca remontagem da janela relacionada
            MONTABRW()

         CASE carac_="E"                                      // exclui registro

            #ifdef COM_REDE
               IF !BLOREG(10,.5)                              // tenta bloquear o arquivo
                  LOOP                                        // nao conseguiu...
               ENDI
            #endi

            IF ! DELE()                                       // ja esta excluido?
               IF CONFEXCL()                                  // pede confirmacao
                  IF op_sis<=nss                              // se nao for a senha
                     &arq_cor._get1(EXCLUI)                   // exclui registro/processo inverso
                  ELSE                                        // se nao,
                     DELE                                     // so' exclui
                  ENDI
                  br_w:refreshcurrent()                       // remonta so' o registro na tela
                  FORCABRW(.f.)                               // remonta janela relacionada
               ENDI
            ENDI

            #ifdef COM_REDE
               UNLOCK                                         // libera o registro
            #endi


         CASE carac_="F" .OR. carac_="Q"                      // filtra/quantifica
            cri_ant = criterio
            IF carac_="F"                                     // filtra
               FILTRA(.t.,.t.)                                // escolhe o filtro
               br_w:cargo := {criterio,cpord,chv_rela,INDEXORD()}
               br_w:refreshall()                              // refaz toda a tela
               IF cri_ant!=criterio.AND.!EMPTY(criterio)      // se alterou o filtro
                  grava_db=.t.                                // seta flag de consulta alterada
               ENDI
            ELSE                                              // quantifica
               FILTRA(.f.)                                    // so' monta a expressao
               condq=criterio                                 // retorna filtro anterior
               criterio = cri_ant
            ENDI
            brw_reg=RECN()                                    // salva registro atual
            IF carac_="Q" .AND. LEN(condq)>2                  // continuacao da quantificacao
               brw_tela = SAVESCREEN(0,0,MAXROW(),79)         // da mensagem que esta contando...
               DBOX("CondiáÑo:|"+LEFT(condq,78)+"|| AGUARDE...  Contando. ESC cancela",,,,NAO_APAGA)
               INI_ARQ()                                      // move ponteiro para o inicio do arquivo
               COUNT FOR &condq WHIL INKEY()!=K_ESC TO qu     // conta....
               IF LASTKEY()!=K_ESC                            // nao cancelou entao mostra
                  ALERTA(2)                                   // quantos reg foram contados
                  DBOX("Existe(m) "+LTRIM(TRAN(qu,"@E 9,999,999"))+" registro(s)|na condiáÑo|"+LEFT(condq,78)+"|*",8)
               ENDI
               RESTSCREEN(0,0,MAXROW(),79,brw_tela)           // restaura a tela anterior e
               GO brw_reg                                     // o registro
            ENDI
            MONTABRW()                                        // remonta janela de visualizacao

         CASE carac_="G"                                      // processo glogal
            brw_tela = SAVESCREEN(0,0,MAXROW(),79)            // salva situacao atual
            brw_reg = RECNO()
            GLOBAL()                                          // executa processo
            GO brw_reg                                        // restabelece situacao anterior
            REGINICIO()                                       // verifica se reg esta' no filtro
            br_w:cargo := {criterio,cpord,chv_rela,INDEXORD()}
            br_w:refreshall()                                 // remonta dados da tela
            RESTSCREEN(0,0,MAXROW(),79,brw_tela)              // restaura tela
            MONTABRW()                                        // remonta janela do browse

         CASE carac_="I"                                      // imprime consulta
            IMP_BRW()

         CASE carac_="J" .AND. br_outro != NIL                // troca janela de consulta
            TROCA_BRW()                                       // troca arquivo do browse
            br_w:colorspec := drvcorbox+","+INVCOR(drvcorbox)+","+drvcorenf+","+drvcorget
            FORCABRW(.t.)                                     // troca as cores da janela
            MONTABRW()                                        // remonta dados e a
            br_w:hilite()                                     // janela com a nova cor

         CASE carac_="J"                                      // abre uma nova janela
            msg=""; op_a=0; db=""
            pp=SETKEY(K_F9,NIL)                               // desliga F9 (consulta outro DBF)
            FOR i=1 TO nss                                    // monta menu de DBF disponiveis
               IF sistema[i,O_OUTROS,O_NIVEL]<=nivelop
                  msg+="|"+sistema[i,O_MENU]
                  db+=RIGHT(STR(100+i),2)
               ENDI
            NEXT
            cod_sos=30
            IF LEN(msg)>1                                     // escolhe o DBF da nova janela
               op_a=DBOX(SUBS(msg,2),,,E_MENU,,"BASES DE DADOS")
            ENDI
            IF op_a>0                                         // escolheu...
               op_a=VAL(SUBS(db,op_a*2-1,2))                  // acha a sua subscricao
               op_sis_x=op_sis                                // salva subscricao atual
               SETCOLOR(drvcortna)
               IF abreoutro(op_a)                             // e abre a outra janela
                  grava_db = .t.                              // flag de consulta alterada
                  IF op_sis_x != op_sis
                     op_ind=1                                 // indice 'default`
                     qt_ind=LEN(sistema[op_sis,O_INDIC])      // qde de indices do arquivo
                     chv=ATAIL(sistema[op_sis,O_CHAVE])       // pega ultimo elemento das chaves
                     IF chv=="codlan"                         // se e' ntx de relacionamento nao pode
                        qt_ind--
                     ENDI
                     IF qt_ind>1                              // escolheum conjunto de indice
                        msg=""
                        FOR t=1 to qt_ind
                           msg+="|"+sistema[op_sis,O_CONSU,t]
                        NEXT
                        op_ind=DBOX(SUBS(msg,2),,,E_MENU,,"SELECIONE O INDICE")
                        IF op_ind>1
                           DBSETORDER(op_ind)
                        ENDI
                     ENDI
                     SELE (m_origem)
                     x_=ASCAN(sistema[op_sis_x,O_DBRELA],{|db_|sistema[op_sis,O_ARQUI]=db_})
                     i_=LEN(sistema[op_sis,O_CPRELA])         // se DBF escolhido e relacionado,
                     IF x_>0.AND.i_>0                         // monta a expressao de relacionamento
                        chv_rela=""
                        FOR i=1 TO LEN(sistema[op_sis,O_CPRELA])
                           chv_rela+="+"+TRANSCAMPO(.f.,sistema[op_sis,O_CPRELA,i],i)
                        NEXT
                     ELSE                                     // se usuario montar expressao
                        PEGARELA(.t.)
                     ENDI
                     chv_rela=IF(LEN(chv_rela)>2,SUBS(chv_rela,2),"")
                     br_outro:cargo := {"","",chv_rela,op_ind}// inicializa variavel de usuario
                  ENDI
                  criterio:=cpord := ""                       // inicializa filtro/ordenacao
                  SELE (outro_db)                             // muda para a janela de baixo
                  PEGACHV2()                                  // pega final do relaciomento
                  INI_ARQ()                                   // procura 1o. reg da relacao
                  LDBEDIT(.f.)                                // monta as novas colunas
                  FORCABRW(.t.)                               // imprime dados da janela de cima
                  MONTABRW()                                  // monta nova janela de visualizacao
               ELSE
                  op_sis = op_sis_x                           // nao conseguiu abrir nova janela
               ENDI
            ENDI
            SETKEY(K_F9,pp)                                   // habilita F9 (consulta outros DBFs)

         CASE carac_="L"                                          // localiza registro
            SEPARA(br_w:getcolumn(br_w:colpos):cargo)             // separa atributos da coluna
            cod_sos=36
            ecara=(tp_cp=="C".OR.tp_cp=="M")                      // tipo do campo
            brw_tela = SAVESCREEN(0,0,MAXROW(),79)                // salva tela atual
            chvpesq=IF(ecara,SPAC(30),IF(tp_cp="D",CTOD(''),IF(tp_cp="L",.t.,0)))
            msg="Argumento - Localiza argumento no campo "+cp_titu+;
                "|CondiáÑo - Localiza registro sob uma condiáÑo"+;
                "|Cancelar a operaáÑo"                            // escolhe o tipo de localizacao
            x=DBOX(msg,,,E_MENU,,SEPLETRA("LOCALIZAÄéO",1))
            IF x!=0 .AND. x!=3                                    // nao cancelou
               cond_p=""
               IF x=1                                             // localiza por argumento
                  msg="LOCALIZAR ARGUMENTO "+IF(ecara,"CONTIDO ","")+" EM "+MAIUSC(cp_titu)
                  chvpesq=DBOX("Informe o argumento",,,,,msg,chvpesq,cp_masc)
                  IF cp_crit=="V" .OR. CRIT(cp_crit,18)           // argumento de pesquisa ok?
                     IF (!EMPT(chvpesq) .OR. tp_cp="L").AND.LASTKEY()!=K_ESC
                        IF ecara                                  // se for caracter
                           chvpesq=ALLTRIM(chvpesq)               // deixa localizar so as letras digitadas
                           igc=1                                  // se tem minusculo no campo
                           IF cp_masc!="@!"                       // pergunta se quer ignorar a caixa
                              igc=DBOX("Sim|NÑo|Cancelar a operaáÑo",,,E_MENU,,"IGNORAR CAIXA|(A=a)?")
                           ENDI
                           IF igc=1.OR.igc=2                      // prepara expressao de pesquisa
                              cond_p=IF(igc=2,"'"+chvpesq+"' $ "+cp_,"MAIUSC('"+chvpesq+"') $ UPPER("+cp_+")")
                           ENDI
                        ELSE
                           cond_p=cp_+"=chvpesq"                  // prepara expressao de pesquisa
                        ENDI
                     ENDI
                  ENDI
               ELSE                                               // localiza por condicao
                  cri_ant = criterio                              // salva filtro atual
                  FILTRA(.f.)                                     // monta expressao de pesquisa
                  cond_p=criterio
                  criterio = cri_ant                              // retorna filtro atual
               ENDI
               RESTSCREEN(0,0,MAXROW(),79,brw_tela)               // restaura tela anterior
               IF LEN(cond_p)>2                                   // continua a localizar...
                  DBOX("Localizando|"+LTRIM(TRAN(chvpesq,""))+"|*|ESC interrompe",,,,NAO_APAGA,"AGUARDE...")
                  brw_reg=RECN()
                  INI_ARQ()                                       // move ponteiro para o inicio do arquivo
                  LOCA FOR &cond_p. WHIL INKEY()!=K_ESC           // tenta localizar registro desejado
                  IF ! FOUND().AND.LASTKEY()!=K_ESC               // nao achou ou cancelou
                     ALERTA(4)
                     DBOX("NÑo encontrado!|*",13,40)              // mensagem ao usuario
                     GO brw_reg
                  ELSE
                     ALERTA(1)                                    // achou...
                     fg_loc=.t.                                   // sinal sonoro
                  ENDI
               ENDI
               br_w:refreshall()                                  // remonta os dados da consulta
            ENDI
            RESTSCREEN(0,0,MAXROW(),79,brw_tela)                  // restaura tela anterior

         CASE carac_="M"                                          // modifica registro
            IF !br_w:stable                                       // forca a apresentacao de
               br_w:forcestable()                                 // todos os registros na tela
               x_=COL(); y_=ROW()                                 // salva coordenadas atuais do cursor
            ENDI

            #ifdef COM_REDE
               IF !BLOREG(10,.5)                                  // tenta bloquear o registro
                  LOOP                                            // nao conseguiu...
               ENDI
            #endi

            SEPARA(br_w:getcolumn(br_w:colpos):cargo)             // separa atributos da coluna
            evirt=(cp_crit=="V")                                  // pode modificar?
            IF (AT(UPPER(cp_),UPPER(INDEXKEY(1)))>0.AND.sistema[op_sis,O_OUTROS,O_TPCHV]).OR.;
               evirt.OR.DELE()
               ALERTA()
               DBOX(IF(DELE(),"REGISTRO EXCLU°DO","CAMPO NéO EDITèVEL"),12,,1)
            ELSE
               IF op_sis<=nss                                     // se nao esta' alterando a senha,
                  &arq_cor._get1(FORM_INVERSA)                    // executa processo inverso, se existir
               ENDI
               pp=.f.                                             // flag "refresh" na outra janela?
               IF IF(!EMPTY(cp_when).AND.;                        // tem pre-validacao. pode modificar?
                  !("MTAB(" $ cp_when).AND.!("VDBF(" $ cp_when),EVAL(&("{||"+cp_when+"}")),.t.)
                  SETCOLOR(drvcorbox)                             // coloca mensagem no topo da janela
                  IF br_w:nleft+22<br_w:nright                    // avisando que estamos modificando
                     @ br_w:ntop-2,br_w:nleft+12 SAY "{Modifica}"
                  ENDI
                  brw_reg = RECNO()                               // salva registro atual
                  ALERTA(1)                                       // Beep!
                  IF tp_cp=="M"                                   // campo memo...
                     EDIMEMO(cp_,cp_titu,15,2,MAXROW()-1,3+VAL(SUBS(cp_masc,3)),cp_crit)
                  ELSE
                     i = br_w:getcolumn(br_w:colpos):width        // o tamanho atual da coluna
                     IF i != LEN(TRAN(&cp_.,cp_masc)) .AND.;      // esta' diferente to tamanho
                        tp_cp="C"                                 // real do campo estao vamos
                        cp_masc="@S"+ALLTRIM(STR(i,3))+cp_masc    // forcar a rolagem do campo
                     ENDI
                     @ y_,x_ GET &cp_. PICT cp_masc;
                                       VALI CRIT(cp_crit);
                                       WHEN cp_when
                                       AJUDA cp_help
                                       CMDF8 cp_cmd
                     READ
                  ENDI
                  IF br_w:nleft+22<br_w:nright                    // retira mensagem de alteracao
                     @ br_w:ntop-2,br_w:nleft+12 SAY REPL(SUBS(mold,2,1),10)
                  ENDI
                  REGINICIO()                                     // verifica se reg esta' no filtro
                  br_w:refreshcurrent()                           // refaz a linha onde o campo foi modificado
                  IF tp_cp!="M".AND.LASTKEY()!=K_ESC.AND.;        // se o campo nao for memo, nao deu ESC,
                     RECNO()=brw_reg .AND.;                       // nao esta fora do filtro/relacao e
                     AT(UPPER(cp_),UPPER(INDEXKEY(0)))=0          // o campo nao faz parte do indice
                     i_=CHR(VAL(SUBS(ch_tecl,dir_cur*2-1,2)))     // entao passa para o proximo campo
                     KEYB i_+"M"                                  // onte o TAB esta indicando
                  ELSE                                            // caso contrario,
                     IF RECNO() <> brw_reg .OR.;                  // se o campo esta fora do filtro
                        AT(UPPER(cp_),UPPER(INDEXKEY(0)))>0       // ou o campo for parte do indice
                        br_w:refreshall()                         // remonta toda a tela
                     ENDI
                     pp=.t.                                       // flag para refazer o browse
                  ENDI
                  GO brw_reg                                      // reposiciona ponteiro

               ELSE                                               // nao pode ser modificado
                  ALERTA()                                        // mostra por que
                  DBOX("Modifica quando "+UPPER(cp_when),,,3,,"PRê-CR°TICA NéO ATENDIDA!")
               ENDI

               IF op_sis<=nss                                     // se nao for o arquivo de senhas,
                  &arq_cor._get1(FORM_DIRETA)                     // executa processos/lancamentos
               ENDI
               IF pp                                              // se for preciso, forca
                  REGINICIO()                                     // verifica se reg esta' no filtro
                  FORCABRW(.f.)                                   // browse da outra janela
               ENDI
            ENDI

            #ifdef COM_REDE
               UNLOCK                                             // atualiza o disco
            #endif


         CASE carac_="N"                                          // cria nova coluna
            cod_sos=28
            cp_ =SPAC(250) ; cp_titu=SPAC(30)                     // inicializa variveis
            cp_masc=SPAC(30)
            msg="T°tulo da nova coluna:"
            f10=.f.                                               // recebe titulo da nova coluna
            SET KEY K_F10 TO colnova                              // F10 campo de outro arquivo
            cp_titu=DBOX(msg,,,,,"NOVA COLUNA|*|F10=CAMPO DE OUTRO ARQUIVO",cp_titu)
            SET KEY K_F10 TO                                      // desativa F10
            IF LASTKEY()!=K_ESC                                   // se nao abandonou e nao teclou
               IF !f10                                            // F10, recebe conteudo da nova coluna
                  msg+=" "+ALLTRIM(cp_titu)+"|ExpressÑo conte£do:"
                  DO WHILE .t.
                     SET KEY K_F10 TO ve_campos                   // F10 ve campos da estrutura
                     cp_=DBOX(msg,,,,,"NOVA COLUNA|*|F10=CAMPOS DO ARQUIVO",cp_,"@S52@!")
                     SET KEY K_F10 TO                             // desativa F10
                     IF LASTKEY()!=27 .AND. !EMPTY(cp_)           // verifica se o conteudo e valido
                        IF !CRIT("[U]!=TYPE(cp_) .OR. ([|] $ cp_ .AND. [->] $ cp_)~EXPRESSéO ILEGAL",15)
                           LOOP
                        ENDI
                     ENDI
                     EXIT
                  ENDD
               ENDI
               IF !EMPT(cp_) .AND. LASTKEY()!=K_ESC              // nao cancelou...
                  IF !f10                                        // recebe mascara da nova coluna
                     msg+=" "+LEFT(ALLTRIM(cp_),30)+"|Com a m†scara:"
                     cp_masc=DBOX(msg,,,,,"NOVA COLUNA",cp_masc,"@!")
                  ENDI
                  IF LASTKEY()!=K_ESC                            // se nao cancelou
                     IF SETARELA(cp_)                            // coloca set relation
                        IF br_w == br_origem                     // e prepara variavel para
                           db_1rela=db_1rela+TRIM(cp_)+"≥"       // a gravacao da consulta
                        ELSE
                           db_2rela=db_2rela+TRIM(cp_)+"≥"
                        ENDI
                        cp_=SUBS(cp_,AT("|",cp_)+1)
                     ENDI                                        // cria nova coluna com o que
                     ncol = br_w:colpos                          // foi informado
                     cp_titu=ALLTRIM(cp_titu) ; cp_=ALLTRIM(cp_) ; cp_masc=ALLTRIM(cp_masc)
                     br_w:inscolumn(ncol,tbcolumnnew(cp_titu,&("{||TRAN("+cp_+",["+cp_masc+"])}")))
                     br_w:getcolumn(ncol):cargo := cp_+"≥"+cp_masc+"≥"+cp_titu+"≥≥V"
                     br_w:getcolumn(ncol):width := LEN(TRAN(&cp_.,cp_masc))
                     br_w:getcolumn(ncol):colorblock={||IF(DELE(),{3,2},{1,2})}
                     grava_db = .t.                              // modificou a consulta (flag)
                     br_w:refreshall()                           // remonta toda a tela
                  ENDI
               ENDI
            ENDI
            SET KEY K_F10 TO                                     // desativa F10

         CASE carac_="O"                                     // ordenacao da consulta
            cpord=""
            br_wx = br_w                                     // salva browse atual
            CLASS(.t.)                                       // recebe expressao de ordenacao
            IF !EMPT(cpord)                                  // montou ordenacao?
               br_w:refreshall()                             // refaz toda a tela
               IF INDEXORD()>LEN(sistema[op_sis,O_CHAVE])    // se criou indice extra
                  grava_db = .t.                             // seta flag de gravacao e
               ENDI                                          // grava a nova ordenacao
               br_w:cargo:={criterio,cpord,chv_rela,INDEXORD()}
            ENDI
            MONTABRW()                                       // refaz todo o browse

         CASE carac_="P" .AND. ! EMPT(INDEXKEY(1))           // pesquisa indexada de registro
            brw_reg = RECNO()                                // registro atual
            POSI()                                           // recebe/procura registro
            IF brw_reg != RECNO()                            // se o reg nao e o mesmo,
               br_w:rowpos = 1                               // coloca reg atual na primeira
            ENDI                                             // linha da tela
            br_w:configure()                                 // refaz a configuracao do browse

         CASE carac_="R"                                     // recupera registro

            #ifdef COM_REDE
               IF !BLOREG(10,.5)                             // se nao bloqueou o registro,
                  LOOP                                       // retorna ao browse
               ENDI
            #endi

            IF DELE()                                        // se o registro esta' excluido
               IF op_sis<=nss                                // se o arquivo nao for o de senhas,
                  &arq_cor._get1(RECUPERA)                   // recupera reg/processo direto
               ELSE                                          // se for o de senhas
                  RECA                                       // so' recupera
               ENDI
               ALERTA(1)                                     // aviso sonoro
               br_w:refreshcurrent()                         // refaz so' a linha do browse
               FORCABRW(.f.)                                 // remonta a outra janela (se houver)
            ENDI

            #ifdef COM_REDE
               UNLOCK                                        // libera registro
            #endi


         CASE carac_="S".AND.fg_loc                          // seguinte (proximo do localiza)
            brw_tela = SAVESCREEN(0,0,MAXROW(),79)           // salva tela/avisa que esta localizando
            DBOX("LOCALIZANDO "+LTRIM(TRAN(chvpesq,""))+".|ESC interrompe",,,,NAO_APAGA,"AGUARDE!")
            brw_reg=RECN()                                   // salva registro atual
            SKIP IF(EOF(),0,1)                               // pula para o proximo, se nao for fim de arq
            LOCA FOR &cond_p. WHIL INKEY()!=K_ESC            // continua a procura...
            IF ! FOUND().AND.LASTKEY()!=K_ESC                // se nao achou,
               ALERTA(4)                                     // avisa
               DBOX("Registro nÑo encontrado!",13,40)
               GO brw_reg
            ELSE                                             // achou...
               ALERTA(1)                                     // avisa com beep e
               br_w:refreshall()                             // prepara p/ remontar toda a tela
            ENDI
            RESTSCREEN(0,0,MAXROW(),79,brw_tela)             // retira msg de "localizando"

         CASE carac_="T"                                     // muda tamanho da coluna
            SEPARA(br_w:getcolumn(br_w:colpos):cargo)        // pega tamanho atual
            x=IF(TYPE(cp_)=="M",60,LEN(TRAN(&cp_.,cp_masc)))
            msg="Informe o novo tamanho da coluna "+;
                MAIUSC(br_w:getcolumn(br_w:colpos):heading)
            cod_sos=1
            x=DBOX(msg,,,,,"TAMANHO DA COLUNA",x,"99")       // recebe o novo tamanho
            IF CRIT(STR(x)+"<=77.AND."+STR(x)+;              // se o tamanho e valido
               ">0~TAMANHO ILEGAL",12)
               br_w:getcolumn(br_w:colpos):width = x         // atualiza tamanho da coluna
               grava_db = .t.                                // no browse e
               br_w:configure()                              // reconfigura tudo
            ENDI

         CASE carac_="V"                                     // ve todo o registro na tela
            tela_fundo=SAVESCREEN(0,0,MAXROW(),79)           // salva tela
            t_tab:=SETKEY(K_TAB,NIL)                         // desativa o TAB

            #ifdef COM_MOUSE
               IF drvmouse                                   // se mouse esta' ativo,
                  MOUSEGET(@x_,@y_)                          // salva sua posicao atual
               ENDI
            #endi

            i_=SETCOLOR()                                    // salva a cor atual
            DO WHILE .t.
               DISPBEGIN()                                   // comeca a montagem da tela
               IMPRELA()                                     // imprime telas relacionadas
               &arq_cor._gets()                              // apresenta o conteudo do registro
               INFOSIS()                                     // imprime o rodape' da tela
               DISPEND()                                     // mostra tela pronta
               ALERTA(1)
               cod_sos=35

               #ifdef COM_MOUSE
                  tecl_p=MOUSETECLA(l_s,c_s,l_i,c_i,.f.)     // espera clique ou alguma tecla
               #else

                  #ifdef COM_REDE
                     tecl_p=INKEY(drvtempo)                  // espera tecla ou sai para refresh
                  #else
                     tecl_p=INKEY(0)                         // espera uma tecla ser digitada
                  #endi

               #endi

               DO CASE
                  CASE tecl_p=K_ALT_F8                       // teclou F8 (rolagem da janela)
                     rola_t=.t.                              // liga flag e
                     ROLATELA()                              // executa a rolagem
                  CASE tecl_p=K_ESC.OR.tecl_p=K_ENTER.OR.tecl_p=32
                     EXIT                                    // abandona
               ENDC
            ENDD
            SETCOLOR(i_)                                     // restaura cor anterior

            #ifdef COM_MOUSE
               IF drvmouse                                   // define janela do mouse
                  MOUSEBOX(br_w:ntop-1,br_w:nleft-1,br_w:nbottom+1,br_w:nright+1)
                  DO WHIL MOUSEGET(0,0)!=0                   // so' sai se os botoes do
                  ENDD                                       // mouse estiverem liberados
                  MOUSESET(x_,y_)                            // restaura a posicao do mouse
               ENDI
            #endi

            RESTSCREEN(0,0,MAXROW(),79,tela_fundo)           // restaura tela
            SETKEY(K_TAB,t_tab)                              // TAB volta a funcionar

         CASE carac_="X"                                           // exporta dados
            cod_sos=32                                             // escolhe o formato da exportacao
            msg="Texto - delimitados, para editores de texto|"+;
                "SDF - 'standard Data Format` para outros sistemas|"+;
                "DBF - formato padrÑo dBASE"
            op_exp=DBOX(msg,,,E_MENU,,"TIPO DE ARQUIVO DE SAIDA")
            IF op_exp!=0
               IF op_exp=1                                         // escolheu o delimitado, entao
                  dli_exp=","                                      // escolhe o delimitador
                  dli_exp=DBOX("Informe o delimitador",,,,,"SEPARAÄéO DOS CAMPOS",dli_exp)
               ENDI
               IF LASTKEY()!=K_ESC
                  brw_tela = SAVESCREEN(0,0,MAXROW(),79)           // salva a tela
                  arq_=ARQGER()                                    // recebe o nome do arquivo a gerar
                  IF !EMPTY(arq_)                                  // quer continuar...
                     cod_sos=1
                     arqexp=arq_+".TXT"                            // se o arq informado existir
                     IF FILE(arqexp)                               // verifica se pode gravar por cima
                        op_=DBOX("Gravar por cima|Cancelar a operaáÑo",,,E_MENU,,"ARQUIVO "+UPPER(arqexp)+" JA EXISTE!")
                        cn=(op_!=1)
                        IF !cn                                     // pode sobrepor,
                           ERASE (arqexp)                          // entao mata arq
                        ENDI
                     ENDI
                     IF op_exp=3                                   // se exporta para outro DBF
                        IF FILE(arq_+".DBF")                       // verifica se o DBF ja existe
                           op_=DBOX("Gravar por cima|Cancelar a operaáÑo",,,E_MENU,,"ARQUIVO "+UPPER(arq_)+".DBF JA EXISTE!")
                           cn=(op_!=1)
                        ENDI
                     ENDI
                  ENDI
                  IF !cn                                           // avisa que esta' trabalhando...
                     DBOX("Gerando o arquivo "+arqexp,15,,,NAO_APAGA)
                     ASIZE(estr_dbf,0); ASIZE(cp_exp,0)            // vetores auxiliares
                     FOR i=1 TO br_w:colcount                      // exporta todas as colunas
                        SEPARA(br_w:getcolumn(i):cargo)            // separa atributo da coluna
                        IF tp_cp!="M"                              // campo memo nao e' exportado
                           IF op_exp=3                             // exporta para DBF
                              cp_x=cp_
                              casadec=0                            // se a coluna for numerica, verifica
                              IF tp_cp="N"                         // a qde de casas decimais
                                 casadec=IF("." $ cp_masc,LEN(cp_masc)-RAT(".",cp_masc),0)
                                 tamanho=0                         // acha o tamanho
                                 FOR t=1 TO LEN(cp_masc)           // do campo
                                    IF !(SUBS(cp_masc,t,1) $ "@BCDEKXZR, ()")
                                       tamanho++
                                    ENDI
                                 NEXT
                              ELSEIF tp_cp="D"                     // a coluna e' uma data
                                 tamanho=8                         // o tamanho e' sempre 8
                              ELSEIF tp_cp="L"                     // a coluna e' tipo logico
                                 tamanho=1                         // o tamanho e' sempre 1
                              ELSE                                 // coluna tipo caracter
                                 tamanho=br_w:getcolumn(i):width
                                 cp_="LEFT("+cp_+"+["+SPAC(tamanho)+"],"+STR(tamanho,3)+")"
                              ENDI
                              IF "->" $ cp_x                       // coluna de outro arquivo
                                 cp_x=SUBS(cp_x,AT("->",cp_x)+2)   // retira o nome do DBF
                              ENDI
                              FOR tt=1 TO 12                       // retira caracteres ilegais
                                 cr_=SUBS(" ()*/+-^%$@&",tt,1)     // do conteudo da coluna
                                 IF cr_ $ cp_x                     // nome do campo do DBF a exportar
                                    cp_x=STRTRAN(cp_titu,cr_,"")
                                 ENDI
                              NEXT                                 // monta vetor da nova estrutura
                              AADD(estr_dbf,{cp_x,tp_cp,tamanho,casadec})
                           ELSE                                    // exportacao TXT/SDF
                              IF AT(tp_cp,"CN")>0                  // caracter/numerico trunca pelo tam da coluna
                                 cp_="LEFT(TRAN("+cp_+",["+cp_masc+"])+["+SPAC(br_w:getcolumn(i):width)+"],"+STR(br_w:getcolumn(i):width,3)+")"
                              END IF
                           ENDI
                           AADD(cp_exp,cp_)                        // vetor com conteudos a exportar
                        ENDI
                     NEXT
                     brw_reg = RECNO()                             // volta para registro anterior
                     dele_atu:=SET(_SET_DELETED,.t.)               // os excluidos nao serao exportados
                     INI_ARQ()                                     // move ponteiro para o inicio do arquivo
                     SET ALTE TO (arq_)                            // abre o arquivo para gravacao
                     SET ALTE ON                                   // liga gravacao
                     SET CONS OFF                                  // nao iremos exibir na tela
                     q=CHR(34)                                     // "aspas"
                     DO WHIL !EOF()                                // para todos os registros
                        FOR t=1 TO LEN(cp_exp)                     // e para todas as colunas
                           c_p=EVAL(&("{||"+cp_exp[t]+"}"))        // "code block" com o conteudo da coluna
                           IF op_exp!=1                            // se nao for delimitado
                              c_p=IF(VALTYPE(c_p)="D",DTOS(c_p),c_p)
                              ?? c_p                               // grava no arquivo
                           ELSE                                    // se delimitado grava entre aspas
                              c_p=IF(VALTYPE(c_p)="D",DTOC(c_p),c_p)
                              ?? q+ALLTRIM(c_p)+q+IF(t=LEN(cp_exp),"",dli_exp)
                           ENDI
                        NEXT
                        ?                                          // pula para proxima linha
                        SKIP                                       // pega proximo registro
                     ENDD
                     SET ALTE OFF                                  // desliga a gravacao
                     SET ALTE TO                                   // fecha arquivo
                     SET CONS ON                                   // reabilita o video
                     SET(_SET_DELETED,dele_atu)                    // restaura situacao do DELE()
                     GO brw_reg                                    // volta para registro anterior
                     IF op_exp=3                                   // exportacao para DBF
                        DBOX("Gerando o arquivo "+arq_+".DBF",15,,,NAO_APAGA)
                        i_=LEN(estr_dbf)                           // verifica/assegura que os nomes
                        FOR t=1 TO i_                              // dos campos nao estao repetidos
                           FOR i=t+1 TO i_
                              IF estr_dbf[t,1]=estr_dbf[i,1]
                                 estr_dbf[i,1]=LEFT(estr_dbf[i,1],8)+STRZERO(i,2)
                              ENDI
                           NEXT
                        NEXT
                        are_a:=SELECT()                            // area atual
                        SELE 0
                        DBCREATE(arq_,estr_dbf)                    // cria o novo DBF
                        USE (arq_)                                 // abre
                        APPEND FROM (arqexp) SDF                   // e anexa os registros
                        USE                                        // fecha
                        ERASE (arqexp)                             // elimina arq .txt temporario
                        SELE (are_a)                               // retorna para area DBF origem
                     ENDI
                     AFILL(cp_exp,"")
                     RESTSCREEN(0,0,MAXROW(),79,brw_tela)          // restaura a tela e
                     ALERTA()                                      // beep
                  ENDI
               ENDI
            ENDI

         CASE carac_="Z"                                   // totaliza coluna
            SEPARA(br_w:getcolumn(br_w:colpos):cargo)      // separa atributos da coluna
            IF tp_cp!="N"                                  // se o campo nao for numerico
               ALERTA()                                    // nao da para somar
               DBOX("Coluna nÑo pode ser totalizada",,,2)
            ELSE
               brw_tela = SAVESCREEN(0,0,MAXROW(),79)      // salva tela, registro e avisa
               brw_reg=RECN()                              // que esta somando
               DBOX("Totalizando "+MAIUSC(cp_titu)+"|ESC interrompe",,,,NAO_APAGA,"AGUARDE!")
               INI_ARQ()                                   // vai para o topo do arquivo
               x=INDEXKEY(0)                               // e comeca a somar
               y=IF(EMPTY(criterio),"1=1",criterio)
               SUM &cp_. TO tot_ FOR !DELE() WHIL INKEY()!=K_ESC .AND. &y. .AND. IF(EMPTY(chv_rela).OR.br_w==br_origem,.t.,&x.=chv_1)
               GO brw_reg
               IF LASTKEY()!=K_ESC                         // nao cancelou
                  ms="999,999,999,999,999,999"             // mostra quanto foi o somatorio
                  dec=AT(".",cp_masc)
                  ms+=IF(dec>0,SUBS(cp_masc,dec),"")
                  ms=IF(LEFT(cp_masc,1)="@",LEFT(cp_masc,3)+ms,ms)
                  ALERTA(4)
                  DBOX("O somat¢rio de "+MAIUSC(cp_titu)+" Ç|"+TRAN(tot_,ms),,,,,"TOTALIZAÄéO")
               ENDI
               RESTSCREEN(0,0,MAXROW(),79,brw_tela)        // restaura a tela
            ENDI

      ENDC
   ENDI
ENDD

#ifdef COM_MOUSE
   IF drvmouse
      DO WHIL MOUSEGET(@Li,@Co)!=0                         // se qualquer botao do mouse
      ENDD                                                 // estiver pressionado, espera
      MOUSEBOX(0,0,MAXROW(),79)                            // a sua liberacao
   ENDI
#endi

SELE (m_origem)                                            // seleciona o DBF original da consulta
sos_cod=cod_sos
cod_sos=22
IF USED() .AND. grava_db .AND. !M->v_out                   // modificou a consulta?
   db_aqcom=SPAC(58)
   DO WHIL .t.                                             // procura um nome para gravar
      hms=TIME()                                           // a consulta
      resaq=LEFT(hms,2)+SUBS(hms,4,2)+RIGHT(hms,2)+"."+LEFT(ALIAS(),3)
      aqdbe=drvdbf+"DB"+resaq
      IF ! FILE("&aqdbe.")
         EXIT
      ENDI
   ENDD
   ALERTA(2)                                               // pede um titulo para a consulta
   db_aqcom=DBOX("Identifique-a para gravaáÑo. ESC cancela",,,,,"GRAVA CONSULTA",db_aqcom)
   IF LASTKEY()!=K_ESC.AND.!EMPT(db_aqcom)
      pas = "1"                                            // grava paramenetros das duas janelas
      br_w = br_origem
      db_outro=IF(outro_db=NIL,"",ALIAS(VAL(outro_db)))
      DO WHILE .t.
         db_&pas.qtdc=br_w:colcount                        // numero de colunas
         FOR i=1 TO db_&pas.qtdc                           // para cada coluna
            tt=RIGHT(STR(100+i,3),2)
            db_&pas.carg&tt.= br_w:getcolumn(i):cargo      // (conteudo,mascara,titulo,pre-val,valida,tipo)
            db_&pas.tam&tt. = br_w:getcolumn(i):width      // tamanho da coluna
         NEXT
         id_carg = br_w:cargo                              // situacao do browse
         db_&pas.expo=id_carg[2]                           // ordem
         db_&pas.arqf=id_carg[1]                           // filtro
         db_&pas.chvr=id_carg[3]                             // relacionamento, outra janela
         db_&pas.ind_ord=id_carg[4]                        // indice atual
         db_&pas.freeze=br_w:freeze                        // coluna congelada
         IF pas = "1" .AND. br_outro != NIL                // tem outra janela aberta?
            pas="2"                                        // grava o mesmo
            SELE (outro_db)                                // para a outra janela
            br_w = br_outro
         ELSE
            EXIT                                           // gravou tudo
         ENDI
      ENDD
      SAVE ALL LIKE db_* TO (aqdbe)                        // salva em disco a consulta
   ENDI
ENDI
cod_sos=sos_cod
RETU NIL

/*
   Sintaxe: FORCABRW( <ExpL> )
   Funcao.: Reimprime dados da funcao EDITA()
              ExpL = se .t. reimprime inclusive a moldura.
   Retorna: NIL
*/
STATIC FUNC FORCABRW(imp_cx)
LOCAL id_carg:={}
PRIV op_sis, chv_1, chv_2, criterio, cpord, chv_rela, chv_1, chv_2
COMMIT
IF br_outro != NIL                     // se a 2a. janela estiver aberta
   TROCA_BRW()                         // troca janela do browse

   #ifdef COM_REDE
      COMMIT                           // forca atualizacao em disco
   #endi

   id_carg = br_w:cargo                // retira da variavel de instancia
   criterio=id_carg[1]                 // o filtro que tinha
   cpord=id_carg[2]                    // a ordenacao
   chv_rela=id_carg[3]                 // a relacao
   ind_ord=id_carg[4]                  // e o indice utilizado
   SET ORDE TO (ind_ord)
   op_sis=EVAL(qualsis,ALIAS())    // obtem subscricao do DBF no vetor Sistema
   PEGACHV2()                      // pega final do relaciomento
   IF imp_cx                           // reemprime moldura da janela
      SETCOLOR(drvcortna)
      br_w:colorspec := drvcortna+","+INVCOR(drvcortna)+","+drvcorenf+","+drvcorget
      CAIXA(mold+CHR(0),br_w:ntop-2, br_w:nleft-1, br_w:nbottom+1, br_w:nright+1)
      x=br_w:nright-br_w:nleft+1
      @ br_w:ntop-1,br_w:nleft SAY PADC(MAIUSC(sistema[op_sis,O_MENS]),x,' ')
   ENDI
   IF DELE().AND.SET(_SET_DELETED)     // registro esta apagado e nao visivel
      MOV_PTR(-1)                      // acha o 1o. reg nao apagado
   ENDI
   br_w:refreshall()                   // forca atualizacao da tela nao selecionada
   br_w:forcestable()                  // apresenta os dados
   br_w:dehilite()                     // liga barra cursora
   TROCA_BRW()                         // troca janela do browse
ENDI
RETU NIL

/*
   Sintaxe: MONTABRW()
   Funcao.: Monta janela de visualizaáÑo da consulta
   Retorna: NIL
*/
STATIC FUNC MONTABRW()
LOCAL id_carg:={}
op_sis   = EVAL(qualsis,ALIAS())             // subscricao do arquivo atual
arq_cor  = LEFT(ALIAS(),3)                   // prefixo do arquivo
id_carg  = br_w:cargo                        // variaveis da consulta
criterio = id_carg[1]                        // filtro
cpord    = id_carg[2]                        // ordenacao
chv_rela = id_carg[3]                        // relacao
ind_ord  = id_carg[4]                        // indice atual
DBSETORDER(ind_ord)                          // escolhe o indice atual
PEGACHV2()                                   // pega final do relaciomento
SETCOLOR(drvcorbox)                          // cor da janela selecionada

#ifdef COM_MOUSE
   IF drvmouse                               // define area de atuacao do mouse
      MOUSEBOX(br_w:ntop-1,br_w:nleft-1,br_w:nbottom+1,br_w:nright+1)
   ENDI
#endi


/*
   Monta janela de consulta e mensagens de status e teclas disponiveis
   nas suas bordas
*/
CAIXA(mold+CHR(0),br_w:ntop-2, br_w:nleft-1, br_w:nbottom+1, br_w:nright+1)
@ br_w:ntop-2,br_w:nleft SAY IF(EMPTY(criterio),"{Qde="+LTRIM(STR(RECC(),10))+"}",REPL(SUBS(mold,2,1),11))
x = tit_cons[IF(br_w == br_origem,1,2)]
msg="TAB [ ],F10"+IF(op_sis<=nss.AND.((M->v_out.AND.tem_t).OR.!M->v_out),",F9","")

#ifdef COM_MOUSE
   IF drvmouse                               // botoes do mouse
      msg+=" "+CHR(174)+" "+CHR(175)+" "+CHR(30)+" "+CHR(31)+" "+CHR(24)+" "+CHR(26)+" "+CHR(25)+" "+CHR(27)+" "+CHR(18)
   ENDI
#endi

msg=LEFT(msg,br_w:nright-br_w:nleft)
posi_cur=INT((br_w:nright-br_w:nleft-LEN(msg))/2)
@ br_w:nbottom+1,br_w:nleft+posi_cur SAY msg
@ br_w:nbottom+1,br_w:nleft+posi_cur+5 SAY CHR(VAL(SUBS(di_tecl,dir_cur*2-1,2)))
x=br_w:nright-br_w:nleft+1
@ br_w:ntop-1,br_w:nleft SAY PADC(MAIUSC(sistema[op_sis,O_MENS]),x,' ')
RETU NIL
