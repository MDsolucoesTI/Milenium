 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: HOT91.PRG
 \ Data....: 04-09-2000
 \ Sistema.: MILENIUM - Automa��o Hoteleira
 \ Funcao..: Consulta status dos Apartamentos    
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: Gerado pelos analistas
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'
#Include 'Milenium.ch'


LOCAL reg_dbf:=POINTER_DBF()

PRIV I:=0,mA1,mA2,mA3,mA4,mConAp:={},mCabec:={},mCampos:={}

JANELA(01,11,15,15,66,"Geracao de Consulta")
@ 14,17 SAY "Aguarde um Momento - Executando o Processamento"

Aadd(mConAp,{[Apto],[N],4,0})
Aadd(mConAp,{[Nome],[C],35,0})
Aadd(mConAp,{[RG],[C],14,0})
Aadd(mConAp,{[Pax],[N],2,0})
Aadd(mConAp,{[CHD],[N],2,0})
DbCreate(Usuario,mConAp)
Use &Usuario Exclu New

If !Used([Registro])
   DbfParam=DrvDbf+"Registro"
   UseArq(DbfParam)
   mA1=.T.
Else
   Select Registro
   mA1=.F.
EndIf
If !Used([Conregis])
   DbfParam=DrvDbf+"ConRegis"
   UseArq(DbfParam)
   mA2=.T.
Else
   Select Conregis
   mA2=.F.
EndIf
If !Used([Hospedes])
   DbfParam=DrvDbf+"Hospedes"
   UseArq(DbfParam)
   mA3=.T.
Else
   Select Hospedes
   mA3=.F.
EndIf
If !Used([Aptos])
   DbfParam=DrvDbf+"Aptos"
   UseArq(DbfParam)
   mA4=.T.
Else
   Select Aptos
   mA4=.F.
EndIf

SELE Aptos
LIB=0
NLIB=0
COUNT ALL FOR LIBERADO!='N' TO LIB
COUNT  ALL FOR LIBERADO='N' TO NLIB

Select Registro
SET FILTER TO ATIVO='S' .AND. APTO>99
DBGOTOP()
DO WHILE !EOF()
   SELE ConRegis
   IF Registro->Pax > 1
      SET FILTER TO CODIGO=REGISTRO->CODIGO
      DO WHILE !Eof()
         SELE Hospedes
         LOCATE FOR CODIGO=CONREGIS->CODHOSP
         Select &Usuario
         Append Blan
         Replace Apto With Registro->Apto
         Replace Nome With Hospedes->Nome
         Replace RG With Hospedes->Identidad
         Replace Pax With Registro->Pax
         Replace CHD With Registro->CHD
         SELE ConRegis
         DBSKIP()
      ENDDO
   ELSE
      LOCATE FOR CODIGO=REGISTRO->CODIGO
      SELE Hospedes
      LOCATE FOR CODIGO=CONREGIS->CODHOSP
      Select &Usuario
      Append Blan
      Replace Apto With Registro->Apto
      Replace Nome With Hospedes->Nome
      Replace RG With Hospedes->Identidad
      Replace Pax With Registro->Pax
      Replace CHD With Registro->CHD
   ENDIF
   SELE Registro
   DbSkip()
ENDDO

JANELA(02)

SET CURSOR OFF

mCabec={[Apartamento],[Hospede],[Identidade],[Pax],[CHD]}
mCampos={[Apto],[Nome],[RG],[Pax],[CHD]}

Select &Usuario
Index On Str(Apto,4)+Nome To IndTem

JANELA(01,06,02,22,77,"Apartamentos Ocupados")

@ 21,00 SAY PADR("[ESC] Sai  Apartamentos Liberados =        Apartamentos  Ocupados =",80)
@ 21,37 SAY LIB  PICT "999"
@ 21,70 SAY NLIB PICT "999"

DBEDIT(07,03,20,76,mCampos,,,mCabec,"�","�")

JANELA(02)

If mA1
   Select Registro
   Close
EndIf
If mA2
   Select ConRegis
   Close
EndIf
If mA3
   Select Hospedes
   Close
EndIf
If mA4
   Select Aptos
   Close
EndIf
Select &Usuarios
Close
FErase(&Usuarios)
FErase([IndTem.NTX]) // Apaga o Arquivo

POINTER_DBF(reg_dbf)

RETURN
