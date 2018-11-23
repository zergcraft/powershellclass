#shows total size of all the files in current folder which are MS Office docs
#.docx,.xls,.ppt
#-Create an array of strings to hold file extensions
#-use Where-Object pipeline with -Contains to check each file's extension


#((get-childitem *.docx,*.xls,*.ppt).length).sum

$files=(get-childitem -file)
$ms= (($files | ?{($_.extension -contains ".docx") -or ($_.extension -contains ".xlsx") -or ($_.extension -contains ".pptx")}) | measure length -sum).sum
write-host "The total size of the MS Office files in this folder is: "([math]::round($ms/1KB,2))"KB"