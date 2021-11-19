/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: V01102F9.PRG
 \ Data....: 17-01-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o da variavel CODIHOSP, relatorio MIL_R011
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Programado manualmente pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

Local Ordem
Para Codh,MCod

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

Sele ConRegis
Set Filter to
DbGoTop()
Locate for Codigo=MCod .And. CodHosp=CodH
If Found()
   If Ativo='N'
      Ordem=.T.
   Else
      DBox('N„o ‚ poss¡vel imprimir esta fatura,|pois esta conta est  em aberto - Reabertura.',,,0,.T.,,)
      Ordem=.F.
   EndIf
Else
   Ordem=.F.
EndIf

RETU(Ordem)       // <- deve retornar um valor L¢GICO

*\\ Final de V01102F9.PRG
