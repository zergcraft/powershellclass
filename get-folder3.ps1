


#function2
[IO.Directory]::SetCurrentDirectory((Get-Location))
function get-folder ($Folder2)
{
$Folderall = Get-ChildItem $Folder2 | Where-Object{($_.PSIsContainer)} | foreach-object{$_.Name}
$collection =@(foreach ($i in $Folderall)
{
get-averagefilesize $i
})

$collection2 = $collection | Sort-Object {$_.average} -desc 
write-output $Collection2
}

#function1
Function get-averagefilesize ($Folder) {
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
        continue  
}

#returns average file size for all the files in the folder
$Average= (Get-ChildItem $Folder  -Force -recurse | Measure-Object -Property Length -Average).Average 2> $null
$AverageComplete = "{0:N0}" -f ($Average / 1KB) + "KB"
$myObject = New-Object System.Object
$myobject | add-member -type Noteproperty -name Name -value $Folder
$myobject | add-member -type Noteproperty -name Average -value $Average
return $myobject 


}



#main script
$Foldermain=$args[0]

#get-averagefilesize $Foldermain
get-folder $foldermain
