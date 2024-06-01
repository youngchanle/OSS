#!/bin/bash

convert_month() {
    case "$(echo $1 | tr '[:upper:]' '[:lower:]')" in
        jan|january|1) echo "Jan" ;;
        feb|february|2) echo "Feb" ;;
        mar|march|3) echo "Mar" ;;
        apr|april|4) echo "Apr" ;;
        may|5) echo "May" ;;
        jun|june|6) echo "Jun" ;;
        jul|july|7) echo "Jul" ;;
        aug|august|8) echo "Aug" ;;
        sep|september|9) echo "Sep" ;;
        oct|october|10) echo "Oct" ;;
        nov|november|11) echo "Nov" ;;
        dec|december|12) echo "Dec" ;;
        *) echo "Invalid" ;;
    esac
}

is_leap_year() {
    year=$1
    if (( year % 4 == 0 )); then
        if (( year % 100 == 0 )); then
            if (( year % 400 == 0 )); then
                echo "true"
            else
                echo "false"
            fi
        else
            echo "true"
        fi
    else
        echo "false"
    fi
}

if [ $# -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi

month_input=$1
day=$2
year=$3

month=$(convert_month $month_input)


if [ "$month" == "Invalid" ]; then
    echo "월 오류 + $month_input $day $year 는 유효하지 않습니다"
    exit 1
fi


if ! [[ "$day" =~ ^[0-9]+$ ]]; then
    echo "일 오류 + $month_input $day $year 는 유효하지 않습니다"
    exit 1
fi


if ! [[ "$year" =~ ^[0-9]+$ ]]; then
    echo "연도 오류 + $month_input $day $year 는 유효하지 않습니다"
    exit 1
fi


is_leap=$(is_leap_year $year)
case $month in
    Jan|Mar|May|Jul|Aug|Oct|Dec)
        max_day=31
        ;;
    Apr|Jun|Sep|Nov)
        max_day=30
        ;;
    Feb)
        if [ "$is_leap" == "true" ]; then
            max_day=29
        else
            max_day=28
        fi
        ;;
    *)
        echo "날짜 오류 + $month_input $day $year 는 유효하지 않습니다"
        exit 1
        ;;
esac


if (( day < 1 || day > max_day )); then
    echo "일 오류 + $month_input $day $year 는 유효하지 않습니다"
    exit 1
fi


echo "$month $day $year"
