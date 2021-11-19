/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT31.PRG
 \ Data....: 30-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Emiss„o de Consulta de Apartamentos
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'
SETCOLOR(drvcorbox)

PRIV MRAPTO:={},MRHOSP:={},MRRG:={},MRPAX:={},MRCHD:={},CONTADOR:=0,MRGERAL:={},I:=0

If Select("registro")=0
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
If Select("Aptos")=0
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
EndIf
Sele Hospedes
Set Order to 3

SETCOLOR(drvcorbox)
JANELA(01,11,15,15,66,[S]," Geracao de Consulta ",.T.)
@ 13,17 SAY "Aguarde um Momento - Executando o Processamento"
Arquivo=(Substr(Usuario,1,5)+"PAN")
Do While .t.
   If !file(Arquivo)
      Arq:={}
      AADD(Arq,{"Apto","N",4,0})
      AADD(Arq,{"Nome","C",35,0})
      AADD(Arq,{"Identidade","C",14,0})
      AADD(Arq,{"Pax","N",2,0})
      AADD(Arq,{"CHD","N",2,0})
      DbCreate(Arquivo,Arq)
      Exit
   Else
      Ferase(Arquivo)
   EndIf
EndDo
Use &Arquivo Exclusiv New
SELE Aptos
LIB=0
NLIB=0
COUNT ALL FOR LIBERADO!='N' TO LIB
COUNT  ALL FOR LIBERADO='N' TO NLIB
Sele ConRegis
Set Filter to Ativo='S'
Set Relation to Str(Codigo,10,00) Into Registro, to Str(CodHosp,10,00) into Hospedes
DBGOTOP()
DO WHILE !EOF()
   //Sele Registro
   //DbGoTop()
   //Locate for Codigo=ConRegis->Codigo
   //Sele Hospedes
   //DbGoTop()
   //Locate for Codigo=ConRegis->CodHosp
   SELE &Arquivo
   Appe Blan
   Repl Apto With Registro->Apto
   Repl Nome With Hospedes->Nome
   Repl Identidade With Hospedes->Identidad
   Repl Pax With Registro->Pax
   Repl Chd With Registro->Chd
   SELE ConRegis
   DBSKIP()
ENDDO
SET FILTER TO
JANELA(02)
SET CURSOR OFF
SETCOLOR(drvcorbox)
@ 24,00 SAY PADR("[ESC] Sai",80)
JANELA(01,06,02,22,77,[S]," Apartamentos Ocupados ",.T.)
@ 21,05 Say "Apartamentos Liberados =        Apartamentos  Ocupados ="
@ 21,30 SAY LIB  PICT "999"
@ 21,64 SAY NLIB PICT "999"
SETCOLOR(drvcorbox)
FOR X=03 TO 76
   @ 20,X SAY "Ä"
NEXT
Sele &Arquivo
Index On Str(Apto,4)+Nome To IndTem
MDB1=("Apto","Nome","Identidade","Pax","Chd")
MDB3={"Aptos","Nome","Identidade","Pax","Chd"}
DBGOTOP()
SETCOLOR(drvcorbox)
Do While .T.
   DBEDIT(07,03,19,76,MDB1,"VerDb1",,MDB3,"Ä","³")
   IF LastKey()=27
      CLEAR TYPEAHEAD
      EXIT
   ENDIF
ENDDO
JANELA(02)
Sele &Arquivo
Close All
Ferase(Arquivo)
Ferase([IndTem.ntx])
Set Cursor On
RETURN
