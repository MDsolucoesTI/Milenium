/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Empresa.: Denny Paulista Azevedo Filho
 \ Programa: HOTEL5.PRG
 \ Modulo..: SubMenu de Utilitarios
 \ Vers∆o..: 1.1
 \ Data....: 17-08-94
 \ Revis∆o.: 15-06-95
 \ Sistema.: MILENIUM - AutomaáÑo Hoteleira
 \ Funcao..: Defini escolha do menu disparando o m¢dulo necess†rio
 \ Analista: Denny Paulista Azevedo Filho
 \ Criacao.: Gerado pelo analista
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#INCLUDE 'INKEY.CH'
#INCLUDE 'ACHOICE.CH'
#INCLUDE 'BOX.CH'
#INCLUDE 'SETCURS.CH'

Private Arquivos1,Arquivos2,Bk_mem1:=1,Drive,Drive1,Dat_bk,Cabdados,Inicio
Private Flag1,Time_bk,Cancela,Repete,Erro,Fim,Arq_dbt,Fim_dbt,Last_disk
Private Flag,Gravado,Disco,Tam,Grv_arq,Disquete,Tot_arq,Num_arq,Copia
Private Ini_arq,Arq_des,Arq_fon,Dsk_free,F_size,Destino,Fonte,Fim_dbt
Private Num_arq1,Arq_frag,Bloc,Buffer,R_bytes,W_bytes,F,Cop_arq,Cont,Stop
Private Flag,Sn,Passo,Dest_cab,Texto,Arq_cab,W_cab,N_arq,H,Masc
Private Col_bar,Cor1,Xxx1,Xxx2,Num_fra,Disk_ctl,Dat_ctl,Hor_ctl,Fra,Arq_ant
Private Wdrive,Grv_prim,Vetor1,Vetor2,Fra_ctl1,Fra_ctl,Tam_ctl,Last_ctl
Private Arq_ctl,Mp1,Mp2,DISK_FREE,W_BYTE,ARR_TM
JANELA(01,02,52,15,77)
DO WHILE .T.
   NIVEL=1
   SET CURSOR OFF
   KEYBOARD "1"
   SETCOLOR(CORMUNO)
   OPC1=ACHOICE(03,53,14,76,M5,ML5,'VERMENU',1)
   DO CASE
      CASE OPC1 = 0
         EXIT
      CASE OPC1 = 1     //PLANO DE SENHAS
         DO HOT51
      Case Opc1 = 2    // Informecoes do Hotel
         Do Hot58
      Case Opc1 = 3  // Taxa de Servicos
         Do Hot59
      CASE OPC1 = 4    //ELIMINAR REGISTROS DELETADOS
         DO HOT55
      CASE OPC1 = 5    //RECUPERAR REG. DELETADOS
         DO HOT56
      CASE OPC1 = 6    //REFAZ INDICES
         DO HOT57
      Case Opc1 = 7   // Fazer Backup
         SELE 12
         DBGOTOP()
         IF DRIVE='A'
            BK_MEM1=0
         ELSEIF DRIVE='B'
            BK_MEM1=1
         ENDIF
         IF TRAVARQ()
            Do Hot52
            CLOSE ALL
            ABREARQ()
         ENDIF
      Case Opc1 = 8   // Fazer Restoure
         SELE 12
         DBGOTOP()
         IF DRIVE='A'
            BK_MEM1=0
         ELSEIF DRIVE='B'
            BK_MEM1=1
         ENDIF
         IF TRAVARQ()
            Do Hot53
            ABREARQ()
         ENDIF
      Case OPc1 = 9   // Mudar Drive
         Do Hot54
      CASE OPC1 = 10  // Calculadora
         DO CALC
      CASE OPC1 = 11 //CALENDARIO
         DO CALEN
      CASE OPC1 = 12  //COLCHOES
         DO HOT510
   ENDCASE
ENDDO
JANELA(2)
RETURN

//FUNCAO FECHA E ABRE ARQUIVOS PARA BACKUP

FUNCTION TRAVARQ(X)

LOCAL ORDEM

JANELA(1,11,15,15,66,"Fechamento de Arquivos")
@ 14,17 SAY 'Aguarde um momento - Executando o Processamento'
ORDEM=.F.
SELE 01
IF TRAV()
   CLOSE
ENDIF
SELE 02
IF TRAV()
   CLOSE
ENDIF
SELE 03
IF TRAV()
   CLOSE
ENDIF
SELE 04
IF TRAV()
   CLOSE
ENDIF
SELE 05
IF TRAV()
   CLOSE
ENDIF
SELE 06
IF TRAV()
   CLOSE
ENDIF
SELE 07
IF TRAV()
   CLOSE
ENDIF
SELE 08
IF TRAV()
   CLOSE
ENDIF
SELE 09
IF TRAV()
   CLOSE
ENDIF
SELE 10
IF TRAV()
   CLOSE
ENDIF
SELE 11
IF TRAV()
   CLOSE
ENDIF
SELE 12
IF TRAV()
   CLOSE
ENDIF
SELE 13
IF TRAV()
   CLOSE
ENDIF
SELE 14
IF TRAV()
   CLOSE
ENDIF
ORDEM=.T.
JANELA(02)
RETURN(ORDEM)

//FUNCAO TRAVA TODO O REGISTRO

FUNCTION TRAV()
DO WHILE .T.
   IF FLOCK()
      RETURN(.T.)
   ELSE
      MENS('Arquivo sendo utilizado !!!')
   ENDIF
   IF LASTKEY()=K_ESC
      MENS('Operacao cancelada !!!')
      JANELA(02)
      RETURN(.F.)
   ENDIF
ENDDO
