#!/bin/bash

# 전화번호부 파일
PHONEBOOK="phonebook.txt"

# 지역번호 배열 (최소 5개)
AREA_CODES=("02" "031" "032" "051" "053")
AREAS=("서울" "경기" "인천" "부산" "대구")

# 입력값 검증
if [ "$#" -ne 2 ]; then
    echo "Error: 정확히 2개의 인수를 전달해야 합니다."
    exit 1
fi

NAME=$1
PHONE=$2

# 전화번호 형식 자동 변환
if [[ $PHONE =~ ^[0-9]{10,11}$ ]]; then
    if [[ ${#PHONE} -eq 10 ]]; then
        PHONE="${PHONE:0:2}-${PHONE:2:4}-${PHONE:6:4}"
    elif [[ ${#PHONE} -eq 11 ]]; then
        if [[ ${PHONE:0:2} == "02" ]]; then
            PHONE="${PHONE:0:2}-${PHONE:2:4}-${PHONE:6:4}"
        else
            PHONE="${PHONE:0:3}-${PHONE:3:4}-${PHONE:7:4}"
        fi
    fi
fi

# 전화번호 형식 검증
if ! [[ $PHONE =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]; then
    echo "Error: 전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)"
    exit 1
fi

# 지역번호 찾기
AREA=""
for i in "${!AREA_CODES[@]}"; do
    if [[ $PHONE == ${AREA_CODES[$i]}* ]]; then
        AREA=${AREAS[$i]}
        break
    fi
done

if [ -z "$AREA" ]; then
    echo "Error: 유효한 지역번호가 아닙니다."
    exit 1
fi

# 전화번호부에 이름 검색
MATCHED_LINE=$(grep "^$NAME " "$PHONEBOOK")
if [ -n "$MATCHED_LINE" ]; then
    OLD_PHONE=$(echo $MATCHED_LINE | awk '{print $2}')
    if [ "$OLD_PHONE" == "$PHONE" ]; then
        echo "전화번호부에 동일한 번호가 이미 존재합니다."
        exit 0
    else
        sed -i "/^$NAME /d" "$PHONEBOOK"
        echo "기존 번호를 새 번호로 갱신합니다."
    fi
fi

# 전화번호 추가
echo "$NAME $PHONE $AREA" >> "$PHONEBOOK"

# 이름순으로 정렬
sort -o "$PHONEBOOK" "$PHONEBOOK"

echo "전화번호부에 새로운 번호를 추가했습니다."
exit 0