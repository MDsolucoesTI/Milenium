/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_ATR2.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - AutomaáÑo Hoteleira
 \ Funcao..: Define atributos dos arquivos (sistema[])
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas


sistema[23]={;
            "ManutenáÑo do B.M.D.",;                        // opcao do menu
            "ManutenáÑo do B.M.D.",;                        // titulo do sistema
            {"DTOS(data)+STR(despesa,02,00)","DTOS(data)"},;// chaves do arquivo
            {"Data+despesa","Data"},;                       // titulo dos indices para consulta
            {"0102","01"},;                                 // ordem campos chaves
            "ACUMULO",;                                     // nome do DBF
            {"ACUMULO1","ACUMULO2"},;                       // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {"BMD->data"},;                                 // campos de relacionamento
            {1,1,8,-1,18,80},;                              // num telas/tela atual/coordenadas
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"1=2","NÑo Ç permitido excluir neste m¢dulo"},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "@D",;
     /* titulo        */    "Data",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo da Despesa",;
     /* cmd especial  */    "VDBF(6,57,20,77,'DEPARTA',{'codigo','tipodesp'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(despesa,02,00),'DEPARTA',1)~C¢DIGO DA DESPESA nÑo existe na tabela",;
     /* help do campo */    "Informe o c¢digo da Despesa|F8 Tabela Pick";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Ac£mulo Di†rio",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor do Ac£mulo Di†rio";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Total do dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor total no dia";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "999",;
     /* titulo        */    "Porc. dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem no dia";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "999",;
     /* titulo        */    "Porc mes",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "informe a porcentagem no dia";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Mes",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor do ac£mulo mensal";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Total no màs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor total no Màs";
                         };
)
AADD(sistema[23,O_CAMPO],{;            // ACUMULO
     /* mascara       */    "!",;
     /* titulo        */    "Flag",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[23,O_FORMULA],{;          // ACUMULO - Tipo de Despesa
     /* form mostrar  */    "LEFT(TRAN(DEPARTA->tipodesp,[]),12)",;
     /* lin da formula*/    6,;
     /* col da formula*/    7;
                         };
)


sistema[24]={;
            "Configuraáîes do Sistema",;                    // opcao do menu
            "Configuraáîes do Sistema",;                    // titulo do sistema
            {},;                                            // chaves do arquivo
            {},;                                            // titulo dos indices para consulta
            {},;                                            // ordem campos chaves
            "PARAMET",;                                     // nome do DBF
            {},;                                            // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {3,1,1,3,22,76},;                               // num telas/tela atual/coordenadas
            {3,.f.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Nome do Hotel",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(empresa1)~Necess†rio informar o nome da empresa",;
     /* help do campo */    "Informe o Nome do Hotel";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R 99.999.999/9999-99",;
     /* titulo        */    "CGC",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!empty(cgc1).And.CGC(CGC1)~CGC nÑo aceit†vel",;
     /* help do campo */    "Informe o n£mero do CGC";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R 999.999.999.999",;
     /* titulo        */    "InscriáÑo Estadual",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o numero da InscriáÑo Estadual";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Endereáo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(ender1)~Necess†rio informar o endereáo da empresa",;
     /* help do campo */    "Informe o Endereáo da empresa";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "99999",;
     /* titulo        */    "N£mero",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(numero1)~Necess†rio informar o n£mero do endereáo",;
     /* help do campo */    "Informe o n£mero do endereáo da empresa";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Bairro",;
     /* cmd especial  */    "",;
     /* default       */    "[Centro]",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(bairro1)~Necess†rio informar bairro",;
     /* help do campo */    "Informe o nome do Bairro";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Cidade",;
     /* cmd especial  */    "",;
     /* default       */    "[TaubatÇ]",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(cidade1)~Necess†rio informar a cidade",;
     /* help do campo */    "Informe o nome da Cidade";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Unidade Federativa",;
     /* cmd especial  */    "",;
     /* default       */    "[SP]",;
     /* pre-validacao */    "",;
     /* validacao     */    "!Empty(uf1)~Unidade da FederaáÑo inv†lida",;
     /* help do campo */    "Informe a Unidade Federetiva";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Pais",;
     /* cmd especial  */    "",;
     /* default       */    "[Brasil]",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(pais1)~Necess†rio informar o Pa°s",;
     /* help do campo */    "Informe o Pa°s sede da empresa";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R 99999-999",;
     /* titulo        */    "CEP",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(cep1)~Necess†rio informar CEP",;
     /* help do campo */    "Informe o CEP da Cidade";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R (!999)!!99-9999",;
     /* titulo        */    "Telefone",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(tele1)~Necess†rio informar o telefone da empresa",;
     /* help do campo */    "Informe o telefone da empresa";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R (!999)!!99-9999",;
     /* titulo        */    "Fax",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o N£mero do Fax da empresa|se houver";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Telex",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Telex da empresa|se houver";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "RecepáÑo",;
     /* cmd especial  */    "",;
     /* default       */    "[S]",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Reserva",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Reserva])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "reserva $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo de Reserva esteja|liberado e N caso nÑo|esteja|F8 Tabela Pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Retaguarda",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Retaguarda])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "retaguarda $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo de Retaguarda esteja|liberado e N caso nÑo esteja|F8 tabela pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Restaurante",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Restaurante])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "restaurant $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo de Restaurante esteja|liberado e N caso nÑo esteja|F8 tabela Pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Estoque",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Estoque])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "estoque $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo de Estoque esteja|liberado e N caso nÑo esteja|F8 tabela Pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Financeiro",;
     /* cmd especial  */    "MTAB([SIM|NéO],[FINANCEIRO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "financeiro $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo Financeiro esteja|liberado e N caso nÑo esteja|F8 Tabela Pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Oráamento",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Oráamento])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "orcamen $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo de Planejamento Oráament†rio esteja|liberado e N caso nÑo esteja|F8 tabela pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Ve°culo",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Ve°culo])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "veiculo $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo Ve°culo esteja|liberado e N caso nÑo esteja|F8 tabela pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@!",;
     /* titulo        */    "Marina",;
     /* cmd especial  */    "MTAB([SIM|NéO],[Marina])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "marina $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S caso o m¢dulo Marina esteja|liberado e N caso nÑo esteja|F8 tabela pick";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "99",;
     /* titulo        */    "Taxa de serviáo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "recepcao=[S]",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a taxa de serviáo|que ser† cobrada";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "99999",;
     /* titulo        */    "N£mero da Fatura",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "recepcao=[S]",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero inicial da Fatura";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "9999",;
     /* titulo        */    "Faixa Inicial",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "recepcao=[S]",;
     /* validacao     */    "",;
     /* help do campo */    "Informe qual a numeraáÑo inicial|que ser† considerado passante ou eventual";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "9999",;
     /* titulo        */    "Faixa Final",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "recepcao=[S]",;
     /* validacao     */    "IIf(!Empty(faixaini),!Empty(faixafim),Empty(faixafim))~Faixa Final nÑo aceit†vel",;
     /* help do campo */    "Informe a numeraáÑo final|que ser† considerado passante ou eventual";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "99",;
     /* titulo        */    "N£mero M†ximo Reabertara",;
     /* cmd especial  */    "",;
     /* default       */    "20",;
     /* pre-validacao */    "recepcao=[S]",;
     /* validacao     */    "numreabre>0~N£mero M†ximo de Dias|p/ reabertura nÑo aceit†vel",;
     /* help do campo */    "Informe o n£mero m†ximo de Dias para|ser feita a Reabertura de Conta";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "TÇrmino de Di†ria",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "recepcao=[S]",;
     /* validacao     */    "!EMPT(terdia)~Necess†rio informar TÇrmino da Di†ria",;
     /* help do campo */    "Informe a hora de encerramento da di†ria";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@D",;
     /* titulo        */    "Bmd",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hoar do BMD",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@D",;
     /* titulo        */    "Data da RelaáÑo de Caixa",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora da RelaáÑo do Caixa",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "!",;
     /* titulo        */    "Lanáa Movimento",;
     /* cmd especial  */    "MTAB([Sim|NÑo],[Lanáa Movimento])",;
     /* default       */    "",;
     /* pre-validacao */    "financeiro=[S]",;
     /* validacao     */    "lancmov $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S p/ lanáar o cheque emitido no movimento banc†rio|ou N p/ nÑo efetuar o lanáamento";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "!",;
     /* titulo        */    "Baixa Pagamento",;
     /* cmd especial  */    "MTAB([Sim|NÑo],[Baixa Pagamento])",;
     /* default       */    "",;
     /* pre-validacao */    "financeiro=[S]",;
     /* validacao     */    "baixpag $ [SN]~OpáÑo nÑo aceit†vel",;
     /* help do campo */    "Informe S p/ dar baixa no Contas a Pagar|caso o cheque emitido seja para pagamento de divida registrada|ou N p/ nÑo efetuar a baixa";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@D",;
     /* titulo        */    "Data In°cio de Contrato",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtinicont)~Necess†rio informar a|Data de In°cio do Contrato",;
     /* help do campo */    "Informe a data inicial do Contrato";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "@D",;
     /* titulo        */    "Data final Contrato",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtfimcont)~Necess†rio informar a|Data do Final do Contrato",;
     /* help do campo */    "Informe a Data de tÇrmino do Contrato";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Palavra",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(palavra).and.senha()=Alltrim(palavra)~Necess†rio informar a Senha|ou Senha incorreta.",;
     /* help do campo */    "Informe a Senha deste per°odo";
                         };
)
AADD(sistema[24,O_CAMPO],{;            // PARAMET
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "[USUARIO]",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - RecepáÑo
     /* form mostrar  */    "LEFT(TRAN(If(recepcao=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    22;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Reserva
     /* form mostrar  */    "LEFT(TRAN(if(reserva=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    45;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Restaurante
     /* form mostrar  */    "LEFT(TRAN(if(restaurant=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    17,;
     /* col da formula*/    22;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Estoque
     /* form mostrar  */    "LEFT(TRAN(if(estoque=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    17,;
     /* col da formula*/    45;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Retaguarda
     /* form mostrar  */    "LEFT(TRAN(if(retaguarda=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    68;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Financeiro
     /* form mostrar  */    "LEFT(TRAN(if(financeiro=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    17,;
     /* col da formula*/    68;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - oráament†rio
     /* form mostrar  */    "LEFT(TRAN(if(orcamen=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    19,;
     /* col da formula*/    22;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Ve°culo
     /* form mostrar  */    "LEFT(TRAN(if(veiculo=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    19,;
     /* col da formula*/    45;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Marina
     /* form mostrar  */    "LEFT(TRAN(if(marina=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    19,;
     /* col da formula*/    68;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Lanáamento
     /* form mostrar  */    "LEFT(TRAN(if(lancmov=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    13,;
     /* col da formula*/    64;
                         };
)
AADD(sistema[24,O_FORMULA],{;          // PARAMET - Baixa
     /* form mostrar  */    "LEFT(TRAN(If(baixpag=[S],[im],[Ño]),[]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    64;
                         };
)


sistema[25]={;
            "Senhas",;                                      // opcao do menu
            "Usu†rios do sistema",;                         // titulo do sistema
            {"pass"},;                                      // chaves do arquivo
            {""},;                                          // titulo dos indices para consulta
            {"02"},;                                        // ordem dos campos chvs
            "MILPW",;                                       // nome do DBF
            {ntxpw},;                                       // nome do NTX
            {},;                                            // nome dos DBF relacionados
            {},;                                            // campos de relacionamento
            {1,1,11,19,17,51},;                             // qde telas, tela atual, coordenadas
            {3,.t.},;                                       // nivel acesso/tp chave
            {},; // campos  { mascara, titulo, when, critica }
            {},;// fromula { mascara, titulo, formula, linha, coluna }
            {"",""},;      // condicao de exclusao de registros
            {"",""},;      // condicao de alteracao de registros
            {"",""};       // condicao de recuperacao de registros
           }

msg="DIGITE INICIAIS DAS ROTINAS CERCEADAS AO USUèRIO|"+;
    "P. Procura    F. Filtragem    D. DigitaáÑo     ˇ|"+;
    "M. Modifica   E. Exclui       R. Recupera      ˇ|"+;
    "V. Và global  N. Nova coluna  A. Apaga coluna  ˇ|"+;
    "I. Imprime    O. Ordena       Q. Quantifica    ˇ|"+;
    "L. Localiza   G. Global       C. Congela Colunas|"+;
    "T. Tamanho    J. nova Janela ˇX. eXporta       ˇ|"+;
    "Z. totaliZa                                    ˇ|"
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "",;
     /* titulo        */    "Pass",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@!",;
     /* titulo        */    "Usu†rio",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPTY(nome)~Necess†rio informar NOME",;
     /* help do campo */    "";
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "9",;
     /* titulo        */    "Nivel",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "MTAB([1. OperaáÑo ˇ|2. ManutenáÑo|3. Gerància ˇ],[N°VEL DE ACESSO])",;
     /* validacao     */    "nace$[123]~N°VEL DE ACESSO inv†lido",;
     /* help do campo */    "";
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Firmas/Agentes",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Apartamentos",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Hospedes",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Tipos de Apto",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Categoria do Apto",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Tabela de Di†rias",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Tipo de Despesa",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Cartîes de CrÇdito",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Registro de Grupos",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Dependentes",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Controle de Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Reserva - H¢spedes",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Unidades de Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Salas e Audit¢rios",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Reserva de Salas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo de Registro",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo de Registro",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo de Movimentos",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo de Pagamentos",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo de Descontos",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Cheques-PrÇ-Datados",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo do B.M.D.",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "ManutenáÑo do B.M.D.",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)
AADD(sistema[25,O_CAMPO],{;            // SENHAS
     /* mascara       */    "@A@!",;
     /* titulo        */    "Configuraáîes do Sistema",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    msg;
                         };
)

* \\ Final de MIL_ATR2.PRG
