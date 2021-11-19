/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT21.PRG
 \ Data....: 24-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Efetuar o Registro do Hospede e Lan‡ar Primeira Di ria
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'


LOCAL GETLIST:={},ORDEM

PRIV APRE:="N",REGRE:=0,SAI:=0,TMaxPax:=0
Priv TFirma:=Space(35),TdtSai

Cod_Sos_Ant=Cod_Sos
Cod_Sos=66
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("clientes")=0
   DbfParam=DrvDbf+"clientes"
   UseArq(DbfParam)
EndIf
If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf
If Select("Desconto")=0
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam)
EndIf
If Select("reserva")=0
   DbfParam=DrvDbf+"Reserva"
   UseArq(DbfParam)
EndIf
If Select("RPes")=0
   DbfParam=DrvDbf+"RPes"
   UseArq(DbfParam)
EndIf
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
EndIf
If Select("Categ")=0
   DbfParam=DrvDbf+"Categ"
   UseArq(DbfParam)
EndIf
If Select("Precos")=0
   DbfParam=DrvDbf+"Precos"
   UseArq(DbfParam)
EndIf
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf

Op_Menu=1              //Vari vel que determina a barra de status
Set Deleted On
SELE ConRegis          //INICIALIZA VARIAVEIS DE ARQUIVO CONREGIS
INIC_VAR()
SELE Registro
INIC_VAR()             //INICIALIZA VARIAVEIS DE ARQUIVO REGISTRO
THOSPE=SPACE(35)
MDTENT=Datac
MHENT=HORA(TIME())
MOPENT=Usuario
MOBS=SPACE(30)
TFIRMA=SPACE(35)
TINTERM=SPACE(35)
TIdentidad=Space(14)
MPAX=0
MAPTO=0
TPCONTA=SPACE(07)
TULTPROC=SPACE(20)
TPROXDEST=SPACE(20)
TOBS=SPACE(30)
TDTSAI=CTOD("  /  /  ")
TINTERM=SPACE(35)   //AS INICIALIZACOES TAMBEM SAO FEITAS NO FINAL DO LACO
MDataMov=DataC
DO WHILE .T.
   SETCOLOR(drvcorbox)
   MRHOSP:={}
   MRNome:={}
   MRPC:={}
   MRULTP:={}
   MRPROXD:={}
   MROBS:={}
   MRDTSAI:={}
   JANELA(01,09,17,17,59," Registro de Hospedes ")
   InfoSis("Inclui","[F8] Tabela")
   SETCOLOR(drvcortel)
   @ 09,17 SAY "±±±±±±±±± Registro de Hospedes ±±±±±±±±±±±±"
   @ 11,18 SAY "Ú Apto Â Pax Â CHD Â Dt Entr.  Â H. Ent.¿"
   @ 12,18 SAY "³      ³     ³     ³           ³        ³"
   @ 13,18 SAY "Ã Firma ou Agente ÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´"
   @ 14,18 SAY "³                                       ³"
   @ 15,18 SAY "Ã Intermediario ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 16,18 SAY "³                                       ³"
   @ 17,18 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   APRE="N"
   REGRE=0
   SAI=0
   SET CURSOR ON
   SET KEY K_F8 TO PICKS      //MENU PICK
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
   Flag=.F.
   @ 12,20 GET MAPTO     PICT "9999"       VALID (VEREVEN(@MAPTO))
   Read
   IF LASTKEY()=K_ESC
      EXIT
   ENDIF
   If (Paramet->faixaini<=MApto .And. Paramet->faixafim>=MApto)
      MPax=9
      TMaxPax=99
   Else
      If MPax!=0
         Do NumPax    //Atribui Valor M ximo do N£mero de Pax
         If MPax>TMaxPax
            DBox("N£mero de Pax ultrapassando limite|para este Apartamento.",,,0,.T.,,)
            MPax=TMaxPax
         EndIf
      Else
         Do NumPax
         MPax=TMaxPax
      EndIF
   EndIf
   Flag=.F.
   @ 12,27 GET MPAX      PICT "99"        VALID (VerPax(@MPax))
   @ 12,33 GET MCHD      PICT "99"
   @ 12,39 GET MDTENT                     VALID (!EMPTY(MDTENT))
   @ 12,50 GET MHENT     PICT "@R 99:99"  VALID (!EMPTY(MHENT))
   @ 14,20 GET TFIRMA                     VALID REGFIRMA(@TFIRMA,'F')
   @ 16,20 GET TINTERM                    VALID REGFIRMA(@TINTERM,'I')
   READ
   IF LASTKEY()=K_ESC
      EXIT
   ENDIF
   ATUA=1
   JANELA(01,11,15,19,64," Registro de Hospede ")
   SETCOLOR(drvcortel)
   @ 11,15 Say "±±±±±±±±±±±±± Registro de Hospedes ±±±±±±±±±±±±±±±"
   @ 13,16 SAY "Ú Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ P.Conta ¿"
   @ 14,16 SAY "³                                    ³         ³"
   @ 15,16 SAY "Ã Ult. Proc. ÄÄÄÄÄÄÄÄÄÄÂ Prox. Dest. ÁÄÄÄÄÄÄÄÄÄ´"
   @ 16,16 SAY "³                      ³                       ³"
   @ 17,16 SAY "Ã Observacao ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÂ Dt. Saida ÄÄÄ´"
   @ 18,16 SAY "³                               ³              ³"
   @ 19,16 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   SET CURSOR ON
   Conta=Space(01)  //Isto para abrir ou n„o conjunto/individual normal
   If Empty(Thospe)
      THOSPE=SPACE(35)
      TemReserva=.T.
   Else
      Sele RPes
      Set Filter to Codigo=Reserva->Codigo
      DbGoTop()
//      DbSkip()
      TemReserva=.F.
   EndIf
   TPCONTA='H'
   @ 14,56 Say 'OSPEDE'
   TULTPROC=SPACE(20)
   TPROXDEST=SPACE(20)
   TOBS=SPACE(30)
   If Empty(TdtSai)
      TDTSAI=CTOD("  /  /  ")
   EndIf
   FOR NVEZES=1 TO MPAX
      @ 14,18 GET THOSPE    VALID (REGHOSP(@THOSPE))
      @ 14,55 GET TPCONTA   Pict "@!" VALID (VERPCONTA(@TPCONTA))
      @ 16,18 GET TULTPROC
      @ 16,41 GET TPROXDEST
      @ 18,18 GET TOBS
      @ 18,51 GET TDTSAI
      READ
      IF LASTKEY()=K_ESC
         EXIT
      ENDIF
      SELE Hospedes
      AADD(MRHOSP,CODIGO)
      AADD(MRNome,Nome)
      SELE Registro
      AADD(MRPC,TPCONTA)
      AADD(MRULTP,TULTPROC)
      AADD(MRPROXD,TPROXDEST)
      AADD(MROBS,TOBS)
      AADD(MRDTSAI,TDTSAI)
      If TpConta='F'
         Conta='F'
      EndIF
      IF TemReserva
         THOSPE=SPACE(35)
         TIdentidad=Space(14)
      Else
         Sele RPes
         DbSkip()
         THospe=RPes->Nome
         TIdentidad=RPes->rg
      EndIF
      TPCONTA='H'
      TULTPROC=SPACE(20)
      TPROXDEST=SPACE(20)
      TOBS=SPACE(30)
      @ 14,56 Say 'OSPEDE'
      @ 14,18 SAY THOSPE
      @ 14,55 SAY TPCONTA
      @ 16,18 SAY TULTPROC
      @ 16,41 SAY TPROXDEST
      @ 18,18 SAY TOBS
      @ 18,51 SAY TDTSAI
   NEXT
   SET CURSOR OFF
   IF LASTKEY()=K_ESC
      DBox('Registro nao Cadastrado !!!',,,0,.T.,,)
      JANELA(02)
      EXIT
   ENDIF
   Sele Registro
   MMovimN=Space(01)
   MMovimE=Space(01)
   If MPax>1     //Verifica se existe mais de um hospede no apartamento
      If Conta='F'
         MMovimN='C'
      Else
         XX=Space(01)
         @ 18,22 Get XX  When Balao(3)
         Read
      EndIF
      XXX=Space(01)
      @ 18,22 Get XXX  When Balao(1)
      Read
   Else
      MMovimN='C'
      MMovimE='C'
   EndIF
   SELE Registro
   IF LASTREC()>0
      Set Order to 01                    //ordem codigo
      DbGoBottom()
      MCODIGO=CODIGO+1
      Set Order to 0
   ELSE
      MCODIGO=1
   ENDIF
   MATIVO='S'
   SELE ConRegis            //AREA CONREGIS
   FOR CONTA=1 TO MPAX     //CONTADOR DA MATRIZ DO CODIGO DO NOME DO HOSPEDE
      Do While .T.
         IF TRAVAREG()
            MCODHOSP=MRHOSP[CONTA]
            MNome=MRNome[Conta]
            MPCONTA=MRPC[CONTA]
            MULTPROC=MRULTP[CONTA]
            MPROXDEST=MRPROXD[CONTA]
            MOBS=MROBS[CONTA]
            MDTSAI=MRDTSAI[CONTA]
            REPL_VAR()
            UNLOCK
            Exit
         ENDIF
      EndDo
   NEXT
   SELE Registro
   SET ORDER TO 0
   Sele Conregis
   Set Filter to Codigo=MCodigo
   DbGotop()
   TDtSai=DtSai
   THSai=HSai
   Do While !Eof()
      If DtSai>TDtSai
         TDtSai=DtSai
         THSai=HSai
      EndIF
      DbSkip()
   EndDo
   MDtSai=TDtSai
   MHSai=THSai
   Set Filter to
   Sele Registro
   IF TRAVAREG()
      SELE Registro
      REPL_VAR()
      UNLOCK
      MOPERADOR=Usuario
//      OCUP_APTO(MAPTO)
      If !(!Empty(Paramet->faixaini) .And. MApto>=Paramet->faixaini .And. MApto<=Paramet->faixafim )
         JANELA(01,13,07,19,76," Lancamento Inicial de DI RIA ")
         SETCOLOR(drvcortel)
         @ 13,07 Say "±±±±±±±±±±±±±±±±±±± Lan‡amento Inicial de Di ria ±±±±±±±±±±±±±±±±±±±±±"
         @ 15,08 SAY "Ú Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Data ÄÄÄÄÂ Hora ÄÄÄÄ¿"
         @ 16,08 SAY "³      ³                                     ³          ³          ³"
         @ 17,08 SAY "Ã Tp. Mov. Â Tipo de Despesa ÄÄÄÄÄÄÄÄÄÂ Valor ÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´"
         @ 18,08 SAY "³          ³                          ³                            ³"
         @ 19,08 Say "ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
         If MPax>1 .And. MMovimN='I'
            Con=MPax
         Else
            Con=1
         EndIF
         Sele Categ     //Area de Categorias
         DbGoTop()
         Locate for Pax=MPax
         If Found()
            PaxCateg=Codigo
            Sele Precos     //Area de Pre‡os
            DbGoTop()
            Locate for Tipo=Aptos->Tipo .And. Categ=PaxCateg
            If Found()
               MValor=Diaria
            Else
               DBox('Este Apartamento, nesta Categoria|n„o possui Valor de Diaria.',,,0,.T.,,)
               MValor=0
            EndIF
         Else
            DBox('Esta quantidade de Pax,|nesta categoria, n„o possui valor|de di ria.',,,0,.T.,,)
            MValor=0
         EndIF
         For N=1 To Con
            OCUP_APTO(MAPTO,N)
            Sele Hospedes
            DbGoTop()
            Locate for Codigo=MRHosp[N]
            If Found()
               THospe=Nome
               MCodHosp=Codigo
            Else
               THospe=Space(35)
               MCodHosp=0
            EndIf
            MHORAMOV=HORA(TIME())
            MDATMOV=Datac
            MTIPODESP=1
            MTipoMov=1
            TTIPODESP=1
            TTIPOMOV=1
            MTCon='N'
            MEstorno='N'
            @ 16,10 SAY MAPTO PICT "9999"
            @ 16,17 SAY THOSPE
            @ 16,54 SAY MDATMOV
            @ 16,65 SAY MHORAMOV      PICT "@R 99:99"
            @ 18,21 SAY TTIPODESP     PICT "99"
            @ 18,Col()+2 Say 'Di ria'
            @ 18,10 Say MTIPOMOV      PICT "9"
            If MTipoMov=1
               @ 18,Col()+1 Say 'NORMAL'
            Else
               @ 18,Col()+1 Say 'EXTRA'
            EndIf
            SET CURSOR ON
            SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
            @ 18,48 Get mValor        Pict "@R 99,999.99" Valid (mValor>0)
            READ
            IF LASTKEY()!=K_ESC
               SET CURSOR OFF
               Sele Movim
               IF TRAVAREG()
                  REPL_VAR()
                  UNLOCK
               ENDIF
               XX=Space(01)
               H='N'
               If clientes->descvalor!=0 .or. clientes->descporc!=0
                  DBox('Existe Desconto para este hospede|por causa da firma.||Valor..........: '+STR(clientes->descvalor)+'   | Porcentagem....: '+STR(clientes->descporc)+' %        ',,,0,.T.,,)
               EndIf
               @ 18,44 Get XX  When Balao(2)   //haver  Desconto ?
               Read
               TV=MValor
               IF H='S'        //caso houver desconto entra no la‡o
                  DESCONTO1("HOT21")
                  MCODIGO=REGISTRO->CODIGO
                  MOPERADOR=Usuario
                  MTCON='D'
                  Sele Desconto
                  DbGoTop()
                  Locate FOR CODIGO=REGISTRO->CODIGO .And. CodHosp=MCodHosp
                  IF FOUND()
                     If !Empty(Final)
                        mValor=Final*(-1)
                     Else
                        mValor = (mValor*(Porc/100))*(-1)
                     EndIf
                     Sele Movim
                     MTcon='D'
                     MEstorno='N'
                     IF TRAVAREG()
                        REPL_VAR()
                        UNLOCK
                     ENDIF
                  ENDIF
               ENDIF
               MValor=TV
            Else
               DBox('Hospede Cadastrado !!!|Mas n„o cadastrado a Di ria.',,,0,.T.,,)
            ENDIF
         Next
         If Apre='S'        //Caso Tenha sido Reserva
            REGRE=RECNO()
            Sele RPes
            Set Filter to Codigo=Reserva->Codigo
            DbGoTop()
            Do While !Eof()
               If Rlock()
                  Dele
                  Unlock
                  DbSkip()
               EndIf
            EndDo
            Sele Reserva
            Reg=Recno()
            AApto=Reserva->Apto
            Set Deleted On
            DbGoTop()
            Locate for Apto=AApto .And. Recno()!=Reg
            If !Found()
               Sele Aptos
               DbGoTop()
               Locate for Apto=Reserva->Apto
               Do While .T.
                  If Rlock()
                     Repl Liberado With 'S'
                     Unlock
                     Exit
                  EndIf
               EndDo
            EndIf
            Sele Reserva
            Go Reg
            Do While .T.
               If Rlock()
                  Dele
                  Unlock
                  Exit
               EndIf
            EndDo
            DBox("Reserva Deletada !!!",,,0,.T.,,)
         EndIf
         JANELA(02)
      EndIF
      SELE Registro
      JANELA(02)    //FECHA PRIMEIRA JANELA DE REGISTRO
      JANELA(02)    //FECHA SEGUNDA  JANELA DE REGISTRO
   ELSE
      DBox('Arquivo sendo utilizado !!!',,,0,.T.,,)
   ENDIF
   SET KEY K_F8 TO        //DESATIVA MENU PICKS
   SELE ConRegis                //INICIALIZA VARIAVEIS DE ARQUIVO CONREGIS
   INIC_VAR()
   SELE Registro
   INIC_VAR()             //INICIALIZA VARIAVEIS DE ARQUIVO REGISTRO
   THOSPE=SPACE(35)
   MDTENT=Datac
   MHENT=HORA(TIME())
   MOPENT=Usuario
   MOBS=SPACE(30)
   TFIRMA=SPACE(35)
   TPCONTA='HOSPEDE'
   TINTERM=SPACE(35)
   MPAX=1
   MAPTO=0
   TINTERM=SPACE(35)
ENDDO
SET KEY K_F8 TO        //DESATIVA MENU PICKS
Set Key K_F7 to PesqHosp
JANELA(2)
CLEAR TYPEAHEAD
SET CURSOR On
Sele Reserva
Set Order to 0
Close All
Cod_Sos=Cod_Sos_Ant
Set Deleted Off
RETURN

// FUNCAO DE FLAG DE APTO OCUPADO

PROCEDURE OCUP_APTO(X,Cont)
AREA=SELECT()
SELE Aptos
//LOCATE FOR APTO=X
Seek Str(x,04,00)
DO WHILE .T.
   IF RLOCK()
      REPL LIBERADO WITH 'N'
      UNLOCK
      EXIT
   ELSE
      DBox('Arquivo sendo utilizado !!!',,,0,.T.,,)
   ENDIF
ENDDO
//TRANS=CONREGIS->CODHOSP
SELE Hospedes
Set Order to 3
GO TOP
//LOCATE FOR CODIGO=MrHosp[Cont]
Seek Str(MrHosp[Cont],04,00)
DO WHILE .T.
   IF RLOCK()
      REPL ATIVO WITH 'S'
      UNLOCK
      EXIT
   ELSE
      DBox('Arquivo sendo utilizado !!!',,,0,.T.,,)
   ENDIF
ENDDO
Set Order to 1
SELE &AREA
RETURN

//FUNCAO REGISTRO DE HOSPEDES

FUNCTION REGHOSP(X)        //VERIFICACAO DO NOME DO HOSPEDE

LOCAL GETLIST:={},ORDEM:=.F.

If Flag
   If !Empty(X)
      Ordem=.T.
   EndIF
   Flag=.F.
Else
   IF !EMPTY(X)
      SELE Hospedes               //SELCIONA AREA CADASTRO DO HOSPEDE
      SET ORDER TO 2
      DbGoTop()
      NHosp=0
      COUNT ALL FOR Upper(NOME)=Upper((TRIM(X))) TO NHOSP
      //LOCATE FOR Upper(NOME)=Upper(TRIM(X))
      If !Empty(NHosp)
      //IF FOUND()                       //ENCONTROU O NOME NA LISTA
         //NHOSP=0               //CONTADOR DE HOMONIMOS
         //DbGoTop()
         //COUNT ALL FOR Upper(NOME)=Upper((TRIM(X))) TO NHOSP
         IF NHOSP>1                    //EXISTE HOMONIMOS
            V=MENUHOMO(X) //MENU PICK HOMONIMOS - HOTRT
            IF V
               THOSPE=NOME
               ORDEM=.T.
               Flag=.T.
            ENDIF
         ELSE                          //NAO EXISTE HOMONIMOS
            VER='S'
            MENUHOMO(X)
            IF VER='S'
               MCODHOSP=CODIGO
               THOSPE=NOME
               ORDEM=.T.
            ELSEIF VER!='S'
               ORDEM=CADHOSP()
            ENDIF
         ENDIF
      ELSE                             //NAO ENCONTROU O NOME NA LISTA
         ORDEM=CADHOSP()                     //FUNCAO CADASTRA HOSPEDE
      ENDIF
   ELSE
      DO MENUHOSP
      IF LASTKEY()!=K_ESC
         SELE Hospedes
         THOSPE=NOME
         IF !EMPTY(THOSPE)
            ORDEM=.T.
         ENDIF
      ENDIF
   ENDIF
EndIF
SELE Registro
RETURN(ORDEM)


//FUNCAO REGISTRO FIRMA/AGENTE

FUNCTION REGFIRMA(X,T)

LOCAL GETLIST:={},ORDEM:=.F.

If Flag
   If !Empty(X)
      Ordem=.T.
   EndIF
Else
   ORDEM=.F.
   IF !EMPTY(X)
      SELE clientes
      SET ORDER TO 3
      Contador = 0
      COUNT ALL FOR Upper(NOME)=Upper((TRIM(X))) TO CONTADOR
     // LOCATE FOR Upper(NOME)=Upper(TRIM(X))
      //IF FOUND()
      If !Empty(Contador)
         IF CONTADOR>1
            IF T='F'
               V=FIRMAHOMO('F')
            ELSE
               V=FIRMAHOMO('I')
            ENDIF
            If V
               Ordem=.T.
            Else
               Ordem=.F.
            EndIF
         ELSE
            Seek Upper(Trim(x))
            IF T='F'
               MFIRMAAGE=CODIGO
               TFIRMA=NOME
            ELSEIF T='I'
               MINTERM=CODIGO
               TINTERM=NOME
            ENDIF
            ORDEM=.T.
            SET ORDER TO 1
         ENDIF
      ELSE
         ORDEM=CADFIR(T)
      ENDI
   ELSE
      IF T='F'
         MENUFIRMA('F')
         IF LASTKEY()!=K_ESC
            SELE clientes
            TFIRMA=NOME
            IF !EMPTY(TFIRMA)
               ORDEM=.T.
            ENDIF
         ENDIF
      ELSEIF T='I'
         ORDEM=.T.
      ENDIF
   ENDIF
EndIF
SELE Registro
Flag=.F.
RETURN(ORDEM)

//VERIFICA SE  POR CONTA DA FIMA OU DO HOSPEDE

FUNCTION VERPCONTA(X)

LOCAL ORDEM

If !Empty(X)
   If X='F'.Or. X='H'
      Ordem=.T.
      If X='F'
         @ 14,56 Say 'IRMA  '
      Else
         @ 14,56 Say 'OSPEDE'
      EndIF
   Else
      DBox('Inv lido !!!',,,0,.T.,,)
      Ordem=.F.
   EndIF
Else
   TPConta=MTab([FIRMA|HOSPEDE],[Por Conta])
   If LastKey()!=27
      Ordem=.T.
      If TPConta='F'
         @ 14,56 Say 'IRMA  '
      Else
         @ 14,56 Say 'OSPEDE'
      EndIF
   Else
      Ordem=.F.
   EndIf
EndIF
RETURN(ORDEM)

//FUNCAO CADASTRA HOSPEDE NO ARQUIVO HOSPEDES.DBF

FUNCTION CADHOSP

LOCAL getlist:={},cabem:=1,rep:=ARRAY(FCOU()),ult_reg:=RECN(),dbfseq_,;
      ctl_r, ctl_c, ctl_w, t_f3_, t_f4_
CAD=.F.

OPCAD='SIM'
OpCad=MTab([SIM|NŽO],[Hospede n„o Cadastrado !!!|Cadastra ?])
IF OPCAD='SIM'                    //DESEJA CADASTRAR O NOVO HOSPEDE
   SELE Hospedes
   Inic_Var()
   tem_borda=.t.
   l_s=09
   c_s=00
   l_i=19
   c_i=76
   SETCOLOR(drvtittel)
   vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
   Janela(01,l_s-1,c_s,l_i-1,c_i+1,' CADASTRO DE HOSPEDES ')
   SETCOLOR(drvcortel)
   @ l_s-01,c_s Say "±±±±±±±±±±±±±±±±±±±±±±±±±±± Cadastro de Hospedes ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
   @ l_s+01,c_s SAY "Ú Identidade ÄÄÄÄÂ Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @ l_s+02,c_s SAY "³                ³                                     ³±±±±±±±±±±±±±±±±±±±±³"
   @ l_s+03,c_s SAY "Ã Profiss„o ÄÄÄÄÄÁÄÄÄÄÄÂ Endere‡o ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÂ N£mero Ä´"
   @ l_s+04,c_s SAY "³                      ³                                          ³         ³"
   @ l_s+05,c_s SAY "Ã Bairro ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅ Cidade ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ UF Â CEP ÄÄÄÄÄÄÂÄÄÁÄÄÄÄÄÄÄÄÄ´"
   @ l_s+06,c_s SAY "³                      ³                      ³    ³           ³±±±±±±±±±±±±³"
   @ l_s+07,c_s SAY "Ã Pa¡s ÄÄÄÄÄÄÄÄÄÄÂ Telefone ÄÄÄÄÄÂ Dt. Cad.Â Dt. Nasc.Â Idade ÂÄ Est. Civ. Ä´"
   @ l_s+08,c_s SAY "³                ³               ³         ³          ³       ³             ³"
   @ l_s+09,c_s SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   MDTCAD=Datac
   MPAIS='BRASIL         '
   MNOME=THOSPE
   If !Empty(TIdentidad)
      MIdentidad=TIdentidad
   EndIf
   MESTCIVIL=2
   @ 17,65 Say 'CASADO    '
   SET CURSOR ON
   @ l_s+02 ,c_s+02 GET  midentidad   VALID (VERID(mIDENTIDAD,'I'))
   @ l_s+02 ,c_s+19 GET  mnome        Valid(!Empty(MNome))
   @ l_s+04 ,c_s+02 GET  mprofissao
   @ l_s+04 ,c_s+25 GET  mender
   @ l_s+04 ,c_s+68 GET  mnumer       Pict "99999"
   @ l_s+06 ,c_s+02 GET  mbairro
   @ l_s+06 ,c_s+25 GET  mcidade
   @ l_s+06 ,c_s+48 GET  muf
   @ l_s+06 ,c_s+53 GET  mcep         PICT "@R 99999-999"
   @ l_s+08 ,c_s+02 GET  mpais
   @ l_s+08 ,c_s+18 GET  mfone        PICT "@R (9999)!!99-9999"
   @ l_s+08 ,c_s+35 GET  mdtcad       Valid !Empty(MDtCad)
   @ l_s+08 ,c_s+45 GET  mdtnasc      Valid(Idade(@MDtNasc))
   @ l_s+08 ,c_s+57 GET  midade       PICT "99" When(!Empty(MDtNasc))
   @ l_s+08 ,c_s+63 GET  mestcivil    PICT "9"   VALID(VEREST(@MESTCIVIL))
   READ
   SET CURSOR OFF
   JANELA(02)
   IF LASTKEY()=K_ESC
      SELE Registro
      Set Cursor On
      RETURN(CAD)
   ENDIF
   SET ORDER TO 0
   IF TRAVAREG()
      IF LASTREC()>1
         SKIP -1
         MCODIGO=CODIGO+1
         SKIP +1
      ELSE
         MCODIGO=1
      ENDI
      THOSPE=MNOME
      MCODHOSP=MCODIGO
      MATIVO='S'
      REPL_VAR()
      UNLOCK
      CAD=.T.
   ELSE
      DBox('Registro n„o Cadastrado !!!',,,0,.T.,,)
   ENDIF
   SET ORDER TO 1
   SELE Registro
ENDIF
Set Cursor on
RETURN(CAD)

//FUNCAO CADASTRA FIRMA NO ARQUIVO clientes.DBF

PROCEDURE CADFIR(TIPO)

Local GetList:={}
CADF=.F.
OPCAD='SIM'
OpCad=MTab([SIM|N„O],[Firma n„o Cadastrada !!!|Cadastrar ?])
IF OPCAD='SIM'                   //DESEJA CADASTRAR O NOVA FIRMA
   l_s=09
   c_s=12
   l_i=18
   c_i=74
   SETCOLOR(drvtittel)
   vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
   Janela(01,l_s-1,c_s,l_i,c_i+1,' CADASTRO DE FIRMAS/AGENTES ')
   SETCOLOR(drvcortel)
   @ l_s-01,c_s   Say "±±±±±±±±±±±±±±±±±± Cadastro de Firmas/Agentes ±±±±±±±±±±±±±±±±±±"
   @ l_s+01,c_s+1 SAY "Ú CGC ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Nome ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   @ l_s+02,c_s+1 SAY "³                    ³                                       ³"
   @ l_s+03,c_s+1 SAY "Ã Ins. Estadual ÄÂ Endere‡o ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ l_s+04,c_s+1 SAY "³                ³                                           ³"
   @ l_s+05,c_s+1 SAY "Ã N£mero Â Bairro ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Cidade ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ UF Ä´"
   @ l_s+06,c_s+1 SAY "³        ³                      ³                      ³     ³"
   @ l_s+07,c_s+1 SAY "Ã CEP ÄÄÄÁÄÄÂ Telefone ÄÄÄÄÄÄÂ Desc Val. Â Desc Porc Â Turis ´"
   @ l_s+08,c_s+1 SAY "³           ³                ³           ³       %   ³       ³"
   @ l_s+09,c_s+1 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÙ"
   Sele clientes
   INIC_VAR()
   IF TIPO='F'
      MNOME=TFIRMA
      MTURIS='N'
      @ 17,69 Say 'ŽO'
   ELSEIF TIPO='I'
      MNOME=TINTERM
      MTURIS='S'
      @ 17,69 Say 'IM'
   ENDIF
   SET CURSOR ON
   Set Key K_F8 to Picks
   @ l_s+02 ,c_s+03 GET  mcgc       PICT "@R 99.999.999/9999-99" VALID (VERCGC(MCGC))
   @ l_s+02 ,c_s+24 GET  mnome      VALID (!EMPTY(MNOME))
   @ l_s+04 ,c_s+03 GET  mie        PICT "@R 999.999.999-999"
   @ l_s+04 ,c_s+20 GET  mender
   @ l_s+06 ,c_s+03 GET  mnumer     PICT "99999"
   @ l_s+06 ,c_s+12 GET  mbairro
   @ l_s+06 ,c_s+35 GET  mcidade
   @ l_s+06 ,c_s+58 GET  muf        Pict "@!"
   @ l_s+08 ,c_s+03 GET  mcep       PICT "@R 99.999-999"
   @ l_s+08 ,c_s+15 GET  mfone      PICT "@R (9999)!!99-9999"
   @ l_s+08 ,c_s+32 GET  mdescvalor Pict "@E 99,999.99"
   @ l_s+08 ,c_s+46 GET  mdescporc  Pict "999" When(Empty(mdescvalor))
   @ l_s+08 ,c_s+56 GET  mturis     Pict "@!" VALID (VERTURIS(@MTURIS))
   READ
   SET CURSOR OFF
   JANELA(02)
   IF LASTKEY()=K_ESC
      Set Cursor On
      RETURN(CADF)
   ENDI
   SET ORDER TO 0
   IF TRAVAREG()
      IF LASTREC()>1
         SKIP -1
         MCODIGO=CODIGO+1
         SKIP +1
      ELSE
         MCODIGO=1
      ENDI
      REPL_VAR()
      UNLOCK
   ELSE
      DBox('Firma n„o Cadastrado !!!',,,0,.T.,,)
   ENDIF
   IF TIPO='F'
      MFIRMAAGE=CODIGO
      TFIRMA=MNOME
   ELSEIF TIPO='I'
      MINTERM=CODIGO
      TINTERM=NOME
   ENDIF
   CadF=.T.
   SET ORDER TO 1
   Sele Registro
ENDIF
Set Cursor on
RETURN(CADF)

//Fun‡„o Atribui N£mero M ximo de Pax no Apartamento

Procedure NumPax

Local Area,TCat[5]

If !Empty(MApto)
   Area=Select()
   Sele Aptos
   DbGoTop()
   Locate for Apto=MApto
   TTipoApto=Tipo
   Sele Categ          //Area das Categorias
   DbGoTop()
   Locate for Codigo=Aptos->Categ1
   TCat[1]=Pax
   DbGoTop()
   Locate for Codigo=Aptos->Categ2
   TCat[2]=Pax
   DbGoTop()
   Locate for Codigo=Aptos->Categ3
   If Found()
      TCat[3]=Pax
   Else
      TCat[3]=0
   EndIf
   DbGoTop()
   Locate for Codigo=Aptos->Categ4
   If Found()
      TCat[4]=Pax
   Else
      TCat[4]=0
   EndIf
   DbGoTop()
   Locate for Codigo=Aptos->Categ5
   If Found()
      TCat[5]=Pax
   Else
      TCat[5]=0
   EndIF
   TMaxPax=TCat[1]
   For I=02 to 05
      If TCat[I]>TMaxPax
         TMaxPax=TCat[I]
      EndIf
   Next
   Sele &Area
EndIf
Return

//Funcao Verifica Tamanho M ximo poss¡vel de Pax

Function VerPax(P)

Local Ordem:=.F.

If !Empty(P)
   If P>TMaxPax
      DBox("N£mero de Pax ultrapassando limite|para este Apartamento.",,,0,.T.,,)
      MPax=TMaxPax
   Else
      Ordem=.T.
   EndIf
Else
   DBox("Necess rio informar n£mero de Pax.",,,0,.T.,,)
   Ordem=.F.
EndIF
Return(Ordem)

//FUNCAO TRAVA REGISTROS

FUNCTION TRAVAREG
RET=.F.
DO WHILE .T.
   APPE BLAN
   IF !NETERR()
      RET=.T.
      EXIT
   ELSE
      DBox("Tentando Abrir novo Registro !!!",,,0,.T.,,)
   ENDIF
ENDDO
RETURN RET

// FUNCAO DE VERIFICACAO DO  TIPO DE ESTADO CIVIL

FUNCTION VEREST(Civ)

LOCAL ORDEM:=.F.

If Flag
   OpEC=0
   OpEC=MTab([1-SOLTEIRO|2-CASADO|3-SEPARADO|4-AMASIADO|5-DIVORCIADO],[Estado Civil])
   If LastKey()=27
      Ordem=.F.
      MEstCivil=0
   Else
      Ordem=.T.
      MestCivil=Val(OpEC)
      Do Case
         Case MestCivil=1
            @ 17,65 Say 'SOLTEIRO  '
         Case MestCivil=2
            @ 17,65 Say 'CASADO    '
         Case MestCivil=3
            @ 17,65 Say 'SEPARADO  '
         Case MestCivil=4
            @ 17,65 Say 'AMASIADO  '
         Case MestCivil=5
            @ 17,65 Say 'DIVORCIADO'
      EndCase
   EndIf
Else
   If !Empty(Civ)
      If Civ>0 .And. Civ<6
         Ordem=.T.
         Do Case
            Case MestCivil=1
               @ 17,65 Say 'SOLTEIRO  '
            Case MestCivil=2
               @ 17,65 Say 'CASADO    '
            Case MestCivil=3
               @ 17,65 Say 'SEPARADO  '
            Case MestCivil=4
               @ 17,65 Say 'AMASIADO  '
            Case MestCivil=5
               @ 17,65 Say 'DIVORCIADO'
         EndCase
      Else
         Ordem=.F.
         DBox("Estado Civil Inv lido !!!",,,0,.T.,,)
      EndIF
   Else
      OpEC=0
      OpEC=MTab([1-SOLTEIRO|2-CASADO|3-SEPARADO|4-AMASIADO|5-DIVORCIADO],[Estado Civil])
      If LastKey()=27
         Ordem=.F.
         MEstCivil=0
      Else
         Ordem=.T.
         MestCivil=Val(OpEC)
         Do Case
            Case MestCivil=1
               @ 17,65 Say 'SOLTEIRO  '
            Case MestCivil=2
               @ 17,65 Say 'CASADO    '
            Case MestCivil=3
               @ 17,65 Say 'SEPARADO  '
            Case MestCivil=4
               @ 17,65 Say 'AMASIADO  '
            Case MestCivil=5
               @ 17,65 Say 'DIVORCIADO'
         EndCase
      EndIF
   EndIF
EndIF
Set Cursor On
RETURN(ORDEM)

//Fun‡„o atribui valor para a idade

Function Idade(XX)
Local XXX

If !empty(XX)
   XXX=Calida(XX)
   MIdade=XXX
EndIf
RETU(.T.)       // <- deve retornar um valor L¢GICO
