[IO.Directory]::SetCurrentDirectory((Get-Location))
$File = $args[0]
$FileName = ($File).Name
$NewFolder =  $args[1]
$File2 = (Get-childitem $NewFolder $FileName)


#if the target folder does not exist, create it:
if (-not(test-path $NewFolder -PathType Container))
{
 write-host "Folder does not exist - Creating "$newfolder""
 new-item -itemtype directory "$NewFolder"

}

#if source file does not exist, exit:
if (!(test-path ".\$File"))
{
write-host "Source File does not exist - please retry"
exit 1
}

#if source file is newer than destination file - copy the file:
if (($File.LastWriteTime) -ge ($File2.LastWriteTime))
{
write-host "Source file is newer than destination and/or does not exist in destination folder - copying"
Copy-item  -Path $File -Destination $NewFolder
}
elseif (test-path ".\$newfolder\$filename")
{write-host "File is older and/or exists, not copying" 
exit 1
}





