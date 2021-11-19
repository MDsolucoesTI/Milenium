/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: V00302F9.PRG
 \ Data....: 10-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fun‡„o F8 da vari vel CODIHOSP, relatorio MIL_R003
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

/*
   -------------------------------------------------------------------
   Se abrir outros arquivos salve situacao anterior e restaure ao sair
   como no exemplo abaixo:
     LOCAL reg_dbf:=POINTER_DBF()
     ...        ...        ...        ...
     POINTER_DBF(reg_dbf)
     RETU
   -------------------------------------------------------------------
*/
Para X,Cod

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
EndIf
If Select("Conregis")=0
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
EndIf
If Select("Hospedes")=0
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
EndIf

AREA=SELECT()
Sele ConRegis
Locate for codigo=Cod .And. Ativo='S'
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
      Set Filter to Codigo=Cod .And. Ativo='S'
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

* \\ Final de V00302F9.PRG
