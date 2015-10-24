#!/bin/zsh

#Assignment 4 - Mail Users
#Matt Knouff

#!/bin/bash

if [[ "$1" == "" ]]; then
  echo Usage: $0 \<user1\> \[\<user2\> \[...\]\]
  exit 1
fi

while [[ ! "$1" == "" ]]; do
  if [[ ! getent passwd $1 > /dev/null ]]; then
    echo "No such user: $1"
  fi
   
  if [[ who | cut -d " " -f 1 | grep "^$1\$" > /dev/null ]]; then
      echo "$*" is logged in
      mail "$*" << message
# "Hello `awk -F\: '{print $5}' /etc/passwd` please ignore this mail. My
# instructor requires that I send this message as part of an assignment
# for class 92.312. The current time and date is `date`. Have a 
# nice day `$USER`."
    else
      # user is not currently logged in
      echo "$*" is not logged in
    fi
  shift
done
