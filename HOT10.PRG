/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOT10.PRG
 \ Data....: 08-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rotina avulsa (Lan‡amento de Di ria)
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Programado manualmente pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

/*
   Nivelop = Nivel de acesso do usuario (1=operacao, 2=manutencao e
   3=gerencia)
*/

Local Sos_Ant:=Cod_Sos,Areas_Ant[08],ArAlias[08],CorOld,Curs,L,C
Cod_Sos=79

IF nivelop < 1          // se usuario nao tem
   ALERTA()               // permissao, avisa
   DBOX(msg_auto,,,3)     // e retorna
   RETU
ENDI

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
   Areas_Ant[1]=.T.
   ArAlias[1]="Registro"
Else
   Sele Registro
   Areas_Ant[1]=.F.
   ArAlias[1]="Registro"
EndIf
If Select("Conregis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
   areas_ant[2]=.T.
   ArAlias[2]="ConRegis"
Else
   Sele ConRegis
   areas_ant[2]=.F.
   ArAlias[2]="ConRegis"
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
   areas_ant[3]=.T.
   ArAlias[3]="Hospedes"
Else
   Sele Hospedes
   areas_ant[3]=.F.
   ArAlias[3]="Hospedes"
EndIf
If Select("Desconto")=0
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam)
   areas_ant[4]=.T.
   ArAlias[4]="Desconto"
Else
   Sele Desconto
   areas_ant[4]=.F.
   ArAlias[4]="Desconto"
EndIf
If Select("Movim")=0
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam)
   areas_ant[5]=.T.
   ArAlias[5]="Movim"
Else
   Sele Movim
   areas_ant[5]=.F.
   ArAlias[5]="Movim"
EndIf
If Select("Precos")=0
   DbfParam=DrvDbf+"Precos"
   UseArq(DbfParam)
   areas_ant[06]=.T.
   ArAlias[06]="Precos"
Else
   Sele Precos
   areas_ant[06]=.F.
   ArAlias[06]="Precos"
EndIf
If Select("Categ")=0
   DbfParam=DrvDbf+"Categ"
   UseArq(DbfParam)
   areas_ant[07]=.T.
   ArAlias[07]="Categ"
Else
   Sele Categ
   areas_ant[07]=.F.
   ArAlias[07]="Categ"
EndIf
If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
   areas_ant[08]=.T.
   ArAlias[08]="Aptos"
Else
   Sele Categ
   areas_ant[08]=.F.
   ArAlias[08]="Categ"
EndIf
COROLD=SETCOLOR()
CURS=SETCURSOR()
L=Row()
C=Col()

Set Key K_ALT_L to
Set Key K_F2 to
Set Key K_ALT_H to
Janela(01,12,13,19,68," Lan‡amento de Di rias ")
SETCOLOR(drvcortel)
@ 11,12 Say "±±±±±±±±±±±±±±± Lan‡amento de Di rias ±±±±±±±±±±±±±±±±±±±"
@ 13,13 Say "ÚÄ Apto Â Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ Pax Ä¿"
@ 14,13 Say "³       ³                                      ³      ³"
@ 15,13 Say "ÃÄ Dt. Entr. Â H. Entr. Â Mov. Normal Â Mov. Extra ÄÄÄ´"
@ 16,13 Say "³            ³          ³             ³               ³"
@ 17,13 Say "ÃÄ Porc. Desc. Â Vl. Desc. Â Valor Diaria ÄÄÄÄÄÄÄÄÄÄÄÄ´"
@ 18,13 Say "³          %   ³           ³                          ³"
@ 19,13 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
AXX=Space(01)
Op=Space(01)
@ 14,14 Get AXX When Balao(12)
Read
SETCOLOR(drvcortel)
If Op!='C'
   Sele Registro
   Set Filter to Ativo='S'
   Do WHile !Eof()
      Igual_Var()
      Sele ConRegis
      Set Filter to Codigo=Registro->Codigo .And. Ativo='S'
      DbGoTop()
      Do While !Eof()
         Sele Hospedes
         DbGoTop()
         Locate for Codigo=ConRegis->CodHosp
         MHospede=Nome
         Sele Desconto
         DbGoTop()
         Locate for Codigo=MCodigo .And. CodHosp=ConRegis->CodHosp
         If Found()
            Mfinal=final
            Mporc=porc
         Else
            Mfinal=0
            Mporc=0
         EndIf
         @ 14,16 Say MApto  Pict "9999"
         @ 14,23 Say MHospede
         @ 14,61 Say MPax   Pict "99"
         @ 16,16 Say Mdtent PIct "@d"
         @ 16,29 Say Mhent  Pict "@R 99:99"
         @ 16,39 Say Mmovimn Pict "@!"
         If Mmovimn='C'
            @ 16,40 Say "ONJUNTO   "
         Else
            @ 16,40 Say "NDIVIDUAL"
         EndIf
         @ 16,53 Say Mmovime Pict "@!"
         If Mmovime='C'
            @ 16,54 Say "ONJUNTO   "
         Else
            @ 16,54 Say "NDIVIDUAL"
         EndIf
         @ 18,19 Say MPorc  PIct "999"
         @ 18,30 Say MFinal PIct "@R@E 99,999.99"
         MValor=0
         Set Deleted On
         Sele Movim
         Set Filter to Codigo=Registro->Codigo .And. CodHosp=ConRegis->CodHosp .And. TipoDesp=1 .And. TipoMov=1 .And. TCon='N' .And. Estorno='N'
         DbGoBoTTom()
         MValor=Valor
         @ 18,43 Say MValor Pict "@R 999,999.99"
         If datmov=DataC
            AXX=Space(01)
            AXC=Space(01)
            SETCOLOR(drvcortel)
            @ 14,14 Get AXX When Balao(13)
            Read
            If AXC='N'
               Sele ConRegis
               If Registro->movimn='I'
                  DbSkip()
                  Loop
               Else
                  Exit
               EndIf
            EndIf
            SETCOLOR(drvcortel)
         EndIf
         Set Filter to
         If MValor=0
            DBox('N„o foi encontrado nenhuma Di ria lan‡ada|anteriormente para este hospede.',,,0,.T.,,)
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
                  MValor=0
               EndIF
            Else
               MValor=0
            EndIF
         EndIf
         If (Op='M' .or. MValor=0)
            SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)          //Cor Get's
            Set Cursor On
            @ 18,43 Get MValor Pict "@R 999,999.99" Valid(!Empty(mValor))
            Read
            Set Cursor Off
            SETCOLOR(drvcortel)
            If Lastkey()=27
               DBox('ATEN€ŽO !!!||A Di ria n„o ser  lan‡ada para|este Hospede.',,,0,.T.,,)
               Sele ConRegis
               If Registro->movimn='I'
                  DbSkip()
                  Loop
               Else
                  Exit
               EndIf
            EndIf
         EndIf
         Sele Movim
         Do While .T.
            If TravaReg()
               Repl codigo   With MCodigo
               Repl codhosp  With ConRegis->CodHosp
               Repl datmov   With DataC
               Repl horamov  With Hora(Time())
               Repl tipomov  With 1
               Repl tipodesp With 1
               Repl operador With Usuario
               Repl tcon     With 'N'
               Repl estorno  With 'N'
               Repl valor    With MValor
               Unlock
               Exit
            EndIf
         EndDo
         If MFinal!=0 .or. Mporc!=0
            Sele Desconto
            If !Empty(Final)
               mValor=Final*(-1)
            Else
               mValor = (mValor*(Porc/100))*(-1)
            EndIf
            Sele Movim
            MTcon='D'
            MEstorno='N'
            mcodhosp=ConRegis->CodHosp
            moperador=Usuario
            mtipodesp=1
            mdatmov=Datac
            mhoramov=Hora(Time())
            mtipomov=1
            IF TRAVAREG()
               REPL_VAR()
               UNLOCK
            EndIf
         EndIf
         Sele ConRegis
         If Registro->movimn='C'
            Exit
         Else
            DbSkip()
         EndIf
         MApto=0
         MHospede=Space(35)
         MPax=0
         Mdtent=Ctod("  /  /  ")
         Mhent=0
         Mmovimn=Space(01)
         Mmovime=Space(01)
         MPorc=0
         MFinal=0
         MValor=0
         @ 14,16 Say MApto  Pict "9999"
         @ 14,23 Say MHospede
         @ 14,61 Say MPax   Pict "99"
         @ 16,16 Say Mdtent PIct "@D"
         @ 16,29 Say Mhent  Pict "@R 99:99"
         @ 16,39 Say Mmovimn Pict "@!"
         @ 16,40 Say "          "
         @ 16,53 Say Mmovime Pict "@!"
         @ 16,54 Say "          "
         @ 18,19 Say MPorc  PIct "999"
         @ 18,30 Say MFinal PIct "@R@E 99,999.99"
         @ 18,43 Say MValor Pict "@R 999,999.99"
      EndDo
      Sele Registro
      DbSkip()
   EndDo
EndIf
Janela(02)
Sele ConRegis
Set Filter to
Sele Registro
Set Filter to
For Int=1 To 08         //Loop para fechamento das areas
   If Areas_Ant[Int]
      XXXXX=ArAlias[Int]
      Sele &XXXXX
      Close
   EndIf
Next
Cos_Sos=Sos_Ant
SETCOLOR(CorOld)
SETCURSOR(Curs)
@ L,C Say ''
Set Key K_ALT_L to HOT10
If Sets
   Set Key K_F2 to MudaOp
   Set Key K_ALT_H to AtuData
EndIf
RETU

* \\ Final de HOT10.PRG
