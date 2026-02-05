# List last 5 apache logs
Get-Content C:\xampp\apache\logs\access.log | Select-Object -Last 5