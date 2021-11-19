 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_R004.PRG
 \ Data....: 14-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Rela‡„o de Movimentos
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.t., op_menu:=VAR_COMPL, l_s:=10, c_s:=7, l_i:=14, c_i:=74, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(mold,l_s,c_s,l_i,c_i)               // monta caixa da tela
@ l_s,c_s+23 SAY " CONSULTA DE MOVIMENTO "
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY " Apto...........:"
@ l_s+02,c_s+1 SAY " C¢digo Hospede.:"
@ l_s+03,c_s+1 SAY " Nome do Hospede:"
apto=0                                                       // Apto
codihosp=0                                                   // C¢digo Hospede
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+01 ,c_s+19 GET  apto;
                    PICT "9999";
                    VALI CRIT("apto>0.AND.PTAB(STR(apto,04,00),'REGISTRO',2)~APTO n„o existe na tabela")
                    AJUDA "Informe o n£mero do Apartamento"
                    CMDF8 "VDBF(6,50,20,65,'APTOS',{'apto'},1,'apto',[liberado='N'])"

   @ l_s+02 ,c_s+19 GET  codihosp;
                    PICT "9999999999";
                    VALI CRIT("codihosp>0.AND.PTAB(STR(REGISTRO->codigo,10,00)+STR(codihosp,10,00),'CONREGIS',1)~C¢DIGO HOSPEDE n„o existe na tabela")
                    CMDF8 "VDBF(6,64,20,77,'CONREGIS',{'codhosp','if(ptab(STR(codihosp,10,0),'HOSPEDES',3),HOSPEDES->nome,[])'},1,'codhosp',[REGISTRO->codigo=codigo.and.ativo='S'])"
                    MOSTRA {"LEFT(TRAN(V00301F9(CONREGIS->codhosp),[]),35)", 3 , 19 }

   READ
   SET KEY K_ALT_F8 TO
   IF rola_t
      ROLATELA(.f.)
      LOOP
   ENDI
   IF LASTKEY()=K_ESC                                        // se quer cancelar
      RETU                                                   // retorna
   ENDI

   #ifdef COM_REDE
      IF !USEARQ("MOVIM",.f.,10,1)                           // se falhou a abertura do arq
         RETU                                                // volta ao menu anterior
      ENDI
   #else
      USEARQ("MOVIM")                                        // abre o dbf e seus indices
   #endi

   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)                 // abre arquivo p/ o relacionamento
   PTAB(STR(tipodesp,02,00),"DEPARTA",1,.t.)
   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"CONREGIS",1,.t.)
   SET RELA TO STR(codhosp,10,00) INTO HOSPEDES,;            // relacionamento dos arquivos
            TO STR(tipodesp,02,00) INTO DEPARTA,;
            TO STR(codigo,10,00) INTO REGISTRO,;
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO CONREGIS
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="STR(tipomov,01,00)+DTOS(datmov)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,15,11)                   // nao quis configurar...
      CLOS ALL                                               // fecha arquivos e
      LOOP                                                   // volta ao menu
   ENDI
   IF tps=2                                                  // se vai para arquivo/video
      arq_=ARQGER()                                          // entao pega nome do arquivo
      IF EMPTY(arq_)                                         // se cancelou ou nao informou
         LOOP                                                // retorna
      ENDI
   ELSE
      arq_=drvporta                                          // porta de saida configurada
   ENDI
   SET PRINTER TO (arq_)                                     // redireciona saida
   EXIT
ENDD
DBOX("[ESC] Interrompe",15,,,NAO_APAGA)
dele_atu:=SET(_SET_DELETED,.t.)                              // os excluidos nao servem...
SET DEVI TO PRIN                                             // inicia a impressao
maxli=62                                                     // maximo de linhas no relatorio
IMPCTL(drvpeli)                                              // comprime os dados
IF tps=2
   IMPCTL("' '+CHR(8)")
ENDI
BEGIN SEQUENCE
   DO WHIL ccop<=nucop                                       // imprime qde copias pedida
      pg_=1; cl=999
      INI_ARQ()                                              // acha 1o. reg valido do arquivo
      ccop++                                                 // incrementa contador de copias
      tot066015 := 0                                         // inicializa variaves de totais
      DO WHIL !EOF()
         #ifdef COM_TUTOR
            IF IN_KEY()=K_ESC                                // se quer cancelar
         #else
            IF INKEY()=K_ESC                                 // se quer cancelar
         #endi
            IF canc()                                        // pede confirmacao
               BREAK                                         // confirmou...
            ENDI
         ENDI
         qb06601=datmov                                      // campo para agrupar 1a quebra
         st06601015 := 0                                     // inicializa sub-totais
         DO WHIL !EOF() .AND. datmov=qb06601
            #ifdef COM_TUTOR
               IF IN_KEY()=K_ESC                             // se quer cancelar
            #else
               IF INKEY()=K_ESC                              // se quer cancelar
            #endi
               IF canc()                                     // pede confirmacao
                  BREAK                                      // confirmou...
               ENDI
            ENDI
            qb06602=tipomov                                  // campo para agrupar 1a quebra
            st06602015 := 0                                  // inicializa sub-totais
            DO WHIL !EOF() .AND. datmov=qb06601 .AND. tipomov=qb06602
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               REL_CAB(1)                                    // soma cl/imprime cabecalho
               @ cl,000 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
               REL_CAB(1)                                    // soma cl/imprime cabecalho
               @ cl,000 SAY "ÉÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
               REL_CAB(1)                                    // soma cl/imprime cabecalho
               @ cl,000 SAY "º  Data   º Hora  º Tipo   º Tipo Despesa º Tp. Oper.º Estorno º  Valor    º Operador       º"
               REL_CAB(1)                                    // soma cl/imprime cabecalho
               @ cl,000 SAY "ÈÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
               REL_CAB(1)                                    // soma cl/imprime cabecalho
               @ cl,001 SAY TRAN(datmov,"@D")                // Data do Movimento
               @ cl,010 SAY "³"
               @ cl,012 SAY TRAN(horamov,"@R 99:99")         // Hora do Movimento
               @ cl,018 SAY "³"
               @ cl,020 SAY If(tipomov=1,'Normal','Extra ')  // Tipo de Movimento
               @ cl,027 SAY "³"
               @ cl,029 SAY DEPARTA->tipodesp                // Tipo de Despesa
               @ cl,042 SAY "³"
               @ cl,044 SAY If(tcon='N','Normal  ','Desconto')// Tipo de Opera‡„o
               @ cl,053 SAY "³"
               @ cl,057 SAY If(estorno='S','X',' ')          // Estorno
               @ cl,063 SAY "³"
               st06601015+=valor
               st06602015+=valor
               tot066015+=valor
               @ cl,065 SAY TRAN(valor,"999999.99")          // Valor
               @ cl,075 SAY "³"
               @ cl,077 SAY operador                         // Operador
               SKIP                                          // pega proximo registro
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,065 SAY REPL('-',9)
            @ ++cl,065 SAY TRAN(st06602015,"999999.99")      // sub-tot Valor
            REL_CAB(1)                                       // espacejamento duplo
         ENDD
         IF cl+3>maxli                                       // se cabecalho do arq filho
            REL_CAB(0)                                       // nao cabe nesta pagina
         ENDI                                                // salta para a proxima pagina
         @ ++cl,065 SAY REPL('-',9)
         @ ++cl,065 SAY TRAN(st06601015,"999999.99")         // sub-tot Valor
         REL_CAB(1)                                          // espacejamento duplo
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,065 SAY REPL('-',9)
      @ ++cl,065 SAY TRAN(tot066015,"999999.99")             // total Valor
   ENDD ccop
END SEQUENCE
IMPCTL(drvteli)                                              // retira comprimido
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(15)                                                    // grava variacao do relatorio
SELE MOVIM                                                   // salta pagina
SET RELA TO                                                  // retira os relacionamentos
SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
RETU

STATIC PROC REL_CAB(qt)                                      // cabecalho do relatorio
IF qt>0                                                      // se parametro maior que 0
   cl=cl+qt                                                  // soma no contador de linhas
ENDI
IF cl>maxli .OR. qt=0                                        // quebra de pagina
   @ 0,022 SAY "C O N S U L T A  D E  M O V I M E N T O S"
   @ 0,085 SAY DTOC(DATE())                                  // data do sistema
   @ 1,000 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
   IMPAC("³ C¢digo do Registro :",2,000)
   @ 2,023 SAY TRAN(codigo,"9999999999")                     // C¢digo
   IMPAC("³ C¢digo do Hospede  :",2,041)
   @ 2,064 SAY TRAN(codhosp,"9999999999")                    // C¢digo Hospede
   @ 2,092 SAY "³"
   @ 3,000 SAY "³ Apartamento :"
   @ 3,016 SAY TRAN(REGISTRO->apto,"9999")                   // Apto
   @ 3,029 SAY "Pax :"
   @ 3,035 SAY TRAN(REGISTRO->pax,"99")                      // Pax
   @ 3,041 SAY "³ Nome :"
   @ 3,050 SAY HOSPEDES->nome                                // Nome
   @ 3,092 SAY "³"
   @ 4,000 SAY "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   @ 5,000 SAY "³ Movimento Normal :"
   @ 5,021 SAY If(REGISTRO->movimn='C','Conjunto  ','Individual')// Movimento Normal
   @ 5,043 SAY "Movimento Extra :"
   @ 5,061 SAY if(REGISTRO->movime='C','Conjunto  ','Individual')// Movimento Extra
   @ 5,092 SAY "³"
   cl=qt+5 ; pg_++
ENDI
RETU

* \\ Final de MIL_R004.PRG
