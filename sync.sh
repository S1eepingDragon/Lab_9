#!/bin/bash

REMOTE_USER="labs"
REMOTE_HOST="83.222.10.148"
EMAIL="svyatoslav.klimov@outlook.com"

LOCAL_DIR="/sync"
REMOTE_DIR="/home/labs/lab_9/sync"
EXCLUDE_FILE="/sync/excluded.txt"
LOG_FILE="/tmp/rsync_sync_$(date +%Y-%m-%d_%H-%M-%S).log"

rsync -avz --delete --exclude-from="$EXCLUDE_FILE" "$LOCAL_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" >> "$LOG_FILE" 2>&1
rsync -avz --delete --exclude-from="$EXCLUDE_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR/" >> "$LOG_FILE" 2>&1

mail -s "Sync report" "$EMAIL" < "$LOG_FILE"

rm "$LOG_FILE"
