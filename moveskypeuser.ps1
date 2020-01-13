# Script to Move skype user to target pool 
#Author :  Alif Amzari Mohd Azamee

$File = "$env:USERPROFILE\Desktop\user.csv"
$UserArray = Import-CSV -Path $File
$targetpool = targetpool.domain.com

Foreach ($user in $UserArray){    

    $thecurrentuser = $($user.DisplayName)
    $currentuserpool = Get-CSuser $thecurrentuser | Select-Object RegistrarPool

    #Intitializing Current user
    write-host "will use the following user now: $thecurrentuser"
    Start-Sleep 2

    #backingup user data
    write-host "backing up userdata"
    Export-CsUserData -PoolFqdn "$currentuserpool" -UserFilter "$thecurrentuser" -FileName "c:\temp\$thecurrentuser`_csuserdata.zip" 
    
    #Moving user to target pool 
    write-host "Moving $thecurrentuser to $targetpool"
    Move-CsUser -Identity "$thecurrentuser" -Target $targetpool -confirm:$false

    #Restore user data 
    start-sleep 2
    write-host "importing userdata from backup"
    Import-CsUserData UserFilter "$thecurrentuser" -FileName "C:\temp\$thecurrentuser`_csuserdata.zip"

}
