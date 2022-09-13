#author : Alif Amzari



$csvheader = '"Time(UTC)","FQDN","ResolvedORFailed"'
$outdir = "c:\hp"
$currentime = (get-date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$fqdn = 'itsupport.orsted.com'

function write-header {
    $csvheader |Out-File $outdir\result.csv
}

$testfile = Test-Path $outdir\result.csv
if (!$testfile) {
    write-header
}

$result = @()

Try{
    # Try something that could cause an error
    $dnsa = Resolve-DnsName $fqdn -ErrorAction Stop |Select-Object ipaddress |Format-List |out-string
    $dnsa = $dnsa.split(':') |Select-Object -Index 1 
    $dnsa = $dnsa -replace "`n| ",""
    $trim = write-output "$currentime,$fqdn,$dnsa" |out-string
    $trim.trim() | out-file -FilePath $outdir\result.csv -Append


  
}
Catch{
    # Catch any error
    Write-Output "$currentime,DNS failed,$fqdn" |out-string 
 
}

# Finally
# {
#     # [Optional] Run this part always
#    write-host done
# }