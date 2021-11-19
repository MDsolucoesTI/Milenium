 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT23.PRG
 \ Modulo..: Fechamento de Conta do Hospede
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 01-02-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Efetuar o Fechamento da Conta do Hospede
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

LOCAL GETLIST:={},ORDEM
PUBLIC MTAXA:=0,Cod:=0,NumRd:=0,Vc:=.T.

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
If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Reserva")=0
   DbfParam=DrvDbf+"Reserva"
   UseArq(DbfParam)
EndIf
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
EndIf
If Select("Pagam")=0
   DbfParam=DrvDbf+"Pagam"
   UseArq(DbfParam)
EndIf
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf
If Select("Desconto")=0
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam)
EndIf
If Select("Cartoes")=0
   DbfParam=DrvDbf+"Cartoes"
   UseArq(DbfParam)
EndIf
If Select("Cheques")=0
   DbfParam=DrvDbf+"Cheques"
   UseArq(DbfParam)
EndIf

Set Deleted On
Cod_Sos_Ant=Cod_Sos
Cod_Sos=68
SET KEY K_F8 TO PICKS      //F8 TELA PICKS - HOTELRT.PRG
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,05,00,19,79," Fechamento de Conta ")
SETCOLOR(drvcortel)
@ 05,00 Say "±±±±±±±±±±±±±±±±±±±±±±±±±±±± Fechamento de Conta ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
@ 07,00 SAY "Ú Apto Â Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ H. Entrada Â Dt. Entrada ÄÄÄÄÄÄ¿"
@ 08,00 SAY "³      ³                                      ³            ³                   ³"
@ 09,00 SAY "Ã PAX Â CHD Â Ultima Procedencia ÄÄÂ Proximo Destino ÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 10,00 SAY "³     ³     ³                      ³                                           ³"
@ 11,00 SAY "Ã Firma ou Agente ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÂ Intermediario ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 12,00 SAY "³                                     ³                                        ³"
@ 13,00 SAY "Ã Observacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 14,00 SAY "³                                                                              ³"
@ 15,00 SAY "Ã H. Sa¡da Â Dt. Sa¡da ÄÂ Vl Normal ÄÄÄÄÄÄÄÂ Ser. Normal ÄÄÂ Vl Desc. ÄÂ Porc. ´"
@ 16,00 SAY "³          ³            ³                  ³               ³           ³     % ³"
@ 17,00 SAY "Ã Vl Extra ÄÄÄÄÄÄÄÄÂ Ser. Extra ÄÄÄÂ Vl Desc . Â Porc. Â Valor Total ÄÄÁÄÄÄÄÄÄÄ´"
@ 18,00 SAY "³                  ³               ³           ³     % ³                       ³"
@ 19,00 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
DO WHILE .T.
   Vc=.T.           //Caso Tecle ESC, na Forma de Pagamento
   Set Key K_F8 to Picks
   MPAX:=MCHD:=0
   MULTPROC:=MPROXDEST:=SPACE(20)
   TFIRMAAGE:=TINTERM:=SPACE(20)
   MHSAI:="0000"
   MDTSAI:=CTOD("  /  /  ")
   Sele Conregis
   Inic_Var()
   Sele Registro
   INIC_VAR()
   //@ 10,02 SAY MPAX       PICT "999"
   //@ 10,08 SAY MCHD       PICT "99"
   //@ 10,14 SAY MULTPROC
   //@ 10,37 SAY MPROXDEST
   //@ 12,02 SAY TFIRMAAGE
   //@ 12,40 SAY TINTERM
   //@ 14,02 SAY MOBS
   //@ 16,03 SAY MHSAI      PICT "@R 99:99"
   //@ 16,13 SAY MDTSAI     PICT "@D"
   TFIRMAAGE=SPACE(35)
   THOSPEDE=SPACE(35)
   TAPTO=0
   SET CURSOR ON
   @ 08,02 GET TAPTO    PICT "9999"      VALID(VERIFICA(@TAPTO))
   READ
   SET CURSOR OFF
   IF LASTKEY()=27
      EXIT
   ENDI
   Sele Registro
   IGUAL_VAR()       //na area de Registro
   Sele Conregis           //Area ConRegis
   Igual_Var()
   If MInterm>0
      Sele clientes
      Locate for Codigo=Registro->Interm
      If Found()
         TInterm=Nome
      EndIF
   EndIF
   SELE clientes
   LOCATE FOR CODIGO=Registro->FIRMAAGE
   TFIRMAAGE=NOME
   SELE Registro
   MDTSAI=DATAC
   MHSAI=HORA(TIME())
   SET CURSOR ON
   @ 08,09 SAY THOSPEDE
   @ 08,49 SAY MHENT      PICT "@R 99:99"
   @ 08,62 SAY MDTENT
   @ 10,02 SAY MPAX       PICT "999"
   @ 10,08 SAY MCHD       PICT "99"
   @ 10,14 SAY MULTPROC
   @ 10,37 SAY MPROXDEST
   @ 12,02 SAY TFIRMAAGE
   @ 12,40 SAY TINTERM
   @ 14,02 SAY MOBS
   @ 16,03 GET MHSAI      PICT "@R 99:99"   VALID (!EMPTY(MHSAI))
   @ 16,13 GET MDTSAI     PICT "@D"         VALID (!EMPTY(MDTSAI))
   READ
   If LastKey()=27
      Exit
   EndIf
   SET CURSOR OFF
   SELE Registro
   MVLNORMAL=CALCVL(1)                //CALCULA VALOR NORMAL
   MSERNOR=MVLNORMAL*(Paramet->TxSer/100)  //CALCULA Taxa Servico DO NORMAL
   TNORTOT=MVLNORMAL+MSERNOR          //CALCULA VALOR TOTAL NORMAL
   MVLEXTRA=CALCVL(2)                 //CALCULA VALOR EXTRA
   MSEREXT=MVLEXTRA*(Paramet->TxSer/100) //CALCULA Taxa Servico DO EXTRA
   TEXTTOT=MVLEXTRA+MSEREXT           //CALCULA VALOR TOTAL EXTRA
   MOPSAI=Usuario
   MFinalNor=0
   MProcNor=0
   MFinalExt=0
   MPorcExt=0
   @ 16,25 SAY MVLNORMAL  PICT "@E 9,999,999,999.99"
   @ 16,44 SAY MSERNOR    PICT "@E 99,999,999.99"
   @ 18,02 SAY MVLEXTRA   PICT "@E 9,999,999,999.99"
   @ 18,21 SAY MSEREXT    PICT  "@E 99,999,999.99"
   XTotal=MVLNORMAL+MSERNOR+MVLEXTRA+MSEREXT
   @ 18,57 Say XTotal Pict "@E 999,999,999,999.99"
   Set Cursor On
   @ 16,60 Get Mfinalnor  Pict "@E 99,999.99"     When(MVlNormal>0)
   @ 16,72 Get Mporcnor   Pict "999"              When(MVlNormal>0 .And. Empty(MFinalNor))
   If MVlExtra>0
      @ 18,37 Get MfinalExt  Pict "@E 99,999.99"  When(MVlExtra>0)
      @ 18,49 Get MporcExt   PIct "999"           When(MVlExtra>0 .And. Empty(MFinalExt))
   EndIF
   Read
   IF LASTKEY()=27
      EXIT
   ENDI
//Calculo do Desconto dado no Fechamento da Conta - Desconto Geral
   If !Empty(MFinalNor) .Or. !Empty(MPorcNor)
      If !Empty(MPorcNor)
         tDesc = (tNorTot*(MPorcNor/100))
         xNorTot = tNorTot - tDesc
         TNorTot=XNorTot
      Else
         XNorTot = tNorTot - MFinalNor
         TNorTot=XNorTot
         tDesc = MFinalNor
      EndIF
   EndIF
   If !Empty(MFinalExt) .Or. !Empty(MPorcExt)
      If !Empty(MPorcExt)
         tDesc = (textTot*(MPorcExt/100))
         xextTot = textTot - tDesc
         TextTot=XExtTot
      Else
         xextTot = textTot - MFinalExt
         TExtTot=XExtTot
         tDesc = MFinalExt
      EndIF
   EndIF
   XTotal=TNorTot+TExtTot
   @ 18,57 Say XTotal Pict "@E 999,999,999,999.99"
   SET CURSOR OFF
   Opcao=Space(01)
   XXX=Space(01)
   @ 14,74 Get XXX  When Balao(4)
   Read
   DO CASE
      CASE OPCAO='S'
         XX=Space(01)
         Fecha=Space(01)
         @ 14,74 Get XX  When Balao(6)
         read
         Flag1=.T.   //para ver se fecha somente extra/normal/tudo
         Do Case
            Case Fecha='T'        //Faz Fechamento Normal e Extra
               If TNortot>0
                  FORMAPAG(1,TNORTOT)
               EndIf
               If VC
                  IF TEXTTOT>0
                     FORMAPAG(2,TEXTTOT)
                  ENDIF
               EndIf
            Case Fecha='E'        //Faz Fechamento somente Extra
               FORMAPAG(2,TEXTTOT)
               If VC             //Caso Tenha Teclado ESC, na Forma Pagamento
                  TFinalNor=MFinalNor
                  TPorcNor=MProcNor
                  TFinalExt=MFinalExt
                  TPorcExt=MPorcExt
                  Fechamento('E',TExtTot,ConRegis->CodHosp)
               EndIf
               Flag1=.F.
            Case Fecha='N'       //Faz Fechamento somente Normal
               FORMAPAG(1,TNORTOT)
               If VC             //Caso Tenha Teclado ESC, na Forma Pagamento
                  TFinalNor=MFinalNor
                  TPorcNor=MProcNor
                  TFinalExt=MFinalExt
                  TPorcExt=MPorcExt
                  Fechamento('N',TNorTot,ConRegis->CodHosp)
               EndIf
               Flag1=.F.
         EndCase
         SET ORDER TO 0
         If VC                  //Caso Tenha Teclado ESC, Forma Pagamento
            Do GeraRd
            If Flag1            //se fechou extra e normal do hospede
               If Registro->MovimN='C' .And. Registro->MovimE='C'
                  Sele ConRegis
                  Do While .T.
                     DbGoTop()
                     Locate For Codigo=Registro->Codigo .And. Ativo=[S]
                     If !Found()
                        Exit
                     EndIf
                     SELE Hospedes           //mais de um Apartamento
                     DbGoTop()
                     Locate for Codigo=ConRegis->CodHosp
                     Ver=Vermais(Codigo)
                     If Ver
                        DO WHILE .T.
                           IF RLOCK()
                              REPL ATIVO WITH 'N'
                              UNLOCK
                              EXIT
                           ENDI
                        ENDD
                     EndIf
                     Sele Conregis
                     Do While .T.
                        If Rlock()
                           Repl ativo    With 'N'
                           Repl VlNormal With MVlNormal
                           Repl VlExtra  With MVlExtra
                           Repl SerNor   With MSerNor
                           Repl SerExt   With MSerExt
                           Repl finalnor With MFinalNor
                           Repl porcnor  With MPorcNor
                           Repl finalext With MFinalExt
                           Repl porcext  With MporcExt
                           Repl dtsai    With MDtSai
                           Repl hsai     With MHSai
                           Repl rd       With mRD
                           Unlock
                           Exit
                        EndIF
                     EndDo
                  EndDo
                  Sele Registro
                  Do While .T.
                     If Rlock()
                        Repl Ativo With 'N'
                        Repl hsai     With mHSai
                        Repl dtsai    With mDtSai
                        Repl opsai    With Usuario
                        Unlock
                        Exit
                     EndIF
                  EndDo
                  SELE Aptos
                  DBGOTOP()
                  LOCATE FOR APTO=REGISTRO->APTO
                  TAtivo='N'
                  SELE reserva
                  DBGOTOP()
                  LOCATE FOR APTO=APTOS->APTO
                  IF FOUND()
                     LIB='R'
                  ELSE
                     LIB='S'
                  ENDIF
                  SELE Aptos
                  DO WHILE .T.
                     IF RLOCK()
                        REPL LIBERADO WITH LIB
                        UNLOCK
                        EXIT
                     ENDI
                  ENDD
               Else
                  SELE Conregis //VERIFICACAO SE EXISTE MAIS DE UM HOSPEDE...
                  REGIST=RECNO()  //...NO MESMO QUARTO
                  DBGOTOP()
                  Contad=0
                  COUNT ALL FOR ((Codigo=Registro->Codigo) .AND. (ATIVO='S')) TO CONTAD
                  GO REGIST
                  If Contad=0
                     Contad=1
                  EndIf
                  IF CONTAD=1
                     SELE Aptos
                     DBGOTOP()
                     LOCATE FOR APTO=REGISTRO->APTO
                     SL=02         //N£mero da Area
                     TAtivo='N'
                     SELE reserva
                     DBGOTOP()
                     LOCATE FOR APTO=APTOS->APTO
                     IF FOUND()
                        LIB='R'
                     ELSE
                        LIB='S'
                     ENDIF
                     SELE Aptos
                     DO WHILE .T.
                        IF RLOCK()
                           REPL LIBERADO WITH LIB
                           UNLOCK
                           EXIT
                        ENDI
                     ENDD
                     Sele Registro
                     Do While .T.
                        If Rlock()
                           Repl Ativo With 'N'
                           Repl hsai     With mHSai
                           Repl dtsai    With mDtSai
                           Repl opsai    With Usuario
                           Unlock
                           Exit
                        EndIf
                     EndDo
                  EndIf
                  Sele ConRegis
                  Do While .T.
                     If Rlock()
                        Repl hsai     With mHSai
                        Repl dtsai    With mDtSai
                        Repl Ativo    With 'N'
                        Repl VlNormal With MVlNormal
                        Repl VlExtra  With MVlExtra
                        Repl finalnor With Mfinalnor
                        Repl porcnor  With MPorcNor
                        Repl SerNor   With MSerNor
                        Repl SerExt   With MSerExt
                        Repl finalext With MFinalExt
                        Repl porcext  With MPorcExt
                        Repl Rd       With MRd
                        Unlock
                        Exit
                     EndIf
                  EndDo
                  SELE Hospedes         //verifica se o hospede  se hospedou...
                  DbGoTop()       //...em mais de um Apartamento
                  Locate for Codigo=ConRegis->CodHosp
                  Ver=Vermais(Codigo)
                  If Ver
                     DO WHILE .T.
                        IF RLOCK()
                           REPL ATIVO WITH 'N'
                           UNLOCK
                           EXIT
                        ENDI
                     ENDD
                  EndIf
                  Sele Registro
                  Do While .T.
                     If Rlock()
                        If (Pax>1 .And. (movimn='I' .or. movime='I'))
                           XXXXX=Pax-1
                           Repl Pax   With XXXXX
                        EndIF
                        Unlock
                        Exit
                     EndIF
                  EndDo
               EndIF
            EndIF
         EndIf
         Sele Registro
         SET ORDER TO 1
      CASE OPCAO='N'
         MVLNORMAL=0
         MSERNOR=0
         MVLEXTRA=0
         MSEREXT=0
         Mfinalnor=0
         Mporcnor=0
         MfinalExt=0
         MporcExt=0
         THOSPEDE=SPACE(35)
         XTotal=0
         Mfinalnor=0
         Mporcnor=0
         MfinalExt=0
         MporcExt=0
         @ 08,09 SAY THOSPEDE
         @ 16,25 SAY MVLNORMAL  PICT "@E 9,999,999,999.99"
         @ 16,44 SAY MSERNOR    PICT "@E 99,999,999.99"
         @ 18,02 SAY MVLEXTRA   PICT "@E 9,999,999,999.99"
         @ 18,21 SAY MSEREXT    PICT  "@E 99,999,999.99"
         @ 16,60 Say Mfinalnor  Pict "@E 99,999.99"
         @ 16,72 Say Mporcnor   Pict "999"
         @ 16,60 Say MfinalExt  Pict "@E 99,999.99"
         @ 16,72 Say MporcExt   PIct "999"
         @ 18,57 Say XTotal Pict "@E 999,999,999,999.99"
         @ 16,60 Say Mfinalnor  Pict "@E 99,999.99"
         @ 16,72 Say Mporcnor   Pict "999"
         @ 18,37 Say MfinalExt  Pict "@E 99,999.99"
         @ 18,49 Say MporcExt   PIct "999"
         LOOP
   ENDCASE
   Set Key K_F8 to
   Sele ConRegis
   Set Filter to
   If VC
      DBox('Fechamento conclu¡do !!!',,,0,.T.,,)
      Apto=MApto
      Acodigo=Registro->Codigo
      CodiHosp=MCodHosp
      M->CodiHosp=MCodHosp
      Tel=SaveScreen(00,00,MaxRow(),79)
      Vd=.F.
      If !Empty(MVlNormal)
         Opcao='S'
         XXX=Space(01)
         @ 14,74 Get XXX  When Balao(15)
         Read
         If Opcao='S'
            Vd=.F.
            Tp=1
            Mil_R011(3,40)
            Vd=.T.
         EndIf
         RestScreen(00,00,MaxRow(),79,Tel)
      EndIF
      Sele Movim
      Set Filter to
      IF !Empty(mVlExtra)
         Opcao='S'
         XXX=Space(01)
         @ 14,74 Get XXX  When Balao(16)
         Read
         If Opcao='S'
            Vd=.F.
            Tp=2
            Mil_R011(3,40)
            Vd=.T.
         EndIf
      ENDIF
      RestScreen(00,00,MaxRow(),79,Tel)
   EndIF
   Vd=.T.
   INIC_VAR()
   THOSPEDE=SPACE(35)
   TFIRMAAGE=SPACE(37)
   MPROXDEST=SPACE(20)
   MOBS=SPACE(30)
   MVLNORMAL=0
   MSERNOR=0
   MVLEXTRA=0
   MSEREXT=0
   MDTENT=CTOD("  /  /  ")
   MHENT=SPACE(04)
   Mfinalnor=0
   Mporcnor=0
   MfinalExt=0
   MporcExt=0
   XTotal=0
   SETCOLOR(drvcortel)
   @ 08,09 SAY THOSPEDE
   @ 08,49 SAY MHENT      PICT "@R 99:99"
   @ 08,62 SAY MDTENT
   @ 10,02 SAY MPAX       PICT "999"
   @ 10,08 SAY MCHD       PICT "99"
   @ 10,14 SAY MULTPROC
   @ 10,37 SAY MPROXDEST
   @ 12,02 SAY TFIRMAAGE
   @ 12,40 SAY TINTERM
   @ 14,02 SAY MOBS
   @ 16,03 SAY MHSAI      PICT "@R 99:99"
   @ 16,13 SAY MDTSAI     PICT "@D"
   @ 16,25 SAY MVLNORMAL  PICT "@E 9,999,999,999.99"
   @ 16,44 SAY MSERNOR    PICT "@E 99,999,999.99"
   @ 18,02 SAY MVLEXTRA   PICT "@E 9,999,999,999.99"
   @ 18,21 SAY MSEREXT    PICT  "@E 99,999,999.99"
   @ 16,60 Say Mfinalnor  Pict "@E 99,999.99"
   @ 16,72 Say Mporcnor   Pict "999"
   @ 16,60 Say MfinalExt  Pict "@E 99,999.99"
   @ 16,72 Say MporcExt   PIct "999"
   @ 18,57 Say XTotal Pict "@E 999,999,999,999.99"
   Sele COnRegis
   Set Filter to
ENDDO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
JANELA(2)
Close All
Cod_Sos=Cod_Sos_Ant
Set Cursor On
RETURN

FUNCTION FAZDES(X)
DO WHILE .T.
   IF RLOCK()
      REPLACE VALOR WITH VALOR-X
      UNLOCK
      EXIT
   ELSE
      DBox('Arquivo sendo utilizado !!!',,,0,.T.,,)
   ENDIF
ENDDO
RETURN (NIL)


//FUNCAO CALCULO DO VALOR NORMAL E EXTRA

FUNCTION CALCVL(X)
VL=0
SELE Movim
SET FILTER TO TIPOMOV=X .AND. CODIGO=REGISTRO->CODIGO .And. CodHosp=ConRegis->CodHosp
DBGOTOP()
DO WHILE !EOF()
   VL=VL+Movim->VALOR
   DbSKIP()
ENDDO
SET FILTER TO
SELE Registro
RETURN(VL)


//FUNCAO FORMA DE PAGAMENTO

PROCEDURE FORMAPAG(TP,SALDO)

LOCAL GETLIST:={},ORDEM,AREA

If Tp=1
   Tipo="NORMAL "
Else
   Tipo='EXTRA '
EndIF
InfoSis("Inclui","[F8] Tabela")
JANELA(01,03,08,23,76,[S]," Forma de Pagamento - "+Tipo)
SETCOLOR(drvcortel)
FOR I=09 TO 74
   @ 21,I SAY "Ä"
NEXT I
@ 22,30 SAY "Valor Total  = "
IF Tp=1
   @ 22,43 SAY TNORTOT    PICT "@R 9,999,999,999.99"
ELSE
   @ 22,43 SAY TEXTTOT PICT "@R 9,999,999,999.99"
ENDI
SETCOLOR(drvcortel)
@ 05,12 SAY "Forma Pg"
@ 05,25 SAY "Tp Cartao"
@ 05,46 SAY "Valor"
@ 05,62 SAY "Saldo"
FOR I=09 TO 74
   @ 06,I SAY "Ä"
NEXT I
FOR I=05 TO 20
   @ I,21 SAY "³"
NEXT I
FOR I=05 TO 20
   @ I,41 SAY "³"
NEXT I
FOR I=05 TO 20
   @ I,59 SAY "³"
NEXT I
@ 05,12 SAY ""
@ 06,21 SAY "Å"
@ 06,41 SAY "Å"
@ 06,59 SAY "Å"
L=07
SELE Pagam
DO WHILE SALDO>0
   INIC_VAR()
   MFORMAPAG=0
   MTIPOCART=0
   MData=DataC
   MValor=Saldo
   SET CURSOR ON
   @ L,09 GET MFORMAPAG PICT "9"            VALID(VERFORMA(@MFORMAPAG))
   @ L,22 GET MTIPOCART PICT "99"           WHEN (MFORMAPAG=2)  VALID (VERCARTAO(@MTIPOCART))
   @ L,46 GET MVALOR    PICT "@E 99,999.99" VALID (!EMPTY(MVALOR))
   READ
   SET CURSOR OFF
   If LastKey()=27
      Sele Pagam
      Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp .And. TipoMov=Tp
      DbGoTop()
      Do While !Eof()
         Do While .T.
            If RLock()
               Dele
               UnLock
               Exit
            EndIf
         EndDo
         DbSkip()
      EndDo
      DbSetFilter()
      Sele Cheques
      Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp .And. TipoMov=Tp
      DbGoTop()
      Do While !Eof()
         Do While .T.
            If RLock()
               Dele
               UnLock
               Exit
            EndIf
         EndDo
         DbSkip()
      EndDo
      DbSetFilter()
      DBox('Fechamento n„o Conclu¡do !!!',,,0,.T.,,)
      Janela(02)
      VC=.F.
      Return
   EndIF
//   IF MFORMAPAG=5    //cobran‡a
//      COB()
//   ENDIF
   IF MFORMAPAG=3   //cheque n„o pr‚
      CHEQUE(Tp,'N')
   ENDIF
   If MFormaPag=4   //Cheque Pr‚ Datado
      Cheque(Tp,'S')
   EndIf
   If MFormaPag=2  //cart„o
      JANELA(01,11,13,15,67," Inclusao de Cart”es de Cr‚ditos ")
      @ 12,14 SAY " N§ Cart„o ÄÄÄÄÄÄÄÄÄÄÂ Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ"
      @ 13,14 SAY "                     ³              ³                "
      @ 14,14 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      MNUMERO=SPACE(20)
      MBANCO=0
      MAGENCIA=0
      MOperador=Usuario
      SET CURSOR ON
      @ 13,15 GET MNUMERO                      Valid(!Empty(Mnumero))
      @ 13,37 GET MBANCO      PICT "9999"
      @ 13,52 GET MAGENCIA    PICT "99999"
      READ
      SET CURSOR OFF
      Janela(02)
   EndIf
  //IF MTAXA!=0
  //    @ L,46 SAY MVALOR+(MVALOR*MTAXA/100)
  // ENDIF
  // IF LASTKEY()=27
  //    EXIT
  // ENDIF
   MCODIGO=REGISTRO->CODIGO
   MCodHosp=ConRegis->CodHosp
   MTIPOMOV=Tp
   SALDO=SALDO-MVALOR
   @ L,61 SAY SALDO  Pict "@E 999,999.99"
   Sele Pagam
   If (MFormaPag!=3)
      IF TRAVAREG()
         MDataMov=DataC
         MOperador=Usuario
         REPL_VAR()
         UNLOCK
      ENDIF
   EndIf
   IF L=21
      SCROLL(08,12,21,68,1)
      @ 21,21 SAY "³"
      @ 21,41 SAY "³"
      @ 21,59 SAY "³"
   ELSE
      L=L+1
   ENDIF
ENDDO
JANELA(2)
SELE Registro
MCODIGO=CODIGO
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
RETURN

//FUNCAO VERIFICA SE MAIS DE UM APARTAMENTO O HOSPEDE SE HOSPEDOU

FUNCTION VERMAIS(X)

LOCAL ORDEM,Area

Area=Select()
SELE ConRegis
AUX=RECNO()
SET FILTER TO ATIVO='S'
DBGOTOP()
COUNT ALL FOR CODHOSP=X TO CONTADOR
IF CONTADOR>1
   ORDEM=.F.
ELSE
   ORDEM=.T.
ENDIF
GO AUX
Sele &Area
RETURN (ORDEM)

//Fun‡„o faz fechamento somente do extra ou normal

Procedure Fechamento(X,T,C)

Local Area:=Select(),Regis:=Recno()

Sele Registro
Reg=Recno()
XCodigo=Codigo
DbGoBottom()
TCodigo=Codigo+1
Go Reg
Igual_Var()
Sele Conregis
TVlN=MVLNORMAL
TVlSN=MSERNOR
TVlE=MVLEXTRA
TVlSE=MSerExt
Set Filter to Codigo=MCodigo .And. Ativo='S'
DbGoTop()
Do While !Eof()
   Regi=Recno()    //Porque o TravaReg posiciona o ponteiro no final
   IGual_Var()
   If X='N'
      MVlNormal=0
      MSerNor=0
   Else
      MVlExtra=0
      MSerExt=0
   EndIf
   If TravaReg()
      Repl_Var()
      Do While .T.
         If Rlock()
            Repl Codigo With TCodigo
            Unlock
            Exit
         EndIF
      EndDo
      Unlock
   EndIf
   Go Regi
   If CodHosp=C     //Caso seja o Hospede que est  fechando a conta
      If X='N'
         Do While .T.
            If Rlock()
               Repl VlNormal With TVlN
               Repl SerNor   With TVlSN
               Unlock
               Exit
            EndIF
         EndDo
         MVlNormal=0
         MSerNor=0
         Sele Movim    //Fecha o Normal e o Extra recebe novo Codigo
         Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=Conregis->CodHosp .And. TipoMov=2
         DbGoTop()
         Do While !Eof()
            Do While .T.
               If Rlock()
                  Repl Codigo With TCodigo
                  Unlock
                  Exit
               EndIf
            EndDo
            DbSkip()
         EndDo
         Sele ConRegis
      Else
         Do While .T.
            If Rlock()
               Repl VlExtra With TVlE
               Repl SerExt  With TVlSE
               Unlock
               Exit
            EndIF
         EndDo
         MVlExtra=0
         MSerExt=0
         Sele Movim   //Fecha o Extra e o Normal recebe novo Codigo
         Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=Conregis->CodHosp .And. TipoMov=1
         DbGoTop()
         Do While !Eof()
            Do While .T.
               If Rlock()
                  Repl Codigo With TCodigo
                  Unlock
                  Exit
               EndIf
            EndDo
            DbSkip()
         EndDo
         Sele ConRegis
      EndIf
   Else          //Caso n„o, como ‚ individual, transfere todo o movimento
                    //das outras pessoas para o novo c¢digo do Registro
      Sele Movim
      Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp
      DbGoTop()
      Do While !Eof()
         Do While .T.
            If Rlock()
               Repl Codigo With TCodigo
               Unlock
               Exit
            EndIF
         EndDo
         Go Regi
         DbSkip()
      EndDo
      Sele Desconto
      Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp
      DbGoTop()
      Do While !Eof()
         Do While .T.
            If Rlock()
               Repl Codigo With TCodigo
               Unlock
               Exit
            EndIF
         EndDo
         DbSkip()
      EndDo
      Sele ConRegis
   EndIf
   Do While .T.
      If Rlock()
         Repl Ativo With 'N'
         Unlock
         Exit
      EndIF
   EndDo
   DbSkip()
EndDo
Set Filter to
Sele Registro
If TravaReg()
   MCodigo=TCodigo
   MAtivo='S'
   Repl_Var()
   Unlock
EndIf
Sele ConRegis
DbGoTop()
Locate for CodHosp=C .And. Codigo=XCodigo
Sele Registro
DbGoTop()
Locate for Codigo=ConRegis->Codigo
Do While .T.
   If RLock()
      If ConRegis->CodHosp=C
         Repl dtsai With DataC
         Repl hsai  With Hora(Time())
      EndIF
      Repl ativo With 'N'
      Repl opsai With Usuario
      Unlock
      Exit
   EndIf
EndDo
Sele ConRegis
Set Filter to Codigo=Registro->Codigo
Do While !Eof()
   Do While .T.
      If Rlock()
         Repl ativo    With 'N'
         If ConRegis->CodHosp=C
            Repl hsai     With Hora(Time())
            Repl dtsai    With DataC
            Repl finalnor With tFinalNor
            Repl porcnor  With tPorcNor
            Repl finalext With tFinalExt
            Repl PorcExt  With tPorcExt
         EndIf
         Unlock
         If ConRegis->CodHosp=C
            Do GeraRd
         EndIf
         Exit
      EndIf
   EndDo
   DbSkip()
EndDo
DbSetFilter()
Sele &Area
If Regis#0
   Go Regis
EndIf
Return

//Fun‡„o gera n£mero da fatura ou RD

Procedure GeraRD

IF Conregis->RD=0         //ATUALIZA NUMERO DE RD - REGISTRO
   SELE Paramet
   DBGOTOP()
   MRD=NUMRD+1
   m->NumRD=mRD
   IF LASTREC()<1
      IF TRAVAREG()
         REPL NUMRD WITH MRD
         UNLOCK
      ENDIF
   ELSE
      DO WHILE .T.
         IF RLOCK()
            REPL NUMRD WITH MRD
            UNLOCK
            EXIT
         ENDIF
      ENDDO
   ENDIF
ENDIF
Return
