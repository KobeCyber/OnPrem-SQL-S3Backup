# Configuration
# Change variables to match your speicfications
$DatabaseName = "AWSSQL"
$BackupFolder = "C:\SQLBackups"
$S3Bucket = "kobecyber-s3-sqlbucket"
$S3Prefix = "dailybackups/"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupFile = "$BackupFolder\$DatabaseName" + "_FULL_$Timestamp.bak"

# backup is created using sqlcmd
$sql = "BACKUP DATABASE [$DatabaseName] TO DISK = N'$BackupFile' WITH INIT, COMPRESSION;"
sqlcmd -Q $sql

# Upload to S3
aws s3 cp $BackupFile "s3://$S3Bucket/$S3Prefix"

# Optionally delete local file after upload
Remove-Item $BackupFile -Force
