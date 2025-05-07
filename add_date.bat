@echo off
setlocal enabledelayedexpansion

REM ▒ 기준 날짜: 2024-01-01 00:00
set "startYYYY=2024"
set "startMM=01"
set "startDD=01"
set "startHH=00"
set "startMMin=00"
set "startSS=00"

REM ▒ 오늘 날짜 00:00 (YYYY-MM-DD 00:00)
for /f "tokens=1-3 delims=-" %%a in ('powershell -Command "Get-Date -Format 'yyyy-MM-dd'"') do (
    set "todayYYYY=%%a"
    set "todayMM=%%b"
    set "todayDD=%%c"
)
set "todayHH=00"
set "todayMMin=00"
set "todaySS=00"

REM 출력 테스트
echo 시작일: %startYYYY%-%startMM%-%startDD% %startHH%:%startMMin%:%startSS%
echo 오늘일: %todayYYYY%-%todayMM%-%todayDD% %todayHH%:%todayMMin%:%todaySS%

endlocal
pause
