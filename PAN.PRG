/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: PAN.PRG
 \ Data....: 23-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rotina avulsa (Gerar B.M.D.)
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Programado manualmente pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

Local Fim,Reg,MM

IF nivelop < 2          // se usuario nao tem
   ALERTA()               // permissao, avisa
   DBOX(msg_auto,,,3)     // e retorna
   RETU
ENDI

If Select("Registro")=0
   Use Registro Index Registr1, Registr2, Registr3 shared New
EndIf
If Select("ConRegis")=0
   Use Conregis Index Conregi1 Shared New
EndIf
If Select("Aptos")=0
   Use Aptos    Index Aptos1 Shared New
EndIf
If Select("Hospedes")=0
   Use Hospedes Index Hospede1, Hospede2, Hospede3 Shared New
EndIf
If Select("Desconto")=0
   Use Desconto Index Descont1, Descont2 Shared New
EndIf
If Select("Movim")=0
   Use Movim    Index Movim1, Movim2 Shared New
EndIf
If Select("Paramet")=0
   Use Paramet Shared New
EndIf
If Select("BMD")=0
   Use BMD      Index BMD1 Shared New
EndIf
If Select("Acumulo")=0
   Use Acumulo  Index Acumulo1, Acumulo2 Shared New
EndIf
If Select("Pagam")=0
   Use Pagam    Index Pagam1, Pagam2, Pagam3 Shared New
EndIf

Achou=.F.
Sele Paramet
DbGoTop()
MData=DataC
MDatai=Paramet->Bmd
MDataF=DataC
MHorai=Paramet->HBmd
MHoraF=Hora(Time())
Janela(01,07,17,13,61," Gera‡„o de B.M.D. ")
SETCOLOR(drvcortel)
@ 08,27 Say "Data do B.M.D. :"
@ 10,26 Say "De : "
@ 12,25 Say "At‚ : "
SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
@ 08,42 Get MData   Pict "@D"         Valid(VerData(MData,.T.))
@ 10,31 Get MDatai  Pict "@D"         Valid(!Empty(MDatai))
@ 10,47 Get MHorai  Pict "@R 99:99"   Valid(!Empty(MHorai))
@ 12,31 Get MDataf  Pict "@D"         Valid(!Empty(MDataf))
@ 12,47 Get MHoraf  Pict "@R 99:99"   Valid(!Empty(MHoraf))
Read
If LastKey()=27
   Janela(02)
   Return
EndIf
ind_t=SAVESCREEN(0,0,MAXROW(),79)              // salva tela e da msg
DBOX(" Aguarde !!!",,,,NAO_APAGA)
TData=DataC
MDia=0
MMes=0
mtotaldia=0
MTotalMes=0
Sele Conregis
Set Filter to (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai .And. MHoraF>=HSai)
DbGoTop()
Do While !Eof()
   Sele Movim
   Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConRegis->CodHosp
   DbGoTop()
   mtotaldia=0
   Tp=0
   Do While !Eof()
      MDespesa=TipoDesp
      If Tp!=MDespesa         //isto para fazer a subtra‡„o uma £nica vez
         MDia=0
         MMes=0
         Tp=MDespesa
         If Achou    //Caso a data do B.M.D. j  exista no Banco de Dados
            Sele Acumulo
            DbGoTop()
            Locate for data=BMD->Data .And. Despesa=Movim->TipoDesp
            MMes=Mes-Dia          //Isto porque o valor total pode mudar
            MTotalDia=TotalDia-Dia
            MTotalMes=TotalMes-Dia
         Else
            Fim=VerMes(MData)
            If Fim='N'
               Sele Acumulo
               Reg=Recno()
               DbGoTop()
               MM=CtoD(CalcData(DtoC(MData),-1))
               Locate for Data=MM .And. Despesa=Movim->TipoDesp
               If Found()
                  MMes=Mes
                  MTotalMes=TotalMes
               Else
//                  DBox("ATEN€ŽO !!!||Est  sendo processado o B.M.D. na seguinte data, "+DtoC(MData)+".|Mas n„o foi encontrado o B.M.D. da data "+DtoC(MM)+",|por isto ser  zerado o ac£mulo Mensal.",,,0,.T.,,)
                  MMes=0
               EndIF
               If Reg!=0
                  Go Reg
               EndIf
            Else           //‚ final de mˆs
               Mes=0
               MTotalDia=0
               MTotalMes=0
            EndIf
         EndIf
      EndIf
      Sele Movim
      MDia=MDia+Valor
      MMes=MMes+Valor
      MTotalDia=MTotalDia+Valor
      MTotalMes=MTotalMes+Valor
      DbSkip()
      If Tp!=TipoDesp    //se o pr¢ximo ‚ outra despesa, atualiza ACUMULO.DBF
         Sele Acumulo
         Do While .T.
            If Achou
               If Rlock()
                  Exit
               EndIf
            Else
               If TravaReg()
                  Exit
               EndIf
            EndIF
         EndDo
         Repl_Var()                             //Atualiza o Banco Acumulo
         Unlock
      EndIf
      Sele Movim
   EndDo
   Sele ConRegis
   DbSkip()
EndDo
Sele Acumulo
Set Filter to Data=MData
DbGoTop()
Do While !Eof()
   MPorDia=(Dia*100)/mtotaldia
   MPorMes=(Mes*100)/mtotalmes
   Do While .T.
      If Rlock()
         Exit
      EndIf
   EndDo
   Repl PorMes  With MPorMes
   Repl PorDia  With MPorDia
   Repl TotalDia With MTotalDia
   Repl TotalMes With MTotalMes
   Unlock
   DbSkip()
EndDo
Set Filter to
Sele BMD
XData= Mdata
XDataF=MDataF
XDataI=MDataI
XHoraF=MHoraF
XHoraI=MHoraI
Igual_Var()
mData=Xdata
mDataF=XDataF
mDataI=XDataI
mHoraF=XHoraF
mHoraI=XHoraI
Sele ConRegis
DbGoTop()
Do While !Eof()
   For Form=1 to 6
      Sele Pagam
      Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConRegis->CodHosp .And. FormaPag=Form
      DbGoTop()
      MTotalB=0
      MTotalBm=0
      MValor=0
      MTaxam=0
      MTaxa=0
      Do While !Eof()
         MValor=MValor+Valor
         Sele Pagam
         DbSkip()
      EndDo
      Do Case
         Case Form=1
            MDinheiro=MValor
         Case Form=2
            MCheque=MValor
         Case Form=3
            MChequePre=MValor
         Case Form=4
            MCartao=MValor
         Case Form=5
            MRDA=MValor
         Case Form=6
            MCobranca=MValor
      EndCase
      If Achou    //Caso a data do B.M.D. j  exista no Banco de Dados
         Sele BMD
         Do Case
            Case Form=1
               MTotalB=TotalB-Dinheiro
               MTotalBm=TotalBm-Dinheiro
               MDinheirom=Dinheirom-MValor
            Case Form=2
               MTotalB=TotalB-Cheque
               MTotalBm=TotalBm-Cheque
               MChequem=Chequem-MValor
            Case Form=3
               MTotalB=TotalB-Chequepre
               MTotalBm=TotalBm-Chequepre
               MCheuqepm=Chequepm-MValor
            Case Form=4
               MTotalB=TotalB-Cartao
               MTotalBm=TotalBm-Cartao
               MCartaom=cartaom-MValor
            Case Form=5
               MTotalB=TotalB-rda
               MTotalBm=TotalBm-RDA
               MRDAm=RDAm-MValor
            Case Form=6
               MTotalB=TotalB-cobranca
               MTotalBm=TotalBm-cobranca
               MCobranca=Cobranca-MValor
         EndCase
      Else
         Fim=VerMes(MData)
         If Fim='N'
            Sele Acumulo
            Reg=Recno()
            DbGoTop()
            MM=CtoD(CalcData(DtoC(MData),-1))
            Locate for Data=MM .And. Despesa=Movim->TipoDesp
            If Found()
               MTotalb=TotalB
               MTotalBm=TotalBm
               MTaxam=Taxam
            Else
               MTotalb=0
               MTotalBm=0
               MTaxam=0
            EndIF
            If Reg!=0
               Go Reg
            EndIf
         Else
            MTotalb=0
            MTotalBm=0
            MTaxam=0
         EndIf
      EndIF
      MTotalb=MTotalB+MValor
      MTotalBm=MTotalBm+MValor
      Do Case
         Case Form=1
            MDinheirom=mDinheirom+MValor
         Case Form=2
            MChequem=mChequem+MValor
         Case Form=3
            MCheuqepm=mChequepm+MValor
         Case Form=4
            MCartaom=mcartaom+MValor
         Case Form=5
            MRDAm=mRDAm+MValor
         Case Form=6
            MCobranca=mCobranca+MValor
      EndCase
      MPorcDin=(MDinheiro*100)/mtotalB
      MPorcDinm=(MDinheirom*100)/mtotalBm
      MPorcche=(Mcheque*100)/mtotalB
      MPorcchem=(Mchequem*100)/mtotalBm
      MPorcchepre=(Mchequepre*100)/mtotalB
      MPorcchequepm=(Mchequepm*100)/mtotalBm
      MPorcrda=(Mrda*100)/mtotalB
      MPorcrdam=(Mrdam*100)/mtotalBm
      MPorccob=(Mcobranca*100)/mtotalB
      MPorccobm=(Mcobrancam*100)/mtotalBm
      MTaxa=(MTotalB*Paramet->TxSer)/100      //Calcula Taxa de Servi‡o
      MPorTaxa=(MTaxa*100)/MTotalB
      MPorTaxam=(MTaxa*100)/MTotalBm
      MTaxam=MTaxam+MTaxa
   Next
   Sele ConRegis
   DbSkip()
EndDo
Sele ConRegis
Set Filter to
MAptoEnt=0
MAptoSai=0
MApto=0
MHospEnt=0
MHospSai=0
MHosptotal=0
MQtd=0
MHosp=0
Sele Registro
COUNT ALL FOR (MDataI<=DtEnt .And. MDataF>=DtEnt .And. MHoraI<=HEnt .And. MHoraF>=HEnt .And. Ativo='S') TO MAptoEnt
COUNT ALL FOR (Ativo='S') TO MApto
Sele ConRegis
COUNT ALL FOR (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai .And. MHoraF>=HSai .And. Ativo='N') TO MAptoSai
MAptoTotal=MApto-MAptoSai
MPax=0
Sele ConRegis
COUNT ALL FOR (Ativo='S') TO MHosp
COUNT ALL FOR (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai .And. MHoraF>=HSai .And. Ativo='N') TO MHospSai
Sele Registro
Set Filter to (MDataI<=DtEnt .And. MDataF>=DtEnt .And. MHoraI<=HEnt .And. MHoraF>=HEnt .And. Ativo='S')
DbGoTop()
Do While !Eof()
   MPax=Pax+MPax
   DbSkip()
EndDo
Set Filter to
MHospTotal=MHosp-MHospSai
//Repl AptoEnt   With MAptoEnt
//Repl AptoSai   With MAptoSai
//Repl AptoTotal With MAptoTotal
//Repl HospEnt   With HospEnt
//Repl HospSai   With MHospSai
//Repl HospTotal With MHospTotal
MDiaria=0
MVlDia=0
MRec=0
MVlRec=0
Sele Conregis
Set Filter to (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai .And. MHoraF>=HSai)
Do While !Eof()
   Sele Movim
   Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConREgis->CodHosp .And. TipoDesp=1
   Do While !Eof()
      MDiaria++
      MVlDia=MVlDia+Valor
      DbSkip()
   EndDo
   Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConREgis->CodHosp
   Do While !Eof()
      MRec++
      MVlRec=MVlRec+Valor
      DbSkip()
   EndDo
   Sele ConRegis
   DbSkip()
EndDo
MDiaMedia=MVlDia/MDiaria
MRecMedia=MVlRec/MRec
Fim=VerMes(MData)
If Fim='N'
   Sele BMD
   Reg=Recno()
   DbGoTop()
   MM=CtoD(CalcData(DtoC(MData),-1))
   Locate for Data=MM
   If Found()
      MDiaMediam=DiaMediam+MDiaMedia
      MRecMediam=RecMediam+MRecMediam
   Else
      MDiaMediam=MDiaMedia
      MRecMediam=MRecMedia
   EndIF
   If Reg!=0
      Go Reg
   EndIf
Else
   MDiaMediam=MDiaMedia
   MRecMediam=MRecMedia
EndIf
MSaldoD=MDia
MM=CalcData(DtoC(MData),-1)
Sele Acumulo
Reg=Recno()
Set FIlter to Data=CtoD(MM)
DbGoBottom()
MSaldoA=Dia
Set Filter to
If Reg!=0
   Go Reg
EndIf
MProdDia=MTotalBm
Sele BMD
Do While .T.
   If Achou
      If Rlock()
         Exit
      EndIf
   Else
      If TravaReg()
         Exit
      EndIf
   EndIF
EndDo
//Repl DiaMedia  With MDiaMedia
//Repl RecMedia  With MRecMedia
//Repl DiaMediam With MDiaMediam
//Repl RecMediam With MRecMediam
//Repl SaldoD    With MSaldoD
//Repl SaldoA    With MSaldoA
//Repl ProdDia   With MprodDia
Xdata=Mdata
Repl_Var()
MData=XData
RESTSCREEN(0,0,MAXROW(),79,ind_t)
If !Achou
   XX=Space(01)
   H='S'
   SETCOLOR(drvcorenf)
   @ 08,18 Get XX  When Balao(10)   //Atualizar Parametros
   Read
   If H='S'
      Sele Paramet
      DbGoTop()
      Do While .T.
         If Rlock()
            Repl BMD  With MDataF
            Repl HBMD With MHoraF
            Unlock
            Exit
         EndIf
      EndDo
   EndIF
EndIf
RETU

//Fun‡„o atribui valor para os pr¢ximos get's

Function VerData(XX,TT)

Local Ordem:=.F.,Area:=.F.

If Select("BMD")=0
   Use BMD Index BMD1 Shared New
   Area=.T.
EndIF
If Empty(XX)
   DBox("Data Inv lida !!!",,,0,.T.,,)
   Ordem=.F.
Else
   If XX>DataC
      DBox("Esta data n„o pode ser maior|que a data do sistema, "+DtoC(DataC)+".",,,0,.T.,,)
      Ordem=.F.
   Else
      Sele Bmd
      Set Order to 1
      DbGoTop()
      DbSeek(XX)
      Ordem=.T.
      If Found()
         m->tDatai=Datai
         m->tdataf=Dataf
         m->tHorai=Horai
         m->tHoraf=Horaf
         If TT
            MDatai=Datai
            Mdataf=Dataf
            MHorai=Horai
            MHoraf=Horaf
            @ 10,31 Say MDatai
            @ 10,47 Say MHorai  Pict "@R 99:99"
            @ 12,31 Say MDataf
            @ 12,47 Say MHoraf  Pict "@R 99:99"
         EndIF
         Achou=.T.
      EndIf
   EndIf
EndIf
If Area
   Close
EndIF
Return(Ordem)

//Fun‡„o verifica se ‚ fim de mˆs e se ‚ fim de ano
//Retorna :
//N - Caso n„o seja final de mˆs e ano
//M - Caso seja final de mˆs
//A - Caso seja final de Ano

Function VerMes(Dt)

Local Ordem:=Space(01),MDt,MDia,H,MD,MDi

MD=Substr(DtoC(Dt),04,02)
MDt=Val(MD)
MDi=Substr(DtoC(Dt),01,02)
MDia=Val(MDi)
If MDia=30 .Or. MDia=31 .Or. MDia=28 .or. MDia=29
   Do Case
      Case ((Mdt=1 .or. Mdt=3 .or. Mdt=5 .or. Mdt=7 .or.  Mdt=8 .or. Mdt=10) .and. (MDia=31))
         Ordem='M'                     //Final de Mˆs
      Case MDt=12 .And. MDia=31
         Ordem='A'                     //Final de Ano
      Case MDt=2 .And. MDia=29
         Ordem='M'                     //Final de Mˆs
      Case MDt=2 .and. MDia=28
         H=CalcData(DtoC(Dt),1)
         MDt=Substr(DtoC(H),01,02)
         If (H="29")
            Ordem='N'                  //N„o ‚ final de mˆs
         Else
            Ordem='M'                  //Final de mˆs
         EndIF
      Case ((Mdt=4 .or. Mdt=6 .or. Mdt=9 .or. Mdt=11) .and. (MDia=30))
         Ordem='M'                     //Final de Mˆs
      Otherwise
         Ordem='N'
   EndCase
Else
   Ordem='N'
EndIF
Return(Ordem)
