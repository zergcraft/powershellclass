#Raphael Vecina
#This is a comment for my Script
<#---------------------------------------------
This is a block comment
---------------------------------------------#>

write-host "Saving the following files" `
            "to the ""Backup"" folder:"

$BUCount = 0
$BUSize = 0


get-childitem | where {
    $_.LastWriteTime -ge "2011-01-01" } |
foreach-object {
    write-host " Backup\$($_.Name)"
    $BUSize += $_.Length
    $BUCount ++
    copy-item $_ Backup\}
write-host "Saved:" $BUCount "files," `
                    $BUSize "bytes"
