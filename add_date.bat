@echo off
setlocal enabledelayedexpansion

REM 시작 날짜 설정
set "yyyy=2024"
set "mm=01"
set "dd=01"

REM 오늘 날짜 가져오기
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set "todayyyyy=%%a"
    set "todaymm=%%b"
    set "todaydd=%%c"
)

REM 메모 파일 초기화
del memo.txt >nul 2>&1

:loop
REM 날짜 형식 YYYY-MM-DD
set "currentDate=%yyyy%-%mm%-%dd%"
echo !currentDate! 00:00:00>> memo.txt

REM 오늘 날짜와 비교
if "!yyyy!!mm!!dd!"=="!todayyyyy!!todaymm!!todaydd!" goto git

REM 다음 날짜로 증가
call :nextday %yyyy% %mm% %dd%
set "yyyy=%newyyyy%"
set "mm=%newmm%"
set "dd=%newdd%"
goto loop

:nextday
set /a d=%3, m=1%2 %% 100, y=%1

REM 월별 일수 설정
set "days31=01 03 05 07 08 10 12"
set "days30=04 06 09 11"

set /a d+=1

REM 윤년 계산
set /a leap=0
set /a "mod4=%y%%%4", "mod100=%y%%%100", "mod400=%y%%%400"
if %mod4%==0 if not %mod100%==0 set leap=1
if %mod400%==0 set leap=1

set daysInMonth=31
echo %days30% | findstr /C:"%m%" >nul && set daysInMonth=30
if "%m%"=="02" (
    if %leap%==1 (set daysInMonth=29) else (set daysInMonth=28)
)

if %d% GTR %daysInMonth% (
    set d=1
    set /a m+=1
    if %m% GTR 12 (
        set m=1
        set /a y+=1
    )
)

REM 포맷 맞추기
if %d% LSS 10 (set "dd=0%d%") else (set "dd=%d%")
if %m% LSS 10 (set "mm=0%m%") else (set "mm=%m%")
set "newyyyy=%y%"
set "newmm=%mm%"
set "newdd=%dd%"
goto :eof

:git
echo Git add 시작...
git add .
if errorlevel 1 (
    echo 오류: git add 실패
    goto :eof
)
echo Git commit 시작...
git commit -m "memo.txt 업데이트: %date% %time%"
if errorlevel 1 (
    echo 오류: git commit 실패
    goto :eof
)
echo Git push 시작...
git push origin main
if errorlevel 1 (
    echo 오류: git push 실패
    goto :eof
)

echo 완료.
endlocal
