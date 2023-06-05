# Get the list of disks attached to the VM
$disks = Get-Disk

# Iterate over each disk
foreach ($disk in $disks) {
    # Get the disk's partitions
    $partitions = Get-Partition -DiskNumber $disk.Number

    # Iterate over each partition
    foreach ($partition in $partitions) {
        # Check if the partition is of type "Basic"

            # Get the disk size and partition size
            $diskSize = $disk.Size
            $partitionSize = $partition.Size

            # Calculate the unallocated space
            $unallocatedSpace = $diskSize - $partitionSize


            # Check if unallocated space exists
            if ($unallocatedSpace -gt 0) {
                $size = (Get-PartitionSupportedSize -DiskNumber $disk.number -PartitionNumber $partition.PartitionNumber)
                # Extend the volume to use the unallocated space
                Resize-Partition -DiskNumber $disk.number -PartitionNumber $partition.PartitionNumber -size $size.SizeMax
                Write-Host "Extended volume for drive $($partition.DriveLetter)"
            }
        
    }
}
