#!/bin/bash


SOURCE_DIR=$1
BACKUP_NAME=$(basename "$SOURCE_DIR")_$(date +%Y-%m-%d_%H-%M-%S).tar.gz
BACKUP_DIR="/tmp"
REMOTE_USER="labs"
REMOTE_HOST="83.222.10.148"
REMOTE_DIR="home/labs/lab_9/backups"


tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

scp "$BACKUP_DIR/$BACKUP_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_DIR && ls -tp | grep -v '/$' | tail -n +4 | xargs -I {} rm -- {}"

rm "$BACKUP_DIR/$BACKUP_NAME"

