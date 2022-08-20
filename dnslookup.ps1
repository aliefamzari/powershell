#author : Alif Amzari



$csvheader = "Time(UTC),ResolvedORFailed,FQDN"
$outdir = "c:\hp"
$currentime = (get-date).ToUniversalTime().ToString("yy-MM-ddTHH:mm:ss")
$fqdn = "itsupport.orsted.com"

function write-header {
    $csvheader |Out-File $outdir\result.csv
}

$testfile = Test-Path $outdir\result.csv
if (!$testfile) {
    write-header
}

Try{
    # Try something that could cause an error
    $dnsa = Resolve-DnsName $fqdn -ErrorAction Stop |Select-Object ipaddress |Format-List |out-string
    $dnsa = ($dnsa.split(':') |Select-Object -Index 1) 
    Write-Output "$currentime,$dnsa,$fqdn" |out-string |Add-Content -Path $outdir\result.csv 
}
Catch{
    # Catch any error
    Write-Output "$currentime,DNS failed,$fqdn" |out-string |Add-Content -Path $outdir\result.csv      
}
# Finally
# {
#     # [Optional] Run this part always
#    write-host done
# }