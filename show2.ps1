#Script argument definitions:
$folder=$args[0]
$day=$args[1] -as [System.DayOfWeek] #Parameter is converted to System.DayOfWeek

#If statement to check if there are 2 arguments provided
if ($args.count -lt 2)
{
    write-host "This script needs 2 arguments"
    write-host "1) The folder"
    write-host "2) The day of week"
}

#IF Statement to check if folder is valid
if (-not (Test-Path $folder -pathtype container))
{
    write-host "Folder:$Folder not found!"
    exit 1
}

#IF Statement to check day of week is valid

if ($day -eq $null)
{
    write-host "2nd argument is not a day of the week!"
    exit 1
}


#Find the files in inputfolder($folder) and display files that were created during the input day ($Day)
get-childitem $folder | ?{($_.CreationTime).DayofWeek -eq "$Day"}
