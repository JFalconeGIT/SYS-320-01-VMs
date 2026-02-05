# Display anything but 200 
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch