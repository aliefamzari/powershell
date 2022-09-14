#author : Alif Amzari



$csvheader = '"Time(UTC)","FQDN","ResolvedORFailed"'
$outdir = "$env:userprofile\result.csv"
$currentime = (get-date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$fqdn = 'itsupport.orsted.com'

function write-header {
    $csvheader |Out-File $outdir
}

$testfile = Test-Path $outdir
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
    $trim.trim() | out-file -FilePath $outdir -Append


  
}
Catch{
    # Catch any error
    $trim = Write-Output "$currentime,$fqdn,DNS failed" |out-string 
    $trim.trim() | out-file -FilePath $outdir -Append
 
}
