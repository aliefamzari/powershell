#This script is to fetch RecepientTypeDetails properties and output result to CSV file. The script read user array from userlist.csv that you supplied.
#Place userlist.csv at your desktop
#Place CheckRecipientTypeDetailsWithOutput.ps1 at your desktop
#Output file will save as out.csv at your desktop 
#All rights reserved AAMA 2019

$File = "$env:USERPROFILE\Desktop\userlist.csv"   
$userlist = Import-CSV -Path $File
$results = @()

foreach ($user in $userlist){
$results += Get-Recipient $user.namelist -ErrorAction SilentlyContinue |Select Name, RecipientTypeDetails
}

Write-Output $results         

$results | Export-Csv $env:USERPROFILE\Desktop\out.csv -NoTypeInformation  