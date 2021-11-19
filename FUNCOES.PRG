/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: FUNCOES.PRG
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
reg_dbf=POINTER_DBF()                     // salva situacao de todos dbf's
tem_t=.f.
IF !EMPTY(v_ar)                           // alguma variavel pendente?
 IF VALTYPE(&v_ar.) $ "CNDL"              // se for caracter, numerica, data
  tem_t=!("OP_" $ UPPER(v_ar))            // ou logico e nao for de menu, pode
  v_ar=TRIM(TRANSCAMPO(.t.,v_ar))         // transferir para o get pendente
 ENDI
ENDI
PTAB(IF(tem_t,v_ar,"%^"),db)              // abre arquivo e tenta posicionar

#ifdef COM_REDE
 IF NETERR()                              // se ocorreu erro de abertura
  RETU .t.                                // retorna
 ENDI
#endi

SELE (db)                                 // seleciona o arquivo escolhido
IF EOF()                                  // se fim de arquivo,
 GO TOP                                   // vai para o 1o. registro
ENDI
t_w:=SETKEY(K_CTRL_W,NIL)                 // desabilita e salva
t_r:=SETKEY(K_CTRL_R,NIL)                 // as teclas de controle
t_c:=SETKEY(K_CTRL_C,NIL)
t_7:=SETKEY(K_F7,NIL); t_9:=SETKEY(K_F9,NIL)
IF sistema[EVAL(qualsis,ALIAS()),O_OUTROS,O_NIVEL]>nivelop
 ALERTA()                                 // usuario nao tem permissao
 DBOX(msg_auto,,,3)                       // avisa
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
POINTER_DBF(reg_dbf)                      // restaura ponteiro dos dbf's
SETKEY(K_CTRL_W,t_w)                      // restaura teclas de controle
SETKEY(K_CTRL_R,t_r)
SETKEY(K_CTRL_C,t_c)
SETKEY(K_F7,t_7); SETKEY(K_F9,t_9)
RESTSCREEN(0,0,MAXROW(),79,v_)            // restaura tela
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
IF ! USED()                          // se nao existir arquivo
 RETU .f.                            // aberto, cai fora
ENDI
criterio=IF(cr_=NIL,"",cr_)          // tem filtro inicial?
cpord=IF(ord_=NIL,"",ord_)           // tem ordem inicial?
FOR i_=1 TO FCOU()                   // declara privados todos os
 msg=FIELD(i_)                       // campos do arquivo da consulta
 PRIV &msg.
NEXT

#ifdef COM_MOUSE
 IF drvmouse
  DO WHIL MOUSEGET(0,0)!=0           // se qualquer botao do mouse
  ENDD                               // estiver pressionado espera
 ENDI                                // liberacao
#endi

brw=.t.                              // pega posicao atual da tela
vr_edita=NOVAPOSI(@li_sup,@co_sup,@li_inf,@co_inf)
mo_dif=IF(mo_dif=NIL,.t.,mo_dif)     // trata as rotinas
IF TYPE("mo_dif")="L"                // que nao poderao
 IF !mo_dif                          // ser acessadas
  mo_dif="DERMG"                     // durante a consulta
 ELSE
  mo_dif=""
 ENDI
ENDI
cor_orig=SETCOLOR()                  // salva cor original
brw_reg=RECN()                       // registro atual
volta_db=.t.
SET KEY K_TAB TO dir_cur             // TAB muda posicao do cursor

#ifdef COM_REDE
 brw_tempo=drvtempo                  // tempo de "refresh"
#endi

t_f8=SETKEY(K_ALT_F8,NIL)            // salva/reseta tecla ALT-F8
BRWFUNC(PROCNAME(1)!="VDBF")         // funcoes auxiliares
SETKEY(K_ALT_F8,t_f8)                // seta tecla ALT-F8

#ifdef COM_REDE
 IF brw_tempo!=drvtempo              // se alterou o tempo de "refresh"
  SAVE TO (arqconf) ALL LIKE drv*    // salva em disco
 ENDI
#endi

SETCOLOR(cor_orig)                   // restaura cor original
op_sis = op_sy_
SET KEY K_TAB TO                     // resta TAB
brw=.f.
SET(_SET_DELETED,dele_atu)           // SET DELE=anterior
RETU .t.



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
IF br_outro != NIL               // se a 2a. janela estiver aberta
 TROCA_BRW()                     // troca janela do browse

 #ifdef COM_REDE
  COMMIT                         // forca atualizacao em disco
 #endi

 id_carg = br_w:cargo            // retira da variavel de instancia
 criterio=id_carg[1]             // o filtro que tinha
 cpord=id_carg[2]                // a ordenacao
 chv_rela=id_carg[3]             // a relacao
 ind_ord=id_carg[4]              // e o indice utilizado
 SET ORDE TO (ind_ord)
 op_sis=EVAL(qualsis,ALIAS())    // obtem subscricao do DBF no vetor Sistema
 PEGACHV2()                      // pega final do relaciomento
 IF imp_cx                       // reemprime moldura da janela
  SETCOLOR(drvcortna)
  br_w:colorspec := drvcortna+","+INVCOR(drvcortna)+","+drvcorenf+","+drvcorget
  CAIXA(mold+CHR(0),br_w:ntop-2, br_w:nleft-1, br_w:nbottom+1, br_w:nright+1)
  x=br_w:nright-br_w:nleft+1
  @ br_w:ntop-1,br_w:nleft SAY PADC(MAIUSC(sistema[op_sis,O_MENS]),x,' ')
 ENDI
 IF DELE().AND.SET(_SET_DELETED) // registro esta apagado e nao visivel
  MOV_PTR(-1)                    // acha o 1o. reg nao apagado
 ENDI
 br_w:refreshall()               // forca atualizacao da tela nao selecionada
 br_w:forcestable()              // apresenta os dados
 br_w:dehilite()                 // liga barra cursora
 TROCA_BRW()                     // troca janela do browse
ENDI
RETU NIL



/*
   Sintaxe: BRWFUNC( [ExpL] )
   Funcao.: Diversas funcoes auxiliares da EDITA()
              ExpL = .t./omitida le consultas gravadas
   Retorna: NIL
*/
STATIC FUNC BRWFUNC(nao_vdbf)



/*
   Sintaxe: IMP_BRW()
   Funcao.: Imprime a consulta da funcao EDITA()
   Retorna: NIL
*/



/*
   Sintaxe: DIR_CUR()
   Funcao.: Muda direcionamento do cursor dentro da funcao EDITA() quando
            o TAB e' acionado
   Retorna: NIL
*/
STATIC FUNC DIR_CUR
dir_cur=IF(dir_cur=4,1,dir_cur+1)
@ br_w:nbottom+1,br_w:nleft+posi_cur+5 SAY CHR(VAL(SUBS(di_tecl,dir_cur*2-1,2)))
RETU NIL



PROC FILTRA(flg,ord)  // Monta seleáÑo de registros

/*
   Se flg=.t., cria indice temporario
   Se ord=.t., alem da filtragem, oferece ordenacao
*/
LOCAL m_campos, op_sis, getlist:={}, cn:=.f.
PRIV cod_sos:=12
cpsel:=criterio :="" ; selnum:=i :=0
op_sis=EVAL(qualsis,ALIAS())                     // subscricao do vetor sistema

/*
   enche m_campos com titulos dos campos (para menu)
*/
IF nivelop>=NIV_CRI_LIVRE                        // se usuario autorizado,
 m_campos="|* * CritÇrio livre * *"              //  pode fazer filtragem livre
ELSE                                             // senao,
 m_campos=""                                     //  nao vai ter esta opcao
ENDI
nc=IF(brw,br_w:colcount,FCOU())                  // numero de campos para escolher
FOR i=1 TO nc                                    // monta menu de campos
 IF brw                                          // se chamado da EDITA()
  cargox=br_w:getcolumn(i):cargo                 //  desmembra coluna em:
  cp_=PARSE(@cargox,"≥")                         //  nome do campo
  ms_=PARSE(@cargox,"≥")                         //  mascara
  ti_=PARSE(@cargox,"≥")                         //  titulo
  m_campos+="|"+ti_                              //  monta menu de campos
 ELSE                                            // senao,
  IF !("I"==sistema[op_sis,O_CAMPO,i,O_CRIT])    //  monta menu de campos
   m_campos+="|"+sistema[op_sis,O_CAMPO,i,O_TITU]//  exceto invisivel
  ENDI
 ENDI
NEXT
m_campos=SUBS(m_campos,2)                        // despreza 1a. barra
op_6=1
m_criterio=""
DO WHIL selnum<3 .AND. cpsel!=SPAC(10)           // permite escolher somente 3 criterios
 selnum++                                        // contador de criterios
 IF selnum>1                                     // ja foi feito pelo menos um criterio
  m_tit="FILTRAGEM|OPERADORES L¢GICOS|*"+m_criterio
  op_2=DBOX("* Ok! *|E|OU",,,E_MENU,,m_tit)      // recebe operadores
  IF op_2=0                                      // cancelou
   criterio=""; cn=.t.                           // limpa criterio existente
   EXIT                                          // e retorna
  ENDI
  IF op_2=1                                      // criterio montado ok
   cpsel=SPAC(10)                                // prepara para sair
   LOOP
  ELSE
   op_2=TRIM(SUBS(".AND..OR. ",(op_2-1)*5-4,5))  // operador escolhido
   criterio  +=op_2                              // junta operador ao criterio
   m_criterio+="|"+op_2                          // monta titulo para proxima dbox()
  ENDI
 ENDI
 cpsel=SPAC(10) ; messaux=criterio
 m_tit="FILTRAGEM|CAMPOS DO ARQUIVO|*"+m_criterio
 op_1=DBOX(m_campos,,,E_MENU,,m_tit)             // escolhe campo para filtrar
 IF op_1=0                                       // cancelou
  criterio=""; cn=.t.                            // limpa criterio existente
  EXIT                                           // e retorna
 ENDI
 IF nivelop>=NIV_CRI_LIVRE                       // usuario pode fazer criterio livre
  IF op_1=1                                      // foi selecionado
   selnum=0 ; clivre=.t.
   EXIT
  ENDI
  op_1--                                         // com criterio livre, ha' mais um item
 ENDI                                            // no menu, portanto, ajusta op_1 para
 IF brw                                          // se chamado da EDITA()
  cargox=br_w:getcolumn(op_1):cargo              //  desmembra coluna para
  cpsel=PARSE(@cargox,"≥")                       //  pega o campo e a
  selpic=PARSE(@cargox,"≥")                      //  mascara
 ELSE                                            // senao,
  ii=0
  FOR i=1 TO FCOU()                              // acha campo escolhido
   IF !("I"==sistema[op_sis,O_CAMPO,i,O_CRIT])
    ii++                                         // desprezando campos
   ENDI                                          // invisiveis
   IF ii=op_1                                    // campo escolhido?
    cpsel=FIEL(i)                                //  seu nome e
    selpic=sistema[op_sis,O_CAMPO,i,O_MASC]      //  sua mascara
    EXIT
   ENDI
  NEXT
 ENDI
 tp_cp=VALTYPE(&cpsel.)                          // tipo do campo?
 m_tit="FILTRAGEM|OPERADORES RELACIONAIS|*"+;
       m_criterio+"|"+TRIM(cpsel)
 m_relac="=  Igual a      ˇ|"+;
         "#  Diferente de ˇ|"
 IF tp_cp!="L"                                   // logico so '= ou #`
  m_relac=m_relac+"<  Menor que    ˇ|"+;
                  "<= Menor ou igual|"+;
                  ">  Maior que    ˇ|"+;
                  ">= Maior ou igual"
 ENDI
 IF AT(tp_cp,"CM")>0                             // se tipo caracter ou memo tem $ (contem)
  m_relac=m_relac+"|$  ContÇm       ˇ|!$ NÑo contÇm   ˇ"
 ENDI
 op_6=DBOX(m_relac,,,E_MENU,,m_tit)              // pega operando
 IF op_6=0                                       // cancelou com ESC
  criterio=""; cn=.t.                            // limpa criterio existente
  EXIT                                           // e retorna
 ENDI
 op_s=TRIM(SUBS("= # < <=> >=$ $ ",op_6*2-1,2))  // inicializa seg oper=tipo do campo
 IF tp_cp="D"
  oper_2=CTOD("")
 ELSEIF tp_cp="N"
  oper_2=0
 ELSE
  oper_2=SPAC(LEN(&cpsel.))
 ENDI
 m_tit="FILTRAGEM: SEGUNDO OPERANDO|*"+m_criterio+"|"+TRIM(cpsel)+op_s
 oper_2=DBOX("Segundo operando (nÑo use aspas):",,,,,m_tit,oper_2,selpic)
 IF LASTKEY()=K_ESC                              // cancelou
  selnum=0                                       // zera numero de criterios,
  criterio=""; cn=.t.                            // e o criterio parcialmente definido
  EXIT                                           // para retornar
 ENDI
 IF tp_cp="D"
  oper_2="CTOD(["+DTOC(oper_2)+"])"
 ELSEIF tp_cp="N"
  oper_2=LTRIM(TRAN(oper_2,""))
 ELSE
  IF EMPT(oper_2)
   oper_2="'"+oper_2+"'"
  ELSE
   oper_2="'"+TRIM(oper_2)+"'"
  ENDI
 ENDI
 IF op_6>6
  IF op_6=8                                      // operador "nao contem" (!$)
   cpsel="!("+oper_2+PADC(op_s,3)+;
         TRIM(cpsel)+")"
  ELSE
   cpsel=oper_2+PADC(op_s,3)+TRIM(cpsel)         // operador "contem" ($)
  ENDI
 ELSE
  cpsel=TRIM(cpsel)+op_s+oper_2                  // outros operadores
 ENDI
 criterio+=cpsel                                 // monta o criterio
 m_criterio+="|"+cpsel                           // monta msg para dbox()
ENDD
IF selnum>0 .AND. !cn                            // ha criterio feito
 IF flg                                          // vamos criar indice temporario
  IF ord!=NIL                                    // e possivelmente, ordenar
   ALERTA()
   cod_sos=21
   msg="Ordenar o arquivo|Prosseguir operaáÑo"   // ve se usuario quer ordenar
   op_=DBOX(msg,,,E_MENU,,"CLASSIFICAÄéO DO ARQUIVO")
   IF op_=1                                      // sim! quer...
    cpord=""
    CLASS(.f.)                                   // entao, ordena
   ENDI
  ENDI
  INDTMP()                                       // cria indice temporario
 ENDI
ELSEIF !cn
 IF clivre                                       // monta criterio livre
  criterio=SPAC(210)
  msg="A EXPRESSéO ABAIXO DEVERè ESTAR DE ACORDO COM|"+;
      "A SINTAXE DA LINGUAGEM PARA EVITAR ERRO DE PROCESSAMENTO|*|"+;
      "F10=CAMPOS DO ARQUIVO|*|INFORME A EXPRESSéO FILTRO:"
  DO WHILE .t.
   SET KEY K_F10 TO ve_campos                    // F10 monta menu de campos
   criterio=DBOX(msg,,,,,SEPLETRA("* FILTRAGEM LIVRE *",1),criterio,"@S50")
   SET KEY K_F10 TO
   IF LASTKEY()=K_ESC                            // cancelou
    criterio=""; cn=.t.
    EXIT
   ENDI
   tp_crit=TYPE(criterio)                        // se a expressao=indeterminada
   IF tp_crit="UI"                               // existe funcao fora da clipper.lib na
    tp_crit=VALTYPE(&criterio.)                  // expressao, logo avalia o seu
   ENDI                                          // conteudo
   IF tp_crit="L"                                // se o tipo da expressao for
    EXIT                                         // logico, entao segue em frente
   ENDI
   ALERTA(3)
   DBOX("EXPRESSéO ILEGAL",15)
  ENDD
  IF !cn
   criterio=ALLTRIM(criterio)                    // tira brancos da expressao
   IF !EMPT(criterio) .AND. flg                  // vai criar indice temporario
    IF ord!=NIL                                  // e ordenar o arquivo se quiser
     CLASS(.f.)
    ENDI
    INDTMP()                                     // cria indice temporario
   ENDI
  ENDI
 ENDI
ENDI
IF EMPT(criterio) .AND. INDEXKEY(0)="LTOC("      // se tirou o filtro
 INDTMP()                                        // indexa o dbf novamente
ENDI
RETU



PROC CLASS(conf_ord_)  //  Pega seqÅància de campos para ordenar arquivo
LOCAL menucp:="", op_sis, clivre:=.f., msg, cpord_antes:=cpord,;
      qt_ind, op_ord:=0, tela_class:=SAVESCREEN(0,0,MAXROW(),79)
PRIV cod_sos:=14
op_sis=EVAL(qualsis,ALIAS())               // qual subsistema?
qt_ind=LEN(sistema[op_sis,O_CHAVE])        // qde de indices do arquivo
IF ATAIL(sistema[op_sis,O_CHAVE])="codlan" // ve se ultima chaves e' de relacionamento
 qt_ind--                                  // se for, nao pode ser escolhido
ENDI
IF qt_ind>1                                // se mais de um indice,
 msg=""                                    // escolhe por menu o conjunto
 FOR t=1 to qt_ind                         // de indice desejado para a
  msg+="|"+sistema[op_sis,O_CONSU,t]       // nova ordenacao
 NEXT
 msg+="|* OUTRA ORDEM *"                   // ou deixa escolher qualquer campo
 op_ord=DBOX(SUBS(msg,2),,,E_MENU,,"SELECIONE A ORDENAÄéO")
 DO CASE
  CASE op_ord=0                            // quer abandonar...
   op_ord=1

  CASE op_ord=qt_ind+1                     // quer escolher qualquer campo
   op_ord=0

  OTHERWISE                                // escolheu um indice...
   cpord+=IF(LEN(cpord)>1,"+","")+;        // comcatena o indice com a
          sistema[op_sis,O_CHAVE,op_ord]   // ordenacao pre-definida
 ENDC
ENDI
IF op_ord=0                           // quer definir uma ordenacao...
 msg=IF(EMPTY(cpord),"","*"+cpord)
 nc=IF(brw,br_w:colcount,FCOU())      // numero de campos para escolher a ordem
 IF nivelop>=NIV_CRI_LIVRE            // verifica se usuario autorizado a fazer
  menucp="|* * OrdenaáÑo livre * *"   // ordenacao livre
 ENDI
 FOR i=1 TO nc                        // monta menu de campos
  IF brw                              // se chamado da EDITA()
   cargox=br_w:getcolumn(i):cargo     //  desmembra coluna em:
   cp_=PARSE(@cargox,"≥")             //  nome do campo
   ms_=PARSE(@cargox,"≥")             //  mascara
   ti_=PARSE(@cargox,"≥")             //  titulo
   menucp+="|"+ti_                    //  e monta menu de campos
  ELSE                                // senao, monta menu de campos
   IF !("I"==sistema[op_sis,O_CAMPO,i,O_CRIT]) //  exceto campos invisiveis
    menucp+="|"+sistema[op_sis,O_CAMPO,i,O_TITU]
   ENDI
  ENDI
 NEXT
ENDI
DO WHIL op_ord=0
 IF LEN(msg)>0                        // mostra campos escolhidos
  op_0=DBOX(SUBS(msg,2),,50,,NAO_APAGA,"ORDENAÄéO")
 ENDI
 op_0=DBOX(SUBS(menucp,2),,6,E_MENU,,"CAMPOS PARA ORDENAR|O ARQUIVO")
 IF op_0!=0                           // escolheu um campo
  op_1=op_0
  IF nivelop>=NIV_CRI_LIVRE           // se tem autorizacao para ordenacao
   IF op_1=1                          // livre, entao faz...
    clivre=.t.
    EXIT
   ENDI
   op_1--                             // faz op_1 a subscricao do campo ou coluna
  ENDI
  IF brw                              // se chamado da EDITA()
   cargox=br_w:getcolumn(op_1):cargo  // desmembra coluna em campo, mascara e titulo
   cp_=PARSE(@cargox,"≥")
   ms_=PARSE(@cargox,"≥")
   ti_=PARSE(@cargox,"≥")
  ELSE
   ii=0
   FOR i=1 TO FCOU()                       // acha campo escolhido
    IF !("I"==sistema[op_sis,O_CAMPO,i,O_CRIT])
     ii++                                  // desprezando campos
    ENDI                                   // invisiveis
    IF ii=op_1                             // campo escolhido?
     cp_=FIEL(i)                           // seu nome e seu
     ti_=sistema[op_sis,O_CAMPO,i,O_TITU]  // titulo
     EXIT
    ENDI
   NEXT
  ENDI
  IF TYPE(cp_) $ "MLU"                     // se tipo MEMO, LOGICO ou INDEFINIDO...
   ALERTA(3)                               // ... nao da' para usar
   DBOX("Campo "+MAIUSC(ti_)+" nÑo|pode ser usado para ordenaáÑo",,,,,"ATENÄéO!")
   LOOP
  ENDI
  cp_=TRANSCAMPO(.f.,cp_)                  // transforma paara caracter
  msgt="ESCOLHA O SENTIDO DA ORDENAÄéO|DO CAMPO "+MAIUSC(ti_)
  op=DBOX("Crescente|Decrescente",,,E_MENU,,msgt)
  msg +="|"+ti_
  IF op=2                                  // pediu ordem decrescente
   cp_="DESCEND("+cp_+")"
   msg+=" (Decrescente)"
  ENDI
  cpord+=IF(LEN(cpord)>1,"+","")+cp_       // concatena campos escolhidos
 ELSE
  EXIT
 ENDI
ENDD
IF clivre                                  // vai fazer ordenacao livre
 cpord=SPAC(210)
 msg="A EXPRESSéO ABAIXO DEVERè ESTAR DE ACORDO COM|"+;
     "A SINTAXE DA LINGUAGEM PARA EVITAR ERRO DE PROCESSAMENTO|*|"+;
     "F10=CAMPOS DO ARQUIVO|*|INFORME A EXPRESSéO PARA ORDENAÄéO"
 DO WHILE .T.
  SET KEY K_F10 TO ve_campos               // habilita F10 para ver campos DBF
  cpord=DBOX(msg,,,,,SEPLETRA("* ORDENAÄéO  LIVRE *",1),cpord,"@S50")
  SET KEY K_F10 TO                         // desabilita F10
  IF LASTKEY()=K_ESC
   cpord=""                                // cancelou...
   EXIT
  ENDI
  tp_crit=TYPE(cpord)
  IF tp_crit="UI"                          // se expressao=indeterminado
   tp_crit=VALTYPE(&cpord.)                // existe funcao fora da clipper.lib
  ENDI                                     // entao avalia o conteudo da expressao
  IF tp_crit $ "CND"
   EXIT                                    // so ordena tipos numerico/caracter
  ENDI
  ALERTA(3)
  DBOX("EXPRESSéO ILEGAL",15)
 ENDD
 cpord=ALLTRIM(cpord)                      // tira brancos da expressao
ENDI
RESTSCREEN(0,0,MAXROW(),79,tela_class)     // restaura tela original
IF !EMPTY(cpord) .AND. conf_ord_ .AND.;    // mudou a ordenacao e quer
   cpord_antes!=cpord                      // que confirma a ordenacao?
 IF op_ord=0                               // se nao escolheu um ja existente
  ALERTA(1)                                // beep! e
  msg="Prosseguir|Cancelar"                // ve se usuario quer ordenar
  msgt="ORDENAÄéO DO ARQUIVO"              // realmente o arquivo
  cod_sos=1
  ii=DBOX(msg,,,E_MENU,,msgt)
  IF ii!=1                                 // se desistiu,
   cpord=cpord_antes                       //  volta ordenacao anterior
  ELSE                                     // senao,
   INDTMP()                                //  cria indice temporario
  ENDI
 ELSE
  INDTMP()                                 // seleciona indice escolhido
 ENDI
ENDI
RETU




