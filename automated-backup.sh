#!/bin/bash

# This is an example of a Bash automation script using cron jobs.
# This script will run every day at 8:00 AM and perform a backup of a specific directory.

# Directory path to backup
DIRECTORY="/path/to/directory"

# Destination path for the backup
DESTINATION="/path/to/destination"

# Remote server path
SERVER="user@server:/remote/path"

# Backup file name
DATE=$(date +"%Y%m%d")
BACKUP_NAME="backup_$DATE.tar.gz"

# Create the backup
tar -czvf "$DESTINATION/$BACKUP_NAME" "$DIRECTORY"

# Check if the backup was created successfully
if [ $? -eq 0 ]; then
  echo "Backup created successfully."
  
  # Send the backup to the remote server using rsync
  rsync -avz "$DESTINATION/$BACKUP_NAME" "$SERVER"
  
  # Check if the transfer was successful
  if [ $? -eq 0 ]; then
    echo "Backup sent to the remote server successfully."
  else
    echo "Error sending the backup to the remote server."
  fi
else
  echo "Error creating the backup."
fi

# Delete the backup file
rm "$DESTINATION/$BACKUP_NAME"

# Check if the backup file was deleted successfully
if [ $? -eq 0 ]; then
  echo "Backup file deleted successfully."
else
  echo "Error deleting the backup file."
fi
