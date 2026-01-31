$outputFile = "C:\Users\champuser\StoppedServices.csv"

Get-Service | 
    Where-Object { $_.Status -eq 'Stopped' } | 
    Select-Object Name, DisplayName, Status, StartType | 
    Sort-Object DisplayName | 
    Export-Csv $outputFile