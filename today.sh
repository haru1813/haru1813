#!/bin/bash

# 1. 현재 경로의 모든 .txt 파일 삭제
rm -f ./*.txt

# 2. 오늘 날짜 형식 (YYYY-MM-DD)
today=$(date +%F)

# 3. 오늘 날짜로 된 .txt 파일 생성 및 내용 작성
echo "$today" > "$today.txt"

# 4. Git 리포지토리로 이동 (리포지토리가 위치한 경로로 수정)
cd /root/project/haru1813 || exit 1  # 경로에 문제가 있을 경우 종료

# 5. Git에 변경사항 추가
git add .

# 6. 오늘 날짜로 커밋 메시지 작성
git commit -m "$today"

# 7. main 브랜치에 푸시
git push origin main
