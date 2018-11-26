$count=0
$size=0

get-childitem | foreach-object{
$count ++
$size += $_.Length
}

write-host $Count "count"
write-host $size "size"