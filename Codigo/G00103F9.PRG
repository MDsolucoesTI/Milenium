/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: G00103F9.PRG
 \ Data....: 17-08-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: Frequ�ncia por particular do gr�fico MIL_G001
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
Para i,f
Local Ordem:=0,Soma,particular,agencia,firma
LOCAL reg_dbf:=POINTER_DBF()

If RelFre
   Sele Registro
   Count All for (DtSai>=i .and. DtSai<=f .and. Firmaage!=1 .and. interm=0) to firma
   Count all for (DtSai>=i .and. DtSai<=f .and. interm!=0) to agencia
   Count all for (DtSai>=i .and. DtSai<=f .and. firmaage=1) to particular
   Soma=particular+agencia+firma
   Ordem=particular*100/soma
EndIf
POINTER_DBF(reg_dbf)
RelFre=.F.
RETU(Ordem)       // <- deve retornar um valor qualquer

* \\ Final de G00103F9.PRG
