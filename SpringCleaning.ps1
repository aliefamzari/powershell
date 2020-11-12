# <Spring cleaning download and maybe your desktop folder.  Files will be moved to your backup drive etc.  
# Author : Alif Amzari Mohd Azamee
# >Date: 2020-11-10
#Start-Transcript
#Sourcing some functoin
. ".\function_notification.ps1"
. ".\function_DeleteEmptyFolder.ps1"

$ErrorActionPreference = "SilentlyContinue"
filter timestamp {"$(Get-Date -Format o)"}
$datestamp = Get-Date -Format "yyyyMMddHHmmss"

#Source and destination path
$SourcePath = "$env:USERPROFILE\Downloads"
# test-path $SourcePath
$DestinationPath = "F:\Downloads"

#Todo stuff - logfile
New-Item -path $DestinationPath\log\$datestamp.log -ItemType file -force |Get-ChildItem -Name -OutVariable logfile
$tlog = "$DestinationPath\log\$logfile"
Write-output "Spring Cleaning" |Out-File -Append $tlog


# Catching files based on types to be move
$videos = Get-ChildItem -Recurse $SourcePath* -Include *.mp4, *.mkv, *.avi, *.mpg, *.mpeg 
$audio = Get-ChildItem -Recurse $SourcePath* -Include *.aac, *.mp3, *.flac, *.m4a, *.ogg, *.alac, *.wav, *.wma 
$programs = Get-ChildItem -Recurse $SourcePath* -Include *.exe, *.msi 
$zipped = Get-ChildItem -Recurse $SourcePath* -Include *.zip, *.rar, *.7z 
$documents = Get-ChildItem -Recurse $SourcePath* -Include *.pdf, *.doc, *.docx, *.xls, *.xlsx, *.odt 
$images = Get-ChildItem -Recurse $SourcePath* -Include *.jpg, *.jpeg, *.png, *.webm

#Doing some math stuff
$filetypecount = Get-ChildItem -file -Recurse $SourcePath\* |ForEach-Object {$_.Name.Split('.')[-1]} |Group-Object |Select-Object Name, count |Sort-Object count -Descending 
$totalcatchfiles = $audio.count + $videos.count + $zipped.Count + $documents.Count + $programs.count + $images.count
$totalfilesize = (($zipped | Measure-Object -sum length).Sum)/1gb + `
                (($audio | Measure-Object -sum length).Sum)/1gb + `
                (($programs | Measure-Object -sum length).Sum)/1gb + `
                (($zipped | Measure-Object -sum length).Sum)/1gb + `
                (($documents | Measure-Object -sum length).Sum)/1gb +`
                (($videos | Measure-Object -sum Length).Sum)/1gb +`
                (($images | Measure-Object -sum Length).Sum)/1gb
$totalgb = [math]::Round($totalfilesize,2)

#tossing stuff into a log file
$videos, $audio, $programs, $zipped, $documents, $images >> $tlog
Write-Output "" >> $tlog
Write-Output "File type count" >> $tlog 
$filetypecount | Out-File -Append $tlog
Write-Output "Total catch files" >> $tlog 
$totalcatchfiles >> $tlog
Write-Output "Total size" >> $tlog 
$totalgb >> $tlog

#Popup Windows 10 toaster notification
Show-Notification -ToastTitle "Spring cleaning started" -ToastText "Cleaning up 'Downloads' folder `n($totalcatchfiles files, $totalgb GB)"
Start-Sleep 5

#Display form popup for user consent 
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$UserInput = [System.windows.Forms.Messagebox]::Show("Would you like to move these now? `nFiles:$totalcatchfiles `nSize:$totalgb GB ","SpringCleaning.ps1",4)

#Doing the actual move. Serious stuff going on. 
switch ($UserInput) {
    Yes {
            #[WIP]fixing destination path when move, missing original subfolder 
            $videos | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($SourcePath.Length)
                New-Item $newpath -Type Directory 
                move-item -Force $_.FullName -Destination $newpath
            }             
            $audio | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($SourcePath.Length)
                New-Item $newpath -Type Directory 
                move-item -Force $_.FullName -Destination $newpath
            }
            $programs | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($SourcePath.Length)
                New-Item $newpath -Type Directory 
                move-item -Force $_.FullName -Destination $newpath
            }
            $zipped | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($SourcePath.Length)
                New-Item $newpath -Type Directory
                move-item -Force $_.FullName -Destination $newpath
            }
            $documents | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($SourcePath.Length)
                New-Item $newpath -Type Directory 
                move-item -Force $_.FullName -Destination $newpath
            }
            $images | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($SourcePath.Length)
                New-Item $newpath -Type Directory
                move-item -Force $_.FullName -Destination $newpath
            }
            
            #Clean empty folders
            Delete-EmptyFolder -path $SourcePath

    }
    No {
        Show-Notification -ToastTitle "Spring Cleaning Cancelled" -ToastText "No files were moved"
    }
}
