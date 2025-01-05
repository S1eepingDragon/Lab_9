#!/bin/bash

REMOTE_USER="labs"
REMOTE_HOST="83.222.10.148"
EMAIL="svyatoslav.klimov@outlook.com"
SUBJECT="Update and reboot"

echo "Connection and update"

ssh "$REMOTE_USER@$REMOTE_HOST" << 'EOF'
    echo "Updating"
    sudo apt update && sudo apt upgrade -y
    
    if [ -f /var/run/reboot-required ]; then
        echo "Reboot is needed, rebooting"
        sudo reboot
    else
        echo "No reboot for you"
    fi
EOF


if ssh "$REMOTE_USER@$REMOTE_HOST" '[ -f /var/run/reboot-required ]'; then
    echo "Server was rebooted. Sending e-mail to $EMAIL."
    echo "$REMOTE_HOST updated and rebooted" | mail -s "$SUBJECT" "$EMAIL"
else
    echo "If there no reboot, there will be no e-mail"
fi

echo "Happy end"
