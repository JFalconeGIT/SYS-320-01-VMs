# Display only IP addresses for 404 errors
$logsnotFormatted = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ' 
$tableRecords = @()

for($i=0; $i -lt $logsnotFormatted.Count; $i++){

$words = ([String]$logsnotFormatted[$i]).Split(" ");

$tableRecords += [pscustomobject]@{"IP" = $words[0] }

}
Write-Host ($tableRecords | Format-Table -AutoSize | Out-String)
