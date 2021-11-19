/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: V01101F9.PRG
 \ Data....: 10-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fun‡„o F8 da variavel CODIHOSP, relatorio MIL_R011
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

Para Ap

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
Sele Paramet
If NumReabre<1
   MNumReabre=20
Else
   MNumReabre=NumReabre
EndIf
DataX=CalcData(DtoC(DataC),-MNumReabre)
Sele Registro
Set Filter to (dtsai>=CtoD(DataX) .and. Ativo='N' .and. Apto = Ap)
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
Close
Sele Registro
Close
Sele ConRegis
Close
SELE &AREA
RETU(M->CodiHosp)       // <- deve retornar um valor qualquer


/*
AREA=SELECT()
Sele ConRegis
Set Filter to
Locate for codigo=Cod .And. Ativo='N'
If !Found()
      M->CodiHosp=0
Else
      If Registro->MovimN='C' .And. Registro->MovimE='C'
         M->CodiHosp=CodHosp
         Sele Hospedes
         DbGoTop()
         Locate for Codigo=Conregis->CodHosp
         THospede=Nome
      Else
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
         Set Filter to Codigo=Cod .And. Ativo='N'
         DbGoTop()
         Do While !Eof()
            MCodHosp=CodHosp
            Sele Hospedes
            DbGoTop()
            Locate for Codigo=ConRegis->CodHosp
            MNome=Nome
            Sele &Usuario
            Appe Blan
            Repl Nome    With MNome
            Repl CodHosp With MCodHosp
            Sele ConRegis
            DbSkip()
         EndDo
         Sele &Usuario
         MDB3={"Codigo","Nome"}
         MDb1={"MCodHosp","Nome"}
         DBGOTOP()
         Sol_Vdbf(11,11,21,60,Usuario,MDB1,Mdb3,"M->CodiHosp","CONSULTA DE HOSPEDES")
         If LastKey()!=27 .And. LastKey()=13
            Sele ConRegis
            Set Filter to
            DbGoTop()
            Locate for CodHosp=&Usuario->CodHosp .And. Codigo=Cod
            THospede=&Usuario->Nome
            M->CodiHosp=&Usuario->CodHosp
            Sele Registro
            DbGoTop()
            Locate for Codigo=ConRegis->Codigo
         EndIf
         Sele &Usuario
         Close
         Sele Hospedes
      EndIf
EndIf
SELE &AREA
RETU(M->CodiHosp)       // <- deve retornar um valor qualquer
*/

* \\ Final de V01101F9.PRG
