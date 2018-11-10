Function get-averagefilesize ([object]$Folder) {
#if no folder name is given then the function should default to looking in the PWD
[IO.Directory]::SetCurrentDirectory((Get-Location))

#if no folder name is given then the function defaults to current folder:
if ($Folder -eq $null)
{
$Folder=(get-location).Path

}

#if given folder does not exist, return with an average size of zero
if ( -not (test-path $Folder -pathtype container) )
{
        write-host -foregroundcolor red "`a`n`"$Folder`" does not exist or is not a folder"
        write-host -foregroundcolor red "The average file size is 0 KBytes"
        return
        
}




#returns average file size for all the files in the folder
$Average= (Get-ChildItem $Folder  -Force | Measure-Object -Property Length -Average).Average 2> $null
$AverageComplete = "{0:N0}" -f ($Average / 1KB) + "KB"
write-host "The average file size in the ""$Folder"" folder is: "$AverageComplete""

}

$Foldermain=$args[0]
get-averagefilesize $Foldermain
