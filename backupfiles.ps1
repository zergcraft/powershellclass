#Raphael Vecina
#This is a comment for my Script
<#---------------------------------------------
This is a block comment
---------------------------------------------#>

write-host "Saving the following files" `
            "to the ""Backup"" folder:"

get-childitem | where {
    $_.LastWriteTime -ge "2011-01-01" } |
foreach-object {
    write-host " Backup\$($_.Name)"
    copy-item $_ Backup\}

