#load notification function
. "C:\Users\Alif\Nextcloud\Documents\Powershell\Practise\function_notification.ps1" 

$SourcePath = "$env:USERPROFILE\Downloads"
# test-path $SourcePath
$DestinationPath = "F:\Downloads"

$videos = Get-ChildItem $SourcePath\* -Include *.mp4, *.mkv, *.avi, *.mpg, *.mpeg 
$audio = Get-ChildItem $SourcePath\* -Include *.aac, *.mp3, *.flac, *.m4a, *.ogg, *.alac, *.wav, *.wma
$programs = Get-ChildItem $SourcePath\* -Include *.exe, *.msi
$zipped = Get-ChildItem $SourcePath\* -Include *.zip, *.rar, *.7z
$documents = Get-ChildItem $SourcePath\* -Include *.pdf, *.doc, *.docx, *.xls, *.xlsx, *.odt

$totalfilecount = $audio.count + $videos.count + $zipped.Count + $documents.Count
$totalfilesize = (($zipped | Measure-Object -sum length).Sum)/1gb + (($audio | Measure-Object -sum length).Sum)/1gb + (($programs | Measure-Object -sum length).Sum)/1gb + (($zipped | Measure-Object -sum length).Sum)/1gb + (($documents | Measure-Object -sum length).Sum)/1gb
$totalgb = [math]::Round($totalfilesize,2)


 Show-Notification -ToastTitle "Spring cleaning started" -ToastText "Cleaning up 'Downloads' folder `n($totalfilecount files, $totalgb GB)"

# if(!(Test-Path "$DestinationPath\videos")) {
#     New-Item -ItemType Directory "$destinationPath\videos"
# }
# $videos | Move-Item -Destination "$DestinationPath\videos"


# if(!(Test-Path "$DestinationPath\audio")) {
#     New-Item -ItemType Directory "$destinationPath\audio"
# }
# $audio | Move-Item -Destination "$DestinationPath\audio"


# if(!(Test-Path "$DestinationPath\programs")) {
#     New-Item -ItemType Directory "$destinationPath\programs"
# }
# $programs | Move-Item -Destination "$DestinationPath\programs"

# if(!(Test-Path "$DestinationPath\zipped")) {
#     New-Item -ItemType Directory "$destinationPath\zipped"
# }
# $zipped | Move-Item -Destination "$DestinationPath\zipped"

# if(!(Test-Path "$DestinationPath\documents")) {
#     New-Item -ItemType Directory "$destinationPath\documents"
# }
# $documents | Move-Item -Destination "$DestinationPath\zipped"