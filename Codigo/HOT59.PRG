 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT59.PRG
 \ Data....: 04-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rotina avulsa (Gerar B.M.D.)  
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

Local Fim,Reg,MM,Ant:=Cod_Sos

IF nivelop < 3          // se usuario nao tem
   ALERTA()               // permissao, avisa
   DBOX(msg_auto,,,3)     // e retorna
   RETU
ENDI

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("ConRegis")=0
   DbfParam=DrvDbf+"ConRegis"
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
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
EndIf
If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
EndIf
If Select("BMD")=0
   DbfParam=DrvDbf+"BMD"
   UseArq(DbfParam)
EndIf
If Select("Acumulo")=0
   DbfParam=DrvDbf+"Acumulo"
   UseArq(DbfParam)
EndIf
If Select("Pagam")=0
   DbfParam=DrvDbf+"Pagam"
   UseArq(DbfParam)
EndIf
If Select("Departa")=0
   DbfParam=DrvDbf+"Departa"
   UseArq(DbfParam)
EndIf

Achou=.F.
Cod_Sos=82
Sele Paramet
DbGoTop()
MData=DataC
MDatai=Paramet->Bmd
MDataF=DataC
MHorai=Paramet->HBmd
MHoraF=Hora(Time())
MSaldoD=0
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
Sele Acumulo
XData=MData
Inic_Var()
MData=XData
Sele ConRegis
Set Order to 1
Sele Acumulo
Set Order to 1     //Data+Despesa
Sele ConRegis
Set Order to 1     //Codigo+CodHosp
Sele Movim
Set Order to 2     //Codigo+CodHosp
Sele Departa
Set Order to 1     //Codigo da Despesa
Fim=VerMes(MData)
Set deleted On
Sele BMD
Set Order to 1
MSladod=0
Reg=Recno()
XData=CtoD(CalcData(DtoC(MData),-1))
DbGoTop()
Locate for Data=XData
If !Found()
   DBox("N„o foi encontrado o B.M.D. do Dia "+DtoC(XData)+",|por isto ser  zerado o ac£mulo Mensal.",,,0,.T.,,)
EndIf
If Reg!=0
   Go Reg
EndIf
Sele Departa
DbGoTop()
Do While !Eof()
   Sele Acumulo
   Mdespsa=0
   MDia=0
   MPordia=0
   MMes=0
   Sele Movim
   Set Filter to TipoDesp=Departa->Codigo
   DbGoTop()
   Do While !Eof()
      Do Case
         Case ((MDataI<=datmov .And. MHoraI<=Horamov) .And. (MdataF>datmov))
            MDia=MDia+Valor
            MTotaldia=MTotaldia+Valor
            MTotalMes=MTotalMes+Valor
            MMes=MMes+Valor
            MSaldod=MSaldod+Valor
         Case MDataF=datmov
            If MHoraf>=Horamov
               MDia=MDia+Valor
               MTotaldia=MTotaldia+Valor
               MTotalMes=MTotalMes+Valor
               MMes=MMes+Valor
               MSaldod=MSaldod+Valor
            EndIf
      EndCase
      DbSkip()
   EndDo
   Set Filter to
   If Achou         //Caso j  tenha sido gerado o BMD desta Data
      Sele Acumulo
      XData=CtoD(CalcData(DtoC(MData),-1))
      DbGoTop()
      Locate for Data=XData .And. Despesa=Departa->Codigo
      If Found()
//         MMes=Mes-MMes
//         MTotalDia=MTotalDia-TotalDia
//         MTotalMes=MTotalMes-TotalMes
      MMes=MMes+Mes
      MTotalMes=TotalMes
      EndIf
      DbGoTop()
      Locate for Data=MData .And. Despesa=Movim->TipoMov
   Else
      Sele Acumulo
      If Fim='N'          //N„o ‚ final de Mˆs
         Reg=Recno()
         XData=CtoD(CalcData(DtoC(MData),-1))
         DbGoTop()
         Locate for Data=XData .And. Despesa=Departa->Codigo
         If Found()
            MMes=Mes+MMes
            MTotalMes=TotalMes+MTotalMes
            MTotalDia=TotalDia+MTotalDia
         EndIf
         If Reg!=0
            Go Reg
         EndIf
      EndIf
   EndIf
   Sele Acumulo
   Do While .T.
      If Achou
         DbGoTop()
         Locate for Despesa=Departa->Codigo .And. Data=MData
         If Rlock()
            Exit
         EndIf
      Else
         If TravaReg()
            Exit
         EndIf
      EndIF
   EndDo
   Mdespesa=Departa->Codigo
   Repl Data     With Mdata
   Repl Despesa  With Mdespesa
   Repl Dia      With MDia
   Repl Mes      With MMes
   Repl TotalMes With MTotalMes
   Unlock
   Sele Departa
   DbSkip()
EndDo
Sele Acumulo
Set Filter to Data=MData
DbGoTop()
Do While !Eof()
   MMes=MMes-Dia
//   MTotalMes=MTotalMes-Dia
   MPorMes=(Mes*100)/MTotalMes
   MporDia=(Dia*100)/MTotalDia
   Do While .T.
      If Rlock()
         Repl Totaldia With MTotalDia
         Repl TotalMes With MTotalMes
         Repl PorMes   With MPorMes
         Repl PorDia   With MPorDia
         Unlock
         Exit
      EndIf
   EndDo
   DbSkip()
EndDo
//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Sele BMD
XData= Mdata
XDataF=MDataF
XDataI=MDataI
XHoraF=MHoraF
XHoraI=MHoraI
Inic_Var()
mData=Xdata
mDataF=XDataF
mDataI=XDataI
mHoraF=XHoraF
mHoraI=XHoraI
MSaldod=MTotalDia
Reg=Recno()
XData=CtoD(CalcData(DtoC(MData),-1))
DbGoTop()
Locate for Data=XData
If Found()
   MTotalBm=TotalBm
   MDinheirom=Dinheirom
   MChequem=Chequem
   MChequepm=Chequepm
   Mcartaom=Cartaom
   MRdam=Rdam
   MCobrancam=Cobrancam
   MPermutam=Permutam
   MTaxam=Taxam
   MSaldoa=Saldod
   MRecMediam=RecMediam
   MDiaMediam=DiaMediam
   MHospTotal=HospTotal
   MAptoTotal=AptoTotal
   MAptoTotalAnt=AptoTotal
   MHospTotalAnt=HospTotal
EndIf
If Reg!=0
   Go Reg
EndIf
Veri=.T. //Para verificar a hora de sa¡da
Sele ConRegis
Set Filter to (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai)
DbGoTop()
Do While !Eof()
   If Conregis->DtSai=MdataF
      If Conregis->hsai<=MHoraF
         Veri=.T.
      Else
         Veri=.F.
      EndIf
   Else
      Veri=.T.
   EndIf
   If Veri
      For Form=1 to 7
         Sele Pagam
         Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConRegis->CodHosp .And. FormaPag=Form
         DbGoTop()
         MValor=0
         Do While !Eof()
            MValor=MValor+Valor
            Sele Pagam
            DbSkip()
         EndDo
         Do Case
            Case Form=1
               MDinheiro=MValor+MDinheiro
               MDinheirom=MValor+MDinheirom
            Case Form=2
               MCheque=MValor+MCheque
               MChequem=MValor+MChequem
            Case Form=3
               MChequePre=MValor+MChequePre
               MChequePm=MValor+MChequePm
            Case Form=4
               MCartao=MValor+MCartao
               MCartaom=MValor+MCartaom
            Case Form=5
               MRDA=MValor+MRda
               MRDAm=MValor+MRdam
            Case Form=6
               MCobranca=MValor+MCobranca
               MCobrancam=MValor+MCobrancam
            Case Form=7
               MPermuta=MValor+MPermuta
               MPermutam=MValor+MPermutam
         EndCase
      Next
      MTaxas=MTaxas+ConRegis->sernor+ConRegis->serext
   EndIf
   Sele ConRegis
   DbSkip()
EndDo
If Achou    //Caso a data do B.M.D. j  exista no Banco de Dados
   MTotalB=0
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
MTotalB=MDinheiro+MCheque+MChequePre+MCartao+MRda+MCobranca+MPermuta+MTotalB
MTotalBm=MDinheiro+MCheque+MChequePre+MCartao+MRda+MCobranca+MPermuta+MTotalBm
//MTaxas=(MTotalB*Paramet->TxSer)/100      //Calcula Taxa de Servi‡o
XTotalB=MTotalB
XTotalBm=MTotalBm
MTotalB=MTotalB+MTaxas
MTotalBm=MTotalBm+MTaxas
MPorDin=(MDinheiro*100)/mtotalB
MPorDinm=(MDinheirom*100)/mtotalBm
MPorche=(Mcheque*100)/mtotalB
MPorchem=(Mchequem*100)/mtotalBm
MPorchepre=(Mchequepre*100)/mtotalB
MPorchequepm=(Mchequepm*100)/mtotalBm
MPorrda=(Mrda*100)/mtotalB
MPorrdam=(Mrdam*100)/mtotalBm
MPorcob=(Mcobranca*100)/mtotalB
MPorcobm=(Mcobrancam*100)/mtotalBm
MPorPer=(MPermuta*100)/MTotalB
MPorPerm=(MPermutam*100)/MTotalBm
MPorTaxa=(MTaxas*100)/MTotalB
MPorTaxam=(MTaxas*100)/MTotalBm
MProdDia=MTotalB
MTaxam=MTaxam+MTaxas
MTotalB=XTotalB
MTotalBm=XTotalBm

Sele ConRegis
Set Filter to
MAptoEnt=0
MAptoSai=0
MApto=0
MHospEnt=0
MHospSai=0
MQtd=0
MHosp=0
Sele Registro
DbGoTop()
Do While !Eof()
   Do Case
      Case ((MDataI<=DtEnt .And. MHoraI<=HEnt) .And. (MdataF>DtEnt))
         MAptoEnt+=1
      Case MDataF=DtEnt
         If MHoraf>=HEnt
            MAptoEnt+=1
         EndIf
   EndCase
   DbSkip()
EndDo
//COUNT ALL FOR (MDataI<=DtEnt .And. MDataF>=DtEnt .And. MHoraI<=HEnt .And. MHoraF>=HEnt .And. Ativo='S') TO MAptoEnt
COUNT ALL FOR (Ativo='S') TO MAptoTot
Sele Registro
//COUNT ALL FOR (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai .And. MHoraF>=HSai .And. Ativo='N') TO MAptoSai
DbGoTop()
Do While !Eof()
   Do Case
      Case ((MDataI<=DtSai .And. MHoraI<=HSai) .And. (MdataF>DtSai))
         MAptoSai+=1
      Case MDataF=DtSai
         If MHoraf>=Hsai
            MAptoSai+=1
         EndIf
   EndCase
   DbSkip()
EndDo
Sele Bmd
MAptoTotal=MAptoEnt+MAptoTotalAnt
MPax=0
Sele ConRegis
COUNT ALL FOR (Ativo='S') TO MHospTot
//COUNT ALL FOR (MDataI<=DtSai .And. MDataF>=DtSai .And. MHoraI<=HSai .And. MHoraF>=HSai .And. Ativo='N') TO MHospSai
DbGoTop()
Do While !Eof()
   Do Case
      Case ((MDataI<=DtSai .And. MHoraI<=HSai) .And. (MdataF>DtSai))
         MHospSai+=1
      Case MDataF=DtSai
         If MHoraf>=Hsai
            MHospSai+=1
         EndIf
   EndCase
   DbSkip()
EndDo
Sele Registro
DbGoTop()
Do While !Eof()
   Do Case
      Case ((MDataI<=DtEnt .And. MHoraI<=HEnt) .And. (MdataF>DtEnt))
         MHospEnt+=1
      Case MDataF=DtEnt
         If MHoraf>=HEnt
            MHospEnt+=1
         EndIf
   EndCase
   DbSkip()
EndDo
//Do While !Eof()
//   MHospEnt=Pax+MHospEnt
//   DbSkip()
//EndDo
Set Filter to
MHospTotal=MHospEnt+MHospTotalAnt
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
DbGoTop()
Do While !Eof()
   Sele Movim
   Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConREgis->CodHosp .And. TipoDesp=1
   DbGoTop()
   Do While !Eof()
      MDiaria+=1
      MVlDia=MVlDia+Valor
      DbSkip()
   EndDo
   Set Filter to Codigo=ConRegis->Codigo .And. CodHosp=ConRegis->CodHosp
   DbGoTop()
   Do While !Eof()
      MRec+=1
      MVlRec=MVlRec+Valor
      DbSkip()
   EndDo
   Sele ConRegis
   DbSkip()
EndDo
Sele ConRegis
Set Filter to
MDiaMedia=MVlDia/MDiaria
MRecMedia=MVlRec/MRec
MDiaMediam=MDiaMediam+MDiaMedia
MRecMediam=MRecMediam+MRecMedia

Sele BMD
DbGoTop()
Locate for data=MData
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
Repl DiaMedia  With MDiaMedia
Repl RecMedia  With MRecMedia
Repl DiaMediam With MDiaMediam
Repl RecMediam With MRecMediam
Repl SaldoD    With MSaldoD
Repl SaldoA    With MSaldoA
Repl ProdDia   With MprodDia
Xdata=Mdata
Repl_Var()
MData=XData
RESTSCREEN(0,0,MAXROW(),79,ind_t)
XData=CtoD(CalcData(DtoC(MData),1))
Sele BMD
Reg=Recno()
Set Filter to
DbGoTop()
Locate for Data=XData
If !Found()
//   If !Achou
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
//   EndIf
EndIF
If Reg!=0
   Go Reg
EndIf
XX=Space(01)
H='S'
SETCOLOR(drvcorenf)
@ 08,18 Get XX  When Balao(18)   //Imprime BMD
Read
If H='S'
   Vd=.F.
   TData=MData
   TDataI=MDataI
   THoraI=MHoraI
   TDataF=MDataF
   THoraF=MHoraF
   MIL_R012(3,40)
   Vd=.T.
EndIf
Cod_Sos=Ant
RETU

//Fun‡„o atribui valor para os pr¢ximos get's

Function VerData(XX,TT)

Local Ordem:=.F.,Area:=.F.

If Select("BMD")=0
   DbfParam=DrvDbf+"BMD"
   UseArq(DbfParam)
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
      Locate for data=XX
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
