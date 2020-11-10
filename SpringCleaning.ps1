# Spring cleaning download folder
#load notification function
. ".\function_notification.ps1" 

$SourcePath = "$env:USERPROFILE\Downloads\"
# test-path $SourcePath
$DestinationPath = "F:\Downloads\"

$videos = Get-ChildItem -Recurse $SourcePath* -Include *.mp4, *.mkv, *.avi, *.mpg, *.mpeg #| ForEach-Object {$_.FullName.Replace($SourcePath, "")}
$audio = Get-ChildItem -Recurse $SourcePath* -Include *.aac, *.mp3, *.flac, *.m4a, *.ogg, *.alac, *.wav, *.wma
$programs = Get-ChildItem -Recurse $SourcePath* -Include *.exe, *.msi
$zipped = Get-ChildItem -Recurse $SourcePath* -Include *.zip, *.rar, *.7z
$documents = Get-ChildItem -Recurse $SourcePath* -Include *.pdf, *.doc, *.docx, *.xls, *.xlsx, *.odt

$totalfilecount = $audio.count + $videos.count + $zipped.Count + $documents.Count + $programs.count
$totalfilesize = (($zipped | Measure-Object -sum length).Sum)/1gb + `
                (($audio | Measure-Object -sum length).Sum)/1gb + `
                (($programs | Measure-Object -sum length).Sum)/1gb + `
                (($zipped | Measure-Object -sum length).Sum)/1gb + `
                (($documents | Measure-Object -sum length).Sum)/1gb +`
                (($videos | Measure-Object -sum Length).Sum)/1gb

$totalgb = [math]::Round($totalfilesize,2)

#Popup Windows 10 notification
Show-Notification -ToastTitle "Spring cleaning started" -ToastText "Cleaning up 'Downloads' folder `n($totalfilecount files, $totalgb GB)"
# Start-Sleep 10

#Display form popup for user consent 
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$UserInput = [System.windows.Forms.Messagebox]::Show("Would you like to move these now? `nFiles:$totalfilecount `nSize:$totalgb GB ","SpringCleaning.ps1",4)

switch ($UserInput) {
    Yes {
            #[WIP]fixing destination path when move, missing original subfolder 
            $videos | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($source.Length)
                New-Item $newpath -Type Directory -ErrorAction SilentlyContinue
                move-item -Force $_.FullName -Destination $newpath
                }
            $audio | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($source.Length)
                New-Item $newpath -Type Directory -ErrorAction SilentlyContinue
                move-item -Force $_.FullName -Destination $newpath
                }
            $programs | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($source.Length)
                New-Item $newpath -Type Directory -ErrorAction SilentlyContinue
                move-item -Force $_.FullName -Destination $newpath
                }
            $zipped | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($source.Length)
                New-Item $newpath -Type Directory -ErrorAction SilentlyContinue
                move-item -Force $_.FullName -Destination $newpath
                }
            $documents | ForEach-Object {
                $newpath = Join-Path $DestinationPath $_.DirectoryName.Substring($source.Length)
                New-Item $newpath -Type Directory -ErrorAction SilentlyContinue
                move-item -Force $_.FullName -Destination $newpath
                }
    No  {
        Show-Notification -ToastTitle "Spring Cleaning Cancelled" -ToastText "No files were moved"
        }
}


