. Join-Path $PSScriptRoot parsing_apache_logs

ApacheLogs1

Write-Host ( 
    $tableRecords |
    Where-Object {
        $_.Page -like "*page2.html*" 
        $_.Referrer -like "*index.html*"
        } | 
        Format-Table -AutoSize | 
           Out-String
           )