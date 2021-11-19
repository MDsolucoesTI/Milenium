/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: CONRES.PRG
 \ Data....: 15-08-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Consulta de Reserva
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 e modificado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL t_, i_, col_cp,col_ti, cps_rela, cr_, ord_
Local Reg_Dbf:=Pointer_Dbf(),L,C,Cor,Cur,XPar:=.F.
PARA  lin_menu,col_menu
PRIV  prefixo_dbf:="CON", op_sis:=EVAL(qualsis,"RPES")       // arquivo a consultar

If Select("Paramet")=0
   DbfParam=DrvDbf+"Paramet"
   UseArq(DbfParam)
   XPar=.T.
Else
   Sele Paramet
   XPar=.F.
EndIF

Set Key K_ALT_R to
Set Key K_F2 to
Set Key K_ALT_H to
L=Row()
C=Col()
Cur=SetCursor()
Cor=SetColor()

op_menu=PROJECOES                                            // flag consulta e faz projecoes
SELE 0

#ifdef COM_REDE
   IF !USEARQ("RPES",.f.,10,1)                               // se falhou a abertura do arq
      RETU                                                   // volta ao menu anterior
   ENDI
#else
   USEARQ("RPES")                                            // abre o dbf e seus indices
#endi

PTAB(STR(codigo,10,00),"RESERVA",1,.t.)                      // abre arquivo p/ o relacionamento
Tl_Ant=SaveScreen(0,0,MaxRow(),79)
If Paramet->Reserva='S'
   SET RELA TO STR(codigo,10,00) INTO RESERVA                   // relacionamento dos arquivos
   col_cp={;                                                    // conteudo das colunas
             "TRAN(RESERVA->apto,[])",;
             "TRAN(RESERVA->pax,[99])",;
             "TRAN(RESERVA->dtreser,[@D])",;
             "nome",;
             "rg",;
             "TRAN(RESERVA->empresa,[])";
          }
   col_ti={;                                                    // titulo das colunas
             "Apartamento",;
             "Pax",;
             "Data de Reserva",;
             "Nome",;
             "Rg",;
             "Nome da Empresa";
          }
   cr_="RESERVA->dtreser>=DataC"                                // filtro inicial
   ord_="DTOS(RESERVA->dtreser)"                                // ordem inicial
   GO TOP                                                       // vai p/ inicio do arquivo
   FOR i_=1 TO LEN(sistema[op_sis,O_CPRELA])                    // libera os campos invisiveis
      sistema[op_sis,O_CAMPO,i_,O_CRIT]="V"                     // que fazem a ligacao dos DBFs
   NEXT                                                         // para serem vistos na consulta
   EDITA(3,3,MAXROW()-2,77,"V",col_cp,col_ti,cr_,ord_)
   FOR i_=1 TO LEN(sistema[op_sis,O_CPRELA])                    // e retorna com o atributo
      sistema[op_sis,O_CAMPO,i_,O_CRIT]="I"                     // de invisivel nos campos da
   NEXT                                                         // ligacao pai-filho
EndIf
Sele Paramet
If XPar
   Close
EndIF
Pointer_Dbf(Reg_Dbf)
RestScreen(0,0,MaxRow(),79,Tl_Ant)
SetColor(Cor)
SetCurSor(Cur)
@ L,C Say ''
Set Key K_ALT_R to ConRes
If Sets
   Set Key K_F2 to MudaOp
   Set Key K_ALT_H to AtuData
EndIf
RETU                                                         // volta para o menu anterior

* \\ Final de CONRES.PRG
