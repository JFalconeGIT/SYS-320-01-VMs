# With .log files in the directory, only get logs that contain the word "error" 

$allLogfiles = Get-ChildItem -path C:\xampp\apache\logs
$allLogfiles | Select-String "error"