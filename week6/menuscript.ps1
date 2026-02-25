. C:\Users\champuser\SYS-320-01-VMs\week4\parsing_apache_logs.ps1        # contains ApacheLogs1
. C:\Users\champuser\SYS-320-01-VMs\week3\Eventlog1+2.ps1                # contains getFailedLogins + GetAtRiskUsers
. C:\Users\champuser\SYS-320-01-VMs\week2\Process_Management_1.ps1       # contains StartChrome

function Show-Menu {
    Write-Host ""
    Write-Host "==============================="
    Write-Host "           SYSTEM MENU"
    Write-Host "==============================="
    Write-Host "1. Display last 10 apache logs"
    Write-Host "2. Display last 10 failed logins"
    Write-Host "3. Display at risk users"
    Write-Host "4. Start Chrome -> champlain.edu"
    Write-Host "5. Exit"
    Write-Host "==============================="
}

$choice = 0

# Keep prompting until user enters 5
while ($choice -ne 5) {

    Show-Menu
    $choice = Read-Host "Enter your choice (1-5)"

    # Validate input
    if ($choice -notmatch '^[1-5]$') {
        Write-Host "Invalid selection. Please enter a number between 1 and 5." -ForegroundColor Red
        continue
    }

    switch ($choice) {

        1 {
            Write-Host "Displaying last 10 Apache logs..." -ForegroundColor Cyan
            ApacheLogs1
        }

        2 {
            Write-Host "Displaying last 10 failed logins..." -ForegroundColor Cyan
            getFailedLogins
        }

        3 {
            Write-Host "Displaying at-risk users..." -ForegroundColor Cyan
            GetAtRiskUsers
        }

        4 {
            Write-Host "Checking Chrome status..." -ForegroundColor Cyan

            # Only start Chrome if not already running
            $chrome = Get-Process chrome -ErrorAction SilentlyContinue

            if (-not $chrome) {
                StartChrome "https://www.champlain.edu"
            }
            else {
                Write-Host "Chrome is already running." -ForegroundColor Yellow
            }
        }

        5 {
            Write-Host "Exiting program..." -ForegroundColor Green
        }
    }

    if ($choice -ne 5) {
        Read-Host "Press ENTER to continue"
        Clear-Host
    }
}