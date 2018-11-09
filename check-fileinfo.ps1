$LenPos = 25 
$DatePos = 36
$LenLength = $DatePos - $lenPos
get-content FileInfo.txt |
foreach {
    $Name = $_.SubString(0, $LenPos).Trim()
    $Len = $_.SubString($LenPos, $LenLength).Trim()
    $Date = $_.SubString($DatePos).Trim()
    $File = get-item $Name
    if ($File.Length -ne $Len)
    {write-host "$Name length has changed"}
    if ($File.LastWriteTime -ne $Date)
    {write-host "$Name date has changed"}
}