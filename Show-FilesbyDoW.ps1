#2 arguments: 
# 1) Name of Folder 
# 2)Day of Week

#displays all files in the named folder that were created on a specified day of week

if ($args.count -lt 2)
{
    write-host "This script needs 2 arguments:"
    exit 1
}


$FolderName = $args[0]
$Day = $args[1] -as [DayofWeek]
if ($Day -eq $null)
{
    write-host "`"$($args[1])`"is not a valid day of the week"

            exit 1
}

if (-not(test-path $FolderName -PathType Container))
{
   write-host "Folder '$FolderName' not found!"
   exit 1
}

Get-ChildItem $FolderName |
        where { ($_.Creationtime.DayOfWeek) -eq $Day } 