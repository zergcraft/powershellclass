

Function Get-AverageFileSize ([string]$Foldername=".")    

#check to see if folder exists, if not then return a 0
{
if ( -not (test-path $Foldername -pathtype container ) )
{return 0}

$filecount=0
$totalfilesize=0
get-childitem $Foldername | Where-Object {$_ -is [Io.FileInfo]} | foreach-object{
$filecount ++
$totalfilesize += $_.Length
}
if ($filecount -eq 0){return 0}

return $totalfilesize/$filecount} 


$HighestAverageSize=0
$highestfoldername=""
Get-ChildItem $args[0] -recurse | where-object{$_ -is [IO.DirectoryInfo]} | 
Foreach-object{
                $thisaveragesize=get-averagefilesize $_.FullName
                        If ($ThisAveragesize -gt $HighestAverageSize )
                        { $highestAverageSize=$ThisAverageSize
                        $HighestFolderName = $_.FullName}
              
}

write-host "The folder with the highest average size is:"
write-host "$highestfoldername"
write-host "It's average file size is" $HighestAverageSize.ToString('N0')