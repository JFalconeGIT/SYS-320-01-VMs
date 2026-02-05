# Display only logs that contains 200 (OK)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' 