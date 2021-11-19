 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: PICK.PRG
 \ Data....: 18-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fun‡”es gerais do sistema
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
   Sintaxe: Sol_VDBF( <N1> <,N2> <,N3> <,N4> <,ExpC1> [,ExpA1] [,ExpA2] [,ExpC2] ,[Titulo] )
   Funcao.: Abre janela de consulta a outro arquivo da aplicacao
              N1,N2,N3,N4 = coordenadas da janela
                    ExpC1 = nome do arquivo a ser consultado
                    ExpA1 = arranjo de campos a mostrar na consulta
                    ExpA2 = Cabe‡alho dos campos
                     ExpN = ordem do indice associado ao arquivo
                    ExpC2 = campo a ser transferido para o get pendente
                    ExpC3 = expressao de filtro inicial
                    Titulo = Titulo da Janela
   Retorna: logico sempre .t.
*/
FUNC Sol_VDBF(l_1,c_1,l_2,c_2,db,cp_db,ca_cpdb,cp_trans,Titulo)
LOCAL v_ar, v_:=SAVESCREEN(0,0,MAXROW(),79), t_w, t_r, t_c, t_7, t_9,;
      ret_val,dele_atu:=SET(_SET_DELETED,.t.), cor_orig, i_, t_f8
PRIV tela_fundo
v_ar=READVAR()
tem_t=.f.
IF !EMPTY(v_ar)                               // alguma variavel pendente?
   IF VALTYPE(&v_ar.) $ "CNDL"                // se for caracter, numerica, data
      tem_t=!("OP_" $ UPPER(v_ar))            // ou logico e nao for de menu, pode
      v_ar=TRIM(TRANSCAMPO(.t.,v_ar))         // transferir para o get pendente
   ENDI
ENDI
DbSelectArea(&db)
DbGoTop()                                     // vai para o 1o. registro
t_w:=SETKEY(K_CTRL_W,NIL)                     // desabilita e salva
t_r:=SETKEY(K_CTRL_R,NIL)                     // as teclas de controle
t_c:=SETKEY(K_CTRL_C,NIL)
t_7:=SETKEY(K_F7,NIL)
t_9:=SETKEY(K_F9,NIL)
l_2=IF(l_2-l_1-1>RECC(),l_1+RECC()+1,l_2)
cod_sos=10
#ifdef COM_MOUSE
   IF drvmouse
      DO WHIL MOUSEGET(0,0)!=0               // se qualquer botao do mouse
      ENDD                                   // estiver pressionado espera
   ENDI                                      // liberacao
#endi
cor_orig=SETCOLOR()                          // salva cor original
t_f8=SETKEY(K_ALT_F8,NIL)                    // salva/reseta tecla ALT-F8
SetColor( drvcorbox+","+INVCOR(drvcorbox)+","+drvcorenf+","+drvcorget)

Janela(01,l_1-1,c_1,l_2,c_2)
@ l_1,c_1+1 Say PadC(Titulo,(c_1-c_2-2))

DbEDit(l_1+1,c_1+1,l_2-1,c_2-1,cp_db,VerDb1,,ca_cpdb,'Í')

Janela(02)

#ifdef COM_MOUSE
   IF drvmouse
      DO WHIL MOUSEGET(@Li,@Co)!=0                         // se qualquer botao do mouse
      ENDD                                                 // estiver pressionado, espera
      MOUSEBOX(0,0,MAXROW(),79)                            // a sua liberacao
   ENDI
#endi
SETKEY(K_ALT_F8,t_f8)                        // seta tecla ALT-F8
SETCOLOR(cor_orig)                           // restaura cor original
SET KEY K_TAB TO                             // resta TAB
SET(_SET_DELETED,dele_atu)                   // SET DELE=anterior
IF LASTKEY()!=K_ESC .AND. cp_trans!=NIL
   ret_val=&cp_trans.
ENDI
SETKEY(K_CTRL_W,t_w)                          // restaura teclas de controle
SETKEY(K_CTRL_R,t_r)
SETKEY(K_CTRL_C,t_c)
SETKEY(K_F7,t_7); SETKEY(K_F9,t_9)
RESTSCREEN(0,0,MAXROW(),79,v_)                // restaura tela
RETU ret_val

//-----------------------------------------------------------------------

//  TESTE DE TECLA PARA FUNCAO DBEDIT() - RAMALHO - MODIFICADA

FUNCTION VERDB1(MD,COUNTER)
Priv x_, y_, Linha, Coluna
ORDEM=1
SET CURSOR OFF
DO CASE
   CASE MD=1                     // FOI PRESSIONADO PGUP OU
      DBox('Inicio do Arquivo',,,1,.T.,,)  // SETA SUPERIOR NO 1 REG.
      ORDEM=1
   CASE MD=2                     // FOI PRESSIONADO PGDN OU
      DBox('Fim de Arquivo',,,1,.T.,,)     // SETA INFERIOR NO ULTIMO
      ORDEM=1                    // REGISTRO
   CASE MD=3
      DBox('Arquivo sem Conteudo',,,1,.T.,,)
      ORDEM=0
   CASE MD=4
       // TESTA A ULTIMA TECLA PRESSIONADA
      DO CASE
         CASE LASTKEY()=27  // FOI PRESSIONADO ESC
            ORDEM=0       // ABANDONA DBEDIT
         CASE LASTKEY()=13
               // FOI PRESSIONADO ENTER, NESSE CASO EDITAREMOS O CAMPO ATUAL
            //REGISTRO=RECNO() // DECLARAR NA ROTINA
                                // QUE CHAMA A FUNCAO COM PRIVATE
            ORDEM=0

      ENDCASE
ENDCASE
SET CURSOR ON
RETURN(ORDEM)
