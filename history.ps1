#PS commands to show
#-which command in the current session took the longest amount of time to execute
#-hint: you can add a duration property to the objects - this will allow you to sort them by their duration
$duration=0
$history=0

$history = get-history 
$duration = ($history | foreach-object {
add-member -inputobject $_ noteproperty duration ($_.EndExecutiontime - $_.StartExecutionTime )-force;$_} ) 
$duration | sort duration -desc | select -first 1 | format-table id,duration,commandline 


 