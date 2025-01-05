#!/bin/bash

REMOTE_USER="labs"
REMOTE_HOST="83.222.10.148"
EMAIL="svyatoslav.klimov@outlook.com"
THRESHOLD=20

USAGE=$(ssh "$REMOTE_USER@$REMOTE_HOST" "df -h / | grep '/' | awk '{print \$5}' | sed 's/%//'")

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "Alarm! Free space on $REMOTE_HOST is ending. Used: $USAGE%" | \
    mail -s "Notification: not enough free space on $REMOTE_HOST" "$EMAIL"
fi
