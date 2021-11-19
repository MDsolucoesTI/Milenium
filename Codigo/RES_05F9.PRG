 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: RES_05F9.PRG
 \ Data....: 28-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Valida‡„o do campo PAX, arquivo RESERVA
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
//Fun‡„o Atribui N£mero M ximo de Pax no Apartamento

LOCAL reg_dbf:=POINTER_DBF()
Local Area[2],TCat[5],Ordem:=.F.
Para XPax

If Select('Aptos')=0
   Area[1]=.T.
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
Else
   Area[1]=.F.
   Sele Aptos
EndIf
If Select('Categ')=0
   Area[2]=.T.
   DbfParam=DrvDbf+"Categ"
   UseArq(DbfParam)
Else
   Area[2]=.F.
   Sele Categ
EndIf


Sele Aptos
TTipoApto=Tipo
Sele Categ          //Area das Categorias
DbGoTop()
Locate for Codigo=Aptos->Categ1
TCat[1]=Pax
DbGoTop()
Locate for Codigo=Aptos->Categ2
TCat[2]=Pax
DbGoTop()
Locate for Codigo=Aptos->Categ3
If Found()
   TCat[3]=Pax
Else
   TCat[3]=0
EndIf
DbGoTop()
Locate for Codigo=Aptos->Categ4
If Found()
   TCat[4]=Pax
Else
   TCat[4]=0
EndIf
DbGoTop()
Locate for Codigo=Aptos->Categ5
If Found()
   TCat[5]=Pax
Else
   TCat[5]=0
EndIF
TMaxPax=TCat[1]
For I=02 to 05
   If TCat[I]>TMaxPax
      TMaxPax=TCat[I]
   EndIf
Next


If !Empty(XPax)
   If TMaxPax<Xpax
      DBox("N£mero de Pax ultrapassando limite|para este Apartamento|N£mero m ximo permitido : "+Str(TMaxPax)+' ocupante(s)',,,0,.T.,,)
   Else
     Ordem=.T.
   EndIf
Else
   DBox("Necess rio informar n£mero de Pax",,,0,.T.,,)
EndIF

For I=1 to 2
   If Area[I]
      Close
   EndIF
Next
Sele Reserva
POINTER_DBF(reg_dbf)

RETU(Ordem)       // <- deve retornar um valor L¢GICO

* \\ Final de RES_01F9.PRG
