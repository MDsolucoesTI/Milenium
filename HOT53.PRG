/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT53.PRG
 \ Modulo..: Fechamento de Conta do Hospede - Reabertura
 \ VersÆo..: 1.1
 \ Data....: 17-08-94
 \ RevisÆo.: 01-02-95
 \ Sistema.: MILENIUM - Automa‡Æo Hoteleira
 \ Funcao..: Fechamento uma conta reaberta do hospede 
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
If Select("registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("reserva")=0
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

Cod_Sos_Ant=Cod_Sos
MOperador=Usuario
Cod_Sos=68
SET KEY K_F8 TO PICKS      //F8 TELA PICKS - HOTELRT.PRG
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,05,00,19,79," Fechamento de Conta ")
SETCOLOR(drvcortel)
@ 05,00 Say "±±±±±±±±±±±±±±±±±±±±±±±±± Fechamento de Conta ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
@ 07,00 SAY "Ú Apto Â Nome do Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ H. Entrada Â Dt. Entrada ÄÄÄÄÄ¿"
@ 08,00 SAY "³      ³                                      ³            ³                  ³"
@ 09,00 SAY "Ã PAX Â CHD Â Ultima Procedencia ÄÄÂ Proximo Destino ÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 10,00 SAY "³     ³     ³                      ³                                          ³"
@ 11,00 SAY "Ã Firma ou Agente ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÂ Intermediario ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 12,00 SAY "³                                     ³                                       ³"
@ 13,00 SAY "Ã Observacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 14,00 SAY "³                                                                             ³"
@ 15,00 SAY "Ã H. Sa¡da Â Dt. Sa¡da ÄÂ Vl Normal ÄÄÄÄÄÄÄÂ Ser. Normal ÄÄÂ Vl Desc. ÄÂ Porc.³"
@ 16,00 SAY "³          ³            ³                  ³               ³           ³     %³"
@ 17,00 SAY "Ã Vl Extra ÄÄÄÄÄÄÄÄÂ Ser. Extra ÄÄÄÂ Vl Desc . Â Porc. Â Valor Total ÄÄÁÄÄÄÄÄÄ´"
@ 18,00 SAY "³                  ³               ³           ³     % ³                      ³"
@ 19,00 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
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
   @ 10,02 SAY MPAX       PICT "999"
   @ 10,08 SAY MCHD       PICT "99"
   @ 10,14 SAY MULTPROC
   @ 10,37 SAY MPROXDEST
   @ 12,02 SAY TFIRMAAGE
   @ 12,40 SAY TINTERM
   @ 14,02 SAY MOBS
   @ 16,03 SAY MHSAI      PICT "@R 99:99"
   @ 16,13 SAY MDTSAI     PICT "@D"
   TFIRMAAGE=SPACE(35)
   THOSPEDE=SPACE(35)
   TAPTO=0
   SET CURSOR ON
   @ 08,02 GET TAPTO    PICT "9999"      VALID(VERIFICA1(@TAPTO))
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
   MVLNORMAL=CALCVL1(1)                //CALCULA VALOR NORMAL
   MSERNOR=MVLNORMAL*(Paramet->TxSer/100)  //CALCULA Taxa Servico DO NORMAL
   TNORTOT=MVLNORMAL+MSERNOR          //CALCULA VALOR TOTAL NORMAL
   MVLEXTRA=CALCVL1(2)                 //CALCULA VALOR EXTRA
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
   @ 16,72 Get Mporcnor   Pict "999"               When(MVlNormal>0 .And. Empty(MFinalNor))
   If MVlExtra>0
      @ 18,37 Get MfinalExt  Pict "@E 99,999.99"  When(MVlExtra>0)
      @ 18,49 Get MporcExt   PIct "999"            When(MVlExtra>0 .And. Empty(MFinalExt))
   EndIF
   Read
   IF LASTKEY()=27
      EXIT
   ENDI
//Calculo do Desconto dado no Fechamento da Conta - Desconto Geral
   If !Empty(MFinalNor) .Or. !Empty(MPorcNor)
      If !Empty(MPorcNor)
         tDesc = (tNorTot*(MPorcNor/100))
         XNorTot = tNorTot - tDesc
         tNorTot=XNorTot
      Else
         xNorTot = tNorTot - MFinalNor
         tNorTot=XNorTot
         tDesc = MFinalNor
      EndIF
   EndIF
   If !Empty(MFinalExt) .Or. !Empty(MPorcExt)
      If !Empty(MPorcExt)
         tDesc = (textTot*(MPorcExt/100))
         xextTot = textTot - tDesc
         tExtTot=XExtTot
      Else
         xextTot = textTot - MFinalExt
         tExtTot=XExtTot
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
         If TNorTot>0
            FORMAPAG1(1,TNORTOT)
         EndIf
         If VC
            IF TEXTTOT>0
               FORMAPAG1(2,TEXTTOT)
            ENDIF
         EndIF
         SET ORDER TO 0
         If VC                  //Caso Tenha Teclado ESC, Forma Pagamento
            Sele ConRegis
            Do While .T.
               If Rlock()
                  Repl VlNormal With MVlNormal
                  Repl VlExtra  With MVlExtra
                  Repl SerNor   With MSerNor
                  Repl SerExt   With MSerExt
                  Repl Ativo    With "N"
                  Repl finalnor With MFinalNor
                  Repl porcnor  With MPorcNor
                  Repl finalext With MFinalExt
                  Repl porcext  With MPorcExt
                  Unlock
                  Exit
               EndIF
            EndDo
            SELE Hospedes           //mais de um Apartamento
            Locate for Codigo=ConRegis->CodHosp
            If Ativo='R'
               DO WHILE .T.
                  IF RLOCK()
                     REPL ATIVO WITH 'N'
                     UNLOCK
                     EXIT
                  ENDI
               ENDD
            EndIF
            Sele Registro
            If Ativo='R'
               Sele ConRegis
               Reg=Recno()
               DbGoTop()
               Locate for Codigo=Registro->Codigo .And. Ativo='R'
               If !Found()
                  Sele Registro
                  Do While .T.
                     If Rlock()
                        Repl Ativo With 'N'
                        Unlock
                        Exit
                     EndIF
                  EndDo
               EndIf
               Sele ConRegis
               If Reg!=0
                  Go Reg
               EndIf
            EndIf
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
         @ 18,57 Say XTotal Pict "@E 999,999,999,999.99"
         LOOP
   ENDCASE
   If VC
      DBox('Fechamento conclu¡do !!!',,,0,.T.,,)
      Tel=SaveScreen(00,00,MaxRow(),79)
      Vd=.F.
      If !Empty(MVlNormal)
         Opcao='S'
         XXX=Space(01)
         @ 14,74 Get XXX  When Balao(15)
         Read
         If Opcao='S'
            Apto=MApto
            CodiHosp=MCodHosp
            Tp=1
            Mil_R011(3,40)
         EndIf
      EndIF
      RestScreen(00,00,MaxRow(),79,Tel)
      IF !Empty(mVlExtra)
         Opcao='S'
         XXX=Space(01)
         @ 14,74 Get XXX  When Balao(16)
         Read
         If Opcao='S'
            Apto=MApto
            CodiHosp=MCodHosp
            Tp=2
            Mil_R011(3,40)
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
ENDDO
SET KEY K_F8 TO         //DESATIVA F8 TELA PICKS - HOTELRT.PRG
JANELA(2)
Close All
Cod_Sos=Cod_Sos_Ant
Set Cursor On
RETURN

//FUNCAO CALCULO DO VALOR NORMAL E EXTRA

FUNCTION CALCVL1(X)
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

PROCEDURE FORMAPAG1(TP,SALDO)

LOCAL GETLIST:={},ORDEM,AREA

If Tp=1
   Tipo="NORMAL "
Else
   Tipo='EXTRA '
EndIF
SETCOLOR(drvcorbox)
InfoSis("Inclui","[F8] Tabela")
JANELA(01,03,08,23,76," Forma de Pagamento - "+Tipo)
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
   MTAXA=0
   MData=DataC
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
   IF MFORMAPAG=5
//      COB()
   ENDIF
   IF MFORMAPAG=3
      Ret=CHEQUE(Tp,'N')
      If !Ret
         KeyBoard Chr(27)
         Loop
      EndIf
   ENDIF
   If MFormaPag=4
      Ret=CHEQUE(Tp,'S')
      If !Ret
         KeyBoard Chr(27)
         Loop
      EndIf
   EndIf
   If MFormaPag=2  //cart„o
      SELE Pagam
      JANELA(01,11,13,15,67," Inclusao de Cart”es de Cr‚ditos ")
      @ 12,14 SAY " N§ Cart„o ÄÄÄÄÄÄÄÄÄÄÂ Banco ÄÄÄÄÄÄÄÂ Agencia ÄÄÄÄÄÄÄ"
      @ 13,14 SAY "                     ³              ³                "
      @ 14,14 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
      MNUMERO=SPACE(20)
      MBANCO=0
      MAGENCIA=0
      MDATAEMIS=DataC
      MOperador=Usuario
      SET CURSOR ON
      @ 13,15 GET MNUMERO                      Valid(!Empty(Mnumero))
      @ 13,37 GET MBANCO      PICT "9999"
      @ 13,52 GET MAGENCIA    PICT "99999"
      READ
      SET CURSOR OFF
      Janela(02)
      IF LASTKEY()=K_ESC
         TFORMAPAG=SPACE(08)
         MNUMERO=SPACE(20)
         MBANCO=0
         MAGENCIA=0
         Exit
      ENDI
   EndIf
   IF MTAXA!=0
      @ L,46 SAY MVALOR+(MVALOR*MTAXA/100)
   ENDIF
   IF LASTKEY()=27
      EXIT
   ENDIF
   MCODIGO=REGISTRO->CODIGO
   MCodHosp=ConRegis->CodHosp
   MTIPOMOV=Tp
   SALDO=SALDO-MVALOR
   @ L,61 SAY SALDO  Pict "@E 999,999.99"
   IF MFORMAPAG!=3
      IF TRAVAREG()
         MVALOR+=(MVALOR*MTAXA/100)
         MDataMov=DataC
         MOperador=Usuario
         REPL_VAR()
         UNLOCK
      ENDIF
   ENDIF
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
