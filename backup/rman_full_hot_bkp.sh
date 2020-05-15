#***************************************************************************************
# $Header:     rman_full_hot_bkp.sh                                                    *
# **************************************************************************************
# * Author:         Ahmed Abdel Fattah                                                 *
# **************************************************************************************
# * DESCRIPTION:    Take rman full hot backup(incremental level 0 )                    *
# * PLATFORM:	    Linux/Solaris/HP-UX/AIX                                            *
# **************************************************************************************

#!/bin/bash

# Check the login user to be "oracle"
# ------------------------------------
usr=`id |cut -d"(" -f2 | cut -d ")" -f1`

if [ $usr != "oracle" ]
then
	echo "You should login as oracle user"
	exit 1
fi

# Check that ORACLE_HOME was set
# ------------------------------
#oh=$ORACLE_HOME
#if [ -z $oh ]
#then
#	echo "You should set the oracle environment"
#	exit 1
#fi

# Check that the user passed one parameter
# ----------------------------------------

if [ $# -lt 1 ] ; then		#not given enough parameters to script
cat <<USAGEINFO

******************************************************************
** USAGE:  	   rman_full_hot_bkp.sh <SID>                       **
**    where <SID> Is the SID of Database to be backed up.       **
**                                                              **
** Prerequisits:                                                **
**  - Login as oracle user                                      **
**  - Ensure that the DB is open                                **
**  - Ensure that the DB is in the archivelog mode              **
**  - Configure FRA , if not already configured                 **
******************************************************************

USAGEINFO
	exit 1
fi

# Set the Oracle Environment
# ---------------------------
export ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/dbhome_1
export ORACLE_SID=$1
export PATH=$ORACLE_HOME/bin:$PATH:.
oh=$ORACLE_HOME

dt="_`date '+%Y%m%d'`"
sid=$1
lg="/backup/$sid/log/rman_full_hot$dt.log"
#lg="/home/oracle/$sid/log/rman_full_hot$dt.log"

echo Script $0 >> $lg
echo >> $lg
echo ========== started on `date` ========== >> $lg
echo   "ORACLE_SID:    $sid" >> $lg
echo   "ORACLE_USER:   $usr" >> $lg
echo   "ORACLE_HOME:   $oh" >> $lg
echo   "RMAN Log File: $lg" >> $lg
echo ============================================================ >> $lg

rman msglog $lg append << EOF
connect target /
set echo on;
configure controlfile autobackup on;

run
{
sql "alter session set nls_date_format=''dd-mm-yyyy hh24:mi:ss''";
allocate channel c1 device type disk ;
allocate channel c2 device type disk ;
allocate channel c3 device type disk ;
allocate channel c4 device type disk ;
backup  as compressed backupset incremental level 0 database tag 'weekly_hot_backup' plus archivelog tag 'weekly_hot_backup';
#backup current controlfile tag 'weekly_control';
release channel c1 ;
release channel c2 ;
release channel c3 ;
release channel c4 ;
}
exit
EOF

echo ========== Completed at `date` ========== >> $lg
