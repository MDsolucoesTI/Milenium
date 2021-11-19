/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_R011.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Fatura
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 e modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas

LOCAL dele_atu, getlist:={}
PARA  lin_menu, col_menu
PRIV  tem_borda:=.f., op_menu:=VAR_COMPL, l_s:=8, c_s:=9, l_i:=16, c_i:=71, tela_fundo:=SAVESCREEN(0,0,MAXROW(),79)
nucop=1
SETCOLOR(drvtittel)
vr_memo=NOVAPOSI(@l_s,@c_s,@l_i,@c_i)     // pega posicao atual da tela
CAIXA(SPAC(8),l_s+1,c_s+1,l_i,c_i-1)      // limpa area da tela/sombra
SETCOLOR(drvcortel)
@ l_s+01,c_s+1 SAY "±±±±±±±±±±±±±±±±±±±±±±±±±± Fatura ±±±±±±±±±±±±±±±±±±±±±±±±±±±"
@ l_s+03,c_s+1 SAY " Ú Apto Â C¢digo Hospede ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ l_s+04,c_s+1 SAY " ³      ³            -                                     ³"
@ l_s+05,c_s+1 SAY " Ã Tipo Movimento ÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ l_s+06,c_s+1 SAY " ³   -            ³"
@ l_s+07,c_s+1 SAY " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
apto=0                                                       // Apto
codihosp=0                                                   // C¢digo Hospede
tp=0                                                         // Tipo de Movimento
DO WHILE .t.
   rola_t=.f.
   cod_sos=56
   SET KEY K_ALT_F8 TO ROLATELA
   SETCOLOR(drvcortel+","+drvcorget+",,,"+corcampo)
   @ l_s+04 ,c_s+04 GET  apto;
                    PICT "9999";
                    VALI CRIT("PTAB(STR(apto,04,00),'REGISTRO',2)~APTO n„o existe na tabela")
                    AJUDA "Informe o n£mero do Apartamento"
                    CMDF8 "V01104F9()"

   @ l_s+04 ,c_s+11 GET  codihosp;
                    PICT "9999999999";
                    VALI CRIT("V01102F9(codihosp,MCodigo)~C¢DIGO HOSPEDE n„o existe na tabela");
                    WHEN "V01101F9(REGISTRO->Apto)"
                    CMDF8 "V01101F9(REGISTRO->Apto)"
                    MOSTRA {"LEFT(TRAN(V01103F9(codihosp),[]),35)", 4 , 24 }

   @ l_s+06 ,c_s+04 GET  tp;
                    PICT "9";
                    VALI CRIT("tp>0 .and. tp<3~TIPO DE MOVIMENTO n„o aceit vel")
                    DEFAULT "1"
                    AJUDA "Informe o Tipo de Movimento"
                    CMDF8 "MTAB([1-NORMAL|2-EXTRA],[TIPO DE MOVIMENTO])"
                    MOSTRA {"LEFT(TRAN(If(tp=1,'NORMAL','EXTRA '),[]),06)", 6 , 8 }

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

   PTAB(STR(tipodesp,02,00),"DEPARTA",1,.t.)                 // abre arquivo p/ o relacionamento
   PTAB(STR(codigo,10,00),"REGISTRO",1,.t.)
   PTAB(STR(codigo,10,00)+STR(codhosp,10,00),"CONREGIS",1,.t.)
   PTAB(STR(codhosp,10,00),"HOSPEDES",3,.t.)
   PTAB(STR(REGISTRO->firmaage,04,00),"CLIENTES",2,.t.)
   SET RELA TO STR(tipodesp,02,00) INTO DEPARTA,;            // relacionamento dos arquivos
            TO STR(codigo,10,00) INTO REGISTRO,;
            TO STR(codigo,10,00)+STR(codhosp,10,00) INTO CONREGIS,;
            TO STR(codhosp,10,00) INTO HOSPEDES,;
            TO STR(REGISTRO->firmaage,04,00) INTO CLIENTES
   titrel:=criterio := ""                                    // inicializa variaveis
   cpord="DTOS(datmov)"
   titrel:=chv_rela:=chv_1:=chv_2 := ""
   tps:=op_x:=ccop := 1
   IF !opcoes_rel(lin_menu,col_menu,4,11)                    // nao quis configurar...
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
IF !EMPTY(drvtapg)                                           // existe configuracao de tam pag?
   op_=AT("NNN",drvtapg)                                     // se o codigo que altera
   IF op_=0                                                  // o tamanho da pagina
      msg="Configura‡„o do tamanho da p gina!"               // foi informado errado
      DBOX(msg,,,,,"ERRO!")                                  // avisa
      CLOSE ALL                                              // fecha todos arquivos abertos
      RETU                                                   // e cai fora...
   ENDI                                                      // codigo para setar/resetar tam pag
   lpp_050=LEFT(drvtapg,op_-1)+"050"+SUBS(drvtapg,op_+3)
   lpp_066=LEFT(drvtapg,op_-1)+"066"+SUBS(drvtapg,op_+3)
ELSE
   lpp_050:=lpp_066 :=""                                     // nao ira mudara o tamanho da pag
ENDI
DBOX("[ESC] Interrompe",15,,,NAO_APAGA)
dele_atu:=SET(_SET_DELETED,.t.)                              // os excluidos nao servem...
SET DEVI TO PRIN                                             // inicia a impressao
maxli=60                                                     // maximo de linhas no relatorio
IMPCTL(lpp_050)                                              // seta pagina com 50 linhas
IMPCTL(drvpde8)                                              // ativa 8 lpp
IF tps=2
   IMPCTL("' '+CHR(8)")
ENDI
BEGIN SEQUENCE
   DO WHIL ccop<=nucop                                       // imprime qde copias pedida
      pg_=1; cl=999
      INI_ARQ()                                              // acha 1o. reg valido do arquivo
      ccop++                                                 // incrementa contador de copias
      tot038030 := 0                                         // inicializa variaves de totais
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
         IF codigo=Registro->Codigo .And.codhosp=M->codihosp .And.tipomov=M->tp// se atender a condicao...
            REL_CAB(2)                                       // soma cl/imprime cabecalho
            @ cl,000 SAY [Data : ]+DtoC(datmov)              // titulo da quebra
            REL_CAB(1)                                       // soma cl/imprime cabecalho
            qb03801=datmov                                   // campo para agrupar 1a quebra
            st03801030 := 0                                  // inicializa sub-totais
            DO WHIL !EOF() .AND. datmov=qb03801
               #ifdef COM_TUTOR
                  IF IN_KEY()=K_ESC                          // se quer cancelar
               #else
                  IF INKEY()=K_ESC                           // se quer cancelar
               #endi
                  IF canc()                                  // pede confirmacao
                     BREAK                                   // confirmou...
                  ENDI
               ENDI
               IF codigo=Registro->Codigo .And.codhosp=M->codihosp .And.tipomov=M->tp// se atender a condicao...
                  REL_CAB(1)                                 // soma cl/imprime cabecalho
                  @ cl,001 SAY DEPARTA->tipodesp             // Tipo de Despesa
                  st03801030+=valor
                  tot038030+=valor
                  @ cl,018 SAY TRAN(valor,"@E 999,999.99")   // Valor
                  @ cl,032 SAY TRAN(horamov,"@R 99:99")      // Hora do Movimento
                  @ cl,041 SAY If(tcon='N','        ','Desconto')// Tipo de Opera‡„o
                  @ cl,052 SAY If(estorno='S','SIM','   ')   // Estorno
                  SKIP                                       // pega proximo registro
               ELSE                                          // se nao atende condicao
                  SKIP                                       // pega proximo registro
               ENDI
            ENDD
            IF cl+3>maxli                                    // se cabecalho do arq filho
               REL_CAB(0)                                    // nao cabe nesta pagina
            ENDI                                             // salta para a proxima pagina
            @ ++cl,018 SAY REPL('-',10)
            @ ++cl,018 SAY TRAN(st03801030,"@E 999,999.99")  // sub-tot Valor
         ELSE                                                // se nao atende condicao
            SKIP                                             // pega proximo registro
         ENDI
      ENDD
      IF cl+3>maxli                                          // se cabecalho do arq filho
         REL_CAB(0)                                          // nao cabe nesta pagina
      ENDI                                                   // salta para a proxima pagina
      @ ++cl,018 SAY REPL('-',10)
      @ ++cl,018 SAY TRAN(tot038030,"@E 999,999.99")         // total Valor
      REL_RDP()                                              // imprime rodape' do relatorio
   ENDD ccop
END SEQUENCE
IMPCTL(drvtde8)                                              // ativa 6 lpp
IMPCTL(lpp_066)                                              // seta pagina com 66 linhas
SET PRINTER TO (drvporta)                                    // fecha arquivo gerado (se houver)
SET DEVI TO SCRE                                             // direciona saida p/ video
IF tps=2                                                     // se vai para arquivo/video
   BROWSE_REL(arq_,2,3,MAXROW()-2,78)
ENDI                                                         // mostra o arquivo gravado
GRELA(4)                                                     // grava variacao do relatorio
SELE MOVIM                                                   // salta pagina
SET RELA TO                                                  // retira os relacionamentos
SET(_SET_DELETED,dele_atu)                                   // os excluidos serao vistos
RETU

STATIC PROC REL_RDP                                          // rodape'
@ 62,000 SAY REPL("Ä",80)
@ 64,006 SAY "(Signature) Assinatura : ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
RETU 

STATIC PROC REL_CAB(qt)                                      // cabecalho do relatorio
IF qt>0                                                      // se parametro maior que 0
   cl=cl+qt                                                  // soma no contador de linhas
ENDI
IF cl>maxli .OR. qt=0                                        // quebra de pagina
   IF pg_>1
      REL_RDP()                                              // imprime rodape' do relatorio
   ENDI
   IMPAC("Data Emiss„o :",0,000)
   @ 0,015 SAY DTOC(DATE())                                  // data do sistema
   @ 0,024 SAY ","
   @ 0,026 SAY NSEM(DATE())                                  // dia da semana
   @ 0,065 SAY "Pag :"
   @ 0,071 SAY TRAN(pg_,'9999')                              // n£mero da p gina
   @ 2,032 SAY "F A T U R A -"
   @ 2,046 SAY TRAN(CONREGIS->rd,"99999")                    // N£mero da Fatura
   @ 3,020 SAY Par([empresa1])                               // Nome do Hotel
   @ 4,006 SAY Par([ender1])                                 // Endere‡o do Hotel
   @ 4,041 SAY ","
   @ 4,043 SAY TRAN(Par([numero1]),"99999")                  // N£mero do Hotel
   @ 4,049 SAY "-"
   @ 4,051 SAY Par([bairro1])                                // Bairro do Hotel
   @ 5,020 SAY Par([cidade1])                                // Cidade do Hotel
   @ 5,040 SAY "/"
   @ 5,041 SAY TRAN(Par([uf1]),"@!")                         // Unidade Federativa Hotel
   @ 5,044 SAY "-"
   @ 5,046 SAY TRAN(Par([cep1]),"@R 99999-999")              // CEP do Hotel
   @ 6,006 SAY "Tele:"
   @ 6,012 SAY TRAN(Par([tele1]),"@R (!999)!!99-9999")       // Telefone do Hotel
   @ 6,028 SAY "- FAX:"
   @ 6,035 SAY TRAN(Par([fax1]),"@R (!999)!!99-9999")        // Fax do Hotel
   @ 6,051 SAY "- Telex:"
   @ 6,060 SAY Par([tex1])                                   // Telex do Hotel
   @ 7,000 SAY REPL("Ä",80)
   @ 8,004 SAY "Apto :"
   IMPCTL(drvpenf)
   @ 8,011 SAY TRAN(REGISTRO->apto,"9999")                   // Apto
   IMPCTL(drvtenf)
   @ 8,021 SAY "Pax:"
   @ 8,026 SAY TRAN(REGISTRO->pax,"99")                      // Pax
   @ 8,033 SAY "CHD:"
   @ 8,038 SAY TRAN(REGISTRO->chd,"99")                      // Chd
   IMPCTL(drvpenf)
   @ 8,069 SAY If(tipomov=1,'Normal','Extra ')               // Tipo de Movimento
   IMPCTL(drvtenf)
   @ 9,004 SAY "(Guest Name) Hospede  :"
   IMPCTL(drvpenf)
   @ 9,028 SAY HOSPEDES->nome                                // Nome do Hospede
   IMPCTL(drvtenf)
   IMPAC("(Adress)     Endere‡o :",10,004)
   @ 10,028 SAY HOSPEDES->ender                              // Ender
   @ 10,068 SAY ","
   @ 10,070 SAY TRAN(HOSPEDES->numer,"99999")                // N£mero
   @ 11,004 SAY "(City)       Cidade   :"
   @ 11,028 SAY HOSPEDES->cidade                             // Cidade
   @ 11,057 SAY "(State) Estado:"
   @ 11,073 SAY TRAN(HOSPEDES->uf,"@!")                      // UF
   @ 12,004 SAY "(Check In)   Data Ent.:"
   @ 12,028 SAY TRAN(REGISTRO->dtent,"@D")                   // Data de Entrada
   IMPAC("(Check Out) Data Sa¡da:",12,043)
   @ 12,067 SAY TRAN(CONREGIS->dtsai,"@D")                   // Data de Sa¡da
   @ 13,000 SAY REPL("Ä",80)
   @ 14,011 SAY "Movimento Normal :"
   @ 14,030 SAY If(REGISTRO->movimn='C','Conjunto  ','Individual')// Movimento Normal
   @ 14,046 SAY "Movimento Extra :"
   @ 14,064 SAY if(REGISTRO->movime='C','Conjunto  ','Individual')// Movimento Extra
   @ 15,022 SAY "Firma :"
   @ 15,030 SAY CLIENTES->nome                               // Nome da Firma
   @ 16,000 SAY REPL("Í",80)
   cl=qt+16 ; pg_++
ENDI
RETU

* \\ Final de MIL_R011.PRG
