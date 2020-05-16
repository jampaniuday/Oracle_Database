

---------------------------------------------------------------------------------------------------------------------------------------------------
#backup INCREMENTAL differencial level 0 





#!/bin/bash
#

#************************************************#
# NOME      : rman_script2_weekly_increLV0.sh    #
# OBJETIVO  : Script to run weekly full backup   #
# CRIACAO   : 07-05-2020                         #
# VERSAO    : 1.0                                #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#


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





        rman target / <<EOF>> ${DIR_LOGS}/rman_script2_weekly_increLV0_${DATE}_${TIME}.log
        set echo on;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system switch logfile';
        sql 'ALTER SYSTEM CHECKPOINT';

	
        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${DIR_BKP_DAYS}/${F_CONTROLFILE}/${DATE}/%F_increLV0_${DATE}_${TIME}';
	      BACKUP INCREMENTAL LEVEL 0 DATABASE TAG 'weekly_increLV0_db_bkup' FORMAT '${DIR_BKP_DAYS}/${F_BACKUPSET}/${DATE}/%d_increLV0_${DATE}_${TIME}_%s_%p.bck';	

	exit

 
  #echo ========== Completed at ${DATE} ==========


#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://dbatricksworld.com/																					                                           #
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														                             #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								               #
#https://www.ostechnix.com/find-size-directory-linux/															                               #
#https://e-tinet.com/linux/crontab/ 																			                                       #
#****************************************************************************************************************#






mkdir -p /backups/ORCL/{backupset,/controlfile}/date




-p (–parents): a opção -p habilita a criação de diretórios parentes quando necessário;



mkdir -p {documentos/{imagens/{wallpapers/,icons/,fotos/}}}

mkdir -p /backups/ORCL/{backupset,/controlfile}/date


/backup/ORCL/controfile
/backup/ORCL/


{imagens/{wallpapers/,icons/,fotos/}




CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/u01/app/oracle/fast_recovery_area/%F';




/u01/app/oracle/fast_recovery_area/XE/backupset/2020_05_15/o1_mf_nnndf_TAG20200515T210114_hcycbby4_.bkp



SELECT * FROM V$FLASH_RECOVERY_AREA_USAGE;
DB_RECOVERY_FILE_DEST 
/disk1/flash_recovery_area

CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
CONFIGURE RETENTION POLICY TO NONE;

ALTER DATABASE ADD LOGFILE;

db_create_onlie_log_des_1 = '+FRA'

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
PATH=$ORACLE_HOME/bin:$PATH


#files Fast Recovery Are
	#CONTROLFILE 
	#ONLINELOG -> .log
	#ARCHIVELOG 
	#BACKUPPIECE 
	#IMAGECOPY 
	#FLASHBACKLOG 
	#backuppset
https://docs.oracle.com/cd/E11882_01/server.112/e18951/asmfiles.htm#OSTMG94200


Finalizado Control File and SPFILE Autobackup em 15/05/20

CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/u01/app/oracle/product/11.2.0/xe/dbs/snapcf_XE.f'; # default


---------------------------------------------------------------------------------------------------------------------------------------------------
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


#variaveis
        #localizacao do diretorio de backup
        RMANBACKUP_LOCATION=/backups

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")

        #localizacao do log de backup
        RMANLOG=/home/oracle/scripts/logs

        #criar diretorio para organizar backup
        DIR_BKP_DAYS=${RMANBACKUP_LOCATION}/${DATE}

        #criar diretorio para organizar logs da saida do scripts
        DIR_LOGS=${RMANLOG}/${DATE}


#criacao de diretorio para organizar backups 		
		if [ -d "${DIR_BKP_DAYS}" ];then
			echo " o diretorio ${DIR_BKP_DAYS} existe ja"
		else
			echo " o diretorio ${DIR_BKP_DAYS} nao existe vamos criar o diretorio"
			mkdir ${DIR_BKP_DAYS}
		fi


#criacao de diretorio para organizar logs da saida do scripts 	
		if [ -d "${DIR_LOGS}" ];then
			echo " o diretorio ${DIR_LOGS} existe ja"
		else
			echo " o diretorio ${DIR_LOGS} nao existe vamos criar o diretorio"
			mkdir ${DIR_LOGS}
		fi		



        rman target / <<EOF>> ${DIR_LOGS}/rman_script2_daily_increLV1${DATE}_${TIME}.log
        set echo on;
   
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system switch logfile';
        sql 'ALTER SYSTEM CHECKPOINT';
		

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${DIR_BKP_DAYS}/%F_increLV0_${DATE}_${TIME}';
        BACKUP INCREMENTAL LEVEL 1 DATABASE TAG 'daily_increLV1_db_bkup'  FORMAT '${DIR_BKP_DAYS}/%d_increLV0_${DATE}_${TIME}_%s_%p.bck';






#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://dbatricksworld.com/																					 #
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#https://www.ostechnix.com/find-size-directory-linux/															 #
#https://e-tinet.com/linux/crontab/ 																			 #
#****************************************************************************************************************#















---------------------------------------------------------------------------------------------------------------------------------------------------

#Minuto (0 a 59) | Hora (0 a 23) | Dia (1 a 31) | Mês (1 a 12)| Dia da semana (0 a 7) | Comando (comando a ser executado)

#test
#* 0,4,8,12,16,20 * * * "/home/oracle/scripts/rman_script2_weekly_full.sh" > /dev/null


# executar:  00 seg | 23 horas | todos os dias | todos os meses | aos domingos
0 0 * * 7  "/home/oracle/scripts/rman_script2_weekly_increLV0.sh"

# executar de segunda a sexta, nas horas: 6h, 12h,18h,00h
0 6,12,18,0 * * 1-6 "/home/oracle/scripts/rman_script2_daily_increLV1.sh"





---------------------------------------------------------------------------------------------------------------------------------------------------






V$DATABASE_BLOCK_CORRUPTION


A flash recovery area
A disk location in which the database can store and manage files related to backup
and recovery. You set the flash recovery area location and size with the DB_
RECOVERY_FILE_DEST and DB_RECOVERY_FILE_DEST_SIZE initialization
parameters.



BACKUP INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG  TAG 'weekly_increLV0_db_bkup' FORMAT '/backups/%D_increLV0_${TIME}_%U_%T_%S_%P.bck';
 

BACKUP INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG  TAG 'weekly_increLV0_db_bkup' FORMAT '/backups/%D_increLV0_%U_%T_%S_%P.bck






C:\Users\PedroAkira\Downloads\swingbench25971\swingbench



RUN
{ 
  ALLOCATE CHANNEL ch1 DEVICE TYPE DISK;
  ALLOCATE CHANNEL ch2 DEVICE TYPE DISK;
  ALLOCATE CHANNEL ch3 DEVICE TYPE DISK;
  BACKUP DATABASE PLUS ARCHIVELOG;
}







DBMS_SCHEDULER 










---------------------------------------------------------------------------------------------------------------------------------------------------
/BACKUPS

fdisk -l

fdisk /dev/sdb
	m
	n
	p
	1
	1
	enter
	w 



mkdir /backups
chown oracle /backups/
chgrp oracle /backups/


df -h

lsblk




mkfs.ext4 /dev/sdb1


mount  /dev/sdb1 /backups/









---------------------------------------------------------------------------------------------------------------------------------------------------

DBMS_SCHEDULER package 



Creating Jobs
You create one or more jobs using the DBMS_SCHEDULER.CREATE_JOB or DBMS_SCHEDULER.CREATE_JOBS procedures or Cloud Control.





begin
    dbms_scheduler.create_job(
        job_name        => 'DATABASE_VALIDATION_VIA_RMAN',
        job_type        => 'EXECUTABLE',
        job_action        => 'c:\rman\rman_validate.bat',
        start_date        => trunc(systimestamp)+4/24,
        repeat_interval        => 'FREQ=DAILY;BYHOUR=4;BYMINUTE=0',
        enabled            => false,
        comments        => 'Database validation job via RMAN validate command');
end;
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






exec dbms_scheduler.create_credential(credential_name => 'ORACLE_OS_CREDS',username => 'oracle', password => 'oracle');



BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'rman_weekly_increLV0',
   job_type           =>  'executable',
   job_action         =>  '/home/oracle/scripts/rman_script2_weekly_increLV0.sh',
   repeat_interval    =>  'FREQ=weekly;byday=sun;BYHOUR=6;BYMINUTE=0', 
   credential_name => 'ORACLE_OS_CREDS',
   enabled            =>    TRUE,
   auto_drop          =>   FALSE,
   comments           =>  'Job to run weekly incremental LVL0 backup');
END;
/





begin
     dbms_scheduler.run_job(job_name=>'RMAN_WEEKLY_INCRELV0'); -- true is default
end;
/

begin
     dbms_scheduler.run_job(job_name=>'RMAN_WEEKLY_INCRELV0',use_current_session => TRUE); -- true is default
end;
/







exec dbms_scheduler.create_credential(credential_name => 'ORACLE_OS_CREDS',username => 'oracle', password => 'oracle');


dbms_credential.create_credential(credential_name   => 'ORACLE_OS_CREDS',
                                  username          =>  'oracle',
                                  password          =>  'oracle',
                                  comments          => 'run scripts using oracle OS account');





 credential_name => 'ORACLE_OS_CREDS'


BEGIN
	exec dbms_scheduler.set_attribute(
		name => 'RMAN_WEEKLY_INCRELV0',
		start_date =>  systimestamp,
		 credential_name => 'ORACLE_OS_CREDS');
END;
/


BEGIN
  DBMS_SCHEDULER.DROP_JOB
  (
     job_name         => 'RMAN_WEEKLY_INCRELV0'
  );
END;
/





BEGIN
	dbms_scheduler.set_attribute(
		name => 'RMAN_WEEKLY_INCRELV0',
		start_date =>  systimestamp);
END;
/



commit;








RMAN_WEEKLY_INCRELV0




dbms_scheduler.set_attribute(
name => ‘RMAN_INCR0_BACKUP’,
attribute => ‘repeat_interval’,
value => ‘freq=weekly; byday=wed,sun; byhour=5; byminute=0; bysecond=0;’);
dbms_scheduler.enable( ‘RMAN_INCR0_BACKUP’ );
end;
/
commit;







-- Check the status of the job.


COLUMN job_name FORMAT A20
SELECT job_name, status, error#
FROM   user_scheduler_job_run_details
ORDER BY job_name;




   start_date        =>  systimestamp,





freq=weekly; byday=sun; byhour=6; byminute=0; bysecond=0;'');



freq=daily;byday=MON,TUE,WED,THU,FRI,SAT;byhour=8,13,18;byminute=0;bysecond=0;




BYDAY=MON,TUE,WED,THU,FRI;









SELECT JOB_NAME FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME = 'RMAN_WEEKLY_INCRELV0';





begin
    dbms_scheduler.run_job(job_name=>'RMAN_WEEKLY_INCRELV0'); -- true is default
end;
/



dbms_scheduler.run_job('RMAN_WEEKLY_INCRELV0', false);



begin
	dbms_scheduler.run_job('RMAN_WEEKLY_INCRELV0', false);
end;
/






SELECT JOB_NAME, REPEAT_INTERVAL FROM DBA_SCHEDULER_JOBS
WHERE JOB_NAME =  'RMAN_WEEKLY_INCRELV0';



XMLDB_NFS_CLEANUP_JOB



exec dbms_scheduler.create_credential(credential_name => 'oracle',username => 'oracle', password => 'oracle');


exec dbms_scheduler.create_job_class(job_class_name=> 'RUN_RMAN_JOB', service=> 'rmansec');


begin
dbms_scheduler.set_attribute(
name => RMAN_DAILY_INCRELV1,
attribute => 'repeat_interval',
value => 'freq=weekly; byday=sun; byhour=6; byminute=0; bysecond=0;'');
end;
/
commit;


 exec DBMS_SCHEDULER.CREATE_CREDENTIAL(credential_name=>'oracle', username=>'oracle', password=>'oracle', database_role=>'SYSDBA');



SELECT credential_name,username,database_role FROM dba_scheduler_credentials




SELECT SYSTIMESTAMP FROM DUAL;





---------------------------------------------------------------------------------------------------------------------------------------------------


.rman


   start_date        =>  systimestamp,





---------------------------------------------------------------------------------------------------------------------------------------------------


SELECT SYSTIMESTAMP FROM DUAL;










https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions173.htm

---------------------------------------------------------------------------------------------------------------------------------------------------

SELECT owner, job_name, enabled FROM dba_scheduler_jobs;






SELECT * FROM dba_scheduler_jobs WHERE JOB_NAME = 'RMAN_DAILY_INCRELV1';




BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'rman_daily_increLV1',
   job_type           =>  'executable',
   job_action         =>  '/home/oracle/scripts/rman_script2_daily_increLV1.sh',
   repeat_interval    =>  'FREQ=DAILY;INTERVAL=1', /* every other day */
   enabled            =>    TRUE,
   auto_drop          =>   FALSE,
   comments           =>  'Job to run daily incremental backup');
END;
/





	




DBMS_SCHEDULER.drop_job(job_name => 'RMAN_DAILY_INCRELV1');

SYS.DBMS_SCHEDULER.DROP_JOB (job_name => 'RMAN_DAILY_INCRELV1');


declare
   l_job_exists number;
begin
   select count(*) into l_job_exists
     from user_scheduler_jobs
    where job_name = 'STATISTICS_COLUMNS_JOB'
          ;

   if l_job_exists = 1 then
      dbms_scheduler.drop_job(job_name => 'RMAN_DAILY_INCRELV1');
   end if;
end;




https://oracle-base.com/articles/10g/scheduler-10g

---------------------------------------------------------------------------------------------------------------------------------------------------







enterprise menager 

https://192.168.15.175:1158/em/console/aboutApplication


192.168.15.175

system 
oracle




/etc/oratab




SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'SOE';


---------------------------------------------------------------------------------------------------------------------------------------------------