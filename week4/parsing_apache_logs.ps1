function ApacheLogs1(){
$logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotFormatted.Length; $i++) {
    $words = $logsNotFormatted[$i].Split(" ");
    $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                        "Time" = $words[3].Trim('['); `
                                        "Method" = $words[5].Trim('"'); `
                                        "Page" = $words[6]; `
                                        "Protocol" = $words[7].Trim('"'); `
                                        "Response" = $words[8]; `
                                        "Refrrer" = $words[10]; `
                                        "Client" = $words[11..($words.Count - 1)] -join ' ' }}
                                       
return $tableRecords | Where-Object {$_.IP -match "10.*" }

}
$tableResults = ApacheLogs1
Write-Host ($tableResults | Where-Object { $_.Page -ilike "*page2.html*" -and `
                                           $_.Referrer -ilike "*index.html*"
                                         }`
        | Format-Table -Autosize | Out-String)