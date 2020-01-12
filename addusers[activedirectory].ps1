# Import active directory module for running AD CMDlet
Import-Module ActiveDirectory

# Prompt user for CSV absolute path
#$filepath = Read-Host -Prompt "Please enter the path to your CSV file"

# Autoload CSV file
$filepath = "$env:USERPROFILE\Nextcloud\Documents\Powershell\newADusers.csv"

# Import the file into a variable
$users = Import-Csv $filepath

# Setup log file
#$date - Get-Date -Format yyyyMMdd.Hmm
#$log = "c:\temp\newusercreated.$date.log"
#Write-Output "addusers[activedirectory].ps1 -- Start"  >> $log


# Loop through each row and gather information
ForEach ($newuser in $users) {

    # Gather the user's information
    $fname = $newuser.'First Name'
    $lname = $newuser.'Last name'
    $jtitle = $newuser.'Job Title'
    $officephone = $newuser.'Office Phone'
    $emailaddress = $newuser.'Email Address'
    $description = $newuser.Description
    $OUpath = $newuser.'Organizational Unit'
    $securepassword = ConvertTo-SecureString "$fname-123" -AsPlainText -Force

    # Echo output for each new user
    Write-Host "Account created for $fname $lname in $OUpath with password $securepassword"

    # Create new user in AD
    New-ADUser -Name "$fname $lname" -GivenName $fname -Surname $lname -UserPrincipalName "$fname.$lname" -Path $OUpath -AccountPassword $securepassword -ChangePasswordAtLogon $true -OfficePhone $officephone -Description $description -EmailAddress $emailaddress -Enabled $true 
}