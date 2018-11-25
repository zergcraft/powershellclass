#shows a list of processes that show ID,NAME,WS,PrivateMemorySize and VirtualMemorySize for each process
#last three should be in MB /1MB
#Show processes in order of increasing WS size
#script should:
#-use write-host cmdlet in conjunction with -f
#-Use the same output formatting string to display the headings and values for each process
#-Determine the name of the longest process and use that in your output formatting string so
# that no more space is used than is necessary to show the process names

#Get the longest name length on the list and use as the "max" padded value for the format str
$LongestName = (get-process | foreach {$_.Name} | Sort length | select -last 1).Length

#assign format string value; format pad each value by 5 characters at the end by using negative(-5) 
$formatstr = "{0,-5} {1,-$LongestName} {2,-5} {3,-5} {4,-5}"

#write the headers using the format string
write-host ("$formatstr" -f "ID","Name","WS","Private","Virtual")
write-host ("$formatstr" -f "----","-----------","---","-----","-----")

#Get each process, sort by WS, and for each process, write each process' ID,Name,WorkingSet,VM,PM. The last 3 are divided by 1MB and rounded by 1 decimal point
Get-Process | sort WS| ForEach-Object {write-host ("$formatstr" -f $_.ID,$_.Name,[math]::Round($_.WorkingSet/1MB,1),[math]::Round($_.PrivateMemorySize/1MB,1),[math]::Round($_.VirtualMemorySize/1MB,1))}
