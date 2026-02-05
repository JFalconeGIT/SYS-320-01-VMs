# Get login and logoff records from Windows Events and save to a variable
# Get the last 14 days of records
$loginouts = Get-EventLog System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() # Empty array to fill with custom values
for($i=0; $i -lt $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].EventID -eq 7001) {$event="Logon"}
if($loginouts[$i].EventID -eq 7002) {$event="Logoff"}

# Creating user property value

$user = $loginouts[$i].ReplacementStrings[1] 

# Adding each new line (in the form of a custom object) to our emtpy array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated 
                                       "Id" = $loginouts[$i].EventID
                                    "Event" = $event;
                                     "User" = $user;
                                     }
} #End of for
$loginoutsTable