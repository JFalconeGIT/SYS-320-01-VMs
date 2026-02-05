# Display only 404 or 400 errors
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 400 '
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '