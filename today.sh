#!/bin/bash

# 1. 현재 경로의 모든 .txt 파일 삭제
rm -f ./*.txt

# 2. 오늘 날짜 형식 (YYYY-MM-DD)
today=$(date +%F)

# 3. 오늘 날짜로 된 .txt 파일 생성 및 내용 작성
echo "$today" > "$today.txt"

# 4. Git에 변경사항 추가
git add .

# 5. 오늘 날짜로 커밋 메시지 작성
git commit -m "$today"

# 6. main 브랜치에 푸시
git push origin main
