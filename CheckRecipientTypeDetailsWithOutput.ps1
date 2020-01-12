# This script is to fetch RecepientTypeDetails properties and output result to CSV file. The script read user array from userlist.csv that you supplied.
# Place userlist.csv at your desktop
# Place CheckRecipientTypeDetailsWithOutput.ps1 at your desktop
# Output file will save as out.csv at your desktop 
# Author : Alif Amzari Mohd Azamee

# Global variables 
$File = "$env:USERPROFILE\Desktop\userlist.csv"   
$userlist = Import-CSV -Path $File
$results = @()

# Fetching user details 
foreach ($user in $userlist){
$results += Get-Recipient $user.namelist -ErrorAction SilentlyContinue |Select Name, RecipientTypeDetails
}

# Write output to variable
Write-Output $results         

# Export stored result to CSV
$results | Export-Csv $env:USERPROFILE\Desktop\out.csv -NoTypeInformation  