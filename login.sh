#!/bin/bash

if [$* -eq "1"] ;then
    echo "인수가 1개가 아닙니다."
  exit 1
fi

while [A -eq 100]
do
  for var in $(who | cut -f1)
    do
      echo "$var 로그인함!"
    done
  sleep 60
done
