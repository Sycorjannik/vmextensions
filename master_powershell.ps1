param(
    [Parameter(Mandatory=$true)]
    [string[]]$number
)
$numbers = $number.Split(',').Replace(";","")
foreach ($n in $numbers) {
    switch ($n) {
        1 {$rawDisks = Get-Disk | Where-Object { $_.PartitionStyle -eq "RAW" -or $_.OperationalStatus -eq "Offline" }

if ($rawDisks.Count -eq 0) {
    Write-Host "No offline disks found to initialize."
    return
}

foreach ($disk in $rawDisks) {
    if ($disk.IsOnline) {
        Write-Host "Disk $($disk.Number) is already online."
    }
    else {
        Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru
        Write-Host "Disk $($disk.Number) initialized."
    }
    
    New-Partition -DiskNumber $disk.Number -AssignDriveLetter -UseMaximumSize |
        Format-Volume -FileSystem NTFS -Confirm:$false

    Write-Host "Disk $($disk.Number) formatted with NTFS file system."
}}
        2 {Install-PackageProvider -Name NuGet -Force; Install-Module -Name Az -Scope AllUsers -Force}
        3 { Write-Host "Joining Domain" }
        default { Write-Error "Invalid number: $n" }
    }
}