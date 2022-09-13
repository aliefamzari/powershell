##### Script based on the great works of XSIOL. #####
##### Formatting, commenting, modifications and merging of the scripts done by TOBKO. #####

##################################
##################################
#####      Initiation        #####
#####    By XSIOL & TOBKO    #####
##################################
##################################

#Error Action preference
$ErrorActionPreference = 'SilentlyContinue'


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
 
# Chrome    
    Write-Host "Stopping Chrome Process" -ForegroundColor Yellow

    try{
        Get-Process -ProcessName Chrome  | Stop-Process -Force 
        Start-Sleep -Seconds 3
        Write-Host "Chrome Process Sucessfully Stopped" -ForegroundColor Green
    }
    
    catch{
        write-output $_
    }

    Write-Host "Clearing Chrome Cache" -ForegroundColor Yellow
    
    try{
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cache"  | Remove-Item -Confirm:$false 
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cookies" -File  | Remove-Item -Confirm:$false 
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Web Data" -File  | Remove-Item -Confirm:$false 
        Write-Host "Chrome Cleaned" -ForegroundColor Green
    }
    
    catch{
        write-output $_
    }
 #Edge
    Write-Host "Stopping IE & Edge Process" -ForegroundColor Yellow
    
    try{
        Get-Process -ProcessName MicrosoftEdge  | Stop-Process -Force 
        Get-Process -ProcessName MSEdge  | Stop-Process -Force 
        Get-Process -ProcessName IExplore  | Stop-Process -Force 
        Write-Host "Internet Explorer and Edge Processes Sucessfully Stopped" -ForegroundColor Green
    }
    
    catch{
        write-output $_
    }

    Write-Host "Clearing IE & Edge Cache" -ForegroundColor Yellow
    
    try{
        RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8
        RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2
        Start-Sleep 3
        Write-Host "IE and Edge Cleaned" -ForegroundColor Green
    }
    
    catch{
        write-output $_
    }
#Firefox
    Write-Host "Stopping Firefox Process" -ForegroundColor Yellow

    try{
        Get-Process -ProcessName Firefox  | Stop-Process -Force 
        Start-Sleep -Seconds 3
        Write-Host "Firefox Process Sucessfully Stopped" -ForegroundColor Green
    }
    
    catch{
        write-output $_
    }

    Write-Host "Clearing Firefox Cache" -ForegroundColor Yellow
    
    try{
        Get-ChildItem -Path $env:LOCALAPPDATA"\Mozilla\Firefox\Profiles\"  | Remove-Item -Confirm:$false -Recurse 

        Write-Host "Firefox Cleaned" -ForegroundColor Green
    }

    catch{
        write-output $_
    }

    Write-Host "Cleanup Complete..." -ForegroundColor Green
    
}
write-host "Exiting script..."
start-sleep -s 6
else{
    Write-Host "Not a valid input, stopping script"
    Start-Sleep -s 6
    Stop-Process -Id $PID
}