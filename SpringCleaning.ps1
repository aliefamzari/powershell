#load notification function
. ".\function_notification.ps1" 

$SourcePath = "$env:USERPROFILE\Downloads"
# test-path $SourcePath
$DestinationPath = "F:\Downloads"

$videos = Get-ChildItem -Recurse $SourcePath\* -Include *.mp4, *.mkv, *.avi, *.mpg, *.mpeg 
$audio = Get-ChildItem -Recurse $SourcePath\* -Include *.aac, *.mp3, *.flac, *.m4a, *.ogg, *.alac, *.wav, *.wma
$programs = Get-ChildItem -Recurse $SourcePath\* -Include *.exe, *.msi
$zipped = Get-ChildItem -Recurse $SourcePath\* -Include *.zip, *.rar, *.7z
$documents = Get-ChildItem -Recurse $SourcePath\* -Include *.pdf, *.doc, *.docx, *.xls, *.xlsx, *.odt

$totalfilecount = $audio.count + $videos.count + $zipped.Count + $documents.Count + $programs.count
$totalfilesize = (($zipped | Measure-Object -sum length).Sum)/1gb + `
                (($audio | Measure-Object -sum length).Sum)/1gb + `
                (($programs | Measure-Object -sum length).Sum)/1gb + `
                (($zipped | Measure-Object -sum length).Sum)/1gb + `
                (($documents | Measure-Object -sum length).Sum)/1gb +`
                (($videos | Measure-Object -sum Length).Sum)/1gb

$totalgb = [math]::Round($totalfilesize,2)

#Popup Windows 10 notifaction
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