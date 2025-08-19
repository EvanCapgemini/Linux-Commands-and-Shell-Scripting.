#!/bin/bash

# [TASK 1] Set Variables
targetDirectory=./project/target
destinationDirectory=./project/backup

# [TASK 2] Display Values
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# [TASK 3] Current Timestamp
currentTS=$(date +%s)

# [TASK 4] Set backupFileName
backupFileName="backup-$currentTS.tar.gz"

# [TASK 5] Define origAbsPath
origAbsPath=$(realpath $targetDirectory)

# [TASK 6] Define destAbsPath
destAbsPath=$(realpath $destinationDirectory)

# [TASK 7] Change Directory
cd $targetDirectory

# [TASK 8] Yesterday’s Timestamp
yesterdayTS=$((currentTS - 24*60*60))

# [TASK 9] List all Files and Directories
allFiles=$(ls)

# [TASK 10] IF Statement
toBackup=()
for file in $allFiles
do
  fileTS=$(date -r $file +%s)
  if [ $fileTS -ge $yesterdayTS ]
  then
    # [TASK 11] Add File
    toBackup+=($file)
  fi
done

# [TASK 12] Create Backup
tar -czvf $backupFileName ${toBackup[@]}

# [TASK 13] Move Backup
mv $backupFileName $destAbsPath

# [TASK 17]
# This cron job runs backup.sh every day at midnight
0 0 * * * /home/runner/<your-replit-project>/backup.sh
