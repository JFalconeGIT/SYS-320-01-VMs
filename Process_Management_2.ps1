Get-Process | Where-Object { 
    if ($_.Path) {
        return $_.Path -notlike "*system32*"
    return $false 
    }
} | Select-Object ID, ProcessName, Path