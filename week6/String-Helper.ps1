# String-Helper
#This script contains functions that help with String/Match/Search operations.

#Functions: Get Matching Lines
#Input:   1) Text with multiple lines  2) Keyword
#Output:  1) Array of lines that contain the keyword

function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}
function checkPassword {
    param(
        [System.Security.SecureString]$securePassword
    )

    # Convert SecureString to plain text
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    # Conditions
    $lengthCheck  = $password.Length -ge 6
    $letterCheck  = $password -match '[A-Za-z]'
    $numberCheck  = $password -match '\d'
    $specialCheck = $password -match '[^a-zA-Z\d]'

    if ($lengthCheck -and $letterCheck -and $numberCheck -and $specialCheck) {
        return $true
    }
    else {
        return $false
    }
}