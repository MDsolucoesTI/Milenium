 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_OUTR.PRG
 \ Data....: 11-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fun‡”es e Procedimentos Gerais do Sistema
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas


#ifdef COM_CALE
   PROC CALE      // Rotina para exibir calend rio

   /*
      Simplificando a estrutura CASE   (thank you Rick Spence!)
      tbc e' um vetor bidimensional que contem as teclas a serem testadas
      e suas respectivas acoes (dentro de "code blocks")
   */
   LOCAL cale_tela:=SAVESCREEN(0,0,MAXROW(),79), cor_atual:=SETCOLOR(),;
   col_dia, dia_1, lisu_:=6, cosu_:=58, liin_:=20, coin_:=79,;
   i_, cl_, vr_cale, m_e_s, a_n_o, ult_dia,;
   tbc:={;
   {K_DOWN, {||datac:=datac-30}},;
   {K_UP,   {||datac:=datac+30}},;
   {K_RIGHT,{||datac:=datac+365}},;
   {K_LEFT, {||datac:=datac-365}};
   }
   SETCOLOR(drvtitmsg)
   vr_cale=NOVAPOSI(@lisu_,@cosu_,@liin_,@coin_)            // posicao atual do calendario
   CAIXA(mold,lisu_,cosu_,liin_,coin_)                      // monta tela de apresentacao
   SETCOLOR(drvcorenf)                                      // do calendario
   @ lisu_+2,cosu_+1 SAY "Do 2a 3a 4a 5a 6a Sa"
   SETCOLOR(drvtitmsg)
   @ lisu_+ 9,cosu_+1 SAY REPL("Ä",coin_-cosu_-1)
   @ lisu_+10,cosu_+2 SAY " Incrementa o MES"              // montra teclas disponiveis
   @ lisu_+11,cosu_+2 SAY " Decrementa o MES"
   @ lisu_+12,cosu_+2 SAY CHR(26)+" Incrementa o ANO"
   @ lisu_+13,cosu_+2 SAY CHR(27)+" Decrementa o ANO"
   SETCOLOR(drvcormsg)
   DO WHIL .t.
      @ lisu_+1,cosu_+1 SAY PADL(TRIM(NMES(datac))+" - "+STR(YEAR(datac)),20)
      dia_1=DOW(datac-DAY(datac)+1)              // dia da semana do 1o. dia do mes
      cl_=lisu_+3
      @ cl_,cosu_+1 CLEAR TO liin_-6,coin_-1     // limpa area dos dias
      col_dia=1+cosu_+3*(dia_1-1)                // coluna inicai do 1o. dia do mes
      m_e_s=MONTH(datac)                         // mes
      a_n_o=YEAR(datac)                          // ano
      IF INT(m_e_s/2) = m_e_s/2                  // acha ultimo dia do mes
         ult_dia=IF(m_e_s<8,IF(m_e_s=2,IF(INT(a_n_o/4)=a_n_o/4,29,28),30),31)
      ELSE
         ult_dia=IF(m_e_s<8,31,30)
      ENDI
      FOR i_=1 TO ult_dia                        // imprime os dias
         IF DAY(DATE())=i_                       // se for heje
            SETCOLOR(drvcorenf)                  // enfatiza
         ENDI
         @ cl_,col_dia SAY PADL(STR(i_,2),2)     // imprime o dia na tela
         SETCOLOR(drvcormsg)                     // retorna a cor normal
         col_dia+=3                              // proxima coluna
         IF dia_1/7=INT(dia_1/7)                 // fim da tela do calendario
            cl_++ ; col_dia=cosu_+1              // passa para proxima linha
         ENDI
         dia_1++                                 // proximo dia
      NEXT
      x=SETCURSOR(0)                             // apaga cursor, x=cursor atual

      #ifdef COM_MOUSE
         k=MOUSETECLA(lisu_+10,cosu_+2,liin_-1,cosu_+2)
      #else
         k=INKEY(0)                              // aguarda pressionar tecla
      #endi

      SETCURSOR(x)                               // volta tamanho original do cursor
      nm=ASCAN(tbc,{|ve_a| k=ve_a[1]})           // procura tecla dentro do vetor tbc (e' o CASE)
      IF nm!=0                                   // achou!
         EVAL(tbc[nm,2])                         // portanto, executa a acao...
      ELSE
         IF k=K_ALT_F8                           // muda calendario de posicao
            MUDA_PJ(@lisu_,@cosu_,@liin_,@coin_,cale_tela,.t.)
            sinal_=" "
            PUBL &vr_cale.:=STR(lisu_,2)+STR(cosu_,2)
            SAVE TO (arqconf) ALL LIKE drv*      // salva as coordenadas em disco
         ELSE                                    // tecla sem acao, portanto,
            EXIT                                 // fora...
         ENDI
      ENDI
   ENDD
   RESTSCREEN(0,0,MAXROW(),79,cale_tela)         // restaura tela e
   SETCOLOR(cor_atual)                           // o esquema de cor

   #ifdef COM_MOUSE
      IF drvmouse                                // se o mouse esta' ativo
         DO WHIL MOUSEGET(0,0)!=0                // espera que os botoes sejam
         ENDD                                    // liberados (nao pressionados)
      ENDI
   #endi

   RETU
#endi


#ifdef COM_MAQCALC
   PROC MAQCALC      // Apresenta "pop-calculadora"
   LOCAL tela_c:=SAVESCREEN(0,0,MAXROW(),79), cur_sor:=SETCURSOR(1),;
   getlist:={}, vr_calc, pg_up, pg_dn, tec_f3, tec_f4, tec_f9, tec_f8
   PRIV  sinal_:=" ", num_disp, fgpaste, cor_calc:=SETCOLOR(),;
   lisu_:=1, cosu_:=40, liin_:=9, coin_:=64, sinal_ant:=" "
   vr_calc=NOVAPOSI(@lisu_,@cosu_,@liin_,@coin_)   // pega posicao atual da calculadora
   fgpaste=(!EMPT(READVAR()).AND.;     // ve se ha campo pendente (captura)
   LEFT(READVAR(),4)!="OPC_")
   SETKEY(K_F6,NIL)                    // evita recursividade
   pg_up =SETKEY(K_PGUP,NIL)           // desabilita PgUp,
   pg_dn =SETKEY(K_PGDN,NIL)           // PgDn,
   tec_f3=SETKEY(K_F3,NIL)             // F3,
   tec_f4=SETKEY(K_F4,NIL)             // F4,
   tec_f9=SETKEY(K_F9,NIL)             // F9 e move caixa ( ALT-F8 )
   tec_f8=SETKEY(K_ALT_F8,{||sinal_dig()})

   SETKEY(35 ,{||sinal_dig()})         // #   raiz quadrada
   SETKEY(36 ,{||sinal_dig()})         // $   inteiro/flutuante
   SETKEY(37 ,{||sinal_dig()})         // %   percentual
   SETKEY(42 ,{||sinal_dig()})         // *   multiplica
   SETKEY(43 ,{||sinal_dig()})         // +   soma
   SETKEY(45 ,{||sinal_dig()})         // -   subtrai
   SETKEY(47 ,{||sinal_dig()})         // /   divide
   SETKEY(61 ,{||sinal_dig()})         // =   total
   SETKEY(94 ,{||sinal_dig()})         // ^   exponencial
   SETKEY(99 ,{||sinal_dig()})         // c   limpa display
   SETKEY(67 ,{||sinal_dig()})         // C
   IF fgpaste
      SETKEY(82 ,{||sinal_dig()})      // R   captura resultado do display
      SETKEY(114,{||sinal_dig()})      // r
   ENDI
   SETCOLOR(drvcormsg)
   CAIXA(mold,lisu_,cosu_,liin_,coin_)
   @ lisu_+1,cosu_+2 SAY "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
   @ lisu_+2,cosu_+2 SAY "³                   ³"
   @ lisu_+3,cosu_+2 SAY "³                   ³"
   @ lisu_+4,cosu_+2 SAY "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
   @ lisu_+5,cosu_+2 SAY " 7 8 9 C     +  -  * "
   @ lisu_+6,cosu_+2 SAY " 4 5 6 .  =  /  %  ^ "
   @ lisu_+7,cosu_+2 SAY " 1 2 3 0     "+CHR(K_ESC)+"  #  $ "
   SETCOLOR(drvcorget)
   @ lisu_+8,cosu_+2 SAY IF(fgpaste,"R, resultado no campo","")
   SETCOLOR(drvcorget+","+drvcorget+",,,"+drvcorget)
   DO WHIL .t.
      gab=IF(fgint,"   999999999999999",;             // mascara
      "999999999999999.99")
      num_disp=0.00                                   // numero no display
      @ lisu_+2,cosu_+3 SAY "="
      @ lisu_+2,cosu_+4 GET nu_calc PICT gab          // mostra total
      CLEAR GETS
      @ lisu_+3,cosu_+3 SAY sinal_ant
      @ lisu_+3,cosu_+4 GET num_disp PICT gab         // capta operando
      READ
      DO CASE
         CASE LASTKEY()=K_ESC.OR.sinal_="R"           // finalizou
            IF fgpaste.AND.sinal_="R"
               KEYB ALLTRIM(TRAN(nu_calc,gab))        // joga resultado no campo
            ENDI
            EXIT                                      // e sai
         CASE sinal_="AF8"                            // muda calculadora de posicao
            MUDA_PJ(@lisu_,@cosu_,@liin_,@coin_,tela_c,.t.)
            sinal_=" "
            PUBL &vr_calc.:=STR(lisu_,2)+STR(cosu_,2)
            SAVE TO (arqconf) ALL LIKE drv*           // salva as coordenadas em disco
         CASE sinal_="$"                              // chaveou inteiro/decimal
            fgint=(!fgint); sinal_=" "
         CASE sinal_="C"                              // limpa display
            nu_calc=0; sinal_=" "
         CASE sinal_="#"                              // raiz quadrada
            IF !EMPTY(num_disp)                       // algum numero no display?
               IF sinal_ant="-"                       // op anterior=subtracao?
                  nu_calc-=SQRT(num_disp)             // subtrai a raiz
               ELSE                                   // do display no resultado
                  nu_calc+=SQRT(num_disp)             // senao, soma
               ENDI
            ELSE                                      // nao exite numero no
               nu_calc=SQRT(nu_calc)                  // display, porisso
            ENDI                                      // calcula raiz do total
            sinal_=" "
         OTHERWISE
            DO CASE
               CASE sinal_ant="-"                     // subtrai
                  nu_calc-=num_disp
               CASE sinal_ant="*"                     // multiplica
                  nu_calc=nu_calc*num_disp
               CASE sinal_ant="/"                     // divide
                  nu_calc=nu_calc/num_disp
               CASE sinal_ant="^"                     // eleva potencia
                  nu_calc=nu_calc^num_disp
               CASE sinal_ant="%"                     // obtem percentual
                  nu_calc=nu_calc/100*num_disp
               OTHERWISE                              // soma (+) ou sem operador
                  nu_calc+=num_disp
            ENDC
      ENDC
      sinal_=IF(sinal_="="," ",sinal_)                // igual nao pode ser exibido
      sinal_ant=sinal_; sinal_=" "                    // salva sinal digitado
   ENDD
   SETCOLOR(cor_calc)                                 // volta com as cores anteriores
   SETCURSOR(cur_sor)                                 // volta cursor com era antes
   SET KEY K_F6 TO maqcalc                            // reabilita calculadora (f6)
   SETKEY(35,NIL); SETKEY(36,NIL)                     // desabilita as teclas
   SETKEY(37,NIL); SETKEY(42,NIL)                     // utilizadas na operacao
   SETKEY(43,NIL); SETKEY(45,NIL)                     // da calculadora
   SETKEY(47,NIL); SETKEY(67,NIL)
   SETKEY(94,NIL); SETKEY(99,NIL)
   SETKEY(82,NIL); SETKEY(114,NIL)
   SETKEY(61,NIL)
   SETKEY(K_PGUP,pg_up)                               // habilita teclas PgUp,
   SETKEY(K_PGDN,pg_dn)                               // PgDn,
   SETKEY(K_F3,tec_f3)                                // F3,
   SETKEY(K_F4,tec_f4)                                // F4,
   SETKEY(K_F9,tec_f9)                                // F9 e
   SETKEY(K_ALT_F8,tec_f8)                            // ALT-F8
   RESTSCREEN(0,0,MAXROW(),79,tela_c)                 // restaura a tela
   RETU

   STATIC PROC SINAL_DIG  // Recebe sinal da calculadora
   sinal_=IF(LASTKEY()=K_ALT_F8,"AF8",;               // recebe sinal digitado e
   UPPER(CHR(LASTKEY())))                      // forca saida do get com
   KEYB CHR(K_ENTER)                                  // ENTER simulado
   RETU
#endi

// FUNCAO DE INICIALIZACAO DE VARIAVEIS  -  RAMALHO

FUNC INIC_VAR
A=FCOUNT()
FOR I=1 TO A
   IF TYPE (FIELD(I))<>"M"
      NOMECAMPO=FIELD(I)
      NOMEVAR="M"+NOMECAMPO
      PUBLIC &NOMEVAR
      DO CASE
         CASE TYPE (FIELD(I))="C"
            &NOMEVAR=SPACE(LEN(&NOMECAMPO))
         CASE TYPE (FIELD(I))="N"
            &NOMEVAR=0
         CASE TYPE (FIELD(I))="D"
            &NOMEVAR=CTOD("")
         CASE TYPE (FIELD(I))="L"
            &NOMEVAR=.F.
      ENDCASE
   ENDIF
NEXT
RETURN(NIL)


// FUNCAO DE ATRIBUICAO DE VARIVEIS COM VALORES DOS CAMPOS

FUNC IGUAL_VAR
A=FCOUNT()
FOR I = 1 TO A
   IF TYPE(FIELD(I))!= "M"
      NOMECAMPO=FIELDNAME(I)
      NOMEVAR="M"+NOMECAMPO
      PUBLIC &NOMEVAR
      &NOMEVAR=&NOMECAMPO
   ENDIF
NEXT
RETURN


// FUNCAO DE LIBERACAO DE VARIAVEIS DA MEMORIA - RAMALHO

FUNC LIB_VAR
A=FCOUNT()
FOR I= 1 TO A
   IF TYPE(FIELD(I))!="M"
      NOMEVAR="M"+FIELD(I)
      RELEASE &NOMEVAR
   ENDIF
NEXT
RELEASE NOMEVAR
RETURN


// FUNCAO  DE GRAVACAO DOS DADOS NO ARQUIVO

FUNC REPL_VAR
A=FCOUNT()
FOR I = 1 TO A
   IF TYPE(FIELD(I))!= "M"
      NOMECAMPO=FIELD(I)
      NOMEVAR="M"+NOMECAMPO
      IF TYPE ("&NOMEVAR")!="U"
         DO WHILE .T.
            IF RLOCK()
               REPLACE &NOMECAMPO WITH &NOMEVAR
               UNLOCK
               EXIT
            ELSE
               DBox("Arquivo sendo utilizado !!!",,,0,.T.,,)
            ENDIF
         ENDDO
      ENDIF
   ENDIF
NEXT
RETURN

//  CRIA/APAGA JANELA DE DIALOGO Adaptada para GAS-Pro

//  TIPO...........: Se 01 Abre a Janela, Se 02 Fecha a Janela
//  JL1,JL2,JC1,JC2: Cordenadas da Janela
//  TITULO.........: Titulo para o topo da Janela
//  Cor............: Se .T. Cor a especificar, Se .F. Cor original da janela

FUNCTION JANELA(TIPO,JL1,JC1,JL2,JC2,Moldura,TITULO,Cor)
IF TIPO=1
   If Empty(Cor)
      Cor=.F.
   EndIf
   NUJAN=NUJAN+1
   CORJAN[NUJAN]=SETCOLOR()
   COORD[NUJAN,1]=JL1
   COORD[NUJAN,2]=(JC1-2)
   COORD[NUJAN,3]=(JL2+2)
   COORD[NUJAN,4]=JC2
   TELAJAN[NUJAN]=(SAVESCREEN(JL1,JC1-2,JL2+2,JC2))
   If !Cor
      SETCOLOR(drvtittel)                            //Cor T¡tulo e Moldura
   EndIf
If Moldura=[S]
   Caixa(Mold,JL1,JC1,JL2,JC2,Freq,.T.)
Else
   Caixa(Spac(8),JL1,JC1,JL2,JC2,Freq,.T.)
EndIf
//   IF !EMPTY(TITULO)
//      @ JL1,JC1+1 SAY PADC(TITULO,(JC2-(JC1+1)),substr(Chr(177),2,1))
//   ENDIF
   SetColor(CorJan[NuJan])
ELSE
   RESTSCREEN(COORD[NUJAN,1],COORD[NUJAN,2],COORD[NUJAN,3],COORD[NUJAN,4],TELAJAN[NUJAN])
   SETCOLOR(CORJAN[NUJAN])
   NUJAN=NUJAN-1
ENDIF
RETURN(NIL)

FUNCTION VEREVEN(X)

LOCAL ORDEM:=.F.

mQQG1=.F.

If Flag      //Se F8 foi pressionado, nÆo precisa passar pela fun‡Æo
   Ordem=.T.
   Flag=.F.
Else
   IF !EMPTY(X)
      If Paramet->faixaini<=X .And. Paramet->faixafim>=x
         Area:=Select()
         Reg=Recno()
         Sele registro
         DbGoTop()
         Locate for Apto=MApto .And.ativo=[S]
         If Found()
            DBox("Eventual em aberto !!!",,,0,.T.,,)
            Ordem=.F.
         Else
            ordem=.T.
         EndIf
         Sele &Area
         Go Reg
      Else
         SELE Hospedes
         ORDEM=REGAPTO(@MAPTO)
         SELE Registro
      EndIf
   ELSE
      SELE Aptos
      DO MENUAPTO
      IF ((LASTKEY()!=K_ESC) .AND. (LIBERADO!='N'))
         ORDEM=REGAPTO(@MAPTO)
      ELSE
         MAPTO=0
      ENDIF
   ENDIF
EndIF

mQQG1=.T.

RETURN(ORDEM)

FUNCTION VERR(X)

LOCAL ORDEM:=.F.

If Flag      //Se F8 foi pressionado, nÆo precisa passar pela fun‡Æo
   Ordem=.T.
   Flag=.F.
Else
   IF !EMPTY(X)
      SELE Aptos
      DbGoTop()
      Seek Str(x,04,00)
      //Locate for Apto=X
      If Found()
         ORDEM=.T.
      Else
         DBox("Apartamento n„o cadastrado !!!",,,0,.T.,,)
         Ordem=.F.
      EndIf
      SELE Registro
   ELSE
      SELE Aptos
      DO MENUAPTO
      IF LASTKEY()!=K_ESC
         ORDEM=.T.
         TApto=MApto
      ELSE
         Ordem=.F.
      ENDIF
   ENDIF
EndIf
RETURN(ORDEM)

//FUNCAO REGISTRO DE APTO

FUNCTION REGAPTO(X)

LOCAL GETLIST:={},ORDEM

If Flag
   Ordem=.T.
Else
   ORDEM=.F.
   SELE Aptos                 //SELECIONA AREA APTOS
   Seek Str(x,04,00)
   //LOCATE FOR APTO=X                  //POSICIONA-SE NO REGISTRO DO APARTAMENTO
   IF FOUND()
      DO CASE
         CASE LIBERADO='S'      //VERIFICA LIBERACAO=SIM
            SELE Registro
            ORDEM=.T.
         CASE LIBERADO='N'      //VERIFICA LIBERACAO=NAO
            DBox("Apartamento Ocupado !!!",,,0,.T.,,)
            IF MENUAPTO(@MAPTO)
               ORDEM=.T.
            ENDIF
         CASE LIBERADO='R' .and. Paramet->Reserva='S'      //VERIFICA LIBERACAO=RESERVADO
            SELE Reserva
            Set Order to 02       //por ordem de data de Reserva
            Set Deleted On
            SET FILTER TO APTO=X
            DbGoTop()
            Seek DtoS(DataC)
            //LOCATE FOR DTRESER=Datac
            IF FOUND()     //DATA DA RESERVA=DATA A SER OCUPADA
               SET FILTER TO
               Sele Rpes
               DbGoTop()
               Locate for codigo=Reserva->Codigo
               JANELA(01,03,16,06,58)
               @ 04,29 SAY "Reservado para o"
               @ 05,18 SAY "Sr."
               @ 05,22 SAY Nome         //NOME DO HOSPEDE DA RESERVA
               Op=Space(01)
               Op=MTab([SIM|NŽO],[Prosseguir ?])
               Janela(02)
               DO CASE
                  CASE OP='S'           //HOSPEDE QUE VAI OCUPAR MESMO QUE A RESERVA
                     Ar=Select()
                     Sele RPes
                     THOSPE=Nome
                     TIdentidad=RG
                     Sele Reserva
                     MPax=Pax
                     TFirma=Empresa
                     TdtSai=DtSai
                     ORDEM=.T.
                     APRE='S'
                     Sele &Ar
                  CASE OP='N'      //HOSPEDE QUE VAI OCUPAR NAO E O MESMO QUE A RESERVA
                     Cod_Ant_1=Cod_Sos
                     Cod_Sos=74
                     DO WHILE .T.
                        opc=Space(03)
                        OpC=MTab([RESERVAR OUTRO|EXCLUIR RESERVA|VOLTAR AO REGISTRO],[Op‡”es])
                        DO CASE
                           CASE OPC=Space(03)
                              EXIT
                           CASE OPC='R'       //RESERVAR OUTRO PARTAMENTO
                              JANELA(01,09,13,19,71," Mudan‡a de Reserva ")
                              @ 10,14 SAY " DT. Reserva Â Apartamento ÄÄÄÄÄÄÄÄÂ Hora Reserva ÄÄÄÄÄÄÄ"
                              @ 11,14 SAY "             ³                     ³                     "
                              @ 12,14 SAY " Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                              @ 13,14 SAY "                                                         "
                              @ 14,14 SAY " Identidade ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Fone ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                              @ 15,14 SAY "                                ³                        "
                              @ 16,14 SAY " Dt. Solicit.Â Hrs. Solicit. Â Recebeu Solic. Reserva ÄÄÄ"
                              @ 17,14 SAY "             ³               ³                           "
                              @ 18,14 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
                              Sele Reserva
                              IGUAL_VAR()
                              Sele RPes
                              Set Filter to Codigo=Reserva->Codigo
                              DbGoTop()
                              Sele Reserva
                              MOPERADOR=Usuario
                              SET CURSOR ON
                              @ 11,15 SAY MDTRESER
                              @ 11,50 SAY MHRESER     PICT "@R 99:99"
                              @ 13,15 SAY RPes->Nome
                              @ 15,15 SAY RPes->Rg
                              @ 15,48 SAY MFONE       PICT "@R (9999)!99-9999"
                              @ 17,15 SAY MDTSOLICIT
                              @ 17,29 SAY MHSOLICIT   PICT "@R 99:99"
                              @ 17,45 SAY MAUTORES
                              Set Key K_F8 to Picks
                              TApto=Reserva->Apto
                              @ 11,29 GET TAPTO       PICT "9999"     Valid(VerR(@Tapto))  //VALID(VERRES(MAPTO,MDTRESER,'A'))
                              READ
                              Set Key K_F8 to
                              SET CURSOR OFF
                              IF LASTKEY()!=K_ESC .And. TApto!=0
                                 If TApto!=X
                                    Are=Select()
                                    R=Recno()
                                    VerReser()  //Coloca Apto='S'
                                    Sele Aptos
                                    DbGoTop()
                                    Locate for Apto=TApto
                                    If Liberado='R' .Or. Liberado='S'
                                       DO WHILE .T.
                                          IF RLOCK()
                                             Repl Liberado with 'R'
                                             UNLOCK
                                             EXIT
                                          EndIf
                                       EndDo
                                    EndIf
                                    Sele &Are
                                    If R!=0
                                       GO R
                                    EndIf
                                 EndIf
                                 DO WHILE .T.
                                    Sele Reserva
                                    IF RLOCK()
                                       MATIVO='S'
                                       Antigo=MApto
                                       MApto=TApto
                                       REPL_VAR()
                                       MApto=Antigo
                                       UNLOCK
                                       EXIT
                                    ELSE
                                       DBox("Arquivo sendo utilizado !!!",,,0,.T.,,)
                                    ENDIF
                                 ENDDO
                              ENDI
                              SELE Registro
                              ORDEM=.T.
                              JANELA(02)
                           CASE OPC='E'      //EXCLUIR A RESERVA
                              OpDel=Space(01)
                              OpDel=MTab([SIM|NŽO],[Confirma‡„o de Exclus„o])
                              DO CASE
                                 CASE OPDEL ='S'
                                    VERRESER()    //MUDA O APTO P/ 'S'
                                    Set Deleted On
                                    Sele RPes
                                    Set Filter to Codigo=Reserva->Codigo
                                    DbGoTop()
                                    Do While !Eof()
                                       If Rlock()
                                          DELE
                                          UNLOCK
                                       EndIf
                                       DbSkip()
                                    EndDo
                                    Set Filter to
                                    Sele Reserva
                                    Do While .T.
                                       If Rlock()
                                          Dele
                                          Unlock
                                          Exit
                                       EndIf
                                    EndDo
                                    ORDEM=.T.
                                    Exit
                                    Set Deleted Off
                                 CASE OPDEL='N' .Or. OpDel=Space(01)
                                    LOOP
                              ENDCASE
                           CASE OPC='V'  //Voltar ao Registro
                              EXIT
                        ENDCASE
                     ENDDO
                     Cod_Sos=Cod_Ant_1
               ENDCASE
               Set Cursor On
               SELE Aptos                 //RETORNA A AREA DE APARTAMENTO
            ELSE            //DATA DA RESERVA E MAIOR QUE A DATA DA OCUPACAO
               Set Deleted On
               DbGoTop()
               LOCATE FOR DTRESER>Datac
               If Found()
                  JANELA(01,03,24,06,55)
                  @ 04,26 SAY "Apartamento Reservado para o"
                  @ 05,33 SAY "dia"
                  @ 05,37 SAY DTRESER
                  OpC=Space(01)
                  OpC=MTab([SIM|NŽO],[Prosseguir ?])
                  JANELA(2)
                  IF OPC='S'   //TUDO BEM, PODE LIBERAR O APTO MESMO COM A RESERVA
                     ORDEM=.T.
                     MPax=Pax
                  ENDIF
               Else
                  XData=DtoC(DataC)
                  DBox("N„o h  reserva marcada a partir da data|de hoje, "+XData+".|Verifique se a data do sistema est  correta|e se realmente n„o existe reserva marcada,|pois a reserva pode estar deletada.",,,0,.T.,,)
                  DBox("E modifique o apartamento que deve estar como R (reservado)|para S (sim), isto para que possa ser efetuado o registro.",,,0,.T.,,)
               EndIf
            ENDIF
            SET FILTER TO
         Otherwise
            Ordem=.T.
      ENDCASE
   ELSE       //NAO ENCONTROU O APARTAMENTO DIGITADO (APTO NAO CADASTRADO)
      DBox("Apartamento Inv lido !!!",,,0,.T.,,)
   ENDIF
EndIF
RETURN(ORDEM)

//FUNCAO MENU PICK PARA APARTAMENTOS LIBERADOS

FUNCTION MENUAPTO

LOCAL ORDEM

Flag=.T.
CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE Aptos
MDB3={"Apto","Liberado"}
DBGOTOP()
Vd=.F.
VDbf(13,16,20,30,"Aptos",MDb3,,"MApto",[Liberado!='N'])
Vd=.T.
SET FILTER TO
IF LASTKEY()=K_ESC
   ORDEM=.F.
ELSE
   MAPTO=APTO
   If mQQG1
      ORDEM=REGAPTO(@MAPTO)
   EndIf
ENDIF
SELE &AREA
SETCURSOR(CUR)
//Flag=.F.
RETURN(ORDEM)

//FUNCAO MENU PICK PARA HOSPEDES HOMONIMOS

Function MENUHOMO(X)

Local Ordem:=.F.

AREA=SELECT()
SELE Hospedes
MDB3={"Nome","Identidad"}
DBGOTOP()
Set Filter to Upper(Nome)=Upper(Trim(X))
DbGoTop()
Vd=.F.
VDbf(15,15,22,72,"Hospedes",MDb3,,,)
Vd=.T.
SET FILTER TO
IF LASTKEY()!=K_ESC
   VER='S'
   MCODHOSP=CODIGO
   Ordem=.T.
ELSE
   Ordem=CADHOSP()                     //FUNCAO CADASTRA HOSPEDE
   VER='N'
ENDIF
SELE &AREA
RETURN(Ordem)

//FUNCAO MENU PICK PARA FIRMAS/AGENTES

FUNCTION MENUFIRMA(A)

LOCAL ORDEM

CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE clientes
//SET ORDER TO 02     //ORDEM ALFABETICA
TITULO='Firmas/Agentes'
IF A='I'
   TITULO='Intermediario'
   SET FILTER TO TURIS='S'
ENDIF
MDB3={"Nome","CGC","Turis"}
DBGOTOP()
Vd=.F.
VDbf(15,11,23,70,"clientes",MDb3,[Nome],,)
Vd=.T.
IF LASTKEY()!=K_ESC
   IF A='F'
      TFIRMA=NOME
      MFIRMAAGE=CODIGO
   ELSEIF A='I'
      TINTERM=NOME
      MINTERM=CODIGO
   ENDIF
   ORDEM=.T.
   Flag=.T.
ENDIF
Set Filter to
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO MENU PICK PARA FIRMAS HOMONIMAS

Function FIRMAHOMO(Y)

Local Ordem:=.F.

AREA=SELECT()
SELE clientes
IF Y='F'
   SET FILTER TO Upper(NOME)=(Upper(AllTRIM(TFIRMA)))
ELSEIF Y='I'
   SET FILTER TO Upper(NOME)=Upper((AllTRIM(TINTERM))) .AND. (TURIS='S')
ENDIF
MDB3={"Nome","CGC"}
DBGOTOP()
Vd=.F.
VDbf(13,14,23,73,"clientes",MDb3,02,,)
Vd=.T.
SET FILTER TO
FIR='N'
IF LASTKEY()!=K_ESC
   MFIRMAAGE=CODIGO
   TFIRMA=NOME
   FIR='S'
   Ordem = .T.
ENDIF
SELE &AREA
RETURN(Ordem)

//FUNCAO MENU PICK PARA HOSPEDES

FUNCTION MENUHOSP()

LOCAL ORDEM

CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE Hospedes
SET ORDER TO 02
MDB3={"Nome","Identidad"}
DBGOTOP()
Vd=.F.
VDbf(13,14,23,73,"Hospedes",MDb3,02,,)
Vd=.T.
//SELE Hospedes
SET ORDER TO 0
IF LASTKEY()=K_ESC
   ORDEM=.F.
ELSE
   THOSPE=NOME
   MHOSPEDE=NOME
   MCODHOSP=CODIGO
   MRG=IDENTIDAD
   ORDEM=.T.
ENDIF
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO VERIFICA APTO ATIVO='S' EM REGISTRO

FUNCTION VERIFICA(X)

LOCAL ORDEM

If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
EndIf
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf
Sele Hospedes
Set Order to 3
Sele Conregis
Set Relation To Str(CodHosp,10,00) Into Hospedes
AREA=SELECT()
ORDEM=.F.
ACHOU=.F.
IF !EMPTY(X)
   //If Paramet->faixaini<=X .And. Paramet->faixafim>=x
   //   Sele registro
   //   DbGoTop()
   //   Locate for Apto=X .And. Ativo=[S]
   //Else
   //   SELE Aptos          //AREA DE APARTAMENTO
   //   DBGOTOP()
   //   LOCATE FOR APTO=X
   //EndIf

   Sele Registro
   Set Filter To Ativo=[S]
   DbGoTop()
   Locate For Apto=X

   //IF FOUND()
      //SELE Registro
      //DBGOTOP()
      //LOCATE FOR APTO=X .And. Ativo='S'
      If !Found()
         TAPTO=0
         ORDEM=.F.
         DBox('Apartamento Liberado !!!|ou Apartamento Inv lido !!!',,,0,.T.,,)
      Else
         Sele ConRegis
         Set Filter To Codigo=Registro->Codigo
         Set Order to 0
         If Registro->MovimN='C' .And. Registro->MovimE='C'
            DbGoTop()
            //Locate for Codigo=Registro->Codigo
            MCodHosp=CodHosp
            MCodigo=Codigo
            //Sele Hospedes
            //DbGoTop()
            //Locate for Codigo=Conregis->CodHosp
            THospede=Hospedes->Nome
         Else
            //IF !Flag
               If Select("&Usuario")!=0
                  Close
               EndIF
               Do While .T.
                  If !file("&Usuario")
                     Arq:={}
                     AADD(Arq,{"CodHosp","N",10,0})
                     AADD(Arq,{"Nome","C",35,0})
                     DbCreAte("&Usuario",Arq)
                     Exit
                  Else
                     FErase("&Usuario")
                  EndIf
               EndDo
               Use &Usuario Exclusiv New
               Sele ConRegis
              // Set Filter to Codigo=Registro->Codigo .And. Ativo='S'
               DbGoTop()
               Do While !Eof()
                  MCodHosp=CodHosp
                  //Sele Hospedes
                  //DbGoTop()
                  //Locate for Codigo=ConRegis->CodHosp
                  MNome=Hospedes->Nome
                  Sele &Usuario
                  Appe Blan
                  Repl Nome    With MNome
                  Repl CodHosp With MCodHosp
                  Sele ConRegis
                  DbSkip()
               EndDo
               Sele &Usuario
               MDB3={"Nome"}
               MDb1={"Nome"}
               DBGOTOP()
               Sol_Vdbf(11,11,21,53,Usuario,MDB1,Mdb3,"tApto","CONSULTA DE HOSPEDES")
               If LastKey()=13
                  Sele ConRegis
                  Set Filter to
                  DbGoTop()
                  Locate for CodHosp=&Usuario->CodHosp .And. Codigo=Registro->Codigo
                  THospede=&Usuario->Nome
                  MCodHosp=&Usuario->CodHosp
                  Ordem=.T.
               EndIf
               Sele &Usuario
               Close
               Sele Hospedes
            //Else
            //   Flag=.F.
            //   Sele Hospedes
            //   THospede=Nome
            //   MCodHosp=Codigo
            //   Sele ConRegis
            //   DbGoTop()
            //   Locate for Codigo=Registro->Codigo .And. CodHosp=Hospedes->Codigo
            //EndIf
         EndIf
         ORDEM=.T.
      EndIf
   //ELSE
   //   TAPTO=0
   //   DBox('Apartamento Inv lido !!!',,,0,.T.,,)
   //ENDIF
ELSE
   DO MENUAPART
   If Lastkey()!=27 .And. TApto!=0
      ORDEM=.T.
   EndIF
ENDIF

Sele Hospedes
Set Order To 1

SELE &AREA
RETURN(ORDEM)

//MENU PICK PARA APTO e Nome do Hospede - Movimento

PROCEDURE MENUAPART(X)
Local mDela_Atu:=SET(_SET_DELETED,.t.), Ordem

Flag=.T.
CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
SELE Aptos
MDB3={"Apto","Liberado"}
DBGOTOP()
Vd=.F.
VDbf(13,16,20,30,"Aptos",MDb3,,"Apto",[Liberado='N'])
Vd=.T.
SET FILTER TO
IF LASTKEY()=K_ESC
   ORDEM=.F.
ELSE
   TAPTO=APTO
ENDIF
SELE &AREA
SETCURSOR(CUR)
//Flag=.F.
RETURN(ORDEM)

/*If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
If Select("&Usuario")!=0
   Close
EndIF
Do While .T.
   If !file("&Usuario")
      Arq:={}
      AADD(Arq,{"Apto","N",4,0})
      AADD(Arq,{"CodHosp","N",10,0})
      AADD(Arq,{"Nome","C",35,0})
      AADD(Arq,{"Codigo","N",10,0})
      DbCreAte("&Usuario",Arq)
      Exit
   Else
      FErase("&Usuario")
   EndIf
EndDo
Use &Usuario Exclusiv New
Sele Conregis
Set Filter to Ativo='S'
DbGoTop()
Do While !Eof()
   Sele Registro
   DbGoTop()
   Locate for Codigo=ConRegis->Codigo
   Sele Hospedes
   DbGoTop()
   Locate for Codigo=ConRegis->CodHosp
   Sele &Usuario
   Appe Blan
   Repl Codigo with Registro->Codigo
   Repl Apto with Registro->Apto
   Repl CodHosp with Hospedes->Codigo
   Repl Nome with Hospedes->Nome
   Sele ConRegis
   DbSkip()
EndDo
SET(_SET_DELETED,mDela_Atu)
MDB3={"Apto","Nome"}
MDB4={"Apto","Nome"}
Sele &Usuario
DBGOTOP()
MDB1={"APTO","Nome"}
MDB2={"999","@!"}
MDB3={"Aptos","Nome"}
DBGOTOP()
Vd=.F.
Li=1
Co=1
Sol_Vdbf(12,09,20,55,Usuario,MDB1,Mdb3,"tApto","CONSULTA DE APARTAMENTOS")
Vd=.T.
If LastKey()!=27
   TApto=Apto
   MCodigo=Codigo
   Sele Registro
   DbGoTop()
   Locate for Codigo=&Usuario->Codigo
   If Registro->MovimN='C' .And. Registro->MovimE='C'
      Sele ConRegis
      DbGoTop()
      Locate for Codigo=&Usuario->Codigo
      MCodHosp=CodHosp
      Sele Hospedes
      DbGoTop()
      Locate for Codigo=Conregis->CodHosp
      THospede=Nome
      MCodHosp=Codigo
   Else
      Sele ConRegis
      DbGoTop()
      Locate for Codigo=&Usuario->Codigo .And. CodHosp=&Usuario->CodHosp
      Sele Hospedes
      DbGoTop()
      Locate for Codigo=ConRegis->CodHosp
      THospede=Nome
      MCodHosp=Codigo
   EndIf
EndIf
Sele &Usuario
Zap
Close
FErase("&Usuario")
Sele Hospedes
Set Order to 0
Sele ConRegis
SET FILTER TO
SETCURSOR(CUR)
SELE &AREA
RETURN(.T.)*/

// FUNCAO DE VERIFICACAO DO TIPO DE DESPESA

FUNCTION VERTDESP(X,L,C)

Local Ordem:=.F.,Area

Area=Select()
CUR=SETCURSOR()
SET CURSOR OFF
If empty(L)
   L=17
   C=25
EndIf
Sele Departa
If Flag
   MDB3={"Codigo","TipoDesp"}
   DbGoTop()
   Vd=.F.
   VDbf(10,28,19,46,"Departa",MDb3,,"MTipoDesp",)
   Vd=.T.
   If LastKey()!=27
      MTipoDesp=Codigo
      @ L,C Say Departa->TipoDesp
      Ordem=.T.
   EndIF
   Flag=.F.
Else
   If !Empty(X)
      DbGoTop()
      Locate for Codigo=X
      If Found()
         @ L,C Say Departa->TipoDesp
         Ordem=.T.
      Else
         DBox('Tipo de Despesa Inv lido !!!',,,0,.T.,,)
         Ordem=.F.
      EndIF
   Else
      MDB3={"Codigo","TipoDesp"}
      DbGoTop()
      Vd=.F.
      VDbf(10,28,19,46,"Departa",MDb3,,"MTipoDesp",)
      Vd=.T.
      If LastKey()!=27 .AND. Codigo!=0
         MTipoDesp=Codigo
         @ L,C Say Departa->TipoDesp
         Ordem=.T.
      EndIF
   EndIF
EndIF
SETCURSOR(CUR)
Sele &Area
RETURN(ORDEM)

//FUNCAO ATRIBUI VALOR PARA VALOR DE DIARIA
PROCEDURE VALDIA
ARE=SELECT()
REG=RECNO()
SELE Movim
DBGOTOP()
LOCATE FOR CODIGO=REGISTRO->CODIGO .AND. TIPODESP=1
IF FOUND()
   MVALOR=VALOR
ELSE
   SELE Aptos
   DBGOTOP()
   LOCATE FOR APTO=REGISTRO->APTO
   MVALOR=DIARIA
ENDIF
SELE &ARE
IF REG#0
   GO REG
ENDIF
RETURN

// FUNCAO DE VERIFICACAO DO  TIPO DE MOVIMENTO

FUNCTION VERTMOV(X)

Local Ordem:=.F.

CUR=SETCURSOR()
SET CURSOR OFF
If Flag
   TTipoMov=MTab([1-NORMAL|2-EXTRA],[TIPO MOVIMENTO])
   MTipoMov=Val(TTipoMov)
   If LastKey()!=27
      SETCOLOR(drvcortel)
      If MTipoMov=1
         @ 17,12 Say 'NORMAL'
      Else
         @ 17,12 Say 'EXTRA '
      EndIf
      Ordem=.T.
   EndIf
   Flag=.F.
Else
   If !Empty(X)
      If X=1 .Or. X=2
         SETCOLOR(drvcortel)
         If X=1
            @ 17,12 Say 'NORMAL'
         Else
            @ 17,12 Say 'EXTRA '
         EndIf
         Ordem=.T.
      Else
         DBox('Tipo de Movimento Inv lido !!!',,,0,.T.,,)
      EndIF
   Else
      TTipoMov=MTab([1-NORMAL|2-EXTRA],[TIPO MOVIMENTO])
      MTipoMov=Val(TTipoMOv)
      If LastKey()!=27
         SETCOLOR(drvcortel)
         If MTipoMov=1
            @ 17,12 Say 'NORMAL'
         Else
            @ 17,12 Say 'EXTRA '
         EndIf
         Ordem=.T.
      EndIf
   EndIF
EndIF
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO HORA ATUAL

FUNCTION HORA(P)
T=''
H=SUBSTR(P,1,2)
M=SUBSTR(P,4,2)
T=H+M
RETURN (T)

// FUNCAO DE MENUS PICKS - GERAL

FUNCTION PICKS(P,L,V)

LOCAL ORDEM

ORDEM=.T.
DO CASE
   CASE (V="MFORMAPAG")
      Flag=.T.
      ORDEM=VERFORMA()
   CASE (V="MTIPOCART")
      Flag=.F.
      ORDEM=VERCARTAO()
   CASE (V="MTIPOMOV")
      Flag=.T.
      ORDEM=VERTMOV(&V,"T")
   CASE (V="MTIPODESP")
      Flag=.T.
      If P="HOT29" .or. P="HOT57"
         ORDEM=VERTDESP(,17,13)
      ElseIf P="HOT22"
         Ordem=VertDesp()
      EndIF
   CASE (V="THOSPE") .OR. (V="MHOSPEDE")
      Flag=.T.
      Do MenuHosp
      Flag=.F.
   CASE (V="TFIRMA")
      ORDEM=MENUFIRMA('F')
   CASE (V="TINTERM")
      ORDEM=MENUFIRMA('I')
   CASE ((V="MAPTO").AND.((P="MIL_OUTR") .Or. (P="HOT21") .OR. (P="HOT25")))
      ORDEM=MENUAPTO()
   Case V="TAPTO" .And. P="HOT28"
      Ordem=VerAp()
   Case V="MAPTO" .And. P="HOT28"
      Ordem=VerApt()
   Case V=("TAPTO") .And. P=("REGAPTO")
      Flag=.T.
      TTApto=MApto
      Ordem=MenuApto()
      TApto=MApto
      MApto=TTApto
      Flag=.F.
   Case ((V="MAPTO" .Or. V="TAPTO") .And. (P="HOT22") .OR. (P="HOT28") .Or. P="HOT23" .or. P="HOT261" .or. P="HOT262" .or. P="HOT29" .or. P="HOT24")
      Flag=.T.
      MenuApart(P)
   CASE (V="MESTCIVIL")
      Flag=.T.
      VerEst()
      Flag=.F.
   CASE (V="MTURIS")
      Flag=.T.
      VerTuris()
   CASE (V="TPCONTA")
      VERPCONTA()
   Case (V=[TAPTO] .And. P=[HOT32])
      MenuApart(P)
   Case (V="TAPTO" .And. P="HOT51")
      Flag=.F.
      VerRea()
      KeyBoard Chr(13)
   Case V="TAPTO" .And. P="HOT52" .or. P="HOT53" .or. P="HOT54" .or. P="HOT58" .or. P="HOT57" .or. P="HOT55" .or. P="MIL_R004"
      Flag=.T.
      MenuApart1(P)
   Case V="TAPTO" .And. P="MIL_R003"
      Flag=.T.
      Menuapart()
ENDCASE
RETURN(ORDEM)

//FUNCAO DE DESCONTO

PROCEDURE DESCONTO1(P,L,V)

LOCAL GETLIST:={},Cor:=SetColor()

AREA=SELECT()
REGI=RECNO()
If P="HOT21"
   Sele clientes
   DbGoTop()
   Locate for Codigo=MFirmaAge
   mfinal=clientes->DescValor
   mporc=clientes->DescPorc
Else
   mfinal=0
   mporc=0
EndIf
Sele Desconto
mobs=Space(30)
moperador=Usuario
mAUTOR='GERˆNCIA       '
Set Key K_F7 to  // Desativa F7 Tela Desconto Unitario
SET KEY K_F4  TO        //DESATIVA F4 TELA DE DESCONTO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
SETCOLOR(drvcortel)
JANELA(01,14,01,18,74," Desconto Cont¡nuo ")
@ 15,02 SAY " Porc. ÄÂ Valor ÄÄÄÄÂ Observacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Quem Autorizou ÄÄ"
@ 16,02 SAY "      % ³           ³                                ³                  "
@ 17,02 Say "ÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
Infosis("Inclui","[ESC] Sai")
Set Deleted On
D=.F.
DbGoTop()
Locate FOR CODIGO=REGISTRO->CODIGO .And. CodHosp=MCodHosp .And. TipoDesp=MTipoDesp
Do Case
   Case P = "HOT22" .OR. P="HOT21" .or. P="HOT52"
      IF FOUND()
         TTValor=Trans(Desconto->Final,'@E 999,999.99')
         TTPorc=Str(Desconto->Porc)
         Sele Departa
         DbGoTop()
         Locate for Codigo=Desconto->TipoDesp
         If Found()
            DBox('J  existe Desconto Cont¡nuo cadastrado|para este hospede.||Tipo Despesa...: '+Departa->TipoDesp+'|Valor..........: '+TTValor+'   |Porcentagem....: '+TTPorc+' %        ',,,0,.T.,,)
         EndIf
         SELE &AREA
         SET KEY K_F4 TO DESCONTO1   //TELA DE DESCONTO - HOTRT
         Set Key K_F7 to DescMovim
         SET KEY K_F8 TO PICKS      //MENU PICK
         Infosis("Inclui","[F8] Tabela,   [F7] Desconto Unitario,   [F4] Desconto Continuo")
         JANELA(02)
         SetColor(Cor)
         RETURN
      ELSE
         mAUTOR='GERˆNCIA       '
         mOBS=SPACE(30)
         D=.T.
      ENDIF
   Case P = "HOT23"
      IF FOUND()
         DBox('Desconto j  Registrado !!!',,,0,.T.,,)
         SELE &AREA
         SET KEY K_F4 TO DESCONTO   //TELA DE DESCONTO - HOTRT
         Set Key K_F7 to DescMovim
         SET KEY K_F8 TO PICKS      //MENU PICK
         Infosis("Inclui","[F4] Tela de Desconto,   [F8] Tabelas")
         JANELA(02)
         SetColor(Cor)
         RETURN
      ELSE
         mAUTOR='GERENCIA       '
         mPORC=0
         mFinal=0
         mOBS=SPACE(30)
         mQuando="F"
         D=.T.
      ENDIF
EndCase
SET CURSOR ON
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
@ 16,03 GET mPORC       PICT "999"
@ 16,12 GET mFinal      PICT "@E 99,999.99"    WHEN(EMPTY(mPORC))
@ 16,24 GET mOBS
@ 16,57 GET mAUTOR                    VALID(!EMPTY(mAUTOR))
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   JANELA(2)
   SELE &AREA
   SET KEY K_F4 TO DESCONTO1   //TELA DE DESCONTO - HOTRT
   Set Key K_F7 to DescMovim
   SET KEY K_F8 TO PICKS      //MENU PICK
   If p != "HOT22"
      Infosis("Inclui","[F4] Tela de Desconto,   [F8] Tabelas")
   Else
      Infosis("Inclui","[F8] Tabela,   [F7] Desconto Unitario,   [F4] Desconto Continuo")
   EndIf
   Set Cursor on
   SetColor(Cor)
   RETURN
ENDIF
MOPERADOR=Usuario
IF D
   IF TRAVAREG()
      MCODIGO=REGISTRO->CODIGO
      REPL_VAR()
      UNLOCK
   ENDIF
ENDIF
SELE &AREA
SET KEY K_F4 TO DESCONTO1   //TELA DE DESCONTO - HOTRT
Set Key K_F7 to DescMovim
SET KEY K_F8 TO PICKS      //MENU PICK
If P != "HOT22"
   Infosis("Inclui","[F4] Tela de Desconto,   [F8] Tabelas")
Else
   Infosis("Inclui","[F8] Tabela,   [F7] Desconto Unitario,   [F4] Desconto Continuo")
EndIf
JANELA(02)
Set Cursor On
SetColor(Cor)
RETURN

//FUNCAO VERIFICA IDENTIDADE

FUNCTION VERID(X,Z)
IF !EMPTY(X)
   IF Z='A'
      REG=RECNO()
   ENDIF
   DBGOTOP()
   LOCATE FOR IDENTIDAD=X
   IF FOUND()
      DO CASE
         CASE Z='I'
            DBox('Pessoa j  Cadastrada !!!',,,0,.T.,,)
            ORDER=.F.
         CASE Z='A'
            IF RECNO()=REG
               ORDER=.T.
            ELSE
               DBox('Pessoa j  Cadastrada !!!',,,0,.T.,,)
               ORDER=.F.
            ENDIF
         OTHERWISE
            ORDER=.T.
      ENDCASE
   ELSE
      IF Z='I' .OR. Z='A'
         ORDER=.T.
      ELSE
         DBox('Pessoa j  Cadastrada !!!',,,0,.T.,,)
         ORDER=.F.
      ENDIF
   ENDIF
   IF Z='A'
      GO REG
   ENDIF
   SET ORDER TO 1
ELSE
   DBox('Identidade Inv lida !!!',,,0,.T.,,)
   ORDER=.F.
ENDIF
RETURN (ORDER)

//VERIFICA SE  TURISMO OU NŽO A FIRMA

FUNCTION VERTURIS(X)

LOCAL ORDEM:=.F.

If Flag
   MTuris=MTab([SIM|NŽO],[TURISMO])
   If LastKey()!=27
      If MTuris='S'
         @ 17,69 Say 'IM'
      Else
         @ 17,69 Say 'ŽO'
      EndIF
      Ordem=.T.
   EndIf
   Flag=.F.
Else
   If !Empty(X)
      If X='S' .Or. X='N'
         Ordem=.T.
         If X='S'
            @ 17,69 Say 'IM'
         Else
            @ 17,69 Say 'ŽO'
         EndIF
      Else
         DBox('Inv lido !!!',,,0,.T.,,)
      EndIF
   Else
      MTuris=MTab([SIM|NŽO],[TURISMO])
      If LastKey()!=27
         If MTuris='S'
            @ 17,69 Say 'IM'
         Else
            @ 17,69 Say 'ŽO'
         EndIF
         Ordem=.T.
      EndIf
   EndIF
EndIF
RETURN(ORDEM)

//FUNCAO VERIFICA SE JA EXISTE CGC DE FIRMA

FUNCTION VERCGC(X,T)

Local Ordem:=.F.,Aux,V:=.F.

AUX=RECNO()
IF !EMPTY(X)
   DBGOTOP()
   IF T='I'
      LOCATE FOR CGC=X
   ELSE
      LOCATE FOR CGC=X .AND. RECNO()#AUX
   ENDIF
   IF !FOUND()
      V=VCgc(X)
      If !V
         DBox('Digito do CGC n„o confere !!!',,,0,.T.,,)
      EndIF
      ORDEM=.T.
   ELSE
      DBox('CGC j  existenta !!!',,,0,.T.,,)
   ENDIF
ELSE
   DBox('CGC Inv lido !!!',,,0,.T.,,)
ENDIF
GO AUX
RETURN(ORDEM)

// FUNCAO DE VERIFICACAO DA FORMA DE PAGAMENTO

FUNCTION VERFORMA(X)

Local Ordem:=.F.,H

CUR=SETCURSOR()
SET CURSOR OFF
AREA=SELECT()
If Flag
   H=MTab([1-DINHEIRO|2-CARTŽO|3-CHEQUE|4-CHEQUE-PR|5-RDA|6-COBRAN€A|7-PERMUTA],[TIPOS DE PAGAMENTO])
   If LastKey()!=27
      Ordem=.T.
      Do Case
         Case Val(H)=1
            @ L,11 Say 'DINHEIRO  '
         Case Val(H)=2
            @ L,11 Say 'CARTŽO    '
         Case Val(H)=3
            @ L,11 Say 'CHEQUES   '
         Case Val(H)=4
            @ L,11 Say 'CHEQUE-PR'
         Case Val(H)=5
            @ L,11 Say 'RDA       '
         Case Val(H)=6
            @ L,11 Say 'COBRAN€A  '
         Case Val(H)=7
            @ L,11 Say 'PERMUTA   '
      EndCase
      MFormaPag=Val(H)
   Else
      MFormaPag=0
   EndIF
   Flag=.F.
Else
   If !Empty(X)
      If X>0 .And. X<8
         Ordem=.T.
         Do Case
            Case X=1
               @ L,11 Say 'DINHEIRO  '
            Case X=2
               @ L,11 Say 'CARTŽO    '
            Case X=3
               @ L,11 Say 'CHEQUES   '
            Case X=4
               @ L,11 Say 'CHEQUE-PR'
            Case X=5
               @ L,11 Say 'RDA       '
            Case X=6
               @ L,11 Say 'COBRAN€A  '
            Case X=7
               @ L,11 Say 'PERMUTA   '
         EndCase
      Else
         DBox('Tipo de Pagamento Inv lido !!!',,,0,.T.,,)
      EndIF
   Else
      H=MTab([1-DINHEIRO|2-CARTŽO|3-CHEQUE|4-CHEQUE-PR|5-RDA|6-COBRAN€A|7-PERMUTA],[TIPOS DE PAGAMENTO])
      If LastKey()!=27
         Ordem=.T.
         Do Case
            Case Val(H)=1
               @ L,11 Say 'DINHEIRO  '
            Case Val(H)=2
               @ L,11 Say 'CARTŽO    '
            Case Val(H)=3
               @ L,11 Say 'CHEQUES   '
            Case Val(H)=4
               @ L,11 Say 'CHEQUE-PR'
            Case Val(H)=5
               @ L,11 Say 'RDA       '
            Case Val(H)=6
               @ L,11 Say 'COBRAN€A  '
            Case VAL(H)=7
               @ l,11 Say 'PERMUTA   '
         EndCase
         MFormaPag=Val(H)
      Else
         MFormaPag=0
      EndIF
   EndIF
EndIF
SELECT &AREA
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO TIPO DE CARTAO DE CREDITO - HOT23

FUNCTION VERCARTAO(X)

LOCAL AREA:=SELECT(),Ordem:=.F.

CUR=SETCURSOR()
SET CURSOR OFF
SELE Cartoes          //area de cartoes
If Flag
   MDB3={"Codigo","NomeCar"}
   DBGOTOP()
   Vd=.F.
   VDbf(10,25,18,45,"Cartoes",MDb3,,"MTipoCart",)
   Vd=.T.
   If LastKey()!=27
      MTipoCart=Codigo
      Sele Cartoes
      DbGoTop()
      Locate for Codigo=MTipoCart
      @ L,25 Say NomeCar
      Ordem=.T.
   EndIf
   Flag=.F.
Else
   If !Empty(X)
      Locate for Codigo=X
      If Found()
         Sele Cartoes
         DbGoTop()
         Locate for Codigo=X
         @ L,25 Say NomeCar
         Ordem=.T.
      Else
         DBox('Tipo de Cart„o Inv lido !!!',,,0,.T.,,)
      EndIF
   Else
      MDB3={"Codigo","NomeCar"}
      DBGOTOP()
      Vd=.F.
      VDbf(10,25,18,45,"Cartoes",MDb3,,"MTipoCart",)
      Vd=.T.
      If LastKey()!=27
         MTipoCart=Codigo
         Sele Cartoes
         DbGoTop()
         Locate for Codigo=MTipoCart
         @ L,25 Say NomeCar
         Ordem=.T.
      EndIf
   EndIf
EndIf
SELE &AREA
SETCURSOR(CUR)
RETURN(ORDEM)

//FUNCAO INCLUI COBRANCAS - USADO HOT23, FECHAMENTO DE CONTA

FUNCTION COB()
AREA=SELECT()
DBCOMMITALL()
SELE 16
DbfParam=DrvDbf+"ConRec"
UseArq(DbfParam)
IF !FILE("CONREC.NTX")
   INDEX ON CODFIR TO CONREC
ELSE
   SET INDEX TO CONREC
ENDIF
APPE BLAN
REPLACE CODFIR   WITH MFIRMAAGE,;
DATAFEC  WITH MDTSAI,;
VALOR    WITH MVALOR,;
SITUACAO WITH "A"
DBCOMMIT()
USE
SELE &AREA
RETURN (NIL)

//FUNCAO INCLUI CHEQUE PRE-DATADO OU NAO - USADO HOT23, FECHAMENTO

FUNCTION CHEQUE(TIPO,Op)

LOCAL GETLIST:={},Ordem:=.F.
AREA=SELECT()
DO CASE
   CASE OP=Space(01)
      SELECT &AREA
      TFORMAPAG=SPACE(08)
      RETURN(ORDEM)
   CASE OP='S'            //INCLUSAO DE CHEQUES-PRE
      JANELA(01,13,15,19,60," Inclusao de Cheques Pre ")
      @ 14,16 SAY " N§ Cheques Â Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ"
      @ 15,16 SAY "            ³              ³                "
      @ 16,16 SAY " Data da Emissao Â Data Predatada ÄÄÄÄÄÄÄÄÄÄ"
      @ 17,16 SAY "                 ³                          "
      @ 18,16 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      VALORAUX := MVALOR
      SELE Cheques
      DO WHILE .T.
         INIC_VAR()
         MVALOR := VALORAUX
         MAGENCIA=0
         MDATAEMIS=DataC
         MTIPOMOV=TIPO
         MOperador=Usuario
         SET CURSOR ON
         @ 15,17 GET MNCHEQUE                  VALID (!EMPTY(MNCHEQUE))
         @ 15,30 GET MBANCO       PICT "9999"  VALID (!EMPTY(MBANCO))
         @ 15,45 GET MAGENCIA     PICT "99999"
         @ 17,17 GET MDATAEMIS                 VALID(!EMPTY(MDATAEMIS))
         @ 17,35 GET MDATAPRE                  VALID(If((MDataPre<MDataEmis),(DBox('Data predatada menor que a data|de emiss„o !!!',,,0,.T.,,),.F.),.T.))
         READ
         SET CURSOR OFF
         IF LASTKEY()=K_ESC
            SELE &AREA
            ORDEM=.F.
            TFORMAPAG=SPACE(08)
            JANELA(02)
            RETURN(.F.)
         ENDI
         AUX=VERCHEQUE(MNCHEQUE,MBANCO)
         IF AUX
            EXIT
         ENDIF
      ENDDO
      MNUMERO=MNCHEQUE
      MCODIGO=REGISTRO->CODIGO
      MCODHOSP=ConRegis->CODHOSP
      Sele Cheques
      IF TRAVAREG()
         REPL_VAR()
         UNLOCK
         ORDEM=.T.
      ELSE
         DBox('Cheque n„o Cadastrado !!!',,,0,.T.,,)
      ENDIF
      JANELA (2)
   CASE OP='N'        //INCLUSAO DE CHEQUES n„o Pr‚
      SELE Pagam
      JANELA(01,11,13,15,67," Inclusao de Cheques ")
      @ 12,14 SAY " N§ Cheques ÄÄÄÄÄÄÄÄÄÂ Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ"
      @ 13,14 SAY "                     ³              ³                "
      @ 14,14 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      DO WHILE .T.
         MNUMERO=SPACE(20)
         MBANCO=0
         MAGENCIA=0
         MDATAEMIS=DataC
         MOperador=Usuario
         SET CURSOR ON
         @ 13,15 GET MNUMERO     Pict "!!!!!!!!!"  VALID(!EMPTY(MNUMERO))
         @ 13,37 GET MBANCO      PICT "9999"       VALID (!EMPTY(MBANCO))
         @ 13,52 GET MAGENCIA    PICT "99999"
         READ
         SET CURSOR OFF
         IF LASTKEY()=K_ESC
            SELE &AREA
            ORDEM=.F.
            TFORMAPAG=SPACE(08)
            JANELA(02)
            RETURN(.F.)
         ENDI
         AUX=VERCHEQUE(MNUMERO,MBANCO)
         IF AUX
            EXIT
         ENDIF
      ENDDO
      MCODIGO=REGISTRO->CODIGO
      MCodHosp=ConRegis->CodHosp
      MTIPOMOV=TIPO        //TIPO DE MOVIMENTO PASSADO COMO PARAMETRO
      Sele Pagam
      IF TRAVAREG()
         MDataMov=DataC
         REPL_VAR()
         UNLOCK
         ORDEM=.T.
      ELSE
         DBox('Cheque n„o Cadastrado !!!',,,0,.T.,,)
      ENDIF
      JANELA (2)
      ORDEM=.T.
ENDCASE
SELE &AREA
RETURN (ORDEM)

//FUNCAO VERIFICA APTO

FUNCTION VERAPTO(X,Z)
AREA=SELECT()
ORDEM=.F.
IF !EMPTY(X)
   SELE Aptos
   IF Z='A'
      REG=RECNO()
   ENDIF
   DBGOTOP()
   LOCATE FOR APTO=X
   IF FOUND()
      AT=SELECT()
      DO CASE
         CASE Z='I'
            DBox('Apartamento j  Cadastrado !!!',,,0,.T.,,)
         CASE Z='A'
            IF RECNO()=REG
               ORDEM=.T.
            ELSE
               DBox('Apartamento j  Cadastrado !!!',,,0,.T.,,)
            ENDIF
         OTHERWISE
            ORDEM=.T.
      ENDCASE
   ELSE
      IF Z='I' .OR. Z='A'
         ORDEM=.T.
      ELSE
         DBox('Apartamento j  Cadastrado !!!',,,0,.T.,,)
      ENDIF
      IF Z='A'
         GO REG
      ENDIF
      SET ORDER TO 1
      SELE &AREA
   ENDIF
ELSE
   DBox('Apartamento Inv lido !!!',,,0,.T.,,)
ENDIF
SELE &AREA
RETURN(ORDEM)

//FUNCAO VERIFICA RESERVA

FUNCTION VERRES(XX,D,T)

Local Ordem:=.F.

DBox('parada',,,0,.T.,,)
If !Empty(XX)
   Sele Reserva
   AREA=SELECT()
   AUX=RECNO()
   ORD=VERAPTO(@XX,'C')
   ORDEM=.T.
   IF ORD
      SELE Reserva
      DBGOTOP()
      IF T='ALTERACAO'
         LOCATE FOR ((DTRESER=D) .AND. (APTO=XX) .AND. (RECNO()!=AUX))
      ELSE
         LOCATE FOR ((DTRESER=D) .AND. (APTO=XX))
      ENDIF
      IF FOUND()
         DBox('Apartamento reservado|para esta data !!!',,,0,.T.,,)
         SELE &AREA
         GO AUX
         RETURN(.F.)
      Else
         Sele Registro
         DbGoTop()
         LOCATE FOR APTO=XX .AND. ATIVO='S'
         If Found()
            JANELA(01,03,24,06,62)
            @ 04,32 SAY "Apartamento Ocupado !!!"
            @ 05,28 SAY "Data prevista de saida"
            @ 05,51 SAY DTSAI  PICT "@D"
            Ope=Space(01)
            Ope=MTab([SIM|NŽO],[Prosseguir ?])
            JANELA(02)
            If Ope='S'
               Ordem=.T.
            Else
               Ordem=.F.
            EndIf
         ENDIF
      ENDIF
      SELE &AREA
      GO AUX
   EndIf
EndIf
RETURN(ORDEM)

//FUNCAO ATUALIZA O APTO PARA 'S' DEPOIS DE EXCLUIR RESERVA - REGISTRO

FUNCTION VERRESER

Local Regis,Reg,Are,Area,Rc

AREA=SELECT()
REG=RECNO()
Sele Reserva
Regis=Recno()
AUX=APTO
DBGOTOP()
COUNT ALL FOR APTO=AUX TO NUMAPTO
IF NUMAPTO=1
   Sele Reserva
   DbGoTop()
   Locate for Apto=Aux .And. Recno()!=Regis
   If !Found()
      SELE Aptos
      DBGOTOP()
      LOCATE FOR APTO=AUX
      DO WHILE .T.
         IF RLOCK()
            If Liberado='S' .Or. Liberado='R'
               REPL LIBERADO WITH 'S'
            Else
               Repl Liberado with 'N'
            EndIf
            UNLOCK
            EXIT
         ELSE
            DBox('Arquivo sendo utilizado !!!',,,0,.T.,,)
         ENDIF
      ENDDO
   EndIF
ENDIF
Sele Reserva
IF Regis!=0
   Go Regis
ENDIF
SELE &AREA
If Reg!=0
   GO REG
EndIf
RETURN

FUNC CALIDA(X)
Local MIdade
MIDADE=INT((Datac-X)/365)
RETURN(MIdade)

//FUNCAO VERIFICACAO DE CHEQUES
FUNCTION VERCHEQUE(X,Z)

LOCAL ORDEM

ARE=SELECT()
REG=RECNO()
ORDEM=.T.
SELE Cheques
SET FILTER TO BANCO=Z
DBGOTOP()
LOCATE FOR NCHEQUE=X
IF FOUND()
   DBox("Cheque j  Cadastrado !!!",,,0,.T.,,)
   ORDEM=.F.
Else
   SELE Pagam
   SET FILTER TO BANCO=Z
   DBGOTOP()
   LOCATE FOR NUMERO=X
   IF FOUND()
      DBox("Cheque j  Cadastrado !!!",,,0,.T.,,)
      ORDEM=.F.
   ENDIF
   SET FILTER TO
ENDIF
SET FILTER TO
SELE &ARE
IF REG!=0
   GO REG
ENDIF
RETURN (ORDEM)

//FUNCAO MENU PICK DE ESTADO CIVIL

FUNCTION MENUCIVIL

LOCAL ORDEM:=.F.,OpEC

TEstCivil=MTab([1-SOLTEIRO|2-CASADO|3-SEPARADO|4-AMASIADO|5-DIVORCIADO],[Estado Civil])
If LastKey()!=27
   Ordem=.T.
EndIf
RETURN(ORDEM)

//FUNCAO INCLUI CARTAO DE CREDITO - USADO HOT23, FECHAMENTO DE CONTA

FUNCTION CARTAO()
AREA=SELECT()
ORDEM=.T.
JANELA(01,11,13,15,67,"Inclusao de Cartoes")
@ 12,14 SAY " N§ Cartao ÄÄÄÄÄÄÄÄÄÄÂ Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ"
@ 13,14 SAY "                     ³              ³                "
@ 14,14 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
SELE Pagam
SET CURSOR ON
@ 13,15 GET MNUMERO       VALID(!EMPTY(MNUMERO))
@ 13,37 GET MBANCO      PICT "9999"  VALID (!EMPTY(MBANCO))
@ 13,52 GET MAGENCIA    PICT "99999"
READ
SET CURSOR OFF
IF LASTKEY()=K_ESC
   MNUMERO=SPACE(20)
   MBANCO=0
   MAGENCIA=0
   ORDEM=.F.
   TFORMAPAG=SPACE(08)
   JANELA(02)
   RETURN(ORDEM)
ENDIF
JANELA(2)
SELE &AREA
RETURN(ORDEM)

//Fun‡„o Muda Operador

Procedure MudaOp

Local L,C,Cor,Cod_Ant:=Cod_Sos

Set Key K_F2 to
L=Row()
C=Col()
Cor=SetColor()
reg_dbf=POINTER_DBF()                     // salva situacao de todos dbf's
IF !FILE(dbfpw)                                            // se nao existir arquivo de
   ALERTA()                                                // senhas, avisa
   DBOX("Arquivo de senhas ausente!",,,2)
   RESTSCREEN(0,0,MAXROW(),79,v0)                          // restaura a tela
   SETPOS(MAXROW()-1,1)                                    // cursor na penultima linha, coluna 1
   RETU                                                    // retorna ao DOS
ENDI

#ifdef COM_REDE
   IF ! USEARQ(dbfpw,.f.,20,1,.f.)                         // falhou abertura modo compartilhado,
      RESTSCREEN(0,0,MAXROW(),79,v0)                       // restaura tela
      SETPOS(MAXROW()-1,1)                                 // cursor na penultima linha, coluna 1
      RETU                                                 // retorna ao DOS
   ENDI
#else
   EDBF(dbfpw,.t.)                                         // desprotege arquivo de
   USE (dbfpw)                                             // senhas e o utiliza
#endi

IF !FILE(ntxpw+".ntx")                                     // se nao ha indice,
   INDE ON pass TO (ntxpw)                                 // cria o arquivo indice
ENDI
SET INDE TO (ntxpw)
IF ASC(nace)>48 .AND. ASC(nace)<52                         // previne erro

   #ifdef COM_REDE
      IF !BLOARQ(3,.5)                                     // se nao conseguiu bloquear o arquivo,
         RESTSCREEN(0,0,MAXROW(),79,v0)                    // restaura tela
         SETPOS(MAXROW()-1,1)                              // cursor na penultima linha, coluna 1
         RETU                                              // retorna ao DOS
      ENDI
   #endi

   REPL ALL nace WITH ENCRIPT(nace),;                      // manipulacao das senhas
            nome WITH ENCRIPT(nome)                        // criptografando o nivel e nome

   #ifdef COM_REDE
      UNLOCK                                               // libera arquivo
   #endi

ENDI
cod_sos=15
COLORSELECT(COR_GET)
v1=SAVESCREEN(0,0,MAXROW(),79)
CAIXA(mold,10,22,14,58,440)
@ 11,30 SAY "INFORME A SUA SENHA"                          // monta janela para
@ 12,35 SAY "Þ      Ý"                                     // solicitar a entrada
@ 13,26 SAY "ESC para recome‡ar/finalizar"                 // da senha de acesso
cp_=1
DO WHIL .t.
   COLORSELECT(COR_GET)
   senha=PADR(PWORD(12,36),6)                              // recebe a senha do usuario
   COLORSELECT(COR_PADRAO)
   SEEK senha                                              // ve se esta' credenciado
   IF FOUND()                                              // OK!
      usuario=TRIM(DECRIPT(nome))                          // nome do usuario
      senhatu=senha                                        // sua senha
      nivelop=VAL(DECRIPT(nace))                           // seu nivel
      FOR t=1 TO nss                                       // exrot[] contera' as
         msg=sistema[t,O_ARQUI]                            // rotinas nao acessadas
         exrot[t]=ex&msg.                                  // de cada subsistema
      NEXT
      IF nivelop>0.AND.nivelop<4                           // de 1 a 3...
         DBOX("Bom trabalho, "+usuario,13,45,2)            // boas vindas!
         EXIT                                              // use e abuse...
      ENDI
   ELSE
      IF cp_<2 .AND. !EMPTY(senha)                         // epa! senha invalida
         cp_++                                             // vamos dar outra chance
         ALERTA()                                          // estamos avisando!
         DBOX("Senha inv lida!",,,1)
         COLORSELECT(COR_GET)
         @ 12,36 SAY SPAC(6)
      ELSE                                                 // errou duas vezes!
         IF !EMPTY(senha)                                    // se informou senha errada
            ALERTA()                                         // pode ser um E.T.
            DBOX("Usu rio n„o autorizado!",,,2)
         ENDI

         #ifndef COM_REDE
            EDBF(dbfpw,.f.)                                // protege o arquivo de senhas
         #endi

         #ifdef COM_PROTECAO
            EVAL(protdbf,.f.)                              // protege DBF
         #endi

         RESTSCREEN(0,0,MAXROW(),79,v0)                    // restaura tela,
         SETPOS(MAXROW()-1,1)                              // cursor na penultima linha, coluna 1
         MUDAFONTE(0)                                      // retorna com a fonte normal
         Close All
         Quit                                              // e tchau!
      ENDI
   ENDI
ENDD
RESTSCREEN(0,0,MAXROW(),79,v01)                     // restaura tela
USE                                                // fecha o arquivo de senhas
POINTER_DBF(reg_dbf)                               // restaura ponteiro dos dbf's
SeiLa=SetColor()
CBC1(.T.)                                             // atualiza parametros do cabecalho
Msg_Auto="Opera‡„o n„o autorizada, "+Usuario
SetColor(SeiLa)
v01=SAVESCREEN(0,0,MAXROW(),79)
Infosis('[F1] Help, [ALT+H] Muda Data, [F11] Pesq. Hosp., [F2] Muda Op., [ALT+X] Sai')
Cod_Sos=Cod_Ant
Set Key K_F2 to MudaOp
Return

//Fun‡Æo Sai do Sistema

Procedure Sair

Local L,C,Cor,Cod_Ant:=Cod_Sos

Set Key K_ALT_X to
L=Row()
C=Col()
Cor=SetColor()
ALERTA()
msgt="ENCERRAMENTO"
msg ="Finalizar opera‡”es|N„o finalizar"
cod_sos=1
op_=DBOX(msg,,,E_MENU,,msgt,,,1)
IF op_=1
   MUDAFONTE(0)
   Close All
   RESTSCREEN(0,0,MAXROW(),79,v0)                     // s'imbora
   SETPOS(MAXROW()-1,1)                               // e cursor na penultima linha, coluna 1
   Quit
ENDI
SetColor(Cor)
@ L,C Say ''
Set Key K_ALT_X to Sair
Cod_Sos=Cod_Ant
Return

//Fun‡„o d  Bal„o no Get para funcionar o MTab

Function Balao(X)

Do While .T.
   Do Case
      Case x=1
         MMovimE=Mtab([CONJUNTO|INDIVIDUAL],[O Movimento Extra ser  Conjunto|ou Individual ?])
      Case x=2
         H=MTab([SIM|NŽO],[Haver  Desconto ?])
      Case X=3
         MMovimN=Mtab([CONJUNTO|INDIVIDUAL],[O Movimento Normal ser  Conjunto|ou Individual ?])
      Case X=4
         Opcao=MTab([SIM|NŽO],[Fechar Realmente a Conta ?])
      Case X=5
         Opc=MTab([SIM|NŽO],[Cheque Pr‚-Datado ?])
      Case X=6
         Fecha=MTab([NORMAL|EXTRA|TUDO],[Fechar quais Movimentos ?])
      Case X=7
         Opr=MTab([SIM|NŽO],[Reabertura de Conta.|Reabrir Realmente a Conta ?])
      Case X=8
         XXX=MTab([EXTRA|NORMAL E EXTRA],[O Movimento Normal ‚ Conjunto e|o Extra ‚ Individual.|Reabrir qual Movimento ?])
         If LastKey()=27
            Ord=.F.
         Else
            Ord=.T.
         EndIf
      Case X=9
         XXX=MTab([NORMAL|NORMAL E EXTRA],[O Movimento Extra ‚ Conjunto e|o Normal ‚ Individual.|Reabrir qual Movimento ?])
         If LastKey()=27
            Ord=.F.
         Else
            Ord=.T.
         EndIf
      Case X=10
         XH=Substr(MHoraF,01,02)+":"+Substr(MHoraF,03,02)
         H=MTab([SIM|NŽO],[Atualizar o arquivo de Parametros com a data ]+DtoC(MDataF)+[|e a hora ]+XH+[ ?])
      Case X=11
         XXX=MTab([SIM|NŽO],[Efetuar a Sa¡da de Hospede ?])
      Case X=12
         Op=MTab([AUTOMTICO|MANUAL|CANCELAR OPERA€ŽO],[O Lan‡amento de Di ria ser  ?])
      Case X=13
         AXC=MTab([SIM|NŽO],[J  foi lan‡ado uma Di ria hoje, ]+DtoC(DataC)+[|para o este Hospede.|Efetuar este lan‡amento ?],04,19)
      Case X=14
         Opcao=MTab([SIM|NŽO],[Apagar Realmente todos os Movimentos ?],04,19)
      Case X=15
         Opcao=MTab([SIM|NŽO],[Imprimir Fatura de Movimento Normal ?])
      Case X=16
         Opcao=MTab([SIM|NŽO],[Imprimir Fatura de Movimento Extra ?])
      Case X=17
         Ocao=MTab([SIM|NŽO],[Foi encontrado Desconto Cont¡nuo para este Hospede.|Apagar todos os Descontos Cont¡nuos ?],04,19)
      Case X=18
         H=MTab([SIM|NŽO],[Imprimir o Boletim de Movimentos|Di rio ?])
      Case X=19
         Op=MTab([SIM|NŽO],[Prosseguir ?])
   EndCase
   If LastKey()=27
      Loop
   Else
      Exit
   EndIf
EndDo
Return(.F.)

//Fun‡„o Atualiza Data

Procedure AtuData

Local Ant_Sos:=Cod_Sos

Set Key K_ALT_H to
SET CONF (drvconf)             // ajusta SET CONFIRM
cod_sos=1
ALERTA(1)
Cur=SetCursor()
Set Cursor On
msg="Atualize a data de hoje"
datac=DBOX(msg,,,,,"ATEN€ŽO!",datac,"99/99/99")    // confirma a data
//IF UPDATED()                                       // se modificou sugestao,
//   DOSDATA(DTOC(datac))                              // vamos atualizar o DOS
//ENDI
dbfparam=drvdbf+"PARAMET"
SELE A

#ifdef COM_REDE
   USEARQ(dbfparam,.t.,,,.f.)
#else
   USE (dbfparam)
#endi
Cor=SetColor()
RESTSCREEN(0,0,MAXROW(),79,v01)                     // restaura tela
CBC1(.T.)                                             // atualiza parametros do cabecalho
SetColor(Cor)
v01=SAVESCREEN(0,0,MAXROW(),79)
Set Cursor Off
Infosis('[F1] Help, [ALT+H] Muda Data, [F11] Pesq. Hosp., [F2] Muda Op., [ALT+X] Sai')
Set Key K_ALT_H to AtuData
Cod_Sos=Ant_Sos
If !TerCont(DataC)
   Close All
   Keyboard Chr(13)
   Do Sair
EndIf
//If (DataC>(CtoD("31/08/96")))
//   DBox('ATEN€ŽO !!!|Esta ‚ uma vers„o demonstra‡„o v lida at‚ 31/08/96,|para maiores informa‡”es consulte:|Denny Azevedo ou Marilene Esquiavoni|Av. J. K. de Oliveira,350 Sala 325|Taubat‚ - SP|TelFax (012) 232-2108.',,,0,.T.,,)
//   Close all
//   KeyBoard chr(13)
//   do Sair
//EndIF
Return

//Fun‡„o faz pesquisa r pida de hospedes

Procedure PesqHosp

Local GetList:={},MNome:=Space(35),L,C,Cor,Area,Cur,Reg,Areas_Ant[3],ZZ,H
Local ArAlias[3],Arqui
Priv Cod:={},I

L=Row()
C=Col()
Cor=SetColor()
Area=Select()
Reg=Recno()
Cur=SetCursor()
If Select("Conregis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
   areas_ant[2]=.T.
   ArAlias[2]="ConRegis"
Else
   areas_ant[2]=.F.
   ArAlias[2]="ConRegis"
EndIf
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
   Areas_Ant[1]=.T.
   ArAlias[1]="Registro"
Else
   Areas_Ant[1]=.F.
   ArAlias[1]="Registro"
EndIF
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
   Areas_ant[3]=.T.
   ArAlias[3]="Hospedes"
Else
   Areas_Ant[3]=.F.
   ArAlias[3]="Hospedes"
EndIf
Set Key K_F11 to
Set Key K_F2 to
Set Key K_ALT_H to
Janela(01,08,17,14,57,)
SETCOLOR(drvcortel)
@ 10,25 Say 'Qual o Nome do Hospede ?'
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
Set Cursor on
MNome=Space(35)
Do While .T.
   @ 12,20 Get MNome Valid(VerNomeHosp(@MNome))
   Read
   If LastKey()=27
      Janela(02)
      SetColor(Cor)
      SetCursor(Cur)
      For H=1 to 3
         If Areas_Ant[H]
            XXXXX=ArAlias[h]
            Sele &XXXXX
            Close
         EndIf
      Next
      Sele &Area
      If Reg>0
         Go Reg
      EndIF
      @ L,C Say ''
      Set Key K_F11 to PesqHosp
      Return
   Else
      Exit
   EndIf
EndDo
Janela(02)
Sele ConRegis
SETCOLOR(drvcortel)
Arqui=(Substr(Usuario,1,5)+"SOL")
If Select("Arqui")!=0
   Close
EndIF
Do While .T.
   If !File(Arqui)
      Arq:={}
      AADD(Arq,{"Apto","N",4,0})
      AADD(Arq,{"Nome","C",35,0})
      AADD(Arq,{"Identidade","C",14,0})
      DbCreate(Arqui,Arq)
      Exit
   Else
      FErase(Arqui)
   EndIf
EndDo
Use &Arqui Exclusiv New
For ZZ=1 to I
   Sele ConRegis
   DbGoTop()
   Locate for CodHosp=Cod[ZZ] .And. Ativo='S'
   If Found()
      Sele Hospedes
      DbGoTop()
      Locate for Codigo=ConRegis->CodHosp
      Sele Registro
      DbGoTop()
      Locate for Codigo=ConRegis->Codigo .And. Ativo='S'
      Sele &Arqui
      Appe Blan
      Repl Apto With Registro->Apto
      Repl Nome With Hospedes->Nome
      Repl Identidade With Hospedes->Identidad
   EndIF
   Sele ConRegis
   DbSkip()
Next
Sele &Arqui
DbGoTop()
Janela(01,04,08,23,76," Consulta de Hospedes ")
Do While .T.
   DbEdit(05,09,22,75,Arqui)
   If Lastkey()=27
      Exit
   EndIF
EndDo
Set Filter to
Janela(02)
Sele &Arqui
Close
FErase(Arqui)
Set Cursor Off
SetColor(Cor)
SetCursor(Cur)
Sele &Area
If Reg#0
   Go Reg
EndIF
@ L,C Say ''
For H=1 to 3
   If Areas_Ant[H]
      XXXXX=ArAlias[H]
      Sele &XXXXX
      Close
   EndIf
Next
Set Key K_F11 to PesqHosp
If Sets
   Set Key K_F2 to MudaOp
   Set Key K_ALT_H to AtuData
EndIf
Return

//Fun‡„o Verifica se Existe o Hospede

Function VerNomeHosp(Mn)

Local XX,Ordem:=.F.

Sele Hospedes
DbSetFilter()
DbGoTop()
XX=Upper(AllTrim(Mn))
I=0
Do While !Eof()
   If Ativo='S'
      If At(XX,Upper(Hospedes->Nome))>0
         I++
         AADD(Cod,Hospedes->Codigo)
      EndIF
   EndIf
   DbSkip()
EndDo
If I=0
   DBox("Nenhuma pessoa encontrada com|este nome ou sobrenome.",,,0,.T.,,)
   Ordem=.F.
Else
   Ordem=.T.
EndIF
Return(Ordem)

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
FUNC Sol_VDBF(l_1,c_1,l_2,c_2,db,cp_db,ca_cpdb,cp_trans,DbTitu)
LOCAL v_ar, v_:=SAVESCREEN(0,0,MAXROW(),79), t_w, t_r, t_c, t_7, t_9,;
ret_val,dele_atu:=SET(_SET_DELETED,.t.), cor_orig, i_, t_f8
PRIV tela_fundo, Regitro
v_ar=READVAR()
tem_t=.f.
IF !EMPTY(v_ar)                               // alguma variavel pendente?
   IF VALTYPE(&v_ar.) $ "CNDL"                // se for caracter, numerica, data
      tem_t=!("OP_" $ UPPER(v_ar))            // ou logico e nao for de menu, pode
      v_ar=TRIM(TRANSCAMPO(.t.,v_ar))         // transferir para o get pendente
   ENDI
ENDI
DbSelectArea(db)
DbGoTop()                                     // vai para o 1o. registro
t_w:=SETKEY(K_CTRL_W,NIL)                     // desabilita e salva
t_r:=SETKEY(K_CTRL_R,NIL)                     // as teclas de controle
t_c:=SETKEY(K_CTRL_C,NIL)
t_7:=SETKEY(K_F7,NIL)
t_9:=SETKEY(K_F9,NIL)
l_2=IF(l_2-l_1-1>RECC(),l_1+RECC()+2,l_2)
cod_sos=10
#ifdef COM_MOUSE
   IF drvmouse
      DO WHIL MOUSEGET(0,0)!=0               // se qualquer botao do mouse
      ENDD                                   // estiver pressionado espera
   ENDI                                      // liberacao
#endi
cor_orig=SETCOLOR()                          // salva cor original
t_f8=SETKEY(K_ALT_F8,NIL)                    // salva/reseta tecla ALT-F8
SetColor( drvcorbox+","+INVCOR(drvcorbox)+",,,"+drvcorget)

Janela(01,l_1-2,c_1,l_2,c_2,,.T.)
@ l_1-1,Int((c_2-c_1-2)/2) Say DbTitu
Set Cursor Off

DbEDit(l_1,c_1+1,l_2-1,c_2-1,cp_db,"VerDb1",,ca_cpdb,'Í')

Set Cursor On
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
      KeyBoard Chr(27)
      ORDEM=0
   CASE MD=4
       // TESTA A ULTIMA TECLA PRESSIONADA
      DO CASE
         CASE LASTKEY()=27  // FOI PRESSIONADO ESC
            ORDEM=0       // ABANDONA DBEDIT
         CASE LASTKEY()=13
               // FOI PRESSIONADO ENTER, NESSE CASO EDITAREMOS O CAMPO ATUAL
            REGISTRO=RECNO() // DECLARAR NA ROTINA
                                // QUE CHAMA A FUNCAO COM PRIVATE
            ORDEM=0

      ENDCASE
ENDCASE
SET CURSOR ON
RETURN(ORDEM)

Func AchaProc( Nome )
Local lAchou:= .f.

If Procname() = UPPER(Nome)
   lAchou= .t.
Else
   For i = 1 to 20
      If Procname(i) = UPPER(Nome)
         lAchou= .t.
         Exit
      Endif
   Next
Endif
Retu lAchou

Function CGC(XCGC)

Local X

If !empty(XCgc)
   X=VCgc(XCgc)
   If !X
      DBox("Digito do CGC n„o confere !!!",,,0,.T.,,)
   EndIF
EndIf
RETU(.T.)       // <- deve retornar um valor L¢GICO

//Fun‡„o verifica se outro arquivo est  utilizando, para dele‡„o
//Area     - Area em uso
//AreaAtu  - Area que a fun‡„o ir  fazer a verifica‡„o
//Condicao - Expess„o em clipper para fazer a verifica‡„o
//     E retornar  .F. se encontrou e .T. caso n„o tenha encontrado

Function VerDel(Area,AreaAtu,Condicao)

Local reg_dbf:=POINTER_DBF(),Cl[2],Ordem:=.T.

Set Deleted On
If Select("@AreaAtu")=0
   Use &AreaAtu Shared New
   Cl[1]=.T.
Else
   Cl[1]=.F.
EndIf

Sele &AreaAtu
DbGoTop()
Locate for &Condicao
If Found()
   Ordem=.F.
EndIF
If Cl[1]
   Sele &AreaAtu
   Close
EndIf
Sele &Area
POINTER_DBF(reg_dbf)                          // restaura ponteiro dos dbf's
Return(Ordem)

//Fun‡„o faz verifica‡„o no Codigo e CodHosp para o Set Filter
Function VerCod(Area,At)

Local Ordem:=.F.,XCodigo:=0,Cod:=&Area->Codigo,CodH:=&Area->CodHosp

Sele ConRegis
Set Filter to Ativo='R'
DbGoTop()
//Locate for (Codigo=Cod .And. CodHosp=CodH)
Seek(Str(Codigo,10,00)+Str(CodHosp,10,00))
If ConRegis->Ativo=At
   XCodigo=ConRegis->Codigo
   XCodHosp=Conregis->CodHosp
Else
   XCodigo=0
   XCodHosp=0
EndIf
Set Filter to
Sele &Area
Return(XCodigo)

Function Funcao(Ap)

Area=Select()

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf
Sele ConRegis
Set Order to 0

If Select("&Usuario")!=0
   Close
EndIF
Do While .T.
   If !file("&Usuario")
      Arq:={}
      AADD(Arq,{"CodHosp","N",10,0})
      AADD(Arq,{"Nome","C",35,0})
      AADD(Arq,{"Codigo","N",10,0})
      DbCreAte("&Usuario",Arq)
      Exit
   Else
      FErase("&Usuario")
   EndIf
EndDo
Use &Usuario Exclusiv New
Sele Registro
Set Filter to Apto=Ap
DbGoTop()
Do While !Eof()
   Sele ConRegis
   DbGoTop()
   Locate for Codigo=Registro->Codigo
   MCodigo=ConRegis->Codigo
   MCodHosp=ConRegis->CodHosp
   Sele Hospedes
   DbGoTop()
   Locate for Codigo=ConRegis->CodHosp
   MNome=Nome
   Sele &Usuario
   Appe Blan
   Repl Nome    With MNome
   Repl CodHosp With MCodHosp
   Repl Codigo  With MCodigo
   Sele Registro
   DbSkip()
EndDo
Sele &Usuario
MDB3={"Codigo","Nome"}
MDb1={"CodHosp","Nome"}
DBGOTOP()
Sol_Vdbf(11,11,21,60,Usuario,MDB1,Mdb3,"M->CodiHosp","CONSULTA DE HOSPEDES")
If LastKey()=13
   Sele ConRegis
   Set Filter to
   DbGoTop()
   Locate for CodHosp=&Usuario->CodHosp .And. Codigo=&Usuario->Codigo
   THospede=&Usuario->Nome
   M->CodiHosp=&Usuario->CodHosp
   MCodigo=&Usuario->Codigo
   Sele Registro
   DbGoTop()
   Locate for Codigo=ConRegis->Codigo
EndIf
Sele &Usuario
Close
Sele Hospedes
SELE &AREA
RETU(M->CodiHosp)       // <- deve retornar um valor qualquer

Procedure Chama

Local Area:=.F.

USE
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
   Area=.T.
EndIf
DbGoTop()
If Empty(Paramet->Empresa1)
   Sele Paramet
   DbGoTop()
   Do While .T.
      If Rlock()
         Exit
      Else
         DBox('Aguarde !!!. Tentando abrir o arquivo.|',,,1,.T.,,)
      EndIf
   EndDo
   Repl Empresa1     With "Denny Azevedo & Marilene Esquiavoni"
   Repl cgc1         With "00011901000189"
   Repl ender1       With "Av. Jucelino K. de Oliveira"
   Repl numero1      With "00350"
   Repl bairro1      With "Centro"
   Repl cidade1      With "Taubate"
   Repl uf1          With "SP"
   Repl Pais1        With "Brasil"
   Repl cep1         With "12010060"
   Repl tele1        With "012200322108"
   Repl fax1         With "012200322108"
   Repl recepcao     With "S"
   Repl reserva      With "S"
   Repl restaurant   With "N"
   Repl estoque      With "N"
   Repl retaguarda   With "N"
   Repl financeiro   With "N"
   Repl Orcamen      With "N"
   Repl veiculo      With "N"
   Repl marina       With "N"
   Repl DtIniCont    With CtoD("13/08/1996")
   Repl dtfimcont    With CtoD("31/12/2015")
   Repl Palavra      With [58605489063107]
   Unlock
   DBox('Esta ‚ uma vers„o Demostra‡„o, v lida at‚ '+DtoC(dtfimcont)+',|qualquer d£vida consulte:||Denny Azevedo ou Marilene Esquiavoni|Av. J.K. de Oliveira, 350 - Sala 325|Taubat‚ - S„o Paulo|TeleFax : (012) 232-2108',,,0,.T.,,)
EndIf
If Senha()!=AllTrim(Paramet->Palavra)
   DBox('Houve Viola‡„o na Configura‡„o do Sistema ou na Senha de libera‡„o|comunique-se com sua empresa de suporte ou com Denny Azevedo ou Marilene Esquiavoni|para verifica‡„o do ocorrido.',,,0,.T.,,)
   Close all
   KeyBoard chr(13)
   do Sair
EndIf
If !TerCont(DataC)
   Close All
   Keyboard Chr(13)
   Do Sair
EndIf
CBC1(.T.)                                                     // atualiza parametros do cabecalho
If Area       //fecha ou n„o fecha Paramet.dbf
   Close
EndIf
DbfParam=DrvDbf+"clientes"
UseArq(DbfParam)
If Lastrec()<1
   Do While .T.
      If Rlock()
         Appe Blan
         Repl Codigo With 1
         Repl Nome   With 'Passante'
         Repl CGC    With '00000000000001'
         Unlock
         Exit
      EndIf
   EndDo
EndIf
Close
DbfParam=DrvDbf+"Tipo"
UseArq(DbfParam)
If LasTrec()<1
   Do While .T.
      If Rlock()
         Appe Blan
         Repl Codigo With 1
         Repl Tipo With 'Passante'
         Unlock
         Exit
      EndIf
   EndDo
EndIf
Close
DbfParam=DrvDbf+"Categ"
UseArq(DbfParam)
If LasTrec()<1
   Do While .T.
      If Rlock()
         Appe Blan
         Repl Codigo With 1
         Repl Categoria With 'Passante'
         Repl Pax with 9
         Unlock
         Exit
      EndIf
   EndDo
EndIf
Close
DbfParam=DrvDbf+"Hospedes"
UseArq(DbfParam)
If Lastrec()<1
   Do While .T.
      If Rlock()
         Appe Blan
         Repl Codigo With 1
         Repl Identidad With "10000000000000"
         Repl Nome With 'Passante'
         Unlock
         Exit
      EndIF
   EndDo
EndIf
Close
DbfParam=DrvDbf+"Departa"
UseArq(DbfParam)
If Lastrec()<1
   Do While .T.
      If Rlock()
         Appe Blan
         Repl Codigo With 1
         Repl TipoDesp With 'Di ria'
         Unlock
         Exit
      EndIF
   EndDo
EndIf
Close
If Select("Unidade")=0
   DbfParam=DrvDbf+"Unidade"
   UseArq(DbfParam)
Endif
If Lastrec()<1
   Do While .T.
      If Rlock()
         Appe Blan
         Repl Codigo   With 1
         Repl Unidade With 'Pr¢prio Hotel'
         Unlock
         Exit
      EndIF
   EndDo
EndIf
Close
Return

//Fun‡„o para utilizar as vari veis de parametros de rede

Function Par(cp)

Local ar_:=Alias(),DbfParam

DbfParam=DrvDbf+"Paramet"
UseArq(DbfParam)
If Empty(Ar_)
   Sele 0
Else
   Sele (Ar_)
EndIf
Retu(Paramet->&Cp)

//Fun‡„o para verifica‡„o da Data de t‚rmino do contrato

Func TerCont(mData)
Local Ar_:=Alias(),DbfParam,mOrdem:=.T.
Static mViola:=0

DbfParam=DrvDbf+"Paramet"
UseArq(DbfParam)
If Empty(Ar_)
   Sele 0
Else
   Sele (Ar_)
EndIf
If (mData>Paramet->DtFimCont)
   If ("Demonstracao"$Paramet->Empresa1)
      DBox("ATEN€ŽO !!!|Esta ‚ uma vers„o demonstra‡„o v lida at‚ "+DtoC(Paramet->Dtfimcont)+",|para maiores informa‡”es consulte:|Denny Azevedo ou Marilene Esquiavoni|Av. Juscelino K. de Oliveira, 350 Sala 325|Taubat‚ - SP|TelFax (012) 232-2108",,,0,.T.,,)
   Else
      DBox('ATEN€ŽO !!!|A data que foi fornecida n„o ‚ v lida|sua autoriza‡„o de uso vai at‚ '+DtoC(Paramet->DtFimCont)+'.|Qualquer d£vida entre em contato com sua empresa de suporte|ou diretamente com Denny Azevedo ou Marilene Esquiavoni.',,,0,.T.,,)
   EndIf
   mViola++
   mOrdem=.F.
   If mViola>3
      Close All
      Keyboard Chr(13)
      do Sair
   EndIf
EndIf
Return(mOrdem)

//Fun‡„o para verifica‡„o da senha

Function Senha(Area)
If Select(Area)=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf
simnao:=0
sim=0
nao=0

simnao=simnao+(If(Paramet->reserva=[S],83,78))
simnao=simnao+(If(Paramet->recepcao=[S],83,78))
simnao=simnao+(If(Paramet->retaguarda=[S],83,78))
simnao=simnao+(If(Paramet->restaurant=[S],83,78))
simnao=simnao+(If(Paramet->estoque=[S],83,78))
simnao=simnao+(If(Paramet->financeiro=[S],83,78))
simnao=simnao+(If(Paramet->orcamen=[S],83,78))
simnao=simnao+(If(Paramet->veiculo=[S],83,78))
simnao=simnao+(If(Paramet->marina=[S],83,78))

If(Paramet->Recepcao=[S],Sim++,nao++)
If(Paramet->reserva=[S],Sim++,nao++)
If(Paramet->retaguarda=[S],Sim++,nao++)
If(Paramet->restaurant=[S],Sim++,nao++)
If(Paramet->estoque=[S],Sim++,nao++)
If(Paramet->financeiro=[S],Sim++,nao++)
If(Paramet->orcamen=[S],Sim++,nao++)
If(Paramet->veiculo=[S],Sim++,nao++)
If(Paramet->marina=[S],Sim++,nao++)

simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),01,01)))+17)+sim-nao)*2
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),02,01)))+17)+sim-nao)*3
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),04,01)))+17)+sim-nao)*4
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),05,01)))+17)+sim-nao)*5
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),07,01)))+17)+sim-nao)*7
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),08,01)))+17)+sim-nao)*8
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),09,01)))+17)+sim-nao)*9
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtinicont),10,01)))+17)+sim-nao)*10

simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),01,01)))+30)-sim+nao)*9
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),02,01)))+30)-sim+nao)*8
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),04,01)))+30)-sim+nao)*7
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),05,01)))+30)-sim+nao)*6
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),07,01)))+30)-sim+nao)*5
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),08,01)))+30)-sim+nao)*4
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),09,01)))+30)-sim+nao)*3
simnao=simnao+(((asc(Substr(DtoC(Paramet->dtfimcont),10,01)))+30)-sim+nao)*2

For I:=1 to 35
   simnao=simnao+(Asc(Substr((Paramet->Empresa1),I,01)))
Next
For I:=1 to 14
   simnao=simnao+Asc(Substr((Paramet->Cgc1),I,01))
Next
For I:=1 to 12
   simnao=simnao+Asc(Substr((Paramet->inscr1),I,01))
next
For I:=1 to 35
   simnao=simnao+Asc(Substr((Paramet->ender1),I,01))
next
For I:=1 to 5
   simnao=simnao+Asc(Substr((Paramet->numero1),I,01))
next
For I:=1 to 18
   simnao=simnao+Asc(Substr((Paramet->bairro1),I,01))
next
For I:=1 to 20
   simnao=simnao+Asc(Substr((Paramet->cidade1),I,01))
next
For I:=1 to 2
   simnao=simnao+Asc(Substr((Paramet->uf1),I,01))
next
For I:=1 to 15
   simnao=simnao+Asc(Substr((Paramet->pais1),I,01))
next
For I:=1 to 08
   simnao=simnao+Asc(Substr((Paramet->cep1),I,01))
next
For I:=1 to 12
   simnao=simnao+Asc(Substr((Paramet->tele1),I,01))
next
For I:=1 to 12
   simnao=simnao+Asc(Substr((Paramet->fax1),I,01))
next
For I:=1 to 15
   simnao=simnao+Asc(Substr((Paramet->tex1),I,01))
next
If Sim!=0
   simnao=(simnao*sim)-nao
EndIf
simnao=simnao*simnao*simnao
Return(AllTrim(Str(SimNao)))
