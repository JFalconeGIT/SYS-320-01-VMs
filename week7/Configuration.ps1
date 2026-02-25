$Prompt = "`n"
$Prompt += "Select an Option:`n"
$Prompt += "1: Show Configuration`n"
$Prompt += "2: Change configuration`n"
$Prompt += "3: Exit`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String 
    $choice = Read-Host

    if($choice -eq 3){
        Write-Host "Goodbye fam" | Out-String
        exit
        $operation = $false
    }

    elseif($choice -eq 1){
           