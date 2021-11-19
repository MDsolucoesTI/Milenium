/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: ESPACO.PRG
 \ Data....: 16-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rotina avulsa (Economia Espa‡o em Disco)
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

DBox("ATEN€ŽO !!!||Este recurso somente funcionar  caso|um £nico usu rio esteja acessando o sistema.",,,0,.T.,,)
Op=Space(01)
AXX=Space(01)
@ 12,34 Get AXX When Balao(19)
Read
If Op=[S]
   SETCOLOR(drvcorbox)
   JANELA(01,11,15,15,66,[S]," Liberando Espa‡o em Disco ",.T.)
   @ 13,17 SAY "Aguarde um Momento - Executando o Processamento"
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Movim"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Desconto"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Pagam"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Cheques"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Conregis"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Bmd"
   UseArq(DbfParam,.T.)
   DbfParam=DrvDbf+"Acumulo"
   UseArq(DbfParam,.T.)
   Sele Movim
   Set Filter to datmov<=(DataC-Paramet->numreabre)
   DbGoTop()
   Do While !Eof()
      Sele Desconto
      Set Filter to (Codigo=Movim->Codigo .And. CodHosp=Movim->CodHosp)
      DbGoTop()
      Do While !Eof()
         Dele
         DbSkip()
      EndDO
      Sele Movim
      Dele
      DbSkip()
   EndDo
   Sele movim
   Pack
   Sele Desconto
   Pack
   Close
   Sele Pagam
   Set Filter to datamov<=(DataC-Paramet->numreabre)
   DbGoTop()
   Do While !Eof()
         Dele
         DbSkip()
   EndDo
   Sele Pagam
   Pack
   Close
   Sele Cheques
   Set Filter to datapre<=(DataC-Paramet->numreabre)
   DbGoTop()
   Do While !Eof()
         Dele
         DbSkip()
   EndDo
   Sele Cheques
   Pack
   Close
   Sele Conregis
   Set Filter to dtsai<=(DataC-Paramet->numreabre)
   DbGoTop()
   Do While !Eof()
         Dele
         DbSkip()
   EndDo
   Sele Conregis
   Pack
   Close
   Sele Bmd
   Set Filter to data<=(DataC-Paramet->numreabre)
   DbGoTop()
   Do While !Eof()
      Sele Acumulo
      Set Filter to Data=Bmd->Data
      DbGoTop()
      Do While !Eof()
            Dele
            DbSkip()
      EndDo
         Dele
         DbSkip()
   EndDo
   Sele Bmd
   Pack
   Sele Acumulo
   Pack
   Sele Paramet
   Close
EndIf
RETU
* \\ Final de ESPACO.PRG
