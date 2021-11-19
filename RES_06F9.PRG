/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: RES_02F9.PRG
 \ Data....: 05-12-95
 \ Sistema.: Milenium - Automa‡„o Hoteleira
 \ Funcao..: Pr‚-valida‡„o do campo PAX, arquivo RESERVA
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
//Fun‡„o Atribui N£mero M ximo de Pax no Apartamento

LOCAL reg_dbf:=POINTER_DBF()
Local Area[2],TCat[5]

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
m->Pax=TMaxPax

For I=1 to 2
   If Area[I]
      Close
   EndIF
Next
Sele Reserva
POINTER_DBF(reg_dbf)
RETU(.T.)       // <- deve retornar um valor L¢GICO

* \\ Final de RES_02F9.PRG
