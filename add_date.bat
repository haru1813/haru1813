@echo off
setlocal enabledelayedexpansion

REM 현재 날짜 및 시간 가져오기
for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
    set year=%%a
    set month=%%b
    set day=%%c
)

for /f "tokens=1-3 delims=:." %%h in ("%time%") do (
    set hour=%%h
    set minute=%%i
    set second=%%j
)

REM 날짜 및 시간 형식 지정
set currentDate=%year%-%month%-%day% %hour%:%minute%:%second%

REM 메모 파일 경로 설정 (현재 스크립트와 동일한 폴더)
set memoFilePath="memo.txt"

REM 파일에 현재 날짜 및 시간 추가 (줄 바꿈 포함)
echo %currentDate%>>"%memoFilePath%"
echo.

REM Git 명령어 실행
echo Git add 시작...
git add .
if errorlevel 1 (
    echo 오류: git add 실패
) else (
    echo Git add 성공
)

echo Git commit 시작...
git commit -m "memo.txt 업데이트: %currentDate%"
if errorlevel 1 (
    echo 오류: git commit 실패
) else (
    echo Git commit 성공
)

REM Git push -v로 verbose 모드 활성화
echo Git push 시작...
git push -v origin master
if errorlevel 1 (
    echo 오류: git push 실패
) else (
    echo Git push 성공
)

echo 완료.

endlocal
