# 시작 날짜와 종료 날짜 설정
$startDate = Get-Date "2024-01-01"
$endDate = Get-Date "2025-05-06"

# 현재 날짜를 시작 날짜로 설정
$currentDate = $startDate

# 각 날짜에 대해 반복
while ($currentDate -le $endDate) {
    # 날짜를 문자열로 변환
    $dateStr = $currentDate.ToString("yyyy/MM/dd")
    $timeStr = "00:00:00"
    
    # 환경 변수 설정
    $env:DATE = $dateStr
    $env:TIME = $timeStr
    
    Write-Host "Running for date: $dateStr"
    
    # add_date.bat 실행
    & ".\add_date.bat"
    
    # 다음 날짜로 이동
    $currentDate = $currentDate.AddDays(1)
    
    # 잠시 대기 (1초)
    Start-Sleep -Seconds 1
}

Write-Host "모든 날짜에 대한 실행이 완료되었습니다." 