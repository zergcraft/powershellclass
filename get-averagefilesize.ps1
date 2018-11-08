Function get-averagefilesize {
#if no folder name is given then the function should default to looking in the PWD
[IO.Directory]::SetCurrentDirectory((Get-Location))

$Folder = $args[0]


#if given folder does not exist, return with an average size of zero
if ( -not (test-path $Folder -pathtype container) )
{
        write-host -foregroundcolor red "`a`n`"$Folder`" does not exist or is not a folder"
        write-host -foregroundcolor red "The average file size is 0 KBytes"
}

if ($args[0] -eq $null)
{
    write-host "The average file size in the current folder is:0KBytes"
    exit 1
}



#returns average file size for all the files in the folder
$Average= "{0:N2}" -f ((Get-ChildItem "$Folder" | ?{$_ -is [IO.FileInfo]} | measure length -average).average/1KB )
write-host "The average file size in the ""$Folder"" folder is:"$Average"KBytes"

}
get-averagefilesize