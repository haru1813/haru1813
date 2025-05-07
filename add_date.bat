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

:loop
REM 날짜 및 시간 형식 지정
set currentDate=%year%-%month%-%day% %hour%:%minute%:%second%

REM 1월 1일 0시 0분인지 확인
if "%month%"=="1" if "%day%"=="1" if "%hour%"=="0" if "%minute%"=="0" (
    echo 1월 1일 0시 0분이 되어 프로그램을 종료합니다.
    goto end
)

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

REM 날짜 감소
set /a "day-=1"
if %day% lss 1 (
    set /a "month-=1"
    if %month% lss 1 (
        set /a "year-=1"
        set month=12
    )
    if %month%==1 set day=31
    if %month%==2 (
        set /a "leap=year%%4"
        if %leap%==0 set day=29
        if %leap% neq 0 set day=28
    )
    if %month%==3 set day=31
    if %month%==4 set day=30
    if %month%==5 set day=31
    if %month%==6 set day=30
    if %month%==7 set day=31
    if %month%==8 set day=31
    if %month%==9 set day=30
    if %month%==10 set day=31
    if %month%==11 set day=30
    if %month%==12 set day=31
)

REM 1초 대기 후 다시 실행
timeout /t 1 /nobreak > nul
goto loop

:end
endlocal
pause
