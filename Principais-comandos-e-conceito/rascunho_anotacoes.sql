
---------------------------------------------------------------------------------------------------------------------------------
Tasks:


1- Guest Addicional CD
2- DISPLAY- "OK"
3- SwingBeanch- OK
4- DBA_SCHEDULER_JOBS
5- Scripts- OK
6- RLWRAP -OK
7- Command nohup -OK
8- Listener -OK (solve just create tns.ora with netmgr -> service ) 








---------------------------------------------------------------------------------------------------------------------------------
6- RLWRAP 



su -
cd /opt
tar -xvf rlwrap_0.41.orig.tar.gz
cd rlwrap*
./configure
make 
make check
make install

exit 
su - oracle 


configurar .bash_profile
#Aliasing rlwrap
alias rl_sqlplus='rlwrap sqlplus'
alias rl_rman='rlwrap rman'
alias rl_asmcmd='rlwrap asmcmd'
#end Aliasing rlwrap

#setar o .bash_profile
. .bash_profile

#test
rl_sqlplus / as sysdba




refes:https://www.youtube.com/watch?v=KGUha05urxk&t=14s
      https://oracle-base.com/articles/linux/rlwrap
      http://utopia.knoware.nl/~hlub/uck/rlwrap/
      http://www.dba-oracle.com/t_rlwrap.htm
      https://src.fedoraproject.org/repo/pkgs/rlwrap/rlwrap-0.41.tar.gz/2b570314a4f40a7818d156c158636ba9/
      *download: https://launchpad.net/ubuntu/+source/rlwrap/0.41-1build2 -> rlwrap_0.41.orig.tar.gz







---------------------------------------------------------------------------------------------------------------------------------
Nohup

No hangup (Nohup) é um utilitário de linha de comando que mantém em execução comandos do Linux mesmo depois de desconectar sessões remotas SSH. Como ele faz parte do GNU coreutils você não precisa instalá-lo. Ele vem pré-instalado em todas as distribuições Linux 🙂


O uso é simples e fácil. Depois de entrar no seu sistema remoto via SSH, tudo o que você precisa fazer é:

nohup wget http://mirror.waia.asn.au/ubuntu-releases/xenial/ubuntu-16.04.2-desktop-amd64.iso &
Onde, você antecede ao comando desejado (no caso wget) o utilitário nohup. No final do comando, você usa o ‘&’ para indicar que o processo será executado em segundo plano (background). Durante a execução do comando um arquivo chamado ‘nohup.out’ é criado. Ele contém os logs de execução do comando.



Observe que é preciso colocar o comando em background utilizando o “&” no fim do comando. Caso você esqueça de colocá-lo, então pode usar o conjunto de teclas “CTRL+Z” e depois executar “bg” que o programa vai pra background também – enquanto não executar o `bg` o programa vai ficar parado.
Pronto!! Agora, você pode sair da sessão SSH. O comando remoto continuará funcionando até concluir sua tarefa – no caso baixar a imagem ISO do Ubuntu 🙂

Para mais informações sobre o comando nohup consulte a documentação oficial (man nohup)





refes: https://www.linuxdescomplicado.com.br/2017/07/saiba-como-manter-um-comando-executando-mesmo-depois-de-encerrar-uma-sessao-remota-ssh.html


---------------------------------------------------------------------------------------------------------------------------------
LISTENER | Database Net Services | Oracle Net Listener | listener.ora | tnsnames.ora | sqlnet.ora


Introduction to Oracle Listener


Oracle Listener, not depend oracle database. 
database can be down.


Database connection 
	-all incoming connections land on ORACLE LISTENER
	-its a seprare process that runs on database server
	-listener must be up for new connections
	-listener configuration file resides under:
		*$ $ORACLE_HOME/network/admin (file defaul listener.ora)
	-listener hands over new connetion to PMON
	-single listener can handle connection for multiple databases
	-you can configure multiple listener for single database for load balancing
	-you can configure multiple listeners for multiple databases



wornking with oracle listener
	-command to check listener is running at OS level:
		-# ps -ef| grep tns

	-command to connect listener utility 
		-#lsnrctl

	-checking listener configuration file
		- cat $ORACLE_HOME/network/admin/listener.ora



ORACLE LISTENER configuration
	-two types configuration: manual & netmgr utility

	-sample listner configuration file entry:
		SID_NAME
		ORACLE_HOME=dbhome
		SERVICE_NAME (orcl) select name from V$SERVICES; | select name from V$ACTIVE_SERVICES; | select * from global_name; | show parameter service;

			https://stackoverflow.com/questions/22399766/how-to-find-oracle-service-name

		ORACLE_HOSTNAME







oraenv





Using Oracle Net Manager(netmgr) to create a Service Name and Listener

https://www.youtube.com/watch?v=86WxgQdNTYU



refes:	https://www.youtube.com/watch?v=hoUeYgptyB4&t=756s
obs:
descriptions:

---------------------------------------------------------------------------------------------------------------------------------

SELECT TABLE_NAME FROM DBA_TABLES WHERE TABLESPACE_NAME = 'SOE';


select count(*) from SOE.CUSTOMERS;


---------------------------------------------------------------------------------------------------------------------------------



#Minuto (0 a 59) | Hora (0 a 23) | Dia (1 a 31) | Mês (1 a 12)| Dia da semana (0 a 7) | Comando (comando a ser executado)

#test
#* 0,4,8,12,16,20 * * * "/home/oracle/scripts/rman_script2_weekly_full.sh" > /dev/null


# executar:  00 seg | 23 horas | todos os dias | todos os meses | aos domingos
0 16 * * *  "/home/oracle/scripts/rman_script2_weekly_increLV0.sh"

# executar de segunda a sexta, nas horas: 6h, 12h,18h,00h
#0 6,12,18,0 * * 1-6 "/home/oracle/scripts/rman_script2_daily_increLV1.sh"




---------------------------------------------------------------------------------------------------------------------------------



BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'rman_weekly_increLV0',
   job_type           =>  'executable',
   job_action         =>  '/u01/scripts/rman_script2_weekly_increLV0.sh',
   repeat_interval    =>  'FREQ=weekly;byday=sun;BYHOUR=6;BYMINUTE=0', 
   enabled            =>    TRUE,
   auto_drop          =>   FALSE,
   comments           =>  'Job to run weekly incremental LVL0 backup');
END;
/




BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'rman_daily_increLV1',
   job_type           =>  'executable',
   job_action         =>  '/home/oracle/scripts/rman_script2_daily_increLV1.sh',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=6;BYMINUTE=0', 
   enabled            =>    TRUE,
   auto_drop          =>   FALSE,
   comments           =>  'Job to run daily incremental backup');
END;
/




DBMS_SCHEDULER.DROP_JOB (job_name => 'RMAN_WEEKLY_INCRELV0');



EXEC DBMS_SCHEDULER.RUN_JOB('SYS.RMAN_WEEKLY_INCRELV0');

SELECT owner, job_name, enabled FROM dba_scheduler_jobs;







BEGIN
	dbms_scheduler.drop_job(job_name => 'RMAN_DAILY_INCRELV1');
END;
/

BEGIN
	dbms_scheduler.drop_job(job_name => 'RMAN_WEEKLY_INCRELV0');
END;
/

---------------------------------------------------------------------------------------------------------------------------------



Scheduled Job Running Shell Script FailsWith ORA-27369

Applies to:

Oracle Server - Enterprise Edition -Version: 10.1.0.2 to 10.2.0.4

Oracle Server - Standard Edition -Version: 10.1.0.2 to 10.2.0.4

including Version:11.2.0.4

Sun Solaris SPARC (64-bit)

Linux x86

"ORA-27369: job of type EXECUTABLEfailed with exit code: Unknown error" was still occurring for non oracle users running DBMS_SCHEDULER executed shellscripts. Problem was fixed when filesystem where ORACLE_HOME was mountedon was found to have been mounted w/ nosetuid. Changing mount option to setuidresolved problem

Symptoms

@Checked for relevance on 16-MAY-2008

A Scheduler job has been configuredusing the DBMS_SCHEDULER package. The job executes a shell script using theoption job_type=>’EXECUTABLE’. The script performs a write operation to anoutput file, for example a redirect operation or touch. The write operationfails with:

ORA-27369: job of type EXECUTABLE failedwith exit code: Operation not permitted

 Or

ORA-27369: job of type EXECUTABLE failedwith exit code: 274662

Or

ORA-27369: job of type EXECUTABLE failedwith exit  code: Unknownerror

Indba_scheduler_job_run_details.additional_info, the following details arerecorded:

ORA-27369: job of type EXECUTABLE failedwith exit code: Operation not permitted

STANDARD_ERROR="touch: cannot touch`’: Permission denied"

Or

ORA-27369: job of type EXECUTABLE failedwith exit code: 274662

STANDARD_ERROR="Oracle Schedulererror: Config file is not owned by root or is

writable by group or other or extjob isnot setuid and owned by root"

Cause

If$ORACLE_HOME/rdbms/admin/externaljob.ora exists then external jobs run as theuser and group specified in this file, which by defaultis a lowly privileged user (nobody).

The user ‘nobody’ andthe group ‘nobody’ do not have the proper privileges for write operations.

As a result, themessage ‘Permission denied’ is returned when attempting to write to files.

Solution
Root access is required for the steps below.

1. Ensure the configuration file$ORACLE_HOME/rdbms/admin/externaljob.ora is owned by root:

# cd$ORACLE_HOME/rdbms/admin/

# chown rootexternaljob.ora

2. Ensure the file permissions arecorrectly set for $ORACLE_HOME/rdbms/admin/externaljob.ora.

Remove write privileges from group andother.

# chmod 640externaljob.ora

# ls -la externaljob.ora

-rw-r—– 1 root oinstall 1537 Sep 1309:24 externaljob.ora

3. Edit$ORACLE_HOME/rdbms/admin/externaljob.ora and set run_user to the OS accountthat owns the Oracle installation and the database and run_group to the OSgroup that owns the Oracle_Home.

Example:

OS account: oracle

OS group: oinstall

run_user = oracle

run_group = oinstall

 4. Ensure the setuid bit is set on the$ORACLE_HOME/bin/extjob executable.  Alsomake sure the filesystem is mounted with setuid option.

# cd$ORACLE_HOME/bin

# chown rootextjob

# chmod 4750extjob

# ls -la extjob

-rwsr-x— 1 root oinstall 64988 Mar 2918:22 extjob



转载于:https://blog.51cto.com/90sirdb/1791166



---------------------------------------------------------------------------------------------------------------------------------
#backup INCREMENTAL differencial level 1


#!/bin/bash
#

#****************************************************#
# NOME      : rman_script2_daily_increLV1.sh         #
# OBJETIVO  : Script to run daily incremental backup #
# CRIACAO   : 07-05-2020                             #
# VERSAO    : 1.0                                    #
# AUTOR     : Pedro Akira Danno Lima                 #
#****************************************************#


#Export envirements
# ------------------------------------
	#export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
	#export ORACLE_SID=orcl
	#PATH=$ORACLE_HOME/bin:$PATH
    #estao setadas no .bash_profile do usuario oracle 




#Check the login user to be "oracle"
# ------------------------------------

  USR=$(id |cut -d"(" -f2 | cut -d ")" -f1) #or command $id -un 

  if [ $USR != "oracle" ]
    then
      echo "You should login as oracle user"
      exit 1
  fi



#Variaveis
# ------------------------------------
        #localizacao do diretorio de backup
        RMANBACKUP_LOCATION=/backups

        #nome da instancia e banco de dados
        ORACLENAME=$ORACLE_SID

        #nome do diretorio backupset
        F_BACKUPSET=backupset

        #nome do diretoiro controlfile
        F_CONTROLFILE=controlfile

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")

        #localizacao do log de backup
        RMANLOG=/home/oracle/scripts/logs

        #criar diretorio para organizar backup
        DIR_BKP_DAYS=${RMANBACKUP_LOCATION}/${ORACLENAME}

        #criar diretorio para organizar logs da saida do scripts
        DIR_LOGS=${RMANLOG}/${ORACLENAME}/${DATE}


#Criacao de diretorio para organizar backups 		
# ------------------------------------
		if [ -d "${DIR_BKP_DAYS}/{${F_BACKUPSET},/${F_CONTROLFILE}}/${DATE}" ];then
			echo " o diretorio ${DIR_BKP_DAYS}/{${F_BACKUPSET},/${F_CONTROLFILE}}/${DATE} existe ja"
		else
			echo " o diretorio ${DIR_BKP_DAYS}/{${F_BACKUPSET},/${F_CONTROLFILE}}/${DATE} nao existe vamos criar o diretorio"
			mkdir -p ${DIR_BKP_DAYS}/{${F_BACKUPSET},/${F_CONTROLFILE}}/${DATE}
		fi



#Criacao de diretorio para organizar logs da saida do scripts 	
# ------------------------------------
		if [ -d "${DIR_LOGS}" ];then
			echo " o diretorio ${DIR_LOGS} existe ja"
		else
			echo " o diretorio ${DIR_LOGS} nao existe vamos criar o diretorio"
			mkdir -p ${DIR_LOGS}
		fi		



        rman target / <<EOF>> ${DIR_LOGS}/rman_script2_daily_increLV1${DATE}_${TIME}.log
        set echo on;
   
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system switch logfile';
        sql 'ALTER SYSTEM CHECKPOINT';
		

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${DIR_BKP_DAYS}/${F_CONTROLFILE}/${DATE}/%F_increLV1_${DATE}_${TIME}';
        BACKUP INCREMENTAL LEVEL 1 DATABASE TAG 'daily_increLV1_db_bkup'  FORMAT '${DIR_BKP_DAYS}/${F_BACKUPSET}/${DATE}/%d_increLV1_${DATE}_${TIME}_%s_%p.bck';






#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://dbatricksworld.com/																					 #
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#https://www.ostechnix.com/find-size-directory-linux/															 #
#https://e-tinet.com/linux/crontab/ 																			 #
#****************************************************************************************************************#



---------------------------------------------------------------------------------------------------------------------------------
DBMS_SCHEDULER | DBMS_JOB 

DBMS_SCHEDULER.CREATE_JOB | DBMS_SCHEDULER.CREATE_PROGRAM   | DBMS_SCHEDULER.create_schedule| DBMS_SCHEDULER.CREATE_WINDOW | DBMS_SCHEDULER.CREATE_CHAIN 


#Estrutura completa da package DBMS_SCHEDULER
DESC DBMS_SCHEDULER







refes: 
obs:
desc: 

---------------------------------------------------------------------------------------------------------------------------------
Executar scripts e exportar csv usando SQL*Plus


alter session set nls_timestamp_format='dd/mm/yyyy HH24:mi:ss';
alter session set nls_date_format='dd/mm/yyyy HH24:mi:ss';

set colsep ';'     -- Configura o separador de colunas como sendo ';'
set pagesize 0     -- Remove os cabeçalhos
set trimspool on   -- Remove os espaços em branco inseridos pelo sqlplus
set linesize X     -- Tamanho máximo que terá sua linha
set wrap off       -- Desabilita a quebra de linha. Cuidado pode cortar se for maior que linesize

spool output.csv   -- Configura o arquivo que será escrito







refes: https://makandracards.com/zeroglosa/40039-executar-scripts-e-exportar-csv-usando-sql-plus
obs:
desc: 

---------------------------------------------------------------------------------------------------------------------------------