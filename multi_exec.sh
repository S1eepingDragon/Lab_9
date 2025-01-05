#!/bin/bash

REMOTE_USER="labs"
EMAIL="svyatoslav.klimov@outlook.com"
SERVERS_FILE="servers_list.txt"
COMMAND=$1
LOG_FILE="/tmp/ssh_command_log_$(date +%Y-%m-%d_%H-%M-%S).log"

while IFS= read -r REMOTE_HOST; do
    echo "Ececuting on: $REMOTE_HOST" | tee -a "$LOG_FILE"
    ssh "$REMOTE_USER@$REMOTE_HOST" "$COMMAND" >> "$LOG_FILE" 2>&1
    echo "------------------------" | tee -a "$LOG_FILE"
done < "$SERVERS_FILE"
