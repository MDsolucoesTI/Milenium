/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: V01104F9.PRG
 \ Data....: 23-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fun‡„o F8 da variavel APTO, relatorio MIL_R011
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Programado manualmente pelo analista
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

Area=Select()

If Select("Registro")=0
   DbfParam=DrvDbf+"Registro"
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
      AADD(Arq,{"Codigo","N",10,0})
      AADD(Arq,{"APTO","N",04,0})
      DbCreAte("&Usuario",Arq)
      Exit
   Else
      FErase("&Usuario")
   EndIf
EndDo
Use &Usuario Exclusiv New
Sele Registro
Sele Paramet
If NumReabre<1
   MNumReabre=20
Else
   MNumReabre=NumReabre
EndIf
DataX=CalcData(DtoC(DataC),-mNumReabre)
Sele Registro
Set Filter to Ativo='N' .and. DtSai>=CtoD(DataX)
DbGoTop()
Do While !Eof()
   MCodigo=Codigo
   MApto=Apto
   Sele &Usuario
   DbGoTop()
   Locate for MApto=Apto
   If !Found()
      Appe Blan
      Repl Codigo    With MCodigo
      Repl Apto      With MApto
   EndIf
   Sele Registro
   DbSkip()
EndDo
Sele &Usuario
MDB3={"Apto"}
MDb1={"Apto"}
DBGOTOP()
Sol_Vdbf(11,11,21,50,Usuario,MDB1,Mdb3,"M->APTO","CONSULTA DE APARTAMENTOS")
If LastKey()=13
   Sele Registro
   Set Filter to
   DbGoTop()
   Locate for Codigo=&Usuario->Codigo
   M->Apto=Apto
EndIf
Sele &Usuario
Close
Sele Registro
Close
SELE &AREA
RETU(M->Apto)       // <- deve retornar um valor qualquer

* \\ Final de V01104F9.PRG
