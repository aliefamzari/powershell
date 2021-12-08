##### Script based on the great works of XSIOL. #####
##### Formatting, commenting, modifications and merging of the scripts done by TOBKO. #####

##################################
##################################
#####      Initiation        #####
#####    By XSIOL & TOBKO    #####
##################################
##################################

$challenge = Read-Host "Ready for a fresh spring cleaning of your browsers? 
This will close and clean Internet Explorer, Chrome, Firefox & Edge (Y/N)"
$challenge = $challenge.ToUpper()

# Check if user wrote YES/NO
if ($challenge.Length -gt 1){
    if ($challenge -eq "NO"){
        $challenge = "N"
    }
    
    elseif ($challenge -eq "YES"){
        $challenge = "Y"
    }

    else{
    }
}

if ($challenge -eq "N"){
    Stop-Process -Id $PID
}

elseif ($challenge -eq "Y"){
    
    ##############################
    ##############################
    ##### Cache Clear Script #####
    #####  By XSIOL & TOBKO  #####
    ##############################
    ##############################
    
    Write-Host "Stopping Chrome Process" -ForegroundColor Yellow

    try{
        Get-Process -ProcessName Chrome -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 3
        Write-Host "Chrome Process Sucessfully Stopped" -ForegroundColor Green
    }
    
    catch{
        echo $_
    }

    Write-Host "Clearing Chrome Cache" -ForegroundColor Yellow
    
    try{
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cache" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -ErrorAction SilentlyContinue
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cookies" -File -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -ErrorAction SilentlyContinue
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Web Data" -File -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -ErrorAction SilentlyContinue
        Write-Host "Chrome Cleaned" -ForegroundColor Green
    }
    
    catch{
        echo $_
    }
    
    Write-Host "Stopping IE & Edge Process" -ForegroundColor Yellow
    
    try{
        Get-Process -ProcessName MicrosoftEdge -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Get-Process -ProcessName MSEdge -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Get-Process -ProcessName IExplore -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Write-Host "Internet Explorer and Edge Processes Sucessfully Stopped" -ForegroundColor Green
    }
    
    catch{
        echo $_
    }

    Write-Host "Clearing IE & Edge Cache" -ForegroundColor Yellow
    
    try{
        RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8
        RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2
        Start-Sleep 3
        Write-Host "IE and Edge Cleaned" -ForegroundColor Green
    }
    
    catch{
        echo $_
    }

    Write-Host "Stopping Firefox Process" -ForegroundColor Yellow

    try{
        Get-Process -ProcessName Firefox -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 3
        Write-Host "Firefox Process Sucessfully Stopped" -ForegroundColor Green
    }
    
    catch{
        echo $_
    }

    Write-Host "Clearing Firefox Cache" -ForegroundColor Yellow
    
    try{
        Get-ChildItem -Path $env:LOCALAPPDATA"\Mozilla\Firefox\Profiles\" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse -ErrorAction SilentlyContinue

        Write-Host "Firefox Cleaned" -ForegroundColor Green
    }

    catch{
        echo $_
    }

    Write-Host "Cleanup Complete..." -ForegroundColor Green
}

else{
    Write-Host "Not a valid input, stopping script"
    Start-Sleep -s 6
    Stop-Process -Id $PID
}