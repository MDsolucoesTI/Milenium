 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_ESTR.PRG
 \ Data....: 08-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Cria estrutura dos arquivos 
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas

PROC CLI_estr     // estrutura do arquivo CLIENTES
DBCREATE(dbf,{;
               {"codigo"    ,"N",  4, 0},; // 9999
               {"cgc"       ,"C", 14, 0},; // @R 99.999.999/9999-99
               {"nome"      ,"C", 35, 0},; // 
               {"ie"        ,"C", 12, 0},; // 
               {"descvalor" ,"N",  8, 2},; // @E 99,999.99
               {"descporc"  ,"N",  3, 0},; // 999
               {"turis"     ,"C",  1, 0},; // @!
               {"ender"     ,"C", 40, 0},; // 
               {"numer"     ,"N",  5, 0},; // 99999
               {"compl"     ,"C", 15, 0},; // 
               {"bairro"    ,"C", 20, 0},; // 
               {"cidade"    ,"C", 20, 0},; // 
               {"uf"        ,"C",  2, 0},; // @!
               {"cep"       ,"C",  8, 0},; // @R 99999-999
               {"fone"      ,"C", 12, 0},; // @R (!999)!!99-9999
               {"ramal"     ,"C",  4, 0},; // 
               {"contato"   ,"C", 25, 0},; // 
               {"fax"       ,"C", 12, 0},; // @R (!999)!99-9999
               {"tipo"      ,"C",  1, 0},; // 
               {"codcre"    ,"N",  1, 0},; // 9
               {"rg"        ,"C", 14, 0},; // 
               {"profis"    ,"C", 20, 0},; // 
               {"dtnasc"    ,"D",  8, 0},; // @D
               {"nacio"     ,"C", 20, 0},; // 
               {"natu"      ,"C", 20, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC APT_estr     // estrutura do arquivo APTOS
DBCREATE(dbf,{;
               {"apto"      ,"N",  4, 0},; // 9999
               {"liberado"  ,"C",  1, 0},; // @!
               {"tipo"      ,"N",  2, 0},; // 99
               {"descricao" ,"C", 25, 0},; // 
               {"categ1"    ,"N",  2, 0},; // 99
               {"categ2"    ,"N",  2, 0},; // 99
               {"categ3"    ,"N",  2, 0},; // 99
               {"categ4"    ,"N",  2, 0},; // 99
               {"categ5"    ,"N",  2, 0},; // 99
               {"obs"       ,"C", 30, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC HOS_estr     // estrutura do arquivo HOSPEDES
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"identidad" ,"C", 14, 0},; // 
               {"nome"      ,"C", 35, 0},; // 
               {"profissao" ,"C", 20, 0},; // 
               {"dtcad"     ,"D",  8, 0},; // @D
               {"dtnasc"    ,"D",  8, 0},; // @D
               {"idade"     ,"N",  2, 0},; // 99
               {"estcivil"  ,"N",  1, 0},; // 9
               {"ender"     ,"C", 40, 0},; // 
               {"numer"     ,"N",  5, 0},; // 99999
               {"bairro"    ,"C", 20, 0},; // 
               {"cidade"    ,"C", 20, 0},; // 
               {"uf"        ,"C",  2, 0},; // @!
               {"cep"       ,"C",  8, 0},; // @R 99999-999
               {"pais"      ,"C", 15, 0},; // 
               {"fone"      ,"C", 12, 0},; // @R (!999)!!99-9999
               {"ativo"     ,"C",  1, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC TIP_estr     // estrutura do arquivo TIPO
DBCREATE(dbf,{;
               {"codigo"    ,"N",  2, 0},; // 99
               {"tipo"      ,"C", 10, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC CAT_estr     // estrutura do arquivo CATEG
DBCREATE(dbf,{;
               {"codigo"    ,"N",  2, 0},; // 99
               {"categoria" ,"C", 10, 0},; // 
               {"pax"       ,"N",  1, 0},; // 9
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC PRE_estr     // estrutura do arquivo PRECOS
DBCREATE(dbf,{;
               {"tipo"      ,"N",  2, 0},; // 99
               {"categ"     ,"N",  2, 0},; // 99
               {"diaria"    ,"N",  8, 2};  // @E 99,999.99
             };
)
RETU

PROC DEP_estr     // estrutura do arquivo DEPARTA
DBCREATE(dbf,{;
               {"codigo"    ,"N",  2, 0},; // 99
               {"tipodesp"  ,"C", 12, 0},; // 
               {"custo"     ,"N",  4, 0},; // 9999
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC CAR_estr     // estrutura do arquivo CARTOES
DBCREATE(dbf,{;
               {"codigo"    ,"N",  2, 0},; // 99
               {"nomecar"   ,"C", 15, 0},; // 
               {"taxa"      ,"N",  5, 2},; // 99.99
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC CUR_estr     // estrutura do arquivo CURSO
DBCREATE(dbf,{;
               {"apto"      ,"N",  4, 0},; // 9999
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"movimn"    ,"C",  1, 0},; // @!
               {"movime"    ,"C",  1, 0},; // @!
               {"ativo"     ,"C",  1, 0};  // 
             };
)
RETU

PROC EXC_estr     // estrutura do arquivo EXCUR
DBCREATE(dbf,{;
               {"apto"      ,"N",  4, 0},; // 9999
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"aptodepend","N",  4, 0},; // 9999
               {"ativo"     ,"C",  1, 0},; // 
               {"flag_excl" ,"C",  1, 0};  // !
             };
)
RETU

PROC RES_estr     // estrutura do arquivo RESERVA
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"tipo"      ,"N",  2, 0},; // 99
               {"categoria" ,"N",  2, 0},; // 99
               {"apto"      ,"N",  4, 0},; // 9999
               {"pax"       ,"N",  2, 0},; // 99
               {"dtreser"   ,"D",  8, 0},; // @D
               {"dtsai"     ,"D",  8, 0},; // @D
               {"hreser"    ,"C",  4, 0},; // @R 99:99
               {"trata"     ,"C",  1, 0},; // 9
               {"unidade"   ,"N",  2, 0},; // 99
               {"obs"       ,"C", 35, 0},; // 
               {"descporc"  ,"N",  3, 0},; // 999
               {"descvalor" ,"N",  8, 2},; // @R 99,999.99
               {"preco"     ,"N",  8, 2},; // @R 99,999.99
               {"permuta"   ,"C",  1, 0},; // @!
               {"formapag"  ,"N",  1, 0},; // 9
               {"cartao"    ,"N",  2, 0},; // 99
               {"cortesia"  ,"C",  1, 0},; // @!
               {"autocorte" ,"C", 15, 0},; // 
               {"fatdiaria" ,"C",  1, 0},; // @!
               {"fatdespesa","C", 10, 0},; // 
               {"somentedia","C",  1, 0},; // @!
               {"diariacp"  ,"C",  1, 0},; // @!
               {"reservado" ,"C", 15, 0},; // 
               {"empresa"   ,"C", 35, 0},; // 
               {"contato"   ,"C", 15, 0},; // 
               {"ramal"     ,"N",  5, 0},; // 99999
               {"fone"      ,"C", 12, 0},; // @R (!999)!!99-9999
               {"agencia"   ,"C", 35, 0},; // 
               {"bonus"     ,"C",  1, 0},; // @!
               {"recebido"  ,"C",  1, 0},; // @!
               {"noshow"    ,"C",  1, 0},; // @!
               {"dtsolicit" ,"D",  8, 0},; // @D
               {"hsolicit"  ,"C",  4, 0},; // @R 99:99
               {"operador"  ,"C", 15, 0},; // 
               {"autores"   ,"C", 15, 0},; // 
               {"efetivou"  ,"C",  1, 0};  // @!
             };
)
RETU

PROC RPE_estr     // estrutura do arquivo RPES
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"numero"    ,"N",  2, 0},; // 99
               {"nome"      ,"C", 35, 0},; // 
               {"rg"        ,"C", 14, 0},; // 
               {"flag_excl" ,"C",  1, 0};  // !
             };
)
RETU

PROC UNI_estr     // estrutura do arquivo UNIDADE
DBCREATE(dbf,{;
               {"codigo"    ,"N",  2, 0},; // 99
               {"unidade"   ,"C", 20, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC SAL_estr     // estrutura do arquivo SALAO
DBCREATE(dbf,{;
               {"codigo"    ,"N",  2, 0},; // 99
               {"descricao" ,"C", 15, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC AGE_estr     // estrutura do arquivo AGENDA
DBCREATE(dbf,{;
               {"data"      ,"D",  8, 0},; // @D
               {"hora"      ,"C",  4, 0},; // @R 99:99
               {"sala"      ,"N",  2, 0},; // 99
               {"datalib"   ,"D",  8, 0},; // @D
               {"horalib"   ,"C",  4, 0},; // @R 99:99
               {"empresa"   ,"C", 35, 0},; // 
               {"telefone"  ,"C", 12, 0},; // @R (!999)!!99-9999
               {"ramal"     ,"N",  5, 0},; // 99999
               {"contato"   ,"C", 15, 0},; // 
               {"coffee"    ,"C",  1, 0},; // @!
               {"descrcoffe","C", 15, 0},; // 
               {"datareser" ,"D",  8, 0},; // @D
               {"horareser" ,"C",  4, 0},; // @R 99:99
               {"autorizou" ,"C", 20, 0},; // 
               {"obs"       ,"C", 35, 0},; // 
               {"operador"  ,"C", 15, 0};  // 
             };
)
RETU

PROC REG_estr     // estrutura do arquivo REGISTRO
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"apto"      ,"N",  4, 0},; // 9999
               {"pax"       ,"N",  2, 0},; // 99
               {"chd"       ,"N",  2, 0},; // 99
               {"hent"      ,"C",  4, 0},; // @R 99:99
               {"dtent"     ,"D",  8, 0},; // @D
               {"movimn"    ,"C",  1, 0},; // @!
               {"movime"    ,"C",  1, 0},; // @!
               {"ativo"     ,"C",  1, 0},; // 
               {"firmaage"  ,"N",  4, 0},; // 9999
               {"interm"    ,"N",  4, 0},; // 9999
               {"dtsai"     ,"D",  8, 0},; // @D
               {"hsai"      ,"C",  4, 0},; // @R 99:99
               {"opent"     ,"C", 15, 0},; // 
               {"opsai"     ,"C", 15, 0},; // 
               {"intref"    ,"N",  8, 0};  // 99999999
             };
)
RETU

PROC CON_estr     // estrutura do arquivo CONREGIS
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"codhosp"   ,"N", 10, 0},; // 9999999999
               {"nome"      ,"C", 35, 0},; // 
               {"rd"        ,"N",  5, 0},; // 99999
               {"obs"       ,"C", 30, 0},; // 
               {"pconta"    ,"C",  1, 0},; // @!
               {"ultproc"   ,"C", 20, 0},; // 
               {"proxdest"  ,"C", 20, 0},; // 
               {"vlnormal"  ,"N", 13, 2},; // 9999999999.99
               {"sernor"    ,"N", 11, 2},; // 99999999.99
               {"finalnor"  ,"N",  8, 2},; // @E 99,999.99
               {"porcnor"   ,"N",  3, 0},; // 999
               {"vlextra"   ,"N", 13, 2},; // 9999999999.99
               {"serext"    ,"N", 11, 2},; // 99999999.99
               {"finalext"  ,"N",  8, 2},; // @E 99,999.99
               {"porcext"   ,"N",  3, 0},; // 999
               {"dtsai"     ,"D",  8, 0},; // @D
               {"hsai"      ,"C",  4, 0},; // @R 99:99
               {"ativo"     ,"C",  1, 0},; // 
               {"flag_excl" ,"C",  1, 0};  // !
             };
)
RETU

PROC MOV_estr     // estrutura do arquivo MOVIM
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"codhosp"   ,"N", 10, 0},; // 9999999999
               {"datmov"    ,"D",  8, 0},; // @D
               {"horamov"   ,"C",  4, 0},; // @R 99:99
               {"tipomov"   ,"N",  1, 0},; // 9
               {"tipodesp"  ,"N",  2, 0},; // 99
               {"operador"  ,"C", 15, 0},; // 
               {"tcon"      ,"C",  1, 0},; // @!
               {"estorno"   ,"C",  1, 0},; // @!
               {"valor"     ,"N",  9, 2};  // 999999.99
             };
)
RETU

PROC PAG_estr     // estrutura do arquivo PAGAM
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"codhosp"   ,"N", 10, 0},; // 9999999999
               {"datamov"   ,"D",  8, 0},; // @D
               {"tipomov"   ,"N",  1, 0},; // 9
               {"formapag"  ,"N",  1, 0},; // 9
               {"tipocart"  ,"N",  2, 0},; // 99
               {"valor"     ,"N",  9, 2},; // 999999.99
               {"numero"    ,"C", 20, 0},; // 
               {"banco"     ,"N",  4, 0},; // 9999
               {"agencia"   ,"N",  5, 0},; // 99999
               {"operador"  ,"C", 15, 0};  // 
             };
)
RETU

PROC DES_estr     // estrutura do arquivo DESCONTO
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"codhosp"   ,"N", 10, 0},; // 9999999999
               {"final"     ,"N",  8, 2},; // 99999.99
               {"porc"      ,"N",  3, 0},; // 999
               {"obs"       ,"C", 30, 0},; // 
               {"operador"  ,"C", 15, 0},; // 
               {"tipodesp"  ,"N",  2, 0},; // 99
               {"autor"     ,"C", 15, 0};  // 
             };
)
RETU

PROC CHE_estr     // estrutura do arquivo CHEQUES
DBCREATE(dbf,{;
               {"codigo"    ,"N", 10, 0},; // 9999999999
               {"codhosp"   ,"N", 10, 0},; // 9999999999
               {"ncheque"   ,"C",  9, 0},; // 999999999
               {"banco"     ,"N",  4, 0},; // 9999
               {"valor"     ,"N", 10, 2},; // 9999999.99
               {"dataemis"  ,"D",  8, 0},; // @D
               {"datapre"   ,"D",  8, 0},; // @D
               {"tipomov"   ,"N",  1, 0},; // 9
               {"operador"  ,"C", 15, 0};  // 
             };
)
RETU

PROC BMD_estr     // estrutura do arquivo BMD
DBCREATE(dbf,{;
               {"data"      ,"D",  8, 0},; // @D
               {"datai"     ,"D",  8, 0},; // @D
               {"horai"     ,"C",  4, 0},; // @R 99:99
               {"dataf"     ,"D",  8, 0},; // @D
               {"horaf"     ,"C",  4, 0},; // @R 99:99
               {"saldod"    ,"N", 15, 2},; // @E 999,999,999,999.99
               {"saldoa"    ,"N", 15, 2},; // @E 999,999,999,999.99
               {"proddia"   ,"N", 15, 2},; // @E 999,999,999,999.99
               {"dinheiro"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"cheque"    ,"N", 15, 2},; // @E 999,999,999,999.99
               {"chequepre" ,"N", 15, 2},; // @E 999,999,999,999.99
               {"cartao"    ,"N", 15, 2},; // @E 999,999,999,999.99
               {"rda"       ,"N", 15, 2},; // @E 999,999,999,999.99
               {"cobranca"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"permuta"   ,"N", 15, 2},; // @E 999,999,999,999.99
               {"taxas"     ,"N", 10, 2},; // @E 9,999,999.99
               {"totalb"    ,"N", 15, 2},; // @E 999,999,999,999.99
               {"pordin"    ,"N",  3, 0},; // 999
               {"porche"    ,"N",  3, 0},; // 999
               {"porchepre" ,"N",  3, 0},; // 999
               {"porcar"    ,"N",  3, 0},; // 999
               {"porrda"    ,"N",  3, 0},; // 999
               {"porcob"    ,"N",  3, 0},; // 999
               {"porper"    ,"N",  3, 0},; // 999
               {"portaxa"   ,"N",  3, 0},; // 999
               {"pordinm"   ,"N",  3, 0},; // 999
               {"porchem"   ,"N",  3, 0},; // 999
               {"porchepm"  ,"N",  3, 0},; // 999
               {"porcarm"   ,"N",  3, 0},; // 999
               {"porrdam"   ,"N",  3, 0},; // 999
               {"porcobm"   ,"N",  3, 0},; // 999
               {"porperm"   ,"N",  3, 0},; // 999
               {"portaxam"  ,"N",  3, 0},; // 999
               {"dinheirom" ,"N", 15, 2},; // @E 999,999,999,999.99
               {"chequem"   ,"N", 15, 2},; // @E 999,999,999,999.99
               {"chequepm"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"cartaom"   ,"N", 15, 2},; // @E 999,999,999,999.99
               {"rdam"      ,"N", 15, 2},; // @E 999,999,999,999.99
               {"cobrancam" ,"N", 15, 2},; // @E 999,999,999,999.99
               {"permutam"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"taxam"     ,"N", 10, 2},; // @E 9,999,999.99
               {"totalbm"   ,"N", 15, 2},; // @E 999,999,999,999.99
               {"aptoent"   ,"N",  3, 0},; // 999
               {"aptosai"   ,"N",  3, 0},; // 999
               {"aptotot"   ,"N",  3, 0},; // 999
               {"aptototal" ,"N",  3, 0},; // 999
               {"hospent"   ,"N",  3, 0},; // 999
               {"hospsai"   ,"N",  3, 0},; // 999
               {"hosptot"   ,"N",  3, 0},; // 999
               {"hosptotal" ,"N",  3, 0},; // 999
               {"diamedia"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"diamediam" ,"N", 15, 2},; // @E 999,999,999,999.99
               {"recmedia"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"recmediam" ,"N", 15, 2};  // @E 999,999,999,999.99
             };
)
RETU

PROC ACU_estr     // estrutura do arquivo ACUMULO
DBCREATE(dbf,{;
               {"data"      ,"D",  8, 0},; // @D
               {"despesa"   ,"N",  2, 0},; // 99
               {"dia"       ,"N", 15, 2},; // @E 999,999,999,999.99
               {"totaldia"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"pordia"    ,"N",  3, 0},; // 999
               {"pormes"    ,"N",  3, 0},; // 999
               {"mes"       ,"N", 15, 2},; // @E 999,999,999,999.99
               {"totalmes"  ,"N", 15, 2},; // @E 999,999,999,999.99
               {"flag_excl" ,"C",  1, 0};  // !
             };
)
RETU

PROC PAR_estr     // estrutura do arquivo PARAMET
DBCREATE(dbf,{;
               {"empresa1"  ,"C", 35, 0},; // 
               {"cgc1"      ,"C", 14, 0},; // @R 99.999.999/9999-99
               {"inscr1"    ,"C", 12, 0},; // @R 999.999.999.999
               {"ender1"    ,"C", 35, 0},; // 
               {"numero1"   ,"C",  5, 0},; // 99999
               {"bairro1"   ,"C", 18, 0},; // 
               {"cidade1"   ,"C", 20, 0},; // 
               {"uf1"       ,"C",  2, 0},; // @!
               {"pais1"     ,"C", 15, 0},; // 
               {"cep1"      ,"C",  8, 0},; // @R 99999-999
               {"tele1"     ,"C", 12, 0},; // @R (!999)!!99-9999
               {"fax1"      ,"C", 12, 0},; // @R (!999)!!99-9999
               {"tex1"      ,"C", 15, 0},; // 
               {"recepcao"  ,"C",  1, 0},; // @!
               {"reserva"   ,"C",  1, 0},; // @!
               {"retaguarda","C",  1, 0},; // @!
               {"restaurant","C",  1, 0},; // @!
               {"estoque"   ,"C",  1, 0},; // @!
               {"financeiro","C",  1, 0},; // @!
               {"orcamen"   ,"C",  1, 0},; // @!
               {"veiculo"   ,"C",  1, 0},; // @!
               {"marina"    ,"C",  1, 0},; // @!
               {"txser"     ,"N",  2, 0},; // 99
               {"numrd"     ,"N",  5, 0},; // 99999
               {"faixaini"  ,"N",  4, 0},; // 9999
               {"faixafim"  ,"N",  4, 0},; // 9999
               {"numreabre" ,"N",  2, 0},; // 99
               {"terdia"    ,"C",  4, 0},; // @R 99:99
               {"bmd"       ,"D",  8, 0},; // @D
               {"hbmd"      ,"C",  4, 0},; // @R 99:99
               {"dtcaixa"   ,"D",  8, 0},; // @D
               {"hcaixa"    ,"C",  4, 0},; // @R 99:99
               {"lancmov"   ,"C",  1, 0},; // !
               {"baixpag"   ,"C",  1, 0},; // !
               {"dtinicont" ,"D",  8, 0},; // @D
               {"dtfimcont" ,"D",  8, 0},; // @D
               {"palavra"   ,"C", 20, 0},; // 
               {"operador1" ,"C", 15, 0};  // 
             };
)
RETU

* \\ Final de MIL_ESTR.PRG
