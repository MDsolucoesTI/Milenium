/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: MIL_ATR1.PRG
 \ Data....: 18-09-96
 \ Sistema.: MILENIUM - Automa‡„o Hoteleira
 \ Funcao..: Define atributos dos arquivos (sistema[])
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: GAS-Pro v3.0 - modificado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include "milenium.ch"  // inicializa constantes manifestas


sistema[14]={;
            "Salas e Audit¢rios",;                          // opcao do menu
            "Salas e Audit¢rios",;                          // titulo do sistema
            {"STR(codigo,02,00)"},;                         // chaves do arquivo
            {"Por C¢digo"},;                                // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "SALAO",;                                       // nome do DBF
            {"SALAO1"},;                                    // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,6,18,20,63,6,7},;                          // num telas/tela atual/coordenadas/inicio scroll/qtde scroll
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[14,O_CAMPO],{;            // SALAO
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "1",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[14,O_CAMPO],{;            // SALAO
     /* mascara       */    "",;
     /* titulo        */    "Nome da Sala",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(descricao)~Necess rio informar Nome da Sala",;
     /* help do campo */    "Informe o nome da Sala";
                         };
)
AADD(sistema[14,O_CAMPO],{;            // SALAO
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)


sistema[15]={;
            "Reserva de Salas",;                            // opcao do menu
            "Reserva de Salas",;                            // titulo do sistema
            {"DTOS(data)+hora"},;                           // chaves do arquivo
            {"Por Data/Hora"},;                             // titulo dos indices para consulta
            {"0102"},;                                      // ordem campos chaves
            "AGENDA",;                                      // nome do DBF
            {"AGENDA1"},;                                   // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,3,6,21,75},;                               // num telas/tela atual/coordenadas
            {1,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@D",;
     /* titulo        */    "Data",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(data)~Necess rio informar DATA",;
     /* help do campo */    "Informe para que Data esta|sendo reservado a sala";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(hora)~Necess rio informar HORA",;
     /* help do campo */    "Informe para que horas esta|sendo reservado a sala";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo da Sala",;
     /* cmd especial  */    "VDBF(6,54,20,77,'SALAO',{'codigo','descricao'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(sala,02,00),'SALAO',1).and.AGE_02F9()~C¢DIGO DA SALA n„o existe na tabela",;
     /* help do campo */    "Informe o c¢digo da Sala|F8 Tabela Pick";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Desocupa‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "data",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(datalib)~Necess rio informar DATA DE DESOCUPA€ŽO",;
     /* help do campo */    "Informe a Data prevista de Desocupa‡„o";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora de Desocupa‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(horalib).and.AGE_01F9()~Necess rio informar HORA DE DESOCUPA€ŽO",;
     /* help do campo */    "Informe a Hora de Desocupa‡„o";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "VDBF(6,18,20,77,'CLIENTES',{'nome','cgc'},3,'nome',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(empresa)~Necess rio informar EMPRESA",;
     /* help do campo */    "Informe o Nome da Empresa que est |reservando a sala";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@R (!999)!!99-9999",;
     /* titulo        */    "Telefone",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Telefone da Empresa";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "99999",;
     /* titulo        */    "Ramal",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Ramal da pessoa de contato";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "",;
     /* titulo        */    "Contato",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o nome da pessoa de contato";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@!",;
     /* titulo        */    "Coffee Break",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[COFFEE BREAK])",;
     /* default       */    "[N]",;
     /* pre-validacao */    "",;
     /* validacao     */    "coffee $ [SN]~COFFEE BREAK n„o aceit vel",;
     /* help do campo */    "Informe S caso haja Coffee Break|e N caso ja haja";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "",;
     /* titulo        */    "Descri‡„o Coffee Break",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "coffee=[S]",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a descri‡„o do Coffee Break";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "DataC",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(datareser)~Necess rio informar DATA DE RESERVA",;
     /* help do campo */    "Informe a Data em que foi|feita a reserva";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora Reserva",;
     /* cmd especial  */    "",;
     /* default       */    "Hora(Time())",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(horareser)~Necess rio informar HORA RESERVA",;
     /* help do campo */    "Informe a Hora em que foi|feita a reserva";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "",;
     /* titulo        */    "Autorizou",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe quem autorizou a reserva";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "",;
     /* titulo        */    "Observa‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe uma observa‡„o|se houver";
                         };
)
AADD(sistema[15,O_CAMPO],{;            // AGENDA
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "Usuario",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[15,O_FORMULA],{;          // AGENDA - Nome da Sala
     /* form mostrar  */    "LEFT(TRAN(SALAO->descricao,[]),15)",;
     /* lin da formula*/    4,;
     /* col da formula*/    43;
                         };
)
AADD(sistema[15,O_FORMULA],{;          // AGENDA - Coffee Break
     /* form mostrar  */    "LEFT(TRAN(IIf(coffee=[S],[IM],[ŽO]),[@!]),02)",;
     /* lin da formula*/    11,;
     /* col da formula*/    27;
                         };
)


sistema[16]={;
            "Manuten‡„o de Registro",;                      // opcao do menu
            "Manuten‡„o de Registro",;                      // titulo do sistema
            {"STR(codigo,10,00)","STR(apto,04,00)","DTOS(dtent)","STR(firmaage,04,00)"},;// chaves do arquivo
            {"C¢digo","Apartamento","Data Entrada","Firmas"},;// titulo dos indices para consulta
            {"01","02","06","10"},;                         // ordem campos chaves
            "REGISTRO",;                                    // nome do DBF
            {"REGISTR1","REGISTR2","REGISTR3","REGISTR4"},;// nomes dos NTX
            {"CONREGIS"},;                                  // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,0,2,16,78},;                               // num telas/tela atual/coordenadas
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"1=2","N„o ‚ permitido fazer exclus„o|neste m¢dulo"},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "9999",;
     /* titulo        */    "Apto",;
     /* cmd especial  */    "VDBF(6,62,20,77,'APTOS',{'apto','liberado','tipo'},1,'apto',[liberado='S'])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "apto>0.AND.PTAB(STR(apto,04,00),'APTOS',1)~APTO n„o existe na tabela",;
     /* help do campo */    "Informe o n£mero do Apartamento";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "99",;
     /* titulo        */    "Pax",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "pax>0~PAX n„o aceit vel",;
     /* help do campo */    "Informe o n£mero de Pax";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "99",;
     /* titulo        */    "Chd",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero de crian‡as";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora Entrada",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(hent)~Necess rio informar HORA ENTRADA",;
     /* help do campo */    "Informe a Hora de Entrada do Hospede";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Entrada",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtent)~Necess rio informar DATA DE ENTRADA",;
     /* help do campo */    "Informe a Data de Entrada";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "@!",;
     /* titulo        */    "Movimento Normal",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "movimn$[CI]~Necess rio informar MOVIMENTO NORMAL",;
     /* help do campo */    "Informe se o Movimento|‚ Conjunto ou Individual";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "@!",;
     /* titulo        */    "Movimento Extra",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "movime$[CI]~MOVIMENTO EXTRA n„o aceit vel",;
     /* help do campo */    "Informe se o Movimento Extra|‚ Conjunto ou Individual";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "",;
     /* titulo        */    "Ativo",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[ATIVO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "ativo $ [SN]~ATIVO n„o aceit vel",;
     /* help do campo */    "";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "9999",;
     /* titulo        */    "Firma/Agente",;
     /* cmd especial  */    "VDBF(6,14,20,77,'CLIENTES',{'nome','cgc','turis'},2,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(firmaage,07,00),'CLIENTES',2)~FIRMA/AGENTE n„o existe na tabela",;
     /* help do campo */    "Informe o C¢digo da Firma ou Agente|F8 Tabela Pick";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "9999",;
     /* titulo        */    "Intermedi rio",;
     /* cmd especial  */    "VDBF(6,14,20,77,'CLIENTES',{'nome','cgc','turis'},2,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "Empty(interm) .or. PTAB(STR(interm,07,00),'CLIENTES',2)~ ",;
     /* help do campo */    "Informe o C¢digo do Intermedi rio|se houver|F8 Tabela Pick";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtsai)~Necess rio informar DATA DE SA¡DA",;
     /* help do campo */    "Informe a Data de Sa¡da";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora de Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(hsai)~Necess rio informar HORA DE SA¡DA",;
     /* help do campo */    "Informe a Hora de Sa¡da";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "",;
     /* titulo        */    "Operador de Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[16,O_CAMPO],{;            // REGISTRO
     /* mascara       */    "99999999",;
     /* titulo        */    "Ref.Tabelas",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[16,O_FORMULA],{;          // REGISTRO - Nome da Firma
     /* form mostrar  */    "LEFT(TRAN(REG_01F9(firmaage),[]),35)",;
     /* lin da formula*/    9,;
     /* col da formula*/    14;
                         };
)
AADD(sistema[16,O_FORMULA],{;          // REGISTRO - Nome Interm
     /* form mostrar  */    "LEFT(TRAN(REG_02F9(interm),[]),35)",;
     /* lin da formula*/    11,;
     /* col da formula*/    14;
                         };
)
AADD(sistema[16,O_FORMULA],{;          // REGISTRO - Tp Mov. Normal
     /* form mostrar  */    "LEFT(TRAN(REG_03F9(movimn),[]),09)",;
     /* lin da formula*/    6,;
     /* col da formula*/    47;
                         };
)
AADD(sistema[16,O_FORMULA],{;          // REGISTRO - Tp. Mov. Extra
     /* form mostrar  */    "LEFT(TRAN(REG_04F9(movime),[]),09)",;
     /* lin da formula*/    6,;
     /* col da formula*/    61;
                         };
)


sistema[17]={;
            "Manuten‡„o de Registro",;                      // opcao do menu
            "Manuten‡„o de Registro",;                      // titulo do sistema
            {"STR(codigo,10,00)+STR(codhosp,10,00)"},;      // chaves do arquivo
            {"C¢digo+CodHosp"},;                            // titulo dos indices para consulta
            {"0102"},;                                      // ordem campos chaves
            "CONREGIS",;                                    // nome do DBF
            {"CONREGI1"},;                                  // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {"REGISTRO->codigo"},;                          // campos de relacionamento
            {1,1,8,5,23,77},;                               // num telas/tela atual/coordenadas
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "9999999999",;
     /* titulo        */    "Codigo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo Hospede",;
     /* cmd especial  */    "VDBF(6,22,20,77,'HOSPEDES',{'nome','identidad'},3,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "codhosp>0.AND.PTAB(STR(codhosp,10,00),'HOSPEDES',3)~C¢DIGO HOSPEDE n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "",;
     /* titulo        */    "Nome",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(nome)~Necess rio informar NOME",;
     /* help do campo */    "Informe o Nome do Hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "99999",;
     /* titulo        */    "N£mero da Fatura",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!Empty(RD)~N£MERO DA FATURA n„o aceit vel",;
     /* help do campo */    "Informe o N£mero da Fatura";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "",;
     /* titulo        */    "Obs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe uma Observa‡„o|se Houver";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "@!",;
     /* titulo        */    "Por Conta",;
     /* cmd especial  */    "MTAB([FIRMA|HOSPEDE],[POR CONTA])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "pconta$[FH]~POR CONTA n„o aceit vel",;
     /* help do campo */    "Informe se ‚ Por Conta do|Firma ou Hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "",;
     /* titulo        */    "£ltima Procedˆncia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe qual foi a £ltima|procedˆncia do Hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "",;
     /* titulo        */    "Pr¢ximo Destino",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Pr¢ximo Destino do Hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "9999999999.99",;
     /* titulo        */    "Valor Normal",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor da despesa Normal do hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "99999999.99",;
     /* titulo        */    "Valor Servi‡o Normal",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor de Servi‡o Normal";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "@E 99,999.99",;
     /* titulo        */    "Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "!Empty(vlnormal)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Valor do Desconto";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "999",;
     /* titulo        */    "Porcentagem",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "!Empty(vlnornal) .and. Empty(Finalnor)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe valor em Procentagem";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "9999999999.99",;
     /* titulo        */    "Valor Extra",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor da despesa extra do hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "99999999.99",;
     /* titulo        */    "Valor Servi‡o Extra",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor de Servi‡o Extra";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "@E 99,999.99",;
     /* titulo        */    "Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "!Empty(vlextra)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Valor do Desconto";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "999",;
     /* titulo        */    "Porcentagem",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "!Empty(vlextra) .and. Empty(Finalext)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe valor em Procentagem";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dtsai)~Necess rio informar DATA DE SA¡DA",;
     /* help do campo */    "Informe a Data de Sa¡da do Hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora de Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(hsai)~Necess rio informar HORA DE SA¡DA",;
     /* help do campo */    "Informe a Hora de Sa¡da do Hospede";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "",;
     /* titulo        */    "Ativo",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[ATIVO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "ativo $ [SN]~ATIVO n„o aceit vel",;
     /* help do campo */    "";
                         };
)
AADD(sistema[17,O_CAMPO],{;            // CONREGIS
     /* mascara       */    "!",;
     /* titulo        */    "Flag",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "I",;
     /* help do campo */    "";
                         };
)
AADD(sistema[17,O_FORMULA],{;          // CONREGIS - Por Conta
     /* form mostrar  */    "LEFT(TRAN(CON_01F9(pconta),[]),06)",;
     /* lin da formula*/    6,;
     /* col da formula*/    38;
                         };
)


sistema[18]={;
            "Manuten‡„o de Movimentos",;                    // opcao do menu
            "Manuten‡„o de Movimentos",;                    // titulo do sistema
            {"DTOS(datmov)","STR(codigo,10,00)+STR(codhosp,10,00)"},;// chaves do arquivo
            {"Data","Codigo+CodHosp"},;                     // titulo dos indices para consulta
            {"03","0102"},;                                 // ordem campos chaves
            "MOVIM",;                                       // nome do DBF
            {"MOVIM1","MOVIM2"},;                           // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,6,11,18,73},;                              // num telas/tela atual/coordenadas
            {2,.f.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "PTAB(STR(codigo,10,00),'REGISTRO',1)~C¢DIGO n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo Hospede",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "PTAB(STR(codhosp,10,00),'HOSPEDES',3)~C¢DIGO HOSPEDE n„o aceit vel",;
     /* help do campo */    "";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "@D",;
     /* titulo        */    "Data do Movimento",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(datmov)~Necess rio informar DATA DO MOVIMENTO",;
     /* help do campo */    "Informe a Data do Movimento";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora do Movimento",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(horamov)~Necess rio informar HORA DO MOVIMENTO",;
     /* help do campo */    "Informe a Hora do Movimento";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "9",;
     /* titulo        */    "Tipo de Movimento",;
     /* cmd especial  */    "MTAB([1-NORMAL|2-EXTRA],[TIPO DE MOVIMENTO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "tipomov>0 .and. tipomov<3~TIPO DE MOVIMENTO n„o aceit vel",;
     /* help do campo */    "Informe o Tipo de Movimento";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "99",;
     /* titulo        */    "Tipo de Despesa",;
     /* cmd especial  */    "VDBF(6,57,20,77,'DEPARTA',{'codigo','tipodesp'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "tipodesp>0.AND.PTAB(STR(tipodesp,02,00),'DEPARTA',1)~TIPO DE DESPESA n„o existe na tabela",;
     /* help do campo */    "Informe o Tipo de Despesa|F8 Tabela Pick";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "@!",;
     /* titulo        */    "Tipo de Opera‡„o",;
     /* cmd especial  */    "MTAB([NORMAL|DESCONTO],[TCON])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "tcon $ [ND]~ ",;
     /* help do campo */    "Informe se o este Movimento ‚ Normal ou Desconto|F8 Tabela Pick";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "@!",;
     /* titulo        */    "Estorno",;
     /* cmd especial  */    "MTAB([SIM|NŽO],[ESTORNO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "estorno $ [SN]~ESTORNO n„o aceit vel",;
     /* help do campo */    "Informe S caso seja estorno|e N caso n„o seja";
                         };
)
AADD(sistema[18,O_CAMPO],{;            // MOVIM
     /* mascara       */    "999999.99",;
     /* titulo        */    "Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "MOV_04F9(Valor,tcon,estorno)~ ",;
     /* help do campo */    "Informa o Valor da Despesa";
                         };
)
AADD(sistema[18,O_FORMULA],{;          // MOVIM - Apto
     /* form mostrar  */    "LEFT(TRAN(REGISTRO->apto,[9999]),04)",;
     /* lin da formula*/    6,;
     /* col da formula*/    4;
                         };
)
AADD(sistema[18,O_FORMULA],{;          // MOVIM - Nome Hospede
     /* form mostrar  */    "LEFT(TRAN(HOSPEDES->nome,[@!]),35)",;
     /* lin da formula*/    6,;
     /* col da formula*/    11;
                         };
)
AADD(sistema[18,O_FORMULA],{;          // MOVIM - Tipo Movimento
     /* form mostrar  */    "LEFT(TRAN(MOV_02F9(tipomov),[]),07)",;
     /* lin da formula*/    8,;
     /* col da formula*/    28;
                         };
)
AADD(sistema[18,O_FORMULA],{;          // MOVIM - Tipo de Despesa
     /* form mostrar  */    "LEFT(TRAN(DEPARTA->tipodesp,[]),12)",;
     /* lin da formula*/    8,;
     /* col da formula*/    46;
                         };
)
AADD(sistema[18,O_FORMULA],{;          // MOVIM - Tp Opera‡„o
     /* form mostrar  */    "LEFT(TRAN(MOV_01F9(tcon),[]),07)",;
     /* lin da formula*/    10,;
     /* col da formula*/    7;
                         };
)
AADD(sistema[18,O_FORMULA],{;          // MOVIM - Estorno ?
     /* form mostrar  */    "LEFT(TRAN(MOV_03F9(estorno),[]),02)",;
     /* lin da formula*/    10,;
     /* col da formula*/    23;
                         };
)


sistema[19]={;
            "Manuten‡„o de Pagamentos",;                    // opcao do menu
            "Manuten‡„o de Pagamentos",;                    // titulo do sistema
            {"STR(codigo,10,00)","STR(codigo,10,00)+STR(codhosp,10,00)"},;// chaves do arquivo
            {"C¢digo Registro","Codigo+CodHosp"},;          // titulo dos indices para consulta
            {"01","0102"},;                                 // ordem campos chaves
            "PAGAM",;                                       // nome do DBF
            {"PAGAM1","PAGAM2"},;                           // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,6,1,19,80},;                               // num telas/tela atual/coordenadas
            {2,.f.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "PTAB(STR(codigo,10,00),'REGISTRO',1)~C¢DIGO n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo Hospede",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "PTAB(STR(codhosp,10,00),'HOSPEDES',3)~C¢DIGO HOSPEDE n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "@D",;
     /* titulo        */    "Data do Pagamento",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(datamov)~Necess rio informar DATA DO PAGAMENTO",;
     /* help do campo */    "Informe a Data do Pagamento";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "9",;
     /* titulo        */    "Tipo de Movimento",;
     /* cmd especial  */    "MTAB([1-NORMAL|2-EXTRA],[TIPO DE MOVIMENTO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "tipomov>0 .and. tipomov<3~TIPO DE MOVIMENTO n„o aceit vel",;
     /* help do campo */    "Informe se o Movimento ‚ Normal ou Extra|F8 Tabela Pick";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "9",;
     /* titulo        */    "Forma de Pagamento",;
     /* cmd especial  */    "MTAB([1-DINHEIRO|2-CARTŽO|3-CHEQUE|4-CHEQUE-PR‚|5-RDA|6-COBRAN€A|7-PERMUTA],[FORMA DE PAGAMENTO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "formapag>0 .And. formapag<8~FORMA DE PAGAMENTO n„o aceit vel",;
     /* help do campo */    "Informe a Foma de Pagamento";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "99",;
     /* titulo        */    "Tipo de Cart„o",;
     /* cmd especial  */    "VDBF(6,46,20,77,'CARTOES',{'codigo','nomecar','taxa'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "Empty(tipocart).or.PTAB(STR(tipocart,02,00),'CARTOES',1)~TIPO DE CARTŽO n„o existe na tabela",;
     /* help do campo */    "Informe o Tipo de Cart„o";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "999999.99",;
     /* titulo        */    "Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Valor Pago pelo Hospede";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "",;
     /* titulo        */    "N£mero",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero do Cheque ou do Cart„o";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "9999",;
     /* titulo        */    "Banco",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o C¢digo do Banco";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "99999",;
     /* titulo        */    "Agˆncia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero da Agˆncia";
                         };
)
AADD(sistema[19,O_CAMPO],{;            // PAGAM
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[19,O_FORMULA],{;          // PAGAM - Apto
     /* form mostrar  */    "LEFT(TRAN(REGISTRO->apto,[9999]),04)",;
     /* lin da formula*/    6,;
     /* col da formula*/    4;
                         };
)
AADD(sistema[19,O_FORMULA],{;          // PAGAM - Nome Hospede
     /* form mostrar  */    "LEFT(TRAN(HOSPEDES->nome,[@!]),35)",;
     /* lin da formula*/    6,;
     /* col da formula*/    11;
                         };
)
AADD(sistema[19,O_FORMULA],{;          // PAGAM - Tipo Movimento
     /* form mostrar  */    "LEFT(TRAN(PAG_02F9(tipomov),[]),06)",;
     /* lin da formula*/    6,;
     /* col da formula*/    66;
                         };
)
AADD(sistema[19,O_FORMULA],{;          // PAGAM - Forma Pagamento
     /* form mostrar  */    "LEFT(TRAN(PAG_01F9(formapag),[]),10)",;
     /* lin da formula*/    8,;
     /* col da formula*/    8;
                         };
)
AADD(sistema[19,O_FORMULA],{;          // PAGAM - Tipo Cart„o
     /* form mostrar  */    "LEFT(TRAN(CARTOES->nomecar,[]),15)",;
     /* lin da formula*/    8,;
     /* col da formula*/    33;
                         };
)


sistema[20]={;
            "Manuten‡„o de Descontos",;                     // opcao do menu
            "Manuten‡„o de Descontos",;                     // titulo do sistema
            {"autor","STR(codigo,10,00)+STR(codhosp,10,00)"},;// chaves do arquivo
            {"Autoriza‡„o","Codigo+CodHosp"},;              // titulo dos indices para consulta
            {"08","0102"},;                                 // ordem campos chaves
            "DESCONTO",;                                    // nome do DBF
            {"DESCONT1","DESCONT2"},;                       // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,6,13,19,75},;                              // num telas/tela atual/coordenadas
            {2,.f.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "PTAB(STR(codigo,10,00),'REGISTRO',1)~C¢DIGO n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo Hospede",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "1=2",;
     /* validacao     */    "PTAB(STR(codhosp,10,00),'HOSPEDES',3)~C¢DIGO HOSPEDE n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "99999.99",;
     /* titulo        */    "Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Valor do Desconto";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "999",;
     /* titulo        */    "Porcentagem",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "Empty(Final)",;
     /* validacao     */    "",;
     /* help do campo */    "Informe valor em Procentagem";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "",;
     /* titulo        */    "Obs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe uma Observa‡„o|se houver";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "99",;
     /* titulo        */    "C¢digo de Tipo Despesa",;
     /* cmd especial  */    "VDBF(6,57,20,77,'DEPARTA',{'codigo','tipodesp'},1,'codigo',[])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "tipodesp>0.AND.PTAB(STR(tipodesp,02,00),'DEPARTA',1)~C¢DIGO DE TIPO DESPESA n„o existe na tabela",;
     /* help do campo */    "Informe o C¢digo do Tipo de Despesa|F8 Tabela Pick";
                         };
)
AADD(sistema[20,O_CAMPO],{;            // DESCONTO
     /* mascara       */    "",;
     /* titulo        */    "Autoriza‡„o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(autor)~Necess rio informar AUTORIZA€ŽO",;
     /* help do campo */    "Informe quem Autorizou";
                         };
)
AADD(sistema[20,O_FORMULA],{;          // DESCONTO - Apartamento
     /* form mostrar  */    "LEFT(TRAN(REGISTRO->apto,[9999]),04)",;
     /* lin da formula*/    6,;
     /* col da formula*/    4;
                         };
)
AADD(sistema[20,O_FORMULA],{;          // DESCONTO - Nome
     /* form mostrar  */    "LEFT(TRAN(HOSPEDES->nome,[]),35)",;
     /* lin da formula*/    6,;
     /* col da formula*/    11;
                         };
)
AADD(sistema[20,O_FORMULA],{;          // DESCONTO - Tipo de Despesa
     /* form mostrar  */    "LEFT(TRAN(DEPARTA->tipodesp,[]),12)",;
     /* lin da formula*/    11,;
     /* col da formula*/    9;
                         };
)


sistema[21]={;
            "Cheques-Pr‚-Datados",;                         // opcao do menu
            "Cheques-Pr‚-Datados",;                         // titulo do sistema
            {"ncheque+STR(banco,04,00)"},;                  // chaves do arquivo
            {"N£m_Che+Banco"},;                             // titulo dos indices para consulta
            {"0304"},;                                      // ordem campos chaves
            "CHEQUES",;                                     // nome do DBF
            {"CHEQUES1"},;                                  // nomes dos NTX
            {},;                                            // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {1,1,7,14,20,66},;                              // num telas/tela atual/coordenadas
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"",""},;                                       // condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(codigo,10,00),'REGISTRO',1)~C¢DIGO n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "9999999999",;
     /* titulo        */    "C¢digo do Hospede",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "PTAB(STR(codhosp,10,00),'HOSPEDES',3)~C¢DIGO DO HOSPEDE n„o existe na tabela",;
     /* help do campo */    "";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "999999999",;
     /* titulo        */    "N£mero do Cheque",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(ncheque).And.CHE_01F9()~Necess rio informar N£MERO DO CHEQUE",;
     /* help do campo */    "Informe o N£mero do Cheque";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "9999",;
     /* titulo        */    "Banco",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o c¢digo do banco|se houver";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "9999999.99",;
     /* titulo        */    "Valor",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "valor>0~VALOR n„o aceit vel",;
     /* help do campo */    "Informe o Valor do Cheque";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "@D",;
     /* titulo        */    "Data de Emiss„o",;
     /* cmd especial  */    "",;
     /* default       */    "Date()",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dataemis)~Necess rio informar DATA DE EMISSŽO",;
     /* help do campo */    "";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "@D",;
     /* titulo        */    "Data Pr‚-Datada",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(datapre)~Necess rio informar DATA PR-DATADA",;
     /* help do campo */    "Informe a Data Pr‚-Datada";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "9",;
     /* titulo        */    "Tipo Movimento",;
     /* cmd especial  */    "MTAB([1-NORMAL|2-EXTRA],[TIPO MOVIMENTO])",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "tipomov>0~TIPO MOVIMENTO n„o aceit vel",;
     /* help do campo */    "Informe o Tipo de Movimento|F8 Tabela Pick";
                         };
)
AADD(sistema[21,O_CAMPO],{;            // CHEQUES
     /* mascara       */    "",;
     /* titulo        */    "Operador",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "V",;
     /* help do campo */    "";
                         };
)
AADD(sistema[21,O_FORMULA],{;          // CHEQUES - Nome
     /* form mostrar  */    "LEFT(TRAN(HOSPEDES->nome,[]),35)",;
     /* lin da formula*/    6,;
     /* col da formula*/    11;
                         };
)
AADD(sistema[21,O_FORMULA],{;          // CHEQUES - Apto
     /* form mostrar  */    "LEFT(TRAN(REGISTRO->apto,[9999]),04)",;
     /* lin da formula*/    6,;
     /* col da formula*/    4;
                         };
)
AADD(sistema[21,O_FORMULA],{;          // CHEQUES - Tipo  Movimento
     /* form mostrar  */    "LEFT(TRAN(CHE_03F9(tipomov),[]),06)",;
     /* lin da formula*/    11,;
     /* col da formula*/    25;
                         };
)


sistema[22]={;
            "Manuten‡„o do B.M.D.",;                        // opcao do menu
            "Manuten‡„o do B.M.D.",;                        // titulo do sistema
            {"DTOS(data)"},;                                // chaves do arquivo
            {"Data"},;                                      // titulo dos indices para consulta
            {"01"},;                                        // ordem campos chaves
            "BMD",;                                         // nome do DBF
            {"BMD1"},;                                      // nomes dos NTX
            {"ACUMULO"},;                                   // nome dos dbf's relacionados
            {},;                                            // campos de relacionamento
            {2,1,0,-1,24,80},;                              // num telas/tela atual/coordenadas
            {2,.t.},;                                       // nivel acesso/tp chave
            {},;                                            // campos do arquivo
            {},;                                            // formula mostradas
            {"1=2","N„o ‚ permitido excluir neste m¢dulo"},;// condicao de exclusao de registros
            {"",""},;                                       // condicao de alteracao de registros
            {"",""};                                        // condicao de recupercao de registros
           }

AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@D",;
     /* titulo        */    "Data",;
     /* cmd especial  */    "",;
     /* default       */    "DataC",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(data)~Necess rio informar DATA",;
     /* help do campo */    "Informe a Data do B.M.D.";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@D",;
     /* titulo        */    "Data Inicial",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(datai)~Necess rio informar DATA INICIAL",;
     /* help do campo */    "Informe a Data Inicial";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora Inicial",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(horai)~Necess rio informar HORA INICIAL",;
     /* help do campo */    "Informe a Hora Inicial";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@D",;
     /* titulo        */    "Data Final",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(dataf)~Necess rio informar DATA FINAL",;
     /* help do campo */    "Informe a Data Final";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@R 99:99",;
     /* titulo        */    "Hora Final",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "!EMPT(horaf)~Necess rio informar HORA FINAL",;
     /* help do campo */    "Informe a Hora Final";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Saldo do Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Saldo do Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Saldo Anterior",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Saldo Anterior";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Produ‡„o do Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor da Produ‡„o Fechada no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Dinheiro",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Dinheiro no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cheque",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a valor em cheque n„o Pr‚-Datado|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cheque-Pr‚-Datado",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cheque-Pr‚-Datado|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cart„o de Cr‚dito",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cart„o de Cr‚dito|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "R.D.A.",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em R.D.A.|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cobran‡a",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cobran‡a|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Permuta",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Permuta|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 9,999,999.99",;
     /* titulo        */    "Taxa de Servi‡o",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Taxa de Servi‡o";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Total Bruto",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Total Bruto";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Dinheiro por Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Procentagem em Dinheiro|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. cheque dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem de Cheques|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Cheque-Pr‚ Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Procentagem de Cheques-Pr‚-Datados|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Cart„o por  Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a Porcentagem de Cart„o|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc RDA por Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem de R.D.A.|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Cobran‡a Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem de Cobran‡a|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Permuta Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem de Permuta|no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Taxa do Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem da taxa de servi‡o|no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Dinheiro por mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em Dinheiro|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Cheque por Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em cheque n„o pr‚|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Cheque-Pr‚ Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em cheque-pr‚-datado|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. cart„o mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em cart„o|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc RDA mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em R.D.A.|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Cobran‡a no mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em Cobran‡a|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. Permuta no mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem em Premuta|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Porc. taxa mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe a porcentagem da taxa|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Dinheiro Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Dinhiro|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cheque Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cheque n„o pr‚|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cheque-Pr‚-Datado Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cheque-Pr‚-Datado|no Mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cart„o Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cart„o|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "R.D.A. Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em R.D.A.|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Cobran‡a Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Cobran‡a|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Permuta Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor em Permuta|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 9,999,999.99",;
     /* titulo        */    "Taxa mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor da Taxa|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Total bruto mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor do total|no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Apto entrada",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero de Apartamentos que|tiver„o a ocupa‡„o hoje";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Apto Sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero de Apartamento que |tiver„o sua sa¡da hoje";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Total de Apartamentos",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Total de Apartamentos Ocupados";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Apto total",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "informe o total de Apartamentos Ocupados";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Hospedes entrada",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero de pessoas que|se hospedar„o hoje";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Hospede sa¡da",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o n£mero de pessoas que|tiver„o sua sa¡da hoje";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Total de Hospede",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o Total de Hospedes";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "999",;
     /* titulo        */    "Hospede Total",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o total de pessoas hospededadas";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Di ria M‚dia Dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor m‚dio de Di ria no Dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Di ria M‚dia no Mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor M‚dio de Di ria no mˆs";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Receita M‚dia no dia",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor m‚dio de Receita no dia";
                         };
)
AADD(sistema[22,O_CAMPO],{;            // BMD
     /* mascara       */    "@E 999,999,999,999.99",;
     /* titulo        */    "Receita M‚dia no mˆs",;
     /* cmd especial  */    "",;
     /* default       */    "",;
     /* pre-validacao */    "",;
     /* validacao     */    "",;
     /* help do campo */    "Informe o valor M‚dio da Receita no mˆs";
                         };
)

* \\ Final de MIL_ATR1.PRG
