#!/bin/bash

if [ $# -ne 1 ]; then
    echo "인수가 1개가 아닙니다."
    exit 1
fi

user="$1"

while true; do
    for var in $(who | awk '{print $1}'); do
        if [ "$var" = "$user" ]; then
            echo "$var 로그인함!"
        fi
    done
    sleep 60
done
