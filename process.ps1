#shows a list of processes that show ID,NAME,WS,PrivateMemorySize and VirtualMemorySize for each process
#last three should be in MB /1MB
#Show processes in order of increasing WS size


#should:
#-use write-host cmdlet in conjunction with -f
#-Use the same output formatting string to display the headings and values for each process
#-Determine the name of the longest process and use that in your output formatting string so
# that no more space is used than is necessary to show the process names
#$LongestWS = (get-process | foreach {$_.WorkingSet} | Sort length  | select -last 1).Length
#$LongestP = (get-process | foreach {$_.PrivateMemorySize} | Sort length  | select -last 1).Length
#$LongestV = (get-process | foreach {$_.VirtualMemorySize} | Sort length  | select -last 1).Length
#$formatstr = "{0,$LongestID}{1,$LongestName};{2,$LongestWS};{3,$LongestP};{4,$LongestV}" 
#$LongestID = (get-process | foreach {$_.ID} | Sort length | select -last 1).Length

$LongestName = (get-process | foreach {$_.Name} | Sort length | select -last 1).Length
$formatstr = "{0} {1,$LongestName} {2} {3} {4}" 
write-host ("$formatstr" -f "ID","Name","WS","Private","Virtual")
write-host ("$formatstr" -f "-","-","-","-","-")
Get-Process | sort WS| ForEach-Object {write-host ("$formatstr" -f $_.ID,$_.Name,$_.WorkingSet,$_.PrivateMemorySize,$_.VirtualMemorySize)}