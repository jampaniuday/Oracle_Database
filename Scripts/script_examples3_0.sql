

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





        rman target / <<EOF>> ${DIR_LOGS}/rman_script2_weekly_increLV0_${DATE}_${TIME}.log
        set echo on;
        ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system swith logfile';
        sql 'alter system checkpoint';
        sql 'alter database backup controlfile to trace as /backups/controlfile${DATE}_${TIME}.txt';

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${DIR_BKP_DAYS}/%F_${DATE}_${TIME}';
        BACKUP INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG  TAG 'weekly_increLV0_db_bkup' FORMAT '${DIR_BKP_DAYS}/%D_increLV0_${DATE}_${TIME}_%U_%T_%S_%P.bck';




#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://dbatricksworld.com/																					 #
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#https://www.ostechnix.com/find-size-directory-linux/															 #
#https://e-tinet.com/linux/crontab/ 																			 #
#****************************************************************************************************************#















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





        rman target / <<EOF>> ${DIR_LOGS}/rman_script2_daily_increLV1.sh${DATE}_${TIME}.log
        set echo on;
        ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system swith logfile';
        sql 'alter system checkpoint';
        sql 'alter database backup controlfile to trace as /backups/controlfile${DATE}_${TIME}.txt';

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${DIR_BKP_DAYS}/%F_${DATE}_${TIME}';
        BACKUP INCREMENTAL LEVEL 1 DATABASE PLUS ARCHIVELOG  FORMAT '${DIR_BKP_DAYS}/XE_increLV1_${DATE}_${TIME}_%U.bck';






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



 


---------------------------------------------------------------------------------------------------------------------------------------------------