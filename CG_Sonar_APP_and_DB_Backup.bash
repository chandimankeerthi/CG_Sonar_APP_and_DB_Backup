////////app backup////////

#!/bin/bash
DATE=$(date +"%F")					
APP_BACKUP_PATH="/usr/local/sonar/sonarqube-7.9.3/"
BACKUP_LOCATION="/usr/local/sonar/sonarqube-7.9.3/APP_BACKUP"
old_app_bkp_count=$(find /usr/local/sonar/sonarqube-7.9.3/APP_BACKUP -mtime +1 -type f | wc -l)

echo "There are $old_app_bkp_count backup files available at $BACKUP_LOCATION"
echo "Deleting files older than 1 day on $BACKUP_LOCATION dir"
find /usr/local/sonar/sonarqube-7.9.3/APP_BACKUP -mtime +1 -type f -delete
echo "Deleted files older than 1 day"

echo "Move to the Backup Location"
cd "$APP_BACKUP_PATH"
echo "Start the Database Export"
tar -czvf "${APP_BACKUP_PATH}/sonar_app_backup_${DATE}.bak.tar.gz" bin/ conf/ COPYING data/ elasticsearch/ extensions/ lib/ logs/ QualityCode temp/ web/  
echo "Export Completed"

echo "Moving file to the $BACKUP_LOCATION location "
mv sonar_app_backup_${DATE}.bak.tar.gz /usr/local/sonar/sonarqube-7.9.3/APP_BACKUP
exit 0




/////////////////////////////////////////DB BACKUP//////////////////////////////////////////////////////////////////////////////////////////                

#!/bin/bash
DATE=$(date +"%F")		

DB_BACKUP_PATH="/home/postgres/DB_BACKUP"			
DB_BACKUP_COMMAND="/usr/local/pgsql/bin/pg_dump sonar"
old_db_bkp_count=$(find /home/postgres/DB_BACKUP -mtime +1 -type f | wc -l)

echo "There are $old_db_bkp_count backup file available at $DB_BACKUP_PATH dir"
echo "Deleting files older than 1 day on $DB_BACKUP_PATH dir"
find /home/postgres/DB_BACKUP -mtime +1 -type f -delete
echo "Deleted files older than 1 day"

echo "Move to the Backup Location"
cd "$DB_BACKUP_PATH"
echo "Start the Database Export"
${DB_BACKUP_COMMAND} > sonar_db_backup_${DATE}.bak.tar.gz  
echo "Export Completed"

mv sonar_db_backup_${DATE}.bak.tar.gz <movinglocation> (move db dump)

exit 0





//////////////////////////////////////////////////////////////////////


#!/bin/bash

#Postgres db backup script


tday=`date +%d-%m-%Y_%H-%M-%S`
backup_path=~/db_backups/


dbname="sonar"
username="sonar"

cd backup_path

echo "Starting db backup."
/usr/local/pgsql/bin/pg_dump $dbname > sonar_dbdump_$tday.sql
echo "Database backup completed."

echo "Archiving the dump file started."
cd $backup_path
tar -czvf sonar_dbbackup_$tday.tar.gz sonar_dbbackup_$tday.sql
echo "Archiving completed."
rm -rf sonar_dbbackup_$tday.sql
echo "Dumpfile deleted."

echo "Deleting daily backups older than 7 days.."
find $backup_path -maxdepth 1 -mtime +7 -name "sonar_dbbackup_*" -exec rm -rf '{}' ';'
echo "Job completed."









