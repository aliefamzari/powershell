$File = "$env:USERPROFILE\Desktop\userlist.csv"
$userlist = Import-CSV -Path $File
# Add line spacing after each write-host line
$spacing = "`n"

#Looping through each line to check if user is O365 or not.  
foreach ($user in $userlist){
		$currentuser = $($user.namelist)
        write-host $spacing
		write-host "Checking: $currentuser" -ForegroundColor Yellow

		If (get-recipient $currentuser -ErrorAction SilentlyContinue){ 
			write-host -ForegroundColor Green "$currentuser Exist"
			get-recipient $currentuser |fl Name, RecipientTypeDetails
		}
		else{
			write-host -ForegroundColor Red "$currentuser Does not exist!"
		}	
	} 