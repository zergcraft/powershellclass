#shows total size of all the files in current folder which are MS Office docs
#.docx,.xls,.ppt
#-Create an array of strings to hold file extensions
#-use Where-Object pipeline with -Contains to check each file's extension


<#-- assign variable $MS to: Find Files in PWD, Find each file with docx,xlsx,pptx extensions and measure the length,
then sum it all together: --#>

$ms= ((get-childitem -file | ?{($_.extension -contains ".docx") -or
 ($_.extension -contains ".xlsx") -or ($_.extension -contains ".pptx")}) | measure length -sum).sum

#Writes the value of $MS divided by 1KB and rounded by 2 decimals
write-host "The total size of the MS Office files in this folder is: "([math]::round($ms/1KB,2))"KB"