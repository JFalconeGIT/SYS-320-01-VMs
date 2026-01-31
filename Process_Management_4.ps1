$chrome = Get-Process chrome -ErrorAction SilentlyContinue | 
    Where-Object { $_.CommandLine -match 'champlain\.edu' }

if ($chrome) { $chrome | Stop-Process -Froce } 
else { Start-Process "chrome.exe" "https://champlain.edu" } 