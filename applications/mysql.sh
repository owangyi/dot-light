#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing MySQL ]" $yellow   

brew install mysql@8.0
brew link --force mysql@8.0
brew services start mysql@8.0

# Wait for MySQL to start
sleep 3

# Set root password and authentication method
mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"

touch "$done_file"
