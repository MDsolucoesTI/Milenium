 /*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Azevedo - Marilene Esquiavoni
 \ Programa: MIL_ATRI.PRG
 \ Data....: 08-09-2000
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Define atributos dos arquivos (sistema[]) 
 \ Analista: Denny Azevedo - Marilene Esquiavoni
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "milenium.ch"  // inicializa constantes manifestas


/*
   A adicao das  definicoes dos campos (mascara, titulo, cmd esp, when/defa,
   critica, ajuda) dentro do vetor sistema e' feita atraves da funcao AADD(),
   isto previne erro "memory overbooked" do CA-Clipper, durante a compilacao,
   devido a linha ser muito extensa
*/

sistema[01]={;
            "Firmas/Agentes",;                              // opcao do menu
            "Firmas e Agentes",;                            // titulo do sistema
            {"cgc","STR(codigo,04,00)","nome"},;            // chaves do arquivo
            {"CGC","C¢digo","Nome Firma"},;                 // titulo dos indices para consulta
            {"02","01","03"},;                              // ordem campos chaves
            "CLIENTES",;                                    // nome do DBF
            {"CLIENTE1","CLIENTE2","CLIENTE3"},;            // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,6,4,21,78},;                               // num telas/tela atual/coordenadas
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"VerDel([Firmas],[Registro],[FirmaAge=Firmas->Codigo .or. Interm=Codigo .and. Ativo='S'])",;// condicao de exclusao de registros
             "N„o ‚ poss¡vel apagar esta firma|pois a mesma est  sendo utilizado|no registro."},;
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "9999",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@R 99.999.999/9999-99",;
     /* titulo        */    "CGC",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!empty(cgc).AND.CGC(CGC)~CGC n„o aceit vel",;
     /* help do campo */    "Informe o n£mero do CGC da Firma";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(nome)~Necess rio informar NOME",;
     /* help do campo */    "Informe o Nome da Firma";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Ins. Estadual",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Inscri‡„o Estadual";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@E 99,999.99",;
     /* titulo        */    "Desconto em Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Desconto em valor|que a firma tem direito|se houver";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "999",;
     /* titulo        */    "Desconto em porcentagem",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o desconto em porcentagem|que a firma possui no hotel";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@!",;
     /* titulo        */    "Turismo",;
     /* cmd especial  */    "MTAB([SIM|NAO],[TURISMO])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "turis $ [SN]~Caracter inv lido",;
     /* help do campo */    "Informe <S> se for Agencia e|<N> se Firma";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Endere‡o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o endere‡o de Firma ou Agente";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "99999",;
     /* titulo        */    "N£mero",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero do residencia";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Complemento",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o complemento do endere‡o|se houver";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Bairro",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o bairro do endere‡o";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Cidade",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a cidade do endere‡o";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@!",;
     /* titulo        */    "UF",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a sigla da unidade da federa‡„o";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@R 99999-999",;
     /* titulo        */    "CEP",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Entre com o CEP relativo ao endere‡o";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@R (!999)!!99-9999",;
     /* titulo        */    "Fone",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o telefone";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Ramal",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o ramal da pessoa de contato";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Contato",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o nome da pessoa|de contato";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@R (!999)!99-9999",;
     /* titulo        */    "Fax",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero do Fax|se houver";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Tipo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "9",;
     /* titulo        */    "Codcre",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Rg",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Profis",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "@D",;
     /* titulo        */    "Dtnasc",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Nacio",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "",;
     /* titulo        */    "Natu",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_CAMPO],{;            // CLIENTES
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[01,O_FORMULA],{;          // CLIENTES - Turismo
     /* form mostrar  */    "LEFT(TRAN(FIR_01F9(turis),[]),02)",;
     /* lin da formula*/    6,;
     /* col da formula*/    49;
                         };
)

sistema[02]={;
            "Apartamentos",;                                // opcao do menu
            "Apartamentos",;                                // titulo do sistema
            {"STR(apto,04,00)"},;                           // chaves do arquivo
            {"Apto"},;                                      // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "APTOS",;                                       // nome do DBF
            {"APTOS1"},;                                    // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,7,3,17,76},;                               // num telas/tela atual/coordenadas
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"liberado=[S]","N„o ‚ possivel apagar este apartamento|pois n„o est  Liberado"},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "9999",;
     /* titulo        */    "Apartamento",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "apto>0.and.APT_07F9(apto)~APARTAMENTO n„o aceit vel|ou APARTAMENTO dentro da faixa de eventuais",;
     /* help do campo */    "Informe o n£mero do Apartamento";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "@!",;
     /* titulo        */    "Liberado",;
     /* cmd especial  */    "MTAB([SIM|NAO|RESERVADO],[LIBERADO])",;
     /* default       */    "[S]",;
     /* pre-validacao */    "",;
     /* validacao     */    "liberado $ [SNR]~Necess rio informar LIBERADO",;
     /* help do campo */    "Informe se o Apartamento|est  Liberado ou nÆo|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99",;
     /* titulo        */    "Tipo",;
     /* cmd especial  */    "VDBF(6,59,20,77,'TIPO',{'codigo','tipo'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(tipo,02,00),'TIPO',1)~TIPO n„o existe na tabela",;
     /* help do campo */    "Informe o Tipo do Apartamento|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "",;
     /* titulo        */    "Descri‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Descri‡Æo do Apartamento|se houver";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99",;
     /* titulo        */    "Categoria 1",;
     /* cmd especial  */    "VDBF(6,55,20,77,'CATEG',{'codigo','categoria','pax'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!Empty(categ1).AND.PTAB(STR(categ1,02,00),'CATEG',1)~CATEGORIA 1 n„o existe na tabela",;
     /* help do campo */    "Informe a Categoria que o Apartamento|pode assumir|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99",;
     /* titulo        */    "Categoria 2",;
     /* cmd especial  */    "VDBF(6,55,20,77,'CATEG',{'codigo','categoria','pax'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "Empty(categ2).or.PTAB(STR(categ2,02,00),'CATEG',1)~CATEGORIA 2 n„o existe na tabela",;
     /* help do campo */    "Informe a Categoria que o Apartamento|pode assumir|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99",;
     /* titulo        */    "Categoria 3",;
     /* cmd especial  */    "VDBF(6,55,20,77,'CATEG',{'codigo','categoria','pax'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "Empty(categ3).or.PTAB(STR(categ3,02,00),'CATEG',1)~ ",;
     /* help do campo */    "Informe a Categoria que o Apartamento|pode assumir|se houver|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99",;
     /* titulo        */    "Categoria 4",;
     /* cmd especial  */    "VDBF(6,55,20,77,'CATEG',{'codigo','categoria','pax'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "Empty(categ4).Or.PTAB(STR(categ4,02,00),'CATEG',1)~ ",;
     /* help do campo */    "Informe a Categoria que o Apartamento|pode assumir|se houver|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99",;
     /* titulo        */    "Categoria 5",;
     /* cmd especial  */    "VDBF(6,55,20,77,'CATEG',{'codigo','categoria','pax'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "Empty(categ5).Or.PTAB(STR(categ5,02,00),'CATEG',1)~ ",;
     /* help do campo */    "Informe a Categoria que o Apartamento|pode assumir|se houver|F8 Tabela Pick";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "",;
     /* titulo        */    "Observa‡„o de Bloqueio",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe porque o apartamento foi bloqueado";
                         };
)
AADD(sistema[02,O_CAMPO],{;            // APTOS
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - categoria 1
     /* form mostrar  */    "LEFT(TRAN(APT_01F9(categ1),[]),10)",;
     /* lin da formula*/    6,;
     /* col da formula*/    9;
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - categoria 2
     /* form mostrar  */    "LEFT(TRAN(APT_02F9(categ2),[]),10)",;
     /* lin da formula*/    6,;
     /* col da formula*/    27;
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - categoria 3
     /* form mostrar  */    "LEFT(TRAN(APT_03F9(categ3),[]),10)",;
     /* lin da formula*/    6,;
     /* col da formula*/    45;
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - categoria 4
     /* form mostrar  */    "LEFT(TRAN(APT_04F9(categ4),[]),10)",;
     /* lin da formula*/    8,;
     /* col da formula*/    9;
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - categoria 5
     /* form mostrar  */    "LEFT(TRAN(APT_05F9(categ5),[]),10)",;
     /* lin da formula*/    8,;
     /* col da formula*/    27;
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - Tipo
     /* form mostrar  */    "LEFT(TRAN(TIPO->tipo,[]),10)",;
     /* lin da formula*/    4,;
     /* col da formula*/    28;
                         };
)
AADD(sistema[02,O_FORMULA],{;          // APTOS - Liberado
     /* form mostrar  */    "LEFT(TRAN(APT_06F9(liberado),[]),08)",;
     /* lin da formula*/    4,;
     /* col da formula*/    12;
                         };
)


sistema[03]={;
            "Hospedes",;                                    // opcao do menu
            "Hospedes",;                                    // titulo do sistema
            {"identidad","nome","STR(codigo,10,00)"},;      // chaves do arquivo
            {"Identidade","Nome","Codigo"},;                // titulo dos indices para consulta
            {"02","03","01"},;                              // ordem campos chaves
            "HOSPEDES",;                                    // nome do DBF
            {"HOSPEDE1","HOSPEDE2","HOSPEDE3"},;            // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,6,1,19,80},;                               // num telas/tela atual/coordenadas
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"ativo!='S'","N„o ‚ poss¡vel apagar este hospede|pois o mesmo est  hospedado."},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Identidad",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(identidad)~Identidade Inv lida",;
     /* help do campo */    "Informe o n£mero da identidade do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(nome)~Necess rio informar NOME",;
     /* help do campo */    "Informe o Nome do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Profissao",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Profiss„o do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "@D",;
     /* titulo        */    "Dtcad",;
     /* cmd especial  */    "",;
     /* default       */    "date()",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtcad)~Necess rio informar DTCAD",;
     /* help do campo */    "Informe a data de cadastro do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "@D",;
     /* titulo        */    "Dtnasc",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a data de nascimento do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "99",;
     /* titulo        */    "Idade",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "HOS_02F9(dtnasc)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Idade do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "9",;
     /* titulo        */    "Estado Civil",;
     /* cmd especial  */    "MTAB([1-SOLTEIRO|2-CASADO|3-SEPARADO|4-DIVORCIADO|5-AMASIADO],[ESTADO CIVIL])",;
     /* default       */    "2",;
     /* pre-validacao */    "",;
     /* validacao     */    "estcivil>0~ESTCIVIL n„o aceit vel",;
     /* help do campo */    "Informe o Estado Civil do Hospede|F8 tabela Pick";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Ender",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Endere‡o do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "99999",;
     /* titulo        */    "N£mero",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero do residencia";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Bairro",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o nome do Bairro do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Cidade",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o nome da Cidade do Hospede";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "@!",;
     /* titulo        */    "UF",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Unidade Federativa";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "@R 99999-999",;
     /* titulo        */    "CEP",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o CEP";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Pais",;
     /* cmd especial  */    "",;
     /* default       */    "[BRASIL]",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o nome do Pa¡s";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "@R (!999)!!99-9999",;
     /* titulo        */    "Fone",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero do telefone";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "",;
     /* titulo        */    "Ativo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[03,O_CAMPO],{;            // HOSPEDES
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[03,O_FORMULA],{;          // HOSPEDES - Estado Civil
     /* form mostrar  */    "LEFT(TRAN(HOS_01F9(estcivil),[]),10)",;
     /* lin da formula*/    6,;
     /* col da formula*/    65;
                         };
)


sistema[04]={;
            "Tipos de Apto",;                               // opcao do menu
            "Tipos de Apartamento",;                        // titulo do sistema
            {"STR(codigo,02,00)"},;                         // chaves do arquivo
            {"C¢digo"},;                                    // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "TIPO",;                                        // nome do DBF
            {"TIPO1"},;                                     // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,3,19,23,63,6,13},;                         // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"VerDel([Tipo],[Aptos],[Tipo=codigo])","N„o ‚ poss¡vel apagar este tipo de apartamento|pois existe apartamento com|este tipo."},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[04,O_CAMPO],{;            // TIPO
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[04,O_CAMPO],{;            // TIPO
     /* mascara       */    "",;
     /* titulo        */    "Tipos de Apto",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(tipo)~Necess rio informar TIPOS DE APTO",;
     /* help do campo */    "Informe o Tipo a ser assumido|pelo Apartamento";
                         };
)
AADD(sistema[04,O_CAMPO],{;            // TIPO
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)


sistema[05]={;
            "Categoria do Apto",;                           // opcao do menu
            "Categoria do Apartamento",;                    // titulo do sistema
            {"STR(codigo,02,00)"},;                         // chaves do arquivo
            {"C¢digo"},;                                    // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "CATEG",;                                       // nome do DBF
            {"CATEG1"},;                                    // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,2,17,23,62,6,14},;                         // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"VerDel([Categ],[Aptos],[Categ1=codigo .or. Categ2=Codigo .or. Categ3=Codigo .or. Categ4=Codigo .or. Categ5=Codigo])",;// condicao de exclusao de registros
             "N„o ‚ poss¡vel apagar esta categoria pois|existe apartamento com esta categoria."},;
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[05,O_CAMPO],{;            // CATEG
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[05,O_CAMPO],{;            // CATEG
     /* mascara       */    "",;
     /* titulo        */    "Categoria",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(categoria)~Necess rio informar CATEGORIA",;
     /* help do campo */    "Informe a Categoria poss¡vel de ser|assumida pelo apartamento";
                         };
)
AADD(sistema[05,O_CAMPO],{;            // CATEG
     /* mascara       */    "9",;
     /* titulo        */    "Pax",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "pax>0~PAX n„o aceit vel",;
     /* help do campo */    "Informe o n£mero do pax|compat¡vel com a categoria";
                         };
)
AADD(sistema[05,O_CAMPO],{;            // CATEG
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)


sistema[06]={;
            "Tabela de Di rias",;                           // opcao do menu
            "Tabela de Di rias",;                           // titulo do sistema
            {"STR(tipo,02,00)+STR(categ,02,00)"},;          // chaves do arquivo
            {"Tipo e Categoria"},;                          // titulo dos indices para consulta
            {"0102"},;                                      // ordem campos chaves
            "PRECOS",;                                      // nome do DBF
            {"PRECOS1"},;                                   // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,2,17,23,69,6,14},;                         // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[06,O_CAMPO],{;            // PRECOS
     /* mascara       */    "99",;
     /* titulo        */    "Tipo do apartamento",;
     /* cmd especial  */    "VDBF(6,59,20,77,'TIPO',{'codigo','tipo'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(tipo,02,00),'TIPO',1)~TIPO DO APARTAMENTO n„o existe na tabela",;
     /* help do campo */    "Informe o tipo do apartamento|F8 Tabela Pick";
                         };
)
AADD(sistema[06,O_CAMPO],{;            // PRECOS
     /* mascara       */    "99",;
     /* titulo        */    "Categoria do Apartamento",;
     /* cmd especial  */    "VDBF(6,59,20,77,'CATEG',{'codigo','categoria'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(categ,02,00),'CATEG',1)~CATEGORIA DO APARTAMENTO n„o existe na tabela",;
     /* help do campo */    "Informe a categoria do apartamento|F8 Tabela Pick";
                         };
)
AADD(sistema[06,O_CAMPO],{;            // PRECOS
     /* mascara       */    "@E 99,999.99",;
     /* titulo        */    "Di ria",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "diaria>0~DIRIA n„o aceit vel",;
     /* help do campo */    "Informe o valor da di ria";
                         };
)
AADD(sistema[06,O_FORMULA],{;          // PRECOS - Tipos de Apto
     /* form mostrar  */    "LEFT(TRAN(TIPO->tipo,[]),10)",;
     /* lin da formula*/    {||l_a},;
     /* col da formula*/    8;
                         };
)
AADD(sistema[06,O_FORMULA],{;          // PRECOS - Categoria
     /* form mostrar  */    "LEFT(TRAN(CATEG->categoria,[]),10)",;
     /* lin da formula*/    {||l_a},;
     /* col da formula*/    26;
                         };
)


sistema[07]={;
            "Tipo de Despesa",;                             // opcao do menu
            "Tipo de Despesa",;                             // titulo do sistema
            {"STR(codigo,02,00)"},;                         // chaves do arquivo
            {"Codigo"},;                                    // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "DEPARTA",;                                     // nome do DBF
            {"DEPARTA1"},;                                  // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,3,19,23,62,6,13},;                         // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"DEP_01F9(codigo).And.Par([Retyaguarda])=[N]","N„o ‚ poss¡vel apagar este Tipo de Despesa|pois existe movimento cadastrado com este|tipo de despesa"},;// condicao de exclusao de registros
            {"Par([Retaguarda])=[N]","N„o ‚ poss¡vel alterar apartir deste m¢dulo|somente pelo m¢dulo Retaguarda"},;// condicao de alteracao de registros
            {"Par([Retaguarda])=[N]","N„o ‚ poss¡vel recuperar apartir deste m¢dulo|somente pelo m¢dulo Retaguarda"};// condicao de recupercao de registros
           }

AADD(sistema[07,O_CAMPO],{;            // DEPARTA
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[07,O_CAMPO],{;            // DEPARTA
     /* mascara       */    "",;
     /* titulo        */    "Tipo de Despesa",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(tipodesp)~Necess rio informar TIPO DE DESPESA",;
     /* help do campo */    "Informe o Tipo de Despesa";
                         };
)
AADD(sistema[07,O_CAMPO],{;            // DEPARTA
     /* mascara       */    "9999",;
     /* titulo        */    "Centro de Custo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[07,O_CAMPO],{;            // DEPARTA
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)


sistema[08]={;
            "Cart”es de Cr‚dito",;                          // opcao do menu
            "Cart”es de Cr‚dito",;                          // titulo do sistema
            {"STR(codigo,02,00)"},;                         // chaves do arquivo
            {"codigo"},;                                    // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "CARTOES",;                                     // nome do DBF
            {"CARTOES1"},;                                  // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,5,18,23,62,6,11},;                         // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"VerDel([Cartoes],[Pagam],[TipoCart=Cartoes->codigo])","N„o ‚ poss¡vel apagar este cart„o pois|existe pagamento efetuado com este|cart„o."},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[08,O_CAMPO],{;            // CARTOES
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[08,O_CAMPO],{;            // CARTOES
     /* mascara       */    "",;
     /* titulo        */    "Nome do Cart„o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(nomecar)~Necess rio informar NOME DO CARTŽO",;
     /* help do campo */    "Informe o Nome do Cart„o de Cr‚dito";
                         };
)
AADD(sistema[08,O_CAMPO],{;            // CARTOES
     /* mascara       */    "99.99",;
     /* titulo        */    "Taxa",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "taxa>0~TAXA n„o aceit vel",;
     /* help do campo */    "Informe a Taxa do Cart„o";
                         };
)
AADD(sistema[08,O_CAMPO],{;            // CARTOES
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)


sistema[09]={;
            "Registro de Grupos",;                          // opcao do menu
            "Registro de Grupos",;                          // titulo do sistema
            {"STR(apto,04,00)+STR(codigo,10,00)"},;         // chaves do arquivo
            {"Por Apto\C¢digo"},;                           // titulo dos indices para consulta
            {"0102"},;                                      // ordem campos chaves
            "CURSO",;                                       // nome do DBF
            {"CURSO1"},;                                    // nomes dos NTX
            {"EXCUR"},;                                     // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,3,12,9,71},;                               // num telas/tela atual/coordenadas
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[09,O_CAMPO],{;            // CURSO
     /* mascara       */    "9999",;
     /* titulo        */    "Apartamento",;
     /* cmd especial  */    "VDBF(6,49,20,77,'REGISTRO',{'apto','dtent','hent'},2,'apto',[ativo=[S]])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "REGISTRO->ativo=[S].and.PTAB(STR(apto,04,00),'REGISTRO',2)~APARTAMENTO n„o aceit vel",;
     /* help do campo */    "Informe o n£mero do Apartamento Consentrador";
                         };
)
AADD(sistema[09,O_CAMPO],{;            // CURSO
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "REGISTRO->codigo",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[09,O_CAMPO],{;            // CURSO
     /* mascara       */    "@!",;
     /* titulo        */    "Movimento Normal",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[MOVIMENTO NORMAL])",;
     /* default       */    "[S]",;
     /* pre-validacao */    "",;
     /* validacao     */    "movimn$[SN]~Necess rio informar MOVIMENTO NORMAL",;
     /* help do campo */    "Informe se Apartamento consentrador|ir  consentrar o movimento normal";
                         };
)
AADD(sistema[09,O_CAMPO],{;            // CURSO
     /* mascara       */    "@!",;
     /* titulo        */    "Movimento Extra",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[MOVIMENTO EXTRA])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "movime$[SN]~MOVIMENTO EXTRA n„o aceit vel",;
     /* help do campo */    "Informe se o Apartamento consentrador|ir  consentrar o movimento extra";
                         };
)
AADD(sistema[09,O_CAMPO],{;            // CURSO
     /* mascara       */    "",;
     /* titulo        */    "Ativo",;
     /* cmd especial  */    "",;
     /* default       */    "[S]",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[09,O_FORMULA],{;          // CURSO - Mov. Normal
     /* form mostrar  */    "LEFT(TRAN(IIF(movimn=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    4,;
     /* col da formula*/    35;
                         };
)
AADD(sistema[09,O_FORMULA],{;          // CURSO - Mov. Extra
     /* form mostrar  */    "LEFT(TRAN(IIF(movime=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    4,;
     /* col da formula*/    49;
                         };
)


sistema[10]={;
            "Dependentes",;                                 // opcao do menu
            "Registro de Grupos - Dependentes",;            // titulo do sistema
            {"STR(apto,04,00)+STR(codigo,10,00)+STR(aptodepend,04,00)","STR(aptodepend,04,00)"},;// chaves do arquivo
            {"Por Apto\C¢d\Depen","Por Dependente"},;       // titulo dos indices para consulta
            {"010203","03"},;                               // ordem campos chaves
            "EXCUR",;                                       // nome do DBF
            {"EXCUR1","EXCUR2"},;                           // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {"CURSO->apto","CURSO->codigo"},;               // campos de relacionamento
            {1,1,9,19,23,62,6,7},;                          // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[10,O_CAMPO],{;            // EXCUR
     /* mascara       */    "9999",;
     /* titulo        */    "Apartamento",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[10,O_CAMPO],{;            // EXCUR
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[10,O_CAMPO],{;            // EXCUR
     /* mascara       */    "9999",;
     /* titulo        */    "Apartamento",;
     /* cmd especial  */    "VDBF(6,49,20,77,'REGISTRO',{'apto','dtent','hent'},2,'apto',[ativo=[S]])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "REGISTRO->ativo=[S].And.aptodepend!=CURSO->apto~APARTAMENTO n„o foi feito registro|ou igual ao apartamento consentrador",;
     /* help do campo */    "Informe o n£mero do Apartamento Dependente";
                         };
)
AADD(sistema[10,O_CAMPO],{;            // EXCUR
     /* mascara       */    "",;
     /* titulo        */    "Ativo",;
     /* cmd especial  */    "",;
     /* default       */    "[S]",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[10,O_CAMPO],{;            // EXCUR
     /* mascara       */    "!",;
     /* titulo        */    "Flag",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[10,O_FORMULA],{;          // EXCUR - Pax
     /* form mostrar  */    "LEFT(TRAN(REGISTRO->pax,[99]),02)",;
     /* lin da formula*/    {||l_a},;
     /* col da formula*/    24;
                         };
)
AADD(sistema[10,O_FORMULA],{;          // EXCUR - Chd
     /* form mostrar  */    "LEFT(TRAN(REGISTRO->chd,[99]),02)",;
     /* lin da formula*/    {||l_a},;
     /* col da formula*/    31;
                         };
)


sistema[11]={;
            "Controle de Reserva",;                         // opcao do menu
            "Controle de Reserva",;                         // titulo do sistema
            {"STR(codigo,10,00)","DTOS(dtreser)"},;         // chaves do arquivo
            {"C¢digo","Data"},;                             // titulo dos indices para consulta
            {"01","06"},;                                   // ordem campos chaves
            "RESERVA",;                                     // nome do DBF
            {"RESERVA1","RESERVA2"},;                       // nomes dos NTX
            {"RPES"},;                                      // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {2,1,3,0,22,79},;                               // num telas/tela atual/coordenadas
            {1,.f.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "99",;
     /* titulo        */    "Tipo de Apartamento",;
     /* cmd especial  */    "VDBF(6,59,20,77,'TIPO',{'codigo','tipo'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(tipo,02,00),'TIPO',1)~TIPO DE APARTAMENTO n„o existe na tabela",;
     /* help do campo */    "Informe o c¢digo do Tipo de Apartamento";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "99",;
     /* titulo        */    "Categoria do Apartamento",;
     /* cmd especial  */    "VDBF(6,55,20,77,'CATEG',{'codigo','categoria','pax'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(categoria,02,00),'CATEG',1)~CATEGORIA DO APARTAMENTO n„o existe na tabela",;
     /* help do campo */    "Informe o c¢digo da categoria do Apartamento";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "9999",;
     /* titulo        */    "Apto",;
     /* cmd especial  */    "VDBF(6,38,20,77,'APTOS',{'apto','liberado','descricao'},1,'apto',[(tipo=TIPO->codigo).And.(categ1=CATEG->codigo.or.categ2=CATEG->codigo.or.categ3=CATEG->codigo.or.categ4=CATEG->codigo.or.categ5=CATEG->codigo)])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(apto,04,00),'APTOS',1)~APTO n„o existe na tabela",;
     /* help do campo */    "Informe o n£mero do Apartamento|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "99",;
     /* titulo        */    "Pax",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "RES_06F9()",;
     /* validacao     */    "pax>0.AND.RES_05F9(Pax)~ ",;
     /* help do campo */    "Informe o n£mero de Pax";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "dtreser>=DataC.And.RES_03F9(dtreser)~Necess rio informar DATA DE RESERVA|ou DATA DE RESERVA menor que data de hoje.",;
     /* help do campo */    "Informe a Data de Reserva";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "If(empty(dtsai),.t.,dtsai>=dtreser.and.RES_04F9(dtsai))~Data de Sa¡da menor que Data de Entrada",;
     /* help do campo */    "Informe a Data prevista de sa¡da";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora de Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "Hora(Time())",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(hreser)~Necess rio informar HORA DE RESERVA",;
     /* help do campo */    "Informe para que Horas est |marcada a Reserva";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "9",;
     /* titulo        */    "Tratamento",;
     /* cmd especial  */    "MTAB([1-Normal|2-Vip|3-N£pcias],[TRATAMENTO])",;
     /* default       */    "[1]",;
     /* pre-validacao */    "",;
     /* validacao     */    "trata $ [123]~TRATAMENTO n„o aceit vel",;
     /* help do campo */    "Informe o tipo de Tratamento|que o hospede recebera|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo da Unidade Reserva",;
     /* cmd especial  */    "VDBF(6,49,20,77,'UNIDADE',{'codigo','unidade'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(unidade,02,00),'UNIDADE',1)~C¢DIGO DA UNIDADE RESERVA n„o existe na tabela",;
     /* help do campo */    "Informe o c¢digo da Unidade de Reserva|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Observa‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a observa‡„o|se houver";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "999",;
     /* titulo        */    "Desconto em Porcentagem",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Desconto em porcentagem|se houver";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@R 99,999.99",;
     /* titulo        */    "Desconto em valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "Empty(descporc)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o desconto em Valor";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@R 99,999.99",;
     /* titulo        */    "Pre‡o Especial",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Pre‡o Especial de Di ria|se houver";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Permuta",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[PERMUTA])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "permuta $ [SN]~PERMUTA n„o aceit vel",;
     /* help do campo */    "Informe S caso seja permuta|e N caso n„o seja permuta";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "9",;
     /* titulo        */    "Forma de Pagamento",;
     /* cmd especial  */    "MTAB([1-DINHEIRO|2-CARTŽO|3-CHEQUE|4-CHEQUE-PR‚|5-RDA|6-COBRAN€A|7-PERMUTA|8-NŽO ESPECIFICOU],[FORMA DE PAGAMENTO])",;
     /* default       */    "[8]",;
     /* pre-validacao */    "",;
     /* validacao     */    "formapag>0 .And. formapag<9~FORMA DE PAGAMENTO n„o aceit vel",;
     /* help do campo */    "Informe a Foma de Pagamento|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo do Cart„o Cr‚dito",;
     /* cmd especial  */    "VDBF(6,54,20,77,'CARTOES',{'codigo','nomecar'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "formapag=2",;
     /* validacao     */    "PTAB(STR(cartao,02,00),'CARTOES',1)~C¢DIGO DO CARTŽO CRDITO n„o existe na tabela",;
     /* help do campo */    "Informe o c¢digo do n£mero do cart„o de cr‚dito";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Cortesia",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[CORTESIA])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "cortesia $ [SN]~CORTESIA n„o aceit vel",;
     /* help do campo */    "Informe S caso tenha cortesia|e N caso n„o tenha cortesia";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Autoriza‡„o Cortesia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "cortesia=[S]",;
     /* validacao     */    "",;
     /* help do campo */    "Informe que autorizou a cortesia";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Faturamento Di ria",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[FATURAMENTO DIRIA])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "fatdiaria $ [SN]~FATURAMENTO DIRIA n„o aceit vel",;
     /* help do campo */    "Informe S caso seja faturado Di ria|mais outra despesa";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Faturamento Despesa",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "fatdiaria=[S]",;
     /* validacao     */    "If(!Empty(fatdiaria),!EMPT(fatdespesa),Empty(fatdespesa))~Necess rio informar FATURAMENTO DESPESA",;
     /* help do campo */    "Informe a outra despesa que vai ser faturado";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Somente Di ria",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[SOMENTE DIRIA])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "somentedia $ [SN]~SOMENTE DIRIA n„o aceit vel",;
     /* help do campo */    "Informe S caso seja faturado Somente a Di ria";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Diaria (C.P.)-(MAP)",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[DIARIA (C.P.)-(MAP)])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "diariacp $ [SN]~DIARIA (C.P.)-(MAP) n„o aceit vel",;
     /* help do campo */    "Informe S caso seja faturado Di rias (C.P.)-(MAP)";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Reservado por?",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe por quem foi feita a reserva";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "VDBF(6,18,20,77,'CLIENTES',{'nome','cgc'},3,'nome',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Nome da Firma|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Contato",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o nome da Pessoa de Contato";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "99999",;
     /* titulo        */    "Ramal",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Ramal da pessoa de contato";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@R (!999)!!99-9999",;
     /* titulo        */    "Fone",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero do telefone";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "VDBF(6,18,20,77,'CLIENTES',{'nome','cgc'},3,'nome',[turis='S'])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Nome da Firma|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Bonus",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[BONUS])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "bonus $ [SN]~BONUS n„o aceit vel",;
     /* help do campo */    "Informe S caso tenha bonus|e N caso n„o tenha bonus";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Recebido por ?",;
     /* cmd especial  */    "MTAB([1-TELEFONE|2-FAX|3-TELEX],[RECEBIDO POR ?])",;
     /* default       */    "[1]",;
     /* pre-validacao */    "",;
     /* validacao     */    "recebido $ [123]~RECEBIDO POR ? n„o aceit vel",;
     /* help do campo */    "Informe a forma como a reserva chegou|F8 Tabela Pick";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Noshow",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[NOSHOW])",;
     /* default       */    "[S]",;
     /* pre-validacao */    "",;
     /* validacao     */    "noshow $ [SN]~NOSHOW n„o aceit vel",;
     /* help do campo */    "Informe S caso tenha a garantia de noshow|e N caso n„o tenha garantia";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Solicita‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "DataC",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtsolicit)~Necess rio informar DATA DE SOLICITA€ŽO",;
     /* help do campo */    "Informe a Data de Solicita‡„o|da reserva";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora de Solicita‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "Hora(Time())",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(hsolicit)~Necess rio informar HORA DE SOLICITA€ŽO",;
     /* help do campo */    "Informe a Hora da Solicita‡„o";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "Usuario",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "",;
     /* titulo        */    "Autoriza‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "[GERˆNCIA]",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(autores)~Necess rio informar AUTORIZA€ŽO",;
     /* help do campo */    "Informe quem autorizou a Reserva";
                         };
)
AADD(sistema[11,O_CAMPO],{;            // RESERVA
     /* mascara       */    "@!",;
     /* titulo        */    "Efetivou Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Tipos de Apto
     /* form mostrar  */    "LEFT(TRAN(TIPO->tipo,[]),10)",;
     /* lin da formula*/    4,;
     /* col da formula*/    22;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Categoria
     /* form mostrar  */    "LEFT(TRAN(CATEG->categoria,[]),10)",;
     /* lin da formula*/    4,;
     /* col da formula*/    41;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Tratamento
     /* form mostrar  */    "LEFT(TRAN(RES_07F9(trata),[]),07)",;
     /* lin da formula*/    9,;
     /* col da formula*/    8;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Unidade de Rese
     /* form mostrar  */    "LEFT(TRAN(UNIDADE->unidade,[]),20)",;
     /* lin da formula*/    9,;
     /* col da formula*/    23;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Permuta
     /* form mostrar  */    "LEFT(TRAN(IIf(permuta=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    13,;
     /* col da formula*/    8;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Forma Pagamento
     /* form mostrar  */    "LEFT(TRAN(RES_08F9(formapag),[@!]),15)",;
     /* lin da formula*/    13,;
     /* col da formula*/    19;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Cortesia
     /* form mostrar  */    "LEFT(TRAN(IIF(cortesia=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    13,;
     /* col da formula*/    58;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - FatDiaria
     /* form mostrar  */    "LEFT(TRAN(IIf(fatdiaria=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    13;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - somentedia
     /* form mostrar  */    "LEFT(TRAN(IIf(somentedia=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    48;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - DiariaCP
     /* form mostrar  */    "LEFT(TRAN(IIf(DiariaCP=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    15,;
     /* col da formula*/    74;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - bonus
     /* form mostrar  */    "LEFT(TRAN(IIf(bonus=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    9,;
     /* col da formula*/    11;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - recebido
     /* form mostrar  */    "LEFT(TRAN(RES_09F9(recebido),[@!]),08)",;
     /* lin da formula*/    9,;
     /* col da formula*/    21;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - noshow
     /* form mostrar  */    "LEFT(TRAN(IIf(noshow=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    9,;
     /* col da formula*/    36;
                         };
)
AADD(sistema[11,O_FORMULA],{;          // RESERVA - Nome do Cart„o
     /* form mostrar  */    "LEFT(TRAN(CARTOES->nomecar,[]),15)",;
     /* lin da formula*/    13,;
     /* col da formula*/    40;
                         };
)


sistema[12]={;
            "Reserva - H¢spedes",;                          // opcao do menu
            "Reserva - H¢spedes",;                          // titulo do sistema
            {"STR(codigo,10,00)+STR(numero,02,00)"},;       // chaves do arquivo
            {"C¢digo"},;                                    // titulo dos indices para consulta
            {"0102"},;                                      // ordem campos chaves
            "RPES",;                                        // nome do DBF
            {"RPES1"},;                                     // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {"RESERVA->codigo"},;                           // campos de relacionamento
            {1,1,15,7,21,75},;                              // num telas/tela atual/coordenadas
            {1,.f.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[12,O_CAMPO],{;            // RPES
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[12,O_CAMPO],{;            // RPES
     /* mascara       */    "99",;
     /* titulo        */    "N£mero",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "numero>0~N£mero n„o aceit vel",;
     /* help do campo */    "";
                         };
)
AADD(sistema[12,O_CAMPO],{;            // RPES
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "VDBF(6,22,20,77,'HOSPEDES',{'nome','identidad'},2,'nome',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(nome)~Necess rio informar NOME",;
     /* help do campo */    "Informe o Nome do Hospede";
                         };
)
AADD(sistema[12,O_CAMPO],{;            // RPES
     /* mascara       */    "",;
     /* titulo        */    "Rg",;
     /* cmd especial  */    "",;
     /* default       */    "RPE_01F9(nome)",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(rg)~Necess rio informar RG",;
     /* help do campo */    "Informe o n£mero do R.G.";
                         };
)
AADD(sistema[12,O_CAMPO],{;            // RPES
     /* mascara       */    "!",;
     /* titulo        */    "Flag",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)


sistema[13]={;
            "Unidades de Reserva",;                         // opcao do menu
            "Unidades de Reserva",;                         // titulo do sistema
            {"STR(codigo,02,00)"},;                         // chaves do arquivo
            {"Por C¢digo"},;                                // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "UNIDADE",;                                     // nome do DBF
            {"UNIDADE1"},;                                  // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,5,17,22,63,6,10},;                         // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[13,O_CAMPO],{;            // UNIDADE
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo da Unidade",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[13,O_CAMPO],{;            // UNIDADE
     /* mascara       */    "",;
     /* titulo        */    "Unidade de Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(unidade)~Necess rio informar UNIDADE DE RESERVA",;
     /* help do campo */    "Informe a descri‡„o da Unidade de Reserva";
                         };
)
AADD(sistema[13,O_CAMPO],{;            // UNIDADE
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)

* \\ Final de MIL_ATRI.PRG
