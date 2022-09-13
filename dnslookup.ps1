#author : Alif Amzari



$csvheader = '"Time(UTC)","ResolvedORFailed","FQDN"'
$outdir = "c:\hp"
$currentime = (get-date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$fqdn = 'itsupport.orsted.com'

function write-header {
    $csvheader |Out-File $outdir\result.csv
}

# $testfile = Test-Path $outdir\result.csv
# if (!$testfile) {
#     write-header
# }

$result = @()

Try{
    # Try something that could cause an error
    $dnsa = Resolve-DnsName $fqdn -ErrorAction Stop |Select-Object ipaddress |Format-List |out-string
    $dnsa = $dnsa.split(':') |Select-Object -Index 1 
    $dnsa = $dnsa -replace "`n| ",""
    write-output "$currentime,$fqdn,$dnsa"
  
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