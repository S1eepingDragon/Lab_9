#!/bin/bash

REMOTE_USER="labs"
REMOTE_HOST="83.222.10.148"
EMAIL="svyatoslav.klimov@outlook.com"
LOAD_THRESHOLD=5.0

CURRENT_LOAD=$(ssh "$REMOTE_USER@$REMOTE_HOST" "uptime | awk -F'load average:' '{print \$2}' | cut -d',' -f1 | xargs")

if (( $(echo "$CURRENT_LOAD > $LOAD_THRESHOLD" | bc -l) )); then
    ssh "$REMOTE_USER@$REMOTE_HOST" "ps aux --sort=-%cpu | head -n 6 | awk 'NR>1 {print \$2}' | xargs -I{} sudo kill -9 {}"
    echo "CPU load on $REMOTE_HOST is higher ($CURRENT_LOAD > $LOAD_THRESHOLD). processes was shutted down." | \
    mail -s "High CPU load on $REMOTE_HOST" "$EMAIL"
fi
